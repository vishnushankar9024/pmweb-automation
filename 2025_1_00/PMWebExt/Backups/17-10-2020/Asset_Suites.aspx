<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="Asset_Suites.aspx.vb" Inherits="Website.Asset_Suites" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="Asset_SuitesDetails.ascx" TagName="SuiteDetails" TagPrefix="uc1" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc2" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc3" %>
<%@ Register Src="WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc4" %>
<%@ Register Src="AssetTypeWorkOrder.ascx" TagName="AssetTypeWorkOrder" TagPrefix="uc5" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc6" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc7" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc8" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc9" %>
<%@ Register Src="Leases.ascx" TagName="Leases" TagPrefix="uc10" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc11" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc12" %>


<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">
    <script src="JS/Asset/Suites.js" type="text/javascript"></script>

    <style type="text/css" runat="server">
        div.RadAjaxPanel {
            display: inline !important;
        }
    </style>

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script type="text/javascript">
            
            function OpenGoogleSuiteAddressesPicker() {
                var Id = '<%= PM.Asset.SuiteInfo.Id%>';
                if (Id > 0) {
                    var left = (screen.width - 900) / 2;
                    var top = (screen.height - 600) / 2;
                    OpenPOPUp("GoogleAddressesPicker.aspx?RecordType=ASSET_SUITES&ObjectId=" + Id + "&PickerSender=RecordAddress", 920, 415, false);
                }
                return false;
            }

            function VisualCalculator(Gross, Rentable, Usable) {
                $("input[id$=txtRentable]").val(FPrec(Rentable));
                $("input[id$=txtGrossArea]").val(FPrec(Gross));
                $("input[id$=txtUsable]").val(FPrec(Usable));

                CalculateSnapShot();
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }

            function OpenLinkAssetsPopup() {
                var Description = '<%=JSEscape(PM.Asset.SuiteInfo.Name)%>';
                var Id = '<%= PM.Asset.SuiteInfo.Id%>';
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen('LinkAssetsPopup.aspx?ObjectType=ASSET_SUITES&RecordId=' + Id + '&Description=' + Description );
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth, browserHeight);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                wnd.add_close(CloseLinkAssetsPopup);
                return false;
            }

            function CloseLinkAssetsPopup() {
                var btnRefreshHeader = $("[id$=btnRefreshHeader]");
                if (btnRefreshHeader) {
                    btnRefreshHeader.click();
                }
            }
            function maintoolbarClick(Value) {
                var HasMergeTemplate = '<%= PM.Asset.SuiteInfo.HasMergeTemplate%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("ASSET_SUITES")%>';
                var RecordDescription = '<%=JSEscape(PM.Asset.SuiteInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.Asset.SuiteInfo.Name)%>';
                var Id = '<%= PM.Asset.SuiteInfo.Id%>';
                var HasReports = '<%= PM.Asset.SuiteInfo.HasReports%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("ASSET_SUITES") %>';
                switch (Value) {
                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=ASSET_SUITES&Id=" +
                            '<%= PM.Asset.SuiteInfo.Id%>' + "&Description="
                              + Description
                               + "&RecordDescription=" + RecordDescription
                               + "&EntityId=" + '<%=PM.Asset.SuiteInfo.PropertyId%>' + "&EntityType=1", 1045, 515, false);
                        }
                        break;

                    case 'ViewPMWebReports':
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=ASSET_SUITES&Id=" + Id
                    + "&EntityId=" + '<%=PM.Asset.SuiteInfo.PropertyId%>' + "&EntityType=1", 1045, 515, false);
                        }
                        break;

                    case 'Notification':
                        if (Id == 0) break;
                        OpenPOPUp("Notification.aspx?ObjectType=ASSET_SUITES&Id=" +
                        Id + "&Description="
                                    + Description
                                    + "&RecordDescription=" + RecordDescription
                                    + "&EntityId=" + '<%=PM.Asset.SuiteInfo.PropertyId%>' + "&EntityType=1", 1045, 515, false);
                        break;


                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=ASSET_SUITES&Id=" +
                            Id
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Asset.SuiteInfo.PropertyId%>' + "&EntityType=1", 1045, 515, false);
                        }
                        break;
                    case 'New':
                        window.location = "Asset_Suites.aspx";
                        break;

                    default:
                        //  eventArgs.set_cancel(false);
                        break;
                }
            }

            var forceMoreMenuToClose = true;

            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
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
            <telerik:AjaxSetting AjaxControlID="mlpSuites">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpSuites" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpSuites" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <!-- ****************************************Main ToolBar*************************************-->

    <table class="ToolBar LargeToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=202">
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
                <telerik:RadComboBox ID="ddlSuites" runat="server"
                    Skin="Default" CloseDropDownOnBlur="true"
                    meta:resourcekey="ddlSuites" Width="240px" AutoPostBack="False" NoWrap="true"
                    CausesValidation="False" Height="400px"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                    <Items>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CommandName="Save" AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)"></telerik:RadToolBarButton>
                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New" AccessKey="n" CausesValidation="false" PostBack="false"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton SecurityButtonType="Copy" CommandName="Copy" Value="CopyRecord" ImageUrl="Images/ToolBar/CopyRecord.png"></telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>
                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                            EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewPMWebReports"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewTemplates"></telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem Text="Print" Value="Print" CssClass="Print" EnableImageSprite="true">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMweb Report" Value="ViewTemplates"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>

                                                <telerik:RadMenuItem Text="Active" Value="Active" CssClass="ActiveLocation" EnableImageSprite="true"></telerik:RadMenuItem>

                                                <telerik:RadMenuItem Text="InActive" Value="InActive" CssClass="InactiveLocation" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('ASSET_SUITES');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Help" Value="Help" onclick="helpClick();" CssClass="Help" EnableImageSprite="true"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Active.png" OuterCssClass="HideOnMobileToolbar"
                            Value="Activate" CommandName="Activation" ToolTip="Activate">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>

    <!-- *****************************************************************************************-->


    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="1" runat="server" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        MultiPageID="mlpSuites" Skin="Default" OnTabClick="tbsDocument_TabClick" Width="100%" EnableViewState="True">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True" />
            <%-- <telerik:RadTab Text="Details" Value="Details" />--%>
            <telerik:RadTab Text="Leases" Value="Leases" />
            <telerik:RadTab Text="Specifications" Value="Spec" />
            <telerik:RadTab Text="Checklists" Value="Checklists" />
            <%--<telerik:RadTab Text="Work Orders" Value="WorkOrders"/>--%>
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <telerik:RadTab Text="Workflow" Value="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpSuites" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="True" CssClass="documentMultiPages">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" HorizontalAlign="NotSet" LoadingPanelID="ldpPM" EnableAJAX="false">
                <div class="PMMainPage">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLocation" runat="server" Text="Location*" meta:resourcekey="lblLocation" />
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProperties" runat="server" Skin="Default" CloseDropDownOnBlur="true"
                                            AllowCustomText="true" Width="100%" NoWrap="true" Height="300px"
                                            CausesValidation="False" AutoPostBack="true"
                                            ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvLocation" runat="server" ControlToValidate="ddlProperties"
                                            CssClass="Validator" InitialValue="" meta:resourcekey="rfvLocation"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvLocation" runat="server" ControlToValidate="ddlProperties"
                                            ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                            CssClass="Validator" meta:resourcekey="rfvProperties">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBuilding" Text="Building" runat="server" meta:resourcekey="lblBuilding" /></td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlBuildings" runat="server" Filter="Contains"
                                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                            Height="340px" AutoPostBack="true" Width="100%" NoWrap="true"
                                            CausesValidation="False" EnableItemCaching="false"
                                            AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            Style="font-size: 11px" OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblFloor" Text="Floor" runat="server" meta:resourcekey="lblFloor" /></td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlFloors" runat="server"
                                            Skin="Default" CloseDropDownOnBlur="true" Filter="Contains" MarkFirstMatch="true"
                                            Height="340px" Width="100%" NoWrap="true" CausesValidation="False" AutoPostBack="true"
                                            EnableItemCaching="false" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                            EnableVirtualScrolling="true" Style="font-size: 11px" OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblSuiteID" Text="Suite ID*" runat="server" meta:resourcekey="lblSuiteID" />
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtCode" Width="100%" MaxLength="10"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCode" runat="server"
                                            ControlToValidate="txtCode" CssClass="Validator" ValidationGroup="Save"
                                            ErrorMessage="Required" Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                                        <asp:Label ID="lblSpaceCodeUnique" meta:resourcekey="lblSpaceCodeUnique" Text="<br> Space ID should be unique by location,building & floor." CssClass="Validator" runat="server" Visible="false"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblName" Text="Name" runat="server" meta:resourcekey="lblName" />
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtName" MaxLength="500" Width="100%"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblSuiteType" Text="Suite Type" runat="server" meta:resourcekey="lblSuiteType" />
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlType" runat="server"
                                            Skin="Default" CloseDropDownOnBlur="true" Filter="Contains" MarkFirstMatch="true"
                                            Height="340px" Width="100%" NoWrap="true" CausesValidation="False" AutoPostBack="true"
                                            EnableItemCaching="false" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                            EnableVirtualScrolling="true">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblSubType" Text="Sub-Type" runat="server" meta:resourcekey="lblSubType" /></td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlSubType" runat="server"
                                            Skin="Default" CloseDropDownOnBlur="true" Filter="Contains" MarkFirstMatch="true"
                                            Height="340px" Width="100%" NoWrap="true" CausesValidation="False" AutoPostBack="true"
                                            EnableItemCaching="false" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                            EnableVirtualScrolling="true">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLinkedGross" runat="server" Text="Linked Gross" meta:resourcekey="lblLinkedGross"></asp:Label>
                                    </td>
                                    <td class="ControlWidth">
                                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtLinkedGross" CssClass="Double" ReadOnly="true" runat="server" Width="100%"></asp:TextBox>
                                                </td>
                                                <td style="width: 50%; padding-left: 10px; color: #666666 !important;">
                                                    <span id="Span3" runat="server"><%= Me.PM.Asset.SuiteInfo.PropertyUOM%></span>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLinkedUsable" runat="server" Text="Linked Usable" meta:resourcekey="lblLinkedUsable"></asp:Label>
                                    </td>
                                    <td class="ControlWidth">
                                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtLinkedUsable" CssClass="Double" ReadOnly="true" runat="server" Width="100%"></asp:TextBox>
                                                </td>
                                                <td style="width: 50%; padding-left: 10px; color: #666666 !important;">
                                                    <span id="Span2" runat="server"><%= Me.PM.Asset.SuiteInfo.PropertyUOM%></span>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLinkedRentable" runat="server" Text="Linked Rentable" meta:resourcekey="lblLinkedRentable"></asp:Label></td>
                                    <td class="ControlWidth">
                                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtLinkedRentable" CssClass="Double" ReadOnly="true" runat="server" Width="100%"></asp:TextBox>
                                                </td>
                                                <td style="width: 50%; padding-left: 10px; color: #666666 !important;">
                                                    <span id="Span7" runat="server"><%= Me.PM.Asset.SuiteInfo.PropertyUOM%></span>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" runat="server" Text="Status" meta:resourcekey="lblStatus"></asp:Label></td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlStatus" runat="server" Width="100%" Skin="Default">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                        <table width="100%" border="0" cellpadding="0" cellspacing="0" style="display: none;">
                                            <tr>
                                                <td></td>
                                                <td style="width: 30px; padding-left: 8px;">
                                                    <asp:TextBox ID="TxtRevision" CssClass="Integer" Width="30px" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
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
                                            <asp:TextBox ID="txtBarcode" runat="Server" Width="100%" MaxLength="255"></asp:TextBox>
                                            <asp:HiddenField ID="htnBarcodeFormat" runat="server" />
                                            <asp:Label runat="server" ID="lblBarCodeUnique" CssClass="Validator" Text="<%$ Resources:PMWeb, BarCodeUniqueMsg %>"></asp:Label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label ID="LblLinkedAssets" meta:resourcekey="LblLinkedAssets" runat="server" Text="Linked Assets"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton CssClass="SearchButton" runat="server" ID="lbtLinkedAsset" OnClientClick="return OpenLinkAssetsPopup();">
                                                                                            <span class="Icon"></span>
                                            </asp:LinkButton>
                                            <asp:button id="btnRefreshHeader" runat="server" class="Hide"></asp:button>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <div class="NoWrap">
                                            <asp:TextBox ID="txtLinkedAsset" runat="Server" Width="100%" MaxLength="255" style="text-align: right;" Enabled="false" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <fieldset runat="server" id="fldsetAddress">
                                <legend>
                                    <asp:Label ID="lblAddress" meta:resourcekey="lblAddress" runat="server" Text="Address" Style="text-transform: uppercase;"></asp:Label>
                                </legend>
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblAddress1" meta:resourcekey="lblAddress1" Text="Address 1"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtAddress1" MaxLength="100" runat="server" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblAddress2" meta:resourcekey="lblAddress2" Text="Address 2"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtAddress2" MaxLength="100" runat="server" Text="" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblCity" meta:resourcekey="lblCity" Text="City"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtCity" MaxLength="50" runat="server" Text="" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblState" meta:resourcekey="lblState" Text="State/ZIP"></asp:Label>
                                        </td>
                                        <td>
                                            <table width="100%" border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <telerik:RadComboBox ID="ddlStates" runat="server" Width="116px" Skin="Default"
                                                            Height="400px" NoWrap="true" AllowCustomText="true" Filter="Contains">
                                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                                        </telerik:RadComboBox>
                                                    </td>
                                                    <td style="text-align: right;">
                                                        <asp:TextBox ID="txtZip" runat="server" Width="116px"></asp:TextBox>
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
                                            <telerik:RadComboBox ID="ddlCountries" runat="server" Skin="Default" AllowCustomText="true"
                                                Height="400px" Width="100%">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="LblPhone" meta:resourcekey="LblPhone" Text="Phone"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="TxtPhone" MaxLength="100" runat="server" Text="" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="LblFax" meta:resourcekey="LblFax" Text="Fax"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtFax" MaxLength="100" runat="server" Text="" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <div style="float: left;">
                                                <asp:Label runat="server" ID="lblGoogleAddress" meta:resourcekey="lblGoogleAddress" Text="Google Address11"></asp:Label>
                                            </div>
                                            <div style="float: right;">
                                                <asp:LinkButton CssClass="SearchButton" runat="server" ID="btnGoogleAddress" OnClientClick="return OpenGoogleSuiteAddressesPicker();">
                                                                                        <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </div>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtGoogleAddress" MaxLength="255" runat="server" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </div>
                        <div class="col-4 col-4-middle">
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblSnapshot" runat="server" Text="Snapshot" meta:resourcekey="lblSnapshot" Style="text-transform: uppercase;"></asp:Label>
                                </legend>
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:LinkButton runat="server" ID="imgVisualCalculator1" Style="vertical-align: middle; cursor: pointer"
                                                align="left" class="VisualCalculatorButton">
                                                <div>
                                                    <telerik:RadCodeBlock runat="server">
                                                        <asp:LinkButton CssClass="SearchButton" runat="server" ID="imgVisualCalculator">
                                                                                                <span class="Icon"></span>
                                                        </asp:LinkButton>
                                                    </telerik:RadCodeBlock>
                                                </div>
                                            </asp:LinkButton>
                                        </td>
                                        <td class="controlWidth" style="text-align: center; color: #666666; text-transform: uppercase">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblMarket" runat="server" Text="Market" meta:resourcekey="lblMarket" Width="116px"></asp:Label>
                                                    </td>
                                                    <td style="text-align: center;">
                                                        <asp:Label ID="lblCurrent" runat="server" Text="Current" meta:resourcekey="lblCurrent" Width="116px"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblRentMonth" runat="server" Text="Rent/Month" meta:resourcekey="lblRentMonth"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <asp:TextBox ID="txtMarketRentMonth" CssClass="Currency" runat="server" Width="116px"></asp:TextBox>
                                                    </td>
                                                    <td style="text-align: right;">
                                                        <asp:TextBox ID="txtCurrentRentMonth" ReadOnly="True" CssClass="Currency" runat="server" Width="116px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblRentYear" runat="server" Text="Rent/Year" meta:resourcekey="lblRentYear"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <asp:TextBox ID="txtMarketRentYear" ReadOnly="True" CssClass="Currency" runat="server" Width="116px"></asp:TextBox>
                                                    </td>
                                                    <td style="text-align: right;">
                                                        <asp:TextBox ID="txtCurrentRentYear" ReadOnly="True" CssClass="Currency" runat="server" Width="116px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblGrossArea" runat="server" Text="Gross Area" meta:resourcekey="lblGrossArea"></asp:Label></td>
                                        <td class="controlWidth">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td style="width: 116px;">
                                                        <asp:TextBox ID="txtGrossArea" CssClass="Double" runat="server" Width="116px"></asp:TextBox>
                                                    </td>
                                                    <td style="padding-left: 8px; color: #666666;">
                                                        <span id="Span4" runat="server"><%= Me.PM.Asset.SuiteInfo.PropertyUOM%></span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblRentable" runat="server" Text="Rentable" meta:resourcekey="lblRentable"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td style="width: 116px;">
                                                        <asp:TextBox ID="txtRentable" CssClass="Double" runat="server" Width="116px"></asp:TextBox>
                                                    </td>
                                                    <td style="padding-left: 8px; color: #666666;">
                                                        <span id="Span5" runat="server"><%= Me.PM.Asset.SuiteInfo.PropertyUOM%></span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblUsable" runat="server" Text="Usable" meta:resourcekey="lblUsable"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td style="width: 116px;">
                                                        <asp:TextBox ID="txtUsable" CssClass="Double" runat="server" Width="116px"></asp:TextBox>
                                                    </td>
                                                    <td style="padding-left: 8px; color: #666666;">
                                                        <span id="Span6" runat="server"><%= Me.PM.Asset.SuiteInfo.PropertyUOM%></span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblRentAreaMonth" runat="server" Text="Rent/Area/Month" meta:resourcekey="lblRentAreaMonth"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <asp:TextBox ID="txtMarketRentAreaMonth" ReadOnly="True" CssClass="Currency" runat="server" Width="116px"></asp:TextBox>
                                                    </td>
                                                    <td style="text-align: right;">
                                                        <asp:TextBox ID="txtCurrentRentAreaMonth" ReadOnly="True" CssClass="Currency" runat="server" Width="116px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblRentAreaYear" runat="server" Text="Rent/Area/Year" meta:resourcekey="lblRentAreaYear"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <asp:TextBox ID="txtMarketRentAreaYear" ReadOnly="True" CssClass="Currency" runat="server" Width="116px"></asp:TextBox>
                                                    </td>
                                                    <td style="text-align: right;">
                                                        <asp:TextBox ID="txtCurrentRentAreaYear" ReadOnly="True" CssClass="Currency" runat="server" Width="116px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                            <%--<tr>
                                                                    <td><asp:Label ID="lblCurrentTenant" runat="server" Text="Current Tenant" meta:resourcekey="lblCurrentTenant"></asp:Label></td>
                                                                    <td colspan = "3"><asp:TextBox ID="txtCurrentTenant"  CssClass="Double" runat="server" ReadOnly = "True" style="width:190px"></asp:TextBox></td>
                                                                    </tr>--%>

                        </div>
                        <div class="col-4 col-4-right">
                            <uc6:AssetRotator ID="PMrot" runat="server" />
                            <uc12:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />

                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <%--  <telerik:RadPageView ID="pvDetails" runat="server">
                                    <uc1:SuiteDetails ID="SuiteDetails" runat="server" />
                                </telerik:RadPageView>--%>
        <telerik:RadPageView ID="pvLeases" runat="server">
            <uc10:Leases ID="Leases1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc7:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc8:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc3:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc2:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <uc4:WorkflowDocument ID="WorkflowDocument1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc11:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc9:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>



</asp:Content>
