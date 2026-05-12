<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/AssetMaster.Master" CodeBehind="Buildings.aspx.vb" Inherits="Website.Buildings" %>

<%--<%@ Register Src="BuildingDetails.ascx" TagName="BuildingDetails" TagPrefix="uc1" %>--%>
<%@ Register Src="BuildingFloors.ascx" TagName="BuildingFloors" TagPrefix="uc2" %>
<%@ Register Src="BuildingSpaces.ascx" TagName="BuildingSpaces" TagPrefix="uc3" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc4" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc5" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc6" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="AssetTypeEquipments.ascx" TagName="AssetTypeEquipments" TagPrefix="uc8" %>
<%@ Register Src="AssetTypeWorkOrder.ascx" TagName="AssetTypeWorkOrder" TagPrefix="uc9" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc10" %>
<%@ Register Src="AssetComponents.ascx" TagName="AssetComponents" TagPrefix="uc11" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc12" %>
<%--<%@ Register Src="DocumentInspections.ascx" TagName="DocumentInspection" TagPrefix="uc13" %>--%>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc14" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ACPH1" runat="server">

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script src="JS/Asset/Components.js" type="text/javascript"></script>
        <script type="text/javascript">
            var forceradmenuToClose = false;
            var forceMoreMenuToClose = true;
            function OpenComponentItemPopup() {
                return OpenPOPUp('EstimateItemsSelect.aspx?SourceId=Components&IsComponent=1', 910, 580, true);
            }
            function OpenGoogleBuildingAddressesPicker() {
                var Id = '<%= PM.Asset.BuildingInfo.Id%>';
                if (Id > 0) {
                    var browserWidth = $telerik.$(window).width();
                    var browserHeight = $telerik.$(window).height();
                    var wnd = window.radopen("GoogleAddressesPicker.aspx?RecordType=BUILDING&ObjectId=" + Id + "&PickerSender=RecordAddress");
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

            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
                if (args.get_item().get_value() != null && args.get_item().get_value().indexOf("Generate") >= 0) {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue(args.get_item().get_value());
                    button.click();
                }
                maintoolbarClick(args.get_item().get_value())
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }


            function maintoolbarClick(Value) {
                var HasReports = '<%= PM.Asset.BuildingInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.Asset.BuildingInfo.Code & " - " & PM.Asset.BuildingInfo.Name)%>';
                var Id = '<%= PM.Asset.BuildingInfo.Id%>';

                switch (Value) {

                    case 'BIReporting':

                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        args.set_cancel(true);
                        break;

                    case 'Print':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            window.open("ReportsPreviewPopup.aspx?ObjectType=Building&Id=" +
                                 Id
                                 + "&RecordDescription=" + RecordDescription
                                 + "&EntityId=" + '<%=PM.Asset.BuildingInfo.PropertyId%>' + "&EntityType=1",
                                'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        } else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                            args.set_cancel(true);
                        } break;

                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            window.open("ReportsPreviewPopup.aspx?ObjectType=Building&Id=" +
                                 Id
                                 + "&RecordDescription=" + RecordDescription
                                 + "&EntityId=" + '<%=PM.Asset.BuildingInfo.PropertyId%>' + "&EntityType=1",
                                'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;
                        //case 'New':
                        //    window.location = "Buildings.aspx?Id=0";
                        //    break;
                    default:
                        break;
                }
            }


            function VisualCalculator(Gross, Rentable, Usable) {
                $("input[id$=TxtActualRentable]").val(FPrec(Rentable));
                $("input[id$=TxtActualGrossArea]").val(FPrec(Gross));
                $("input[id$=TxtActualUsable]").val(FPrec(Usable));
            }
            function BuildingFloorsRowClick(sender, eventArgs) {
                window.location = "Floors.aspx?Id=" + eventArgs.getDataKeyValue("Id");
            }
            function BuildingSpacesRowClick(sender, eventArgs) {
                window.location = "Spaces.aspx?Id=" + eventArgs.getDataKeyValue("Id");
            }

            function AssetEquipmentRowClick(sender, eventArgs) {
                window.location = "Equipments.aspx?Id=" + eventArgs.getDataKeyValue("Id");
            }

            function AssetWorkOrderRowClick(sender, eventArgs) {
                window.location = "WorkOrders.aspx?Id=" + eventArgs.getDataKeyValue("Id");
            }


            function MoreMenuOpening(sender, args) {
                if (!forceMoreMenuToClose) { args.set_cancel(true); return; }
                if (args.get_item().get_value() == 'Assign') {
                    var lblAssigned = $('.lblAssigned');
                    if (lblAssigned.html() == null || lblAssigned.html() == undefined)
                        forceMoreMenuToClose = false;
                }

            }
            function MoreMenuClosing(sender, args) {
                if (forceMoreMenuToClose) {
                    //forceradmenuToClose = false;
                    return;
                }
                args.set_cancel(true);
            }
        </script>

    </telerik:RadCodeBlock>

    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
             <telerik:AjaxSetting AjaxControlID="mlpBuildings">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpBuildings" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpBuildings" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
      <table style="width:100%" cellpadding="0" cellspacing="0">
            <tr>
                <td>

    <table class="ToolBar SmallToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:HyperLink runat="server" ID="btnSearchDocument" CssClass="lnkPage" NavigateUrl="SearchDocument.aspx?O=10">
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
                <telerik:RadComboBox ID="ddlBuildings" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Building..." Width="240px" AutoPostBack="false" NoWrap="true"
                    CausesValidation="False" Height="400px" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging" DropDownCssClass="ToolbarDropdown">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" OnClientButtonClicked="click_handler" AutoPostBack="true">
                    <Items>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CommandName="Save" AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)"></telerik:RadToolBarButton>
                 
                                <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                    CommandName="New" AccessKey="n" CausesValidation="false" PostBack="true">
                                </telerik:RadToolBarButton>
                        
                        
                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CommandName="Delete"
                            AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>
                        <telerik:RadToolBarSplitButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Printer.png" ToolTip="Print"
                            CommandName="Print" EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked"
                                    OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Print" Value="Print" CssClass="Print">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Go To Bi Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Show Linked BI Reports" Value="ViewReports"></telerik:RadMenuItem> 
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Generate" Value="Generate" CssClass="Generate" SecurityButtonType="Add">
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('BUILDING');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" onclick="helpClick();" CssClass="Help"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Generate.png" CommandName="Generate"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarGenerate">
                        </telerik:RadToolBarSplitButton>
                        <%--<telerik:RadToolBarButton ImageUrl="Images/Toolbar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_AssetManagement.htm#Buildings"></telerik:RadToolBarButton>--%>
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
<telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" CssClass="documentTabs"
        runat="server" MultiPageID="mlpBuildings" Skin="Default" ScrollChildren="true" ScrollButtonsPosition="Left"
        OnTabClick="tbsDocument_TabClick" Width="100%" EnableViewState="True">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True"></telerik:RadTab> 
           <telerik:RadTab Text="Specifications" Value="Spec"></telerik:RadTab>
            <%--<telerik:RadTab Text="Details" Value="Details" />--%>
            <telerik:RadTab Text="Components" Value="Components" />
            <telerik:RadTab Text="Floors" Value="Floors" />
            <telerik:RadTab Text="Spaces" Value="Spaces" />
            <telerik:RadTab Text="Work Orders" Value="WorkOrders" />
            <%--<telerik:RadTab Text="Inspections" Value="DocumentInspections" />--%>
            <telerik:RadTab Text="Equipment" Value="Equipment" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
       
        </Tabs>
    </telerik:RadTabStrip>
              </td>
          </tr>          
</table>
    


    <telerik:RadMultiPage ID="mlpBuildings" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="true">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">

            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" LoadingPanelID="ldpPM" EnableAJAX="false">
                <div class="PMMainPage">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblLocation" meta:resourcekey="lblLocation"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProperties" runat="server" Skin="Default" CloseDropDownOnBlur="true" AllowCustomText="true"
                                            NoWrap="true" Height="300px" CausesValidation="False" AutoPostBack="True"
                                            EmptyMessage="<%$Resources:Asset, ddlLocation_EmptyMsg %>" ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvLocation" runat="server" ControlToValidate="ddlProperties"
                                            CssClass="Validator" InitialValue="" meta:resourcekey="rfv_Properties"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvLocation" runat="server" ControlToValidate="ddlProperties"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" meta:resourcekey="rfv_Properties">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBuildingId" runat="server" meta:resourcekey="lblBuildingId"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtCode" MaxLength="50"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCode" runat="server"
                                            ControlToValidate="txtCode" CssClass="Validator" ValidationGroup="Save"
                                            meta:resourcekey="rfv_Code" Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                                        <asp:Label ID="lblBuildingCodeUnique" CssClass="Validator" runat="server" meta:resourcekey="lblBuildingCodeUnique" Visible="false"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblName" runat="server" meta:resourcekey="lblName"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtName" MaxLength="50"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvName" runat="server"
                                            ControlToValidate="txtName" CssClass="Validator" ValidationGroup="Save"
                                            meta:resourcekey="rfv_Name" Display="Dynamic" ForeColor="">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBuildingType" runat="server" meta:resourcekey="lblBuildingType" Text="Building Type11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlBuildingType" runat="server" Filter="Contains" AllowCustomText="True"
                                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" Height="200px"
                                            AutoPostBack="false" NoWrap="true" CausesValidation="False">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lbloperatingProject" runat="server" meta:resourcekey="lbloperatingProject"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtoperatingProject" MaxLength="50" ReadOnly="true"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliComponentOf" meta:Resourcekey="hliComponentOf" Text="Component Of"></asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtComponentOf" Enabled="false" ReadOnly="true" MaxLength="500"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblComponentType" runat="server" meta:resourcekey="lblComponentType" Text="Component Type11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlComponentType" runat="server" Skin="Default" AllowCustomText="True"
                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>" Filter="Contains" MarkFirstMatch="true">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblServiceInterval" runat="server" meta:resourcekey="lblServiceInterval" Text="Service Interval11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtServiceInterval" runat="server" CssClass="PositiveDouble" MaxLength="15"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblInServiceDate" runat="server" meta:resourcekey="lblInServiceDate"
                                            Text="In Service Date"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpInServiceDate">
                                            <telerik:RadDatePicker ID="dtpInServiceDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                Skin="Default" Culture="English (United States)"
                                                EnableTyping="true">
                                                <DateInput ID="DateInput2" runat="server"></DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCondition" runat="server" meta:resourcekey="lbl_Condition" Text="Condition/Date11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlConditions" runat="server" Filter="Contains"
                                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" Height="200px"
                                            AutoPostBack="false" NoWrap="true" AllowCustomText="True"
                                            CausesValidation="False">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblConditionDate" runat="server" meta:resourcekey="lblConditionDate" Text="Condition Date11"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpConditionDate" style="display: inline">
                                            <telerik:RadDatePicker ID="dtpConditionDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                Skin="Default" Culture="English (United States)"
                                                EnableTyping="true">
                                                <DateInput ID="DateInput1" runat="server"></DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatus"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlStatus" runat="server" Skin="Default">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left">
                                            <asp:Label ID="lblBarcode" runat="server" meta:resourcekey="lblBarcode" Text="Barcode11"></asp:Label>
                                        </div>
                                        <div style="float: right">
                                            <telerik:RadCodeBlock runat="server">
                                                <asp:LinkButton runat="server" ID="imgPMbarcode" CssClass="SearchButton">
                                                    <asp:HiddenField ID="htnBarcodeFormat" runat="server" />
                                                    <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </telerik:RadCodeBlock>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtBarcode" runat="Server" MaxLength="255"></asp:TextBox>
                                        <asp:Label runat="server" ID="lblBarCodeUnique" CssClass="Validator" Text="<%$ Resources:PMWeb, BarCodeUniqueMsg %>"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <fieldset runat="server" id="fldsetAddress">
                                <legend>
                                    <asp:Label ID="lblAddress" class="legend" meta:resourcekey="lblAddress" runat="server" Text="Address11"></asp:Label>
                                </legend>
                                <table class="colTable">

                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblAddress1" meta:resourcekey="lblAddress1" Text="Address 1 11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtAddress1" MaxLength="100" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblAddress2" meta:resourcekey="lblAddress2" Text="Address"></asp:Label>
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
                                            <asp:TextBox ID="txtCity" MaxLength="50" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblStateZip" meta:resourcekey="lblStateZip" Text="State"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table class="TableNoSpacingNoBorder" width="100%">
                                                <tr>
                                                    <td style="width: 50%; padding-right: 4px;">
                                                        <telerik:RadComboBox ID="ddlStates" runat="server" Skin="Default"
                                                            Height="400px" NoWrap="true" AllowCustomText="true" Filter="Contains">
                                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                                        </telerik:RadComboBox>
                                                    </td>
                                                    <td style="width: 50%; padding-left: 4px;">
                                                        <asp:TextBox ID="txtZip" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblCountry" meta:resourcekey="lblCountry" Text="Country11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlCountries" runat="server" Skin="Default" Filter="Contains" MarkFirstMatch="true"
                                                Style="font-size: 11px" Height="400px" AllowCustomText="true">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="LblPhone" meta:resourcekey="LblPhone" Text="Phone11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="TxtPhone" MaxLength="100" runat="server" Text=""></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="LblFax" meta:resourcekey="LblFax" Text="Fax11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtFax" MaxLength="100" runat="server" Text=""></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <div style="float: left">
                                                <asp:Label runat="server" ID="lblGoogleAddress" meta:resourcekey="lblGoogleAddress" Text="Google Address1"></asp:Label>
                                            </div>
                                            <div style="float: right">
                                                <asp:LinkButton runat="server" ID="btnGoogleAddress" CssClass="SearchButton" OnClientClick="return OpenGoogleBuildingAddressesPicker();">
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
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblLinear" class="legend" meta:resourcekey="lblLinear" runat="server" Text="Linear Definition11"></asp:Label>
                                </legend>
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:LinkButton ID="lbtLinearAssets" runat="server" CssClass="SearchButton">
                                                                        <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%" class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td style="width: 50%;" class="NoWrap"></td>
                                                    <td style="width: 50%; text-align: center; color: #666666; text-transform: uppercase;" class="NoWrap">
                                                        <asp:Label runat="server" ID="lblDirection" meta:resourcekey="lblDirection" Text="Direction11"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblBegin" meta:resourcekey="lblBegin" Text="Begin11"> </asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%" class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td style="width: 50%; padding-right: 4px" class="NoWrap">
                                                        <asp:TextBox Style="width: 100%" ID="TxtBegin" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 50%; padding-left: 4px" class="NoWrap">
                                                        <telerik:RadComboBox ID="ddlBeginDirectionId" runat="server" Filter="Contains"
                                                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                                            AutoPostBack="false" NoWrap="true" Width="100%" AllowCustomText="True"
                                                            CausesValidation="False">
                                                        </telerik:RadComboBox>
                                                        <asp:Label runat="server" ID="Label5" Text=""></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblEnd" meta:resourcekey="lblEnd" Text="End11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%" class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td style="width: 50%; padding-right: 4px">
                                                        <asp:TextBox Style="width: 100%" ID="TxtEnd" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 50%; padding-left: 4px">
                                                        <telerik:RadComboBox ID="ddlEndDirectionId" runat="server" Filter="Contains"
                                                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" AllowCustomText="True"
                                                            AutoPostBack="false" NoWrap="true" Width="100%"
                                                            CausesValidation="False">
                                                        </telerik:RadComboBox>
                                                        <asp:Label runat="server" ID="Label7" Text=""></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblApproxLength" meta:resourcekey="lblApproxLength" Text="Approx. Length11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%" class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td style="width: 50%; padding-right: 4px;">
                                                        <asp:TextBox Style="width: 100%" ID="txtLength" CssClass="Double" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 50%; padding-left: 4px">
                                                        <telerik:RadComboBox ID="ddlLengthUOM" runat="server" Filter="Contains" OnClientSelectedIndexChanging="LinearLengthUOMChanging"
                                                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" AllowCustomText="true"
                                                            AutoPostBack="false" NoWrap="true" Width="100%"
                                                            CausesValidation="False">
                                                        </telerik:RadComboBox>
                                                        <asp:Label runat="server" ID="Label9" Text=""></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblLinearArea" meta:resourcekey="lblLinearArea" Text="Area11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%" class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td style="width: 50%; padding-right: 4px">
                                                        <asp:TextBox Style="width: 100%" ID="txtLinearArea" CssClass="PositiveDouble" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 50%; padding-left: 4px">
                                                        <telerik:RadComboBox ID="ddlLinearAreaUOM" runat="server" Filter="Contains" MarkFirstMatch="true"
                                                            Skin="Default" OnClientSelectedIndexChanging="LinearAreaUOMChanging" AllowCustomText="true"
                                                            CloseDropDownOnBlur="true" AutoPostBack="false" NoWrap="true" Width="100%" CausesValidation="False">
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblLeasing" class="legend" meta:resourcekey="lblLeasing" runat="server" Text="Leasing"></asp:Label>
                                </legend>
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:LinkButton runat="server" ID="imgVisualCalculator" Style="vertical-align: middle; cursor: pointer"
                                                align="left" CssClass="SearchButton">
                                                                        <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%" class="TableNoSpacingNoBorder" style="text-align: center; color: #666666; text-transform: uppercase;">
                                                <tr>
                                                    <td style="width: 50%; padding-right: 4px">
                                                        <asp:Label runat="server" ID="LblLinked" meta:resourcekey="LblLinked" Text="Linked"></asp:Label>
                                                    </td>
                                                    <td style="width: 50%; padding-left: 4px;" class="NoWrap">
                                                        <asp:Label runat="server" ID="LblActual" meta:resourcekey="LblActual" Text="Actual11"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="LblGrossArea" meta:resourcekey="LblGrossArea" Text="GrossArea"> </asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%" class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td style="width: 50%; padding-right: 4px">
                                                        <asp:TextBox ID="TxtLinkedGrossArea" runat="server" ReadOnly="true" Style="text-align: right;">  </asp:TextBox>

                                                    </td>
                                                    <td style="width: 50%; padding-left: 4px;" class="NoWrap">
                                                        <asp:TextBox ID="TxtActualGrossArea" CssClass="Double" runat="server"></asp:TextBox>
                                                        <asp:Label runat="server" ID="LblGrossAreaUOM" Text=""></asp:Label>
                                                    </td>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblRentable" meta:resourcekey="lblRentable" Text="Rentable"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%" class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td style="width: 50%; padding-right: 4px">
                                                        <asp:TextBox ID="TxtLinkedRentable" runat="server" ReadOnly="true" Style="text-align: right;"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 50%; padding-left: 4px;" class="NoWrap">
                                                        <asp:TextBox ID="TxtActualRentable" CssClass="Double" runat="server"></asp:TextBox>
                                                        <asp:Label runat="server" ID="lblRentableUOM" Text=""></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblUsable" meta:resourcekey="lblUsable" Text="Usable"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table width="100%" class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td style="width: 50%; padding-right: 4px">
                                                        <asp:TextBox Style="width: 100%; text-align: right;" ID="TxtLinkedUsable" runat="server" ReadOnly="true"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 50%; padding-left: 4px;" class="NoWrap">
                                                        <asp:TextBox ID="TxtActualUsable" CssClass="Double" runat="server"></asp:TextBox>
                                                        <asp:Label runat="server" ID="lblUsableUOM" Text=""></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc10:AssetRotator ID="PMrot" runat="server" />
                            <uc12:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>

                    </div>
                </div>
            </telerik:RadAjaxPanel>

        </telerik:RadPageView>
          <telerik:RadPageView ID="PvSpec" runat="server">
            <uc14:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>
        <%--<telerik:RadPageView ID="pvDetails" runat="server">
                        <uc1:BuildingDetails ID="BuildingDetails" runat="server" />
                    </telerik:RadPageView>--%>
        <telerik:RadPageView ID="pvBuildingComponents" runat="server">
            <uc11:AssetComponents ID="AssetComponents1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvFloors" runat="server">
            <uc2:BuildingFloors ID="BuildingFloors" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvSpaces" runat="server">
            <uc3:BuildingSpaces ID="BuildingSpaces" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkOrders" runat="server">
            <uc9:AssetTypeWorkOrder ID="AssetTypeWorkOrder1" runat="server" />
        </telerik:RadPageView>
        <%-- <telerik:RadPageView ID="pvDocumentInspections" runat="server">
                        <uc13:DocumentInspection ID="DocumentInspection1" runat="server" />
                    </telerik:RadPageView>--%>
        <telerik:RadPageView ID="pvEquipment" runat="server">
            <uc8:AssetTypeEquipments ID="AssetTypeEquipments" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc4:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc5:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
      
    </telerik:RadMultiPage>

    <asp:HiddenField runat="server" ID="hdnCurrentUsage" Value="0"></asp:HiddenField>
    <telerik:RadAjaxLoadingPanel ID="ldpBuildings" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default" />
    <asp:Button runat="server" ID="btnSwitchComponents" CssClass="Hide" />
</asp:Content>
