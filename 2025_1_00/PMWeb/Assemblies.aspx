<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="Assemblies.aspx.vb" Inherits="Website.Assemblies" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="AssembliesDetails.ascx" TagName="AssembliesDetails" TagPrefix="uc1" %>
<%@ Register Src="ngDocNotes.ascx" TagName="DocumentNotes" TagPrefix="uc2" %>
<%@ Register Src="ngDocAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc3" %>
<%@ Register Src="AssetRotator.ascx" TagName="ItemRotator" TagPrefix="uc4" %>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH1" runat="server">

    <asp:PlaceHolder ID="phStartupSript" runat="server"></asp:PlaceHolder>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script language="javascript" type="text/javascript">

            function ShowHideQuantity(ddlVariablesId, txtQuantityId) {
                if (document.getElementById(ddlVariablesId).selectedIndex == 0) {
                    document.getElementById(txtQuantityId).style.display = 'inline';
                } else {
                    document.getElementById(txtQuantityId).style.display = 'none';
                }
            }

            var forceMoreMenuToClose = true;
            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                    sender.close(true);
                    if (args.get_item().get_value() == "Test") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("Test");
                        button.click();
                    }
                    maintoolbarClick(args.get_item().get_value(), args)
                }
            }
            function MoreMenuClosing(sender, args) {
                if (forceMoreMenuToClose) {
                    return;
                }
                args.set_cancel(true);
            }
            function MoreMenuOpening(sender, args) {
                if (!forceMoreMenuToClose) { args.set_cancel(true); return; }
            }
            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }
            function maintoolbarClick(Value) {
                var left = (screen.width - 910) / 2;
                var top = (screen.height - 380) / 2;
                var HasPMWebReports = '<%=PM.QueryBuilderPermissionController.HasReports("ASSEMBLY")%>';
                var Id = '<%= PM.Estimate.AssemblyInfo.Id %>';
                switch (Value) {
                    case 'BIReporting':
                    case 'Print':
                       window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        args.set_cancel(true);
                        break;
                    case 'ViewPMWebReports':           
                        if (HasPMWebReports == 'True' && Id > 0) {
                            var browserWidth = $telerik.$(window).width();
                            var browserHeight = $telerik.$(window).height();
                           var wnd= window.radopen("PMWebReports.aspx?ObjectType=ASSEMBLY&Id=" + Id);
                            if (isMobileScreen()) {
                                wnd.setSize(browserWidth - 10, browserHeight - 10);
                                wnd.moveTo(8, 0);
                            }
                            else {
                                wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                                wnd.Center();
                            }
                        }
                        break;
                    case 'New':
                        window.location = "Assemblies.aspx";
                        break;
                    default:
                        break;
                }
            }

            var showConfirm = 1;

            function onClientSelectedIndexChanging(combo, eventArgs) {
                var callBackFn = function (arg) {
                    if (arg == true && showConfirm == 1) {
                        combo.clearSelection();
                        var item = eventArgs.get_item();
                        showConfirm = 0;
                        combo.findItemByText(item.get_text()).select();
                        combo.set_text(item.get_text());
                        combo.set_value(item.get_value());
                        __doPostBack("ddlFormulas", '{\"Command\":\"Select\"}');
                        showConfirm = 1;
                    }
                }
                if (showConfirm == 1) {
                    radconfirm(unescape(NotificationMessage), callBackFn, 600, 200, null, "", "42");

                }
                eventArgs.set_cancel(true);
            }

        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings> 
             <telerik:AjaxSetting AjaxControlID="mlpAssemblies">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpAssemblies" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpAssemblies" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="ldpAssemblyDetail" runat="server" Skin="Default" />
    <script language="javascript" type="text/javascript" src="JS/Estimates/Assemblies.js"></script>

    <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar LargeToolBar">
        <tr valign="top">
                        <td class="ToolbarTd">
                            <asp:LinkButton runat="server" ID="btnSearchTree" PostBackUrl="AssembliesSearch.aspx">
                                <div class="btnToolbarSearchTree">
                                                   &nbsp; 
                                                </div>
                            </asp:LinkButton>
                        </td>
                        <td style="vertical-align: middle; width: 70%; padding-left: 24px;" class="ToolbarTd">
                            <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default"
                                AutoPostBack="True">
                                <Items>
                                    <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                                        CommandName="Save" AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)" Value="Save">
                                    </telerik:RadToolBarButton>
                                    
                                            <telerik:RadToolBarButton PostBack="false"  ImageUrl="Images/Global/AddLine.png"
                                                CommandName="New">
                                            </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                                        CommandName="Delete" AccessKey="d" Value="Delete" CausesValidation="false">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                                    <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                                        EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint">
                                        <Buttons>
                                            <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewPMWebReports">
                                            </telerik:RadToolBarButton>
                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>
                                    <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Test.png" CausesValidation="false" CommandName="Test"
                                        ToolTip="Test" Value="Test" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="lnkButtonBar" Text="Test Assembly">
                                    </telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                                        <ItemTemplate>
                                            <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                                <Items>
                                                    <telerik:RadMenuItem CssClass="menuMore">
                                                        <Items>
                                                            <telerik:RadMenuItem Text="Print" Value="Print" CssClass="Print">
                                                                <Items>
                                                                    <telerik:RadMenuItem Text="Go To Bi Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                                    <telerik:RadMenuItem Text="Show Linked BI Reports" Value="ViewReports"></telerik:RadMenuItem>
                                                                </Items>
                                                            </telerik:RadMenuItem>
                                                            <telerik:RadMenuItem Text="Test" Value="Test" CssClass="Test"></telerik:RadMenuItem>
                                                              <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('ASSEMBLY');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                            <telerik:RadMenuItem Text="Help" Value="Help" onclick="helpClick();" CssClass="Help"></telerik:RadMenuItem>

                                                        </Items>
                                                    </telerik:RadMenuItem>

                                                </Items>
                                            </telerik:RadMenu>
                                        </ItemTemplate>
                                    </telerik:RadToolBarButton>
                                    <%--<telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Print" ImageUrl="Images/ToolBar/Printer.png" PostBack ="false" >
                                    </telerik:RadToolBarButton>--%>
                                    <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="ExporttoExcel" ImageUrl="Images/toolbar/Excel.png" Visible="false">
                                    </telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton ImageUrl="Images/ToolBar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_Estimating.htm#Assemblies">
                                    </telerik:RadToolBarButton>
                                </Items>
                            </telerik:RadToolBar>
                        </td>
                        <td style="width: 100%"></td>
                    </tr>
       
    </table>
    <table style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr id="trTbsDetails" runat="server">
            <td>
                <table width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
                                runat="server" MultiPageID="mlpAssemblies" Skin="Default" OnTabClick="tbsDocument_TabClick"
                                Width="100%" EnableViewState="true" CausesValidation="False">
                                <Tabs>
                                    <telerik:RadTab Text="Header" Value="Header" Selected="true"></telerik:RadTab>
                                    <telerik:RadTab Value="Details" CssClass="HideTabWhenDetailShownInHeader" />
                                    <telerik:RadTab Value="Notes" />
                                    <telerik:RadTab Value="Attachments" />
                                </Tabs>
                            </telerik:RadTabStrip>
                            <telerik:RadMultiPage ID="mlpAssemblies" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPages"
                                RenderSelectedPageOnly="True" BorderWidth="0">
                                <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
                                    <div class="PMMainPage">
                                        <div class="row JustifyContent R3Cols">
                                            <div class="col-4 col-4-left">
                                                <table class="colTable">
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label runat="server" ID="lblIdTitle" meta:resourcekey="lblAssemblyId" Text="Assembly ID*"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth" style="text-align:right">
                                                            <asp:TextBox runat="server" ID="txtId" ReadOnly="true" style="text-align:right;"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblDescription" runat="server" Text="<%$ Resources:Description %>"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <asp:TextBox runat="server" MaxLength="200" ID="txtDescription"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription" ValidationGroup="Save"
                                                                CssClass="Validator" Display="Dynamic" ForeColor="" meta:resourcekey="rfvRequiredDescription"></asp:RequiredFieldValidator>
                                                        </td>

                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblAssemblyGroup" runat="server" meta:resourcekey="lblAssemblyGroup"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <telerik:RadComboBox ID="ddlAssemblyGroup" runat="server" OnClientLoad="comboLoad" DropDownCssClass="ddlTreeviewTemplate"
                                                                Width="100%" Skin="Default" OnClientDropDownOpened="OnClientDropDownOpenedHandler" Height="300px"
                                                                LoadingMessage="<%$ Resources:PMWeb, Loading %>" >
                                                                <Items>
                                                                    <telerik:RadComboBoxItem Value="0" runat="server"
                                                                        meta:resourcekey="RadComboBoxItem" />
                                                                </Items>
                                                                <ItemTemplate>
                                                                    <telerik:RadTreeView ID="treeAssemblyGroups" Skin="Default" runat="server" Width="100%" />
                                                                </ItemTemplate>
                                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="LblType" runat="server" meta:resourcekey="LblType"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <telerik:RadComboBox ID="ddlType" runat="server" Width="100%" Skin="Default" AllowCustomText="true"
                                                                LoadingMessage="<%$ Resources:PMWeb, Loading %>" Filter="Contains" MarkFirstMatch="true">
                                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblUOM" runat="server" meta:resourcekey="lblUOM"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <telerik:RadComboBox ID="ddlUOM" runat="server" Width="100%" Height="400px" Skin="Default" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true"
                                                                LoadingMessage="<%$ Resources:PMWeb, Loading %>" Style="font-size: 11px">
                                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblFormula" runat="server" meta:resourcekey="lblFormula"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <telerik:RadComboBox ID="ddlFormulas" runat="server" Width="100%" Skin="Default" Filter="Contains" MarkFirstMatch="false" AllowCustomText="true"
                                                               OnClientSelectedIndexChanging="onClientSelectedIndexChanging"
                                                                LoadingMessage="<%$ Resources:PMWeb, Loading %>" OnSelectedIndexChanged="ddlFormulas_SelectedIndexChanged">
                                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div class="col-4 col-4-middle">
                                                <fieldset>
                                                    <legend>
                                                        <asp:Label ID="lblDefaults" runat="server" CssClass="legend" meta:resourcekey="lblDefaults" Text="Defaults"></asp:Label>
                                                    </legend>
                                                    <table class="colTable">
                                                        <tr>
                                                            <td class="labelWidth">
                                                                <asp:Label ID="lblTemplate" runat="server" meta:Resourcekey="lblTemplate" Text="Template"></asp:Label>
                                                            </td>
                                                            <td class="controlWidth">
                                                                <telerik:RadComboBox ID="ddlProjects" runat="server" Height="350px"
                                                                    meta:Resourcekey="ddlProjects" Skin="Default" AllowCustomText="true"
                                                                    EmptyMessage="Select Project..." Width="100%" AutoPostBack="True" NoWrap="true"
                                                                    CausesValidation="False" OnClientTextChange="LOD_DropDownTextChange"
                                                                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" OnItemsRequested="ddl_ItemsRequested"
                                                                    EnableVirtualScrolling="True">
                                                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                                </telerik:RadComboBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="labelWidth">
                                                                <asp:HyperLink ID="hplCostCode" runat="server" meta:Resourcekey="lblCostCode"></asp:HyperLink>
                                                            </td>
                                                            <td class="controlWidth">
                                                                <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="100%"
                                                                    Skin="Default" AllowCustomText="true" Height="300px"
                                                                    EmptyMessage="Select Cost Code..." AutoPostBack="False" NoWrap="true"
                                                                    CausesValidation="False" OnClientTextChange="LOD_DropDownTextChange"
                                                                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" OnItemsRequested="ddl_ItemsRequested"
                                                                    EnableVirtualScrolling="True" meta:Resourcekey="ddlDefaultCostCodes">
                                                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                                </telerik:RadComboBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="labelWidth">
                                                                <asp:Label ID="lblCostType" runat="server" meta:resourcekey="lblCostType"></asp:Label>
                                                            </td>
                                                            <td class="controlWidth">
                                                                <telerik:RadComboBox ID="ddlCostTypes" runat="server" Width="100%" Skin="Default" AllowCustomText="true"
                                                                    LoadingMessage="<%$ Resources:PMWeb, Loading %>" Filter="Contains" MarkFirstMatch="true">
                                                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                                                </telerik:RadComboBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="labelWidth">
                                                                <asp:Label ID="lblPhase" runat="server" meta:resourcekey="lblPhase" ></asp:Label>
                                                            </td>
                                                            <td class="controlWidth">
                                                                <telerik:RadComboBox ID="ddlPhases" Height="300px" AllowCustomText="true" Filter="Contains" MarkFirstMatch="false" runat="server" Width="100%" Skin="Default"
                                                                    LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                                                </telerik:RadComboBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="labelWidth">
                                                                <asp:Label ID="lblLocation" runat="server" meta:resourcekey="lblLocation"></asp:Label>
                                                            </td>
                                                            <td class="controlWidth">
                                                                <telerik:RadComboBox ID="ddlLocations" Height="300px" AllowCustomText="true" Filter="Contains" MarkFirstMatch="false" runat="server" Width="100%" Skin="Default"
                                                                    LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                                                </telerik:RadComboBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="labelWidth">
                                                               
                                                                    <asp:Label runat="server" ID="lblWBS"  meta:resourcekey="lblWBS"></asp:Label>
                                                             </td>
                                                            <td class="controlWidth">
                                                                <telerik:RadComboBox ID="ddlWBS" runat="server" Width="100%" AutoPostBack="false"
                                                                    CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListWBSEmptyMsg %>'
                                                                    NoWrap="True" AllowCustomText="true"
                                                                    OnClientDropDownClosed="dllcompClientClosed1"
                                                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                                    OnItemsRequested="ddl_ItemsRequested"
                                                                    Style="font-size: 11px" Height="250px">
                                                                </telerik:RadComboBox>

                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="labelWidth">
                                                                <div style="float: left;">
                                                                    <asp:Label ID="lblCompany" runat="server" meta:resourcekey="lblCompany"></asp:Label>
                                                                </div>
                                                                <div style="float: right;">
                                                                    <asp:LinkButton CssClass="SearchButton" runat="server" ID="imgfilter1"  OnClientClick="return OpenCompanyFilterPopupProjectNotRequired(this.id.replace('imgfilter1','HiddenField2'),this.id.replace('imgfilter1','ddlCompanies'),'Companies')">
                                                                                <span class="Icon"></span>
                                                                    </asp:LinkButton>
                                                                     <asp:HiddenField ID="HiddenField2" runat="server" />
                                                                </div>
                                                            </td>
                                                            <td class="controlWidth">
                                                                <telerik:RadComboBox ID="ddlCompanies" runat="server" Width="100%"
                                                                    Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select ..."
                                                                    NoWrap="True" AllowCustomText="true" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                                    meta:Resourcekey="ddlDefaultCompanies" OnItemsRequested="ddl_ItemsRequested"
                                                                    Height="350px">
                                                                </telerik:RadComboBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="labelWidth">
                                                                <asp:Label ID="lblBidCategory" meta:Resourcekey="lblBidCategory" runat="server"></asp:Label>
                                                            </td>
                                                            <td class="controlWidth">
                                                                <telerik:RadComboBox ID="ddlBidCategories" runat="server" Width="100%" Skin="Default" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true">
                                                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                                                </telerik:RadComboBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </fieldset>
                                            </div>
                                            <div class="col-4 col-4-right">
                                                <uc4:ItemRotator ID="PMrot" runat="server" />
                                            </div>
                                        </div>
                                    </div>
                                </telerik:RadPageView>
                                <telerik:RadPageView ID="pvDetails" runat="server" CssClass="ShowInHeaderWhenFit Responsive">
                                    <uc1:AssembliesDetails ID="AssembliesDetails1" runat="server" />
                                </telerik:RadPageView>
                                <telerik:RadPageView ID="pvNotes" runat="server" Visible="False">
                                    <uc2:DocumentNotes ID="DocumentNotes" runat="server" />
                                </telerik:RadPageView>
                                <telerik:RadPageView ID="pvAttachments" runat="server" Visible="False">
                                    <uc3:DocumentAttachments ID="DocumentAttachments" runat="server" />
                                </telerik:RadPageView>
                            </telerik:RadMultiPage>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
