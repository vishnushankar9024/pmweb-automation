<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/AssetMaster.Master"
    CodeBehind="Floors.aspx.vb" Inherits="Website.Floors" %>

<%--<%@ Register Src="FloorDetails.ascx" TagName="FloorDetails" TagPrefix="uc1" %>--%>
<%@ Register Src="FloorSpaces.ascx" TagName="FloorSpaces" TagPrefix="uc2" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc3" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc4" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc5" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="AssetTypeEquipments.ascx" TagName="AssetTypeEquipments" TagPrefix="uc8" %>
<%@ Register Src="AssetTypeWorkOrder.ascx" TagName="AssetTypeWorkOrder" TagPrefix="uc9" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc6" %>
<%@ Register Src="AssetComponents.ascx" TagName="AssetComponents" TagPrefix="uc7" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc8" %>
<%--<%@ Register Src="DocumentInspections.ascx" TagName="DocumentInspection" TagPrefix="uc10" %>--%>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc11" %>
<asp:Content ID="C1" ContentPlaceHolderID="ACPH1" runat="server">

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script src="JS/Asset/Components.js" type="text/javascript"></script>
        <script type="text/javascript">
            var forceMoreMenuToClose = true;
            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                    sender.close(true);
                    if (args.get_item().get_value().indexOf("Generate_") == 0) {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findButtonByCommandName(args.get_item().get_value());
                        button.click();
                    }
                    maintoolbarClick(args.get_item().get_value(), args)
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
            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName(), args)
            }
            function OpenComponentItemPopup() {
                return OpenPOPUp('EstimateItemsSelect.aspx?SourceId=Components&IsComponent=1', 910, 580, true);
            }

            function OpenGoogleFloorAddressesPicker() {
                var Id = '<%= PM.Asset.FloorInfo.Id%>';
                if (Id > 0) {
                    var browserWidth = $telerik.$(window).width();
                    var browserHeight = $telerik.$(window).height();
                    var wnd = window.radopen("GoogleAddressesPicker.aspx?RecordType=FLOOR&ObjectId=" + Id + "&PickerSender=RecordAddress" + "&ShowLinearTab=1");
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

            function maintoolbarClick(value, args) {

                var HasReports = '<%= PM.Asset.FloorInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.Asset.FloorInfo.Code & " - " & PM.Asset.FloorInfo.Name)%>';
                var Id = '<%= PM.Asset.FloorInfo.Id%>';

                switch (value) {

                    case 'Planview':
                        var FileGUID = args.get_item().get_attributes('FileGUID')._data.FileGUID;
                        //var left = (screen.width - 820) / 2;
                        //var top = (screen.height - 535) / 2;
                        //window.open('PlanViewEdit.aspx', null,
                        // 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=820,height=535,top=' + top + ',left=' + left);
                        // OpenPOPUp('PlanViewEdit.aspx', 820, 535, false);
                        document.location.href = 'PMWebViewer.aspx?FileGUID=' + FileGUID + '&Source=FLOOR';
                        break;


                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            window.open("ReportsPreviewPopup.aspx?ObjectType=Floor&Id=" +
                                Id
                                + "&RecordDescription=" + RecordDescription
                                + "&EntityId=" + '<%=PM.Asset.FloorInfo.PropertyId%>' + "&EntityType=1",
                                'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;

                    default:
                        break;
                }
            }


            function VisualCalculator(Gross, Rentable, Usable) {
                $("input[id$=txtActualRentable]").val(FPrec(Rentable));
                $("input[id$=txtActualGrossArea]").val(FPrec(Gross));
                $("input[id$=txtActualUsable]").val(FPrec(Usable));
            }
            function DisablePanelAjax() {
                var updatePanel1 = $find($("[id$=pnlDetailPane]")[0].id);
                updatePanel1.set_enableAJAX(false);
            }
            function FloorSpacesRowClick(sender, eventArgs) {
                window.location = "Spaces.aspx?Id=" + eventArgs.getDataKeyValue("Id");
            }

            function AssetEquipmentRowClick(sender, eventArgs) {
                window.location = "Equipments.aspx?Id=" + eventArgs.getDataKeyValue("Id");
            }
            function AssetWorkOrderRowClick(sender, eventArgs) {
                window.location = "WorkOrders.aspx?Id=" + eventArgs.getDataKeyValue("Id");
            }
            //        function OpenEditPalnViewWindow(sender, args) {
            //            switch (args.get_item().get_commandName()) {
            //                case 'Planview':
            //                    var FileGUID = args.get_item().get_attributes('FileGUID')._data.FileGUID;
            //                    //var left = (screen.width - 820) / 2;
            //                    //var top = (screen.height - 535) / 2;
            //                    //window.open('PlanViewEdit.aspx', null,
            //                    // 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=820,height=535,top=' + top + ',left=' + left);
            //                    // OpenPOPUp('PlanViewEdit.aspx', 820, 535, false);
            //                    document.location.href = 'Redlining.aspx?FileGUID=' + FileGUID + '&Source=FLOOR';
            //                    break;
            //            }
            //            return false;
            //        }




        </script>

    </telerik:RadCodeBlock>
    <asp:Button ID="btnCreate" CssClass="Hide" Width="100px" Text="" runat="server" />
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings> 
            <telerik:AjaxSetting AjaxControlID="mlpFloors">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpFloors" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpFloors" LoadingPanelID="ldpPM" />
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
                <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=16">
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
                <telerik:RadComboBox ID="ddlFloors" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                    CloseDropDownOnBlur="true" EmptyMessage="Select Floor..." Width="240px"
                    AutoPostBack="False" NoWrap="true" CausesValidation="False"
                    Height="400px" ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging"
                    OnItemsRequested="ddl_ItemsRequested">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td style="vertical-align: middle; width: 70%" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server"
                    AutoPostBack="true">
                    <Items>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>
                        <%--<telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                                        Value="Search" NavigateUrl="SearchDocument.aspx?O=16" CausesValidation="false">
                                    </telerik:RadToolBarButton>--%>
                        <%--<telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                        CommandName="New" AccessKey="n" ToolTip="New (Alt+n)" CausesValidation="false">
                                    </telerik:RadToolBarButton>--%>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton  SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"  CausesValidation="False" CommandName="New" 
                                                 EnableDefaultButton="false" PostBack="true" ToolTip="New (Alt+n)">
                                               
                         </telerik:RadToolBarButton>

                       <%-- <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="true">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="true" Width="120px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="New">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>--%>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton ImageUrl="Images/ToolBar/PlanViewIcon.png" CommandName="Planview" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPlanview"
                            Value="Planview" PostBack="false" ToolTip="Plan View">
                        </telerik:RadToolBarButton>

                        <%--<telerik:RadToolBarSplitButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Printer.png" CssClass="ToolbarPrint HideOnMobileToolbar"
                                        ToolTip="Print" CommandName="Print" EnableDefaultButton="false" PostBack="false">
                                        <Buttons>
                                            <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports"></telerik:RadToolBarButton>--%>
                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint"
                            EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports"></telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Generate.png" CommandName="Generate" OuterCssClass="HideOnMobileToolbar" Value="Generate" CssClass="ToolbarGenerate"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="true">
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem Text="Print" Value="Print" CssClass="Print">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Generate" Value="Generate" CssClass="Generate" PostBack="true">
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Plan View" Value="Planview" CssClass="" PostBack="false"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('FLOOR');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Help" Value="Help" onclick="helpClick();" CssClass="Help"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton ImageUrl="Images/Toolbar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>"
                            CausesValidation="false" Target="_blank" NavigateUrl="help/PMWebUserManual_AssetManagement.htm#floors">
                        </telerik:RadToolBarButton>
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
    <telerik:RadTabStrip ID="tbsDocument" runat="server" MultiPageID="mlpFloors" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        SelectedIndex="0" Width="100%" EnableViewState="True">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="true"></telerik:RadTab>   
              <telerik:RadTab Text="Specifications" Value="Spec" />
            <%--<telerik:RadTab Text="Details" Value="Details" />--%>
            <telerik:RadTab Text="Components" Value="Components" />
            <telerik:RadTab Text="Spaces" Value="Spaces" />
            <telerik:RadTab Text="Work Orders" Value="WorkOrders" />
            <%--<telerik:RadTab Text="Inspections" Value="DocumentInspections" />--%>
            <telerik:RadTab Text="Equipment" Value="Equipment" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <%--           <telerik:RadTab Text="Workflow" Value="Workflow" Selected="true"  />--%>
        </Tabs>
    </telerik:RadTabStrip>
                  </td>
              </tr>
              </table>
    <telerik:RadMultiPage ID="mlpFloors" runat="server" SelectedIndex="0" styleRenderSelectedPageOnly="true" Width="100%">
        <telerik:RadPageView ID="pvHeader" runat="server">
            <telerik:RadAjaxPanel ID="pnlDetailPane" LoadingPanelID="ldpPM" HorizontalAlign="NotSet" runat="server" Width="100%" EnableAJAX="false">
                <div class="PMMainPage">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLocation" runat="server" meta:resourcekey="lblLocation" />
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProperties" runat="server" CloseDropDownOnBlur="true"
                                            AllowCustomText="true" NoWrap="true" Height="300px"
                                            CausesValidation="False" AutoPostBack="true" 
                                            ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True"
                                            OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvLocationId" runat="server" ControlToValidate="ddlProperties"
                                            CssClass="Validator" InitialValue="" meta:resourcekey="rfv_Properties" Display="Dynamic"
                                            ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvLocationId" runat="server" ControlToValidate="ddlProperties"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" meta:resourcekey="rfv_Properties">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBuilding" runat="server" meta:resourcekey="lblBuilding" />
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlBuildings" runat="server" Filter="Contains" MarkFirstMatch="true"
                                            CloseDropDownOnBlur="true" Height="340px"
                                            NoWrap="true" CausesValidation="False" AutoPostBack="True" EnableItemCaching="false"
                                           AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                            EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvBuildingId" runat="server" ControlToValidate="ddlBuildings"
                                            CssClass="Validator" InitialValue="" meta:resourcekey="rfv_Buildings" Display="Dynamic"
                                            ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvBuildingId" runat="server" ControlToValidate="ddlBuildings"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" meta:resourcekey="rfv_Buildings">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblFloorID" runat="server" meta:resourcekey="lblFloorID" />
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtCode" MaxLength="10" ValidationGroup="Save"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCode" runat="server" ControlToValidate="txtCode"
                                            CssClass="Validator" ValidationGroup="Save" meta:resourcekey="rfv_Code" Display="Dynamic"
                                            ForeColor=""></asp:RequiredFieldValidator>
                                        <asp:Label ID="lblBuildingCodeUnique" meta:resourcekey="lblBuildingCodeUnique" CssClass="Validator"
                                            runat="server" Visible="false"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblName" runat="server" meta:resourcekey="lblName" />
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtName" MaxLength="50" ValidationGroup="Save"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                                            CssClass="Validator" ValidationGroup="Save" meta:resourcekey="rfv_Name" Display="Dynamic"
                                            ForeColor="">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblOperatingProject" runat="server" meta:resourcekey="lblOperatingProject" />
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtOperatingProject" ReadOnly="true" MaxLength="50"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliComponentOf" meta:Resourcekey="hliComponentOf" Text="Component Of" Font-Size="12px" ></asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtComponentOf" Enabled="false" ReadOnly="true" MaxLength="500"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblComponentType" runat="server" Text="Component Type" meta:resourcekey="lblComponentType"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlComponentType" runat="server" Style="font-size: 11px" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true">
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
                                        <telerik:RadCodeBlock runat="server">
                                            <span runat="server" id="rmd_dtpServiceDate" style="display: block">
                                                <telerik:RadDatePicker ID="dtpServiceDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                    SelectedDate='<%# Date.Today %>' Culture="English (United States)"
                                                    EnableTyping="true">
                                                    <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" runat="server"></DateInput>
                                                </telerik:RadDatePicker>
                                            </span>
                                        </telerik:RadCodeBlock>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCondition" runat="server" meta:Resourcekey="lblCondition" Text="Condition" />
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCondition" runat="server" Filter="Contains" MarkFirstMatch="true"
                                            CloseDropDownOnBlur="true" AutoPostBack="false" NoWrap="true" AllowCustomText="True"
                                            DropDownWidth="130px" CausesValidation="False">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblConditionDate" runat="server" meta:Resourcekey="lblConditionDate" Text="Condition Date" />
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadCodeBlock runat="server">
                                            <span id="rmd_dtpConditionDate" runat="server" style="display: inline">
                                                <telerik:RadDatePicker ID="dtpConditionDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                    Culture="English (United States)"
                                                    EnableTyping="true">
                                                    <DateInput ID="DateInput1" LabelCssClass="radLabelCss_Office2007" runat="server"></DateInput>
                                                </telerik:RadDatePicker>
                                            </span>
                                        </telerik:RadCodeBlock>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatus"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlStatus" runat="server" Style="font-size: 11px">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left">
                                            <asp:Label ID="lblBarcode" runat="server" meta:resourcekey="lblBarcode" Text="Barcode"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton runat="server" ID="imgPMbarcode" Style="vertical-align: middle; cursor: pointer"
                                                align="left" class="SearchButton">
                                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadCodeBlock runat="server">
                                            <asp:TextBox ID="txtBarcode" runat="Server" Style="vertical-align: middle;" MaxLength="255"></asp:TextBox>
                                            <asp:Label runat="server" ID="lblBarCodeUnique" CssClass="Validator" Visible="false" Text="<%$ Resources:PMWeb, BarCodeUniqueMsg %>"></asp:Label>
                                            <asp:HiddenField ID="htnBarcodeFormat" runat="server" />
                                        </telerik:RadCodeBlock>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliPlanView" meta:Resourcekey="hliPlanView" Text="Plan View" Font-Size="12px" ></asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <%--<fieldset style="height: 90px; width: 350px; display: block;">
                                                                <legend>
                                                                    <asp:Label ID="lblPlanView" runat="server" Text="Plan View" meta:resourcekey="lblPlanView" /></legend>--%>
                                        <table width="100%" class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td>
                                                    <div style="float: left">
                                                        <asp:HyperLink ID="btnDownloadEdit" runat="server" CausesValidation="false" Style="text-decoration: underline; cursor: hand;"
                                                            Text='' ToolTip="<%$ Resources:PMWeb, Download %>"></asp:HyperLink>
                                                    </div>
                                                    <div style="float: right">
                                                        <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="DisablePanelAjax()"
                                                            SecurityButtonType="ItemMode_Delete" ToolTip="<%$Resources: RemoveFileTooltip %>"
                                                            runat="server" CommandName="DeleteRows" Text="[Delete]" meta:resourcekey="btnDelete">
                                                        </asp:LinkButton>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:FileUpload ID="FileToUpload" runat="server" Width="250px"></asp:FileUpload>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Button ID="btnUpload" runat="server" CausesValidation="False" Text="Upload File"
                                                        meta:resourcekey="btnUpload" style="margin-top:5px; width:240px;" />
                                                </td>
                                            </tr>
                                        </table>
                                        <%--</fieldset>--%>
                                    </td>
                                </tr>
                            </table>
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblLeasing" runat="server" Text="LEASING" CssClass="legend" meta:resourcekey="lblLeasing"></asp:Label>
                                </legend>
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:LinkButton runat="server" ID="imgVisualCalculator" Style="vertical-align: middle; cursor: pointer"
                                                align="left" class="SearchButton">
                                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </td>
                                        <td class="controlWidth">
                                            <table class="TableNoSpacingNoBorder" width="100%">
                                                <tr>
                                                    <td style="width: 50%; text-align: center; color: #666666;">
                                                        <asp:Label ID="lblLinked" runat="server" Text="LINKED" meta:resourcekey="lblLinked"></asp:Label>
                                                    </td>
                                                    <td style="width: 50%; padding-left: 10px; text-align: center; color: #666666;">
                                                        <asp:Label ID="lblActual" runat="server" Text="ACTUAL   " meta:resourcekey="lblActual"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblGrossArea" runat="server" Text="Gross Area" meta:resourcekey="lblGrossArea"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table class="TableNoSpacingNoBorder" width="100%">
                                                <tr>
                                                    <td style="width: 50%">
                                                        <asp:TextBox ID="txtLinkedGrossArea" ReadOnly="true" runat="server" Style="text-align: right"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 50%; padding-left: 10px;">
                                                        <asp:TextBox ID="txtActualGrossArea" CssClass="Double" runat="server"></asp:TextBox>
                                                        <%-- <span id="Span1" runat="server"><%= Me.PM.Asset.FloorInfo.PropertyUOM%></span>--%>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblRentable" runat="server" Text="Rentable" meta:resourcekey="lblRentable"><span></span></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table class="TableNoSpacingNoBorder" width="100%">
                                                <tr>
                                                    <td style="width: 50%">
                                                        <asp:TextBox ID="txtLinkedRentable" ReadOnly="true" runat="server" Style="text-align: right"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 50%; padding-left: 10px;">
                                                        <asp:TextBox ID="txtActualRentable" CssClass="Double" runat="server"></asp:TextBox>
                                                        <%--<span id="Span2" runat="server"><%= Me.PM.Asset.FloorInfo.PropertyUOM%></span>--%>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblUsable" runat="server" Text="Usable" meta:resourcekey="lblUsable"><span></span></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table class="TableNoSpacingNoBorder" width="100%">
                                                <tr>
                                                    <td style="width: 50%">
                                                        <asp:TextBox ID="txtLinkedUsable" ReadOnly="true" runat="server" Style="text-align: right"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 50%; padding-left: 10px;">
                                                        <asp:TextBox ID="txtActualUsable" CssClass="Double" runat="server"></asp:TextBox>
                                                        <%--<span id="Span3" runat="server"><%= Me.PM.Asset.FloorInfo.PropertyUOM%></span>--%>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </div>
                        <div class="col-4 col-4-middle">
                            <fieldset style="width: 100%">
                                <legend>
                                    <asp:Label ID="lblAddress" meta:resourcekey="lblAddress" CssClass="legend" runat="server" Text="ADDRESS"></asp:Label>
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
                                            <asp:Label runat="server" ID="lblStateZIP" meta:resourcekey="lblStateZIP" Text="State / ZIP"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table class="TableNoSpacingNoBorder" width="100%">
                                                <tr>
                                                    <td style="width: 49%">
                                                        <telerik:RadComboBox ID="ddlStates" runat="server" Width="100%"
                                                            Style="font-size: 11px" Height="400px" NoWrap="true" AllowCustomText="true" Filter="Contains">
                                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                                        </telerik:RadComboBox>
                                                    </td>
                                                    <td style="width: 49%; padding-left: 10px; padding-right: 1px;">
                                                        <asp:TextBox ID="txtZip" runat="server"></asp:TextBox>
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
                                                Style="font-size: 11px" Height="400px">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="LblPhone" meta:resourcekey="LblPhone" Text="Phone"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="TxtPhone" MaxLength="100" runat="server" Text=""></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="LblFax" meta:resourcekey="LblFax" Text="Fax"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtFax" MaxLength="100" runat="server" Text=""></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <div style="float: left;">
                                                <asp:Label ID="lblGeolocation" runat="server" meta:resourcekey="lblGeolocation" Text="Geolocation"></asp:Label>
                                            </div>
                                            <div style="float: right;">
                                                <asp:LinkButton runat="server" ID="btnGoogleAddress" OnClientClick="return OpenGoogleFloorAddressesPicker();" CssClass="SearchButton">
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
                            <fieldset style="width: 100%;">
                                <legend>
                                    <asp:Label ID="lblLinearDefinition" CssClass="legend" meta:resourcekey="lblLinearDefinition" runat="server" Text="LINEAR DEFINITION"></asp:Label>
                                </legend>
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:LinkButton ID="lbtLinearAssets" runat="server" CssClass="SearchButton">
                                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </td>
                                        <td class="controlWidth">
                                            <table class="TableNoSpacingNoBorder" width="100%">
                                                <tr>
                                                    <td style="width: 50%;">
                                                        <asp:Label runat="server" ID="Label" meta:resourcekey="label" Text=""></asp:Label>
                                                    </td>
                                                    <td style="width: 50%; padding-left: 10px; text-align: center; color: #666666;">
                                                        <asp:Label runat="server" ID="lblDirection" meta:resourcekey="lblDirection" Text="DIRECTION"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblBegin" meta:resourcekey="lblBegin" Text="Begin"> </asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table class="TableNoSpacingNoBorder" width="100%">
                                                <tr>
                                                    <td style="width: 50%;">
                                                        <asp:TextBox Style="width: 100%" ID="TxtBegin" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 50%; padding-left: 10px;">
                                                        <telerik:RadComboBox ID="ddlBeginDirectionId" runat="server" Filter="Contains" MarkFirstMatch="true"
                                                            CloseDropDownOnBlur="true" AutoPostBack="false" NoWrap="true" AllowCustomText="True"
                                                            Width="100%" CausesValidation="False">
                                                        </telerik:RadComboBox>
                                                        <asp:Label runat="server" ID="Label5" Text=""></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblEnd" meta:resourcekey="lblEnd" Text="End"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table class="TableNoSpacingNoBorder" width="100%">
                                                <tr>
                                                    <td style="width: 50%;">
                                                        <asp:TextBox Style="width: 100%" ID="TxtEnd" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 50%; padding-left: 10px;">
                                                        <telerik:RadComboBox ID="ddlEndDirectionId" runat="server" Filter="Contains" MarkFirstMatch="true"
                                                            CloseDropDownOnBlur="true" AutoPostBack="false" NoWrap="true" AllowCustomText="True"
                                                            Width="100%" CausesValidation="False">
                                                        </telerik:RadComboBox>
                                                        <asp:Label runat="server" ID="Label7" Text=""></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblApproxLength" meta:resourcekey="lblApproxLength"
                                                Text="Approx. Length"> </asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table class="TableNoSpacingNoBorder" width="100%">
                                                <tr>
                                                    <td style="width: 50%;">
                                                        <asp:TextBox Style="width: 100%" ID="txtLength" CssClass="Double" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 50%; padding-left: 10px;">
                                                        <telerik:RadComboBox ID="ddlLengthUOM" runat="server" Filter="Contains" MarkFirstMatch="true"
                                                            CloseDropDownOnBlur="true" AutoPostBack="false" OnClientSelectedIndexChanging="LinearLengthUOMChanging"
                                                            NoWrap="true" Width="100%" CausesValidation="False" AllowCustomText="true">
                                                        </telerik:RadComboBox>
                                                        <asp:Label runat="server" ID="Label9" Text=""></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblLinearArea" meta:resourcekey="lblLinearArea" Text="Area"> </asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table class="TableNoSpacingNoBorder" width="100%">
                                                <tr>
                                                    <td style="width: 50%;">
                                                        <asp:TextBox Style="width: 100%" ID="txtLinearArea" CssClass="PositiveDouble" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 50%; padding-left: 10px;">
                                                        <telerik:RadComboBox ID="ddlLinearAreaUOM" runat="server" Filter="Contains" MarkFirstMatch="true"
                                                            CloseDropDownOnBlur="true" AutoPostBack="false" NoWrap="true" Width="100%"
                                                            CausesValidation="False" OnClientSelectedIndexChanging="LinearAreaUOMChanging" AllowCustomText="true">
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc6:AssetRotator ID="PMrot" runat="server" />
                            <uc8:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView> 
          <telerik:RadPageView ID="pvSpec" runat="server">
            <uc11:DocumentSpecifications ID="Specification1" runat="server" />
        </telerik:RadPageView>
        <%--<telerik:RadPageView ID="pvDetails" runat="server">
                                    <uc1:FloorDetails ID="FloorDetails" runat="server" />
                                </telerik:RadPageView>--%>
        <telerik:RadPageView ID="pvFloorComponents" runat="server">
            <uc7:AssetComponents ID="AssetComponents1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvSpaces" runat="server">
            <uc2:FloorSpaces ID="FloorSpaces" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkOrders" runat="server">
            <uc9:AssetTypeWorkOrder ID="AssetTypeWorkOrder1" runat="server" />
        </telerik:RadPageView>
        <%--  <telerik:RadPageView ID="pvDocumentInspections" runat="server">
                                    <uc10:DocumentInspection ID="DocumentInspection1" runat="server" />
                                </telerik:RadPageView>--%>
        <telerik:RadPageView ID="pvEquipment" runat="server">
            <uc8:AssetTypeEquipments ID="AssetTypeEquipments" runat="server" />
        </telerik:RadPageView>
     
        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc3:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc4:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
        <%--    <telerik:RadPageView ID="pvWorkflow" runat="server" Selected="true">
                                            <uc5:WorkflowDocument ID="WorkflowDocument1" runat="server" />
                                        </telerik:RadPageView>--%>
    </telerik:RadMultiPage>

    <asp:HiddenField runat="server" ID="hdnCurrentUsage" Value="0"></asp:HiddenField>
    <asp:Button runat="server" ID="btnSwitchComponents" CssClass="Hide" />
</asp:Content>
