<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="LocationPrograms.aspx.vb" Inherits="Website.LocationPrograms" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="LocationProgramsDetails.ascx" TagName="LocationProgramsDetails"
    TagPrefix="uc1" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc2" %>
<%@ Register Src="LocationProgramsLocations.ascx" TagName="LocationProgramsLocations"
    TagPrefix="uc3" %>
<%@ Register Src="ProjectProgramPaymentApplications.ascx" TagName="ProjectProgramPaymentApplications"
    TagPrefix="uc4" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc5" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc6" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc7" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc8" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc9" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">

    <style type="text/css">
        /* The following CSS needs to be copied to the page to produce textbox-like RadEditor */
        .RadGrid_PM .rgActiveRow td, .RadGrid_PM .rgHoveredRow td, .RadGrid_PM .rgEditRow td {
            border-bottom-color: #D0D7E5;
            white-space: normal;
        }

        .reLeftVerticalSide, .reRightVerticalSide, .reToolZone, .reToolCell {
            background: white !important;
        }



        .reContentCell {
            border-width: 0 !important;
        }

        .formInput {
            border: solid 1px black;
        }

        .RadEditor {
            filter: chroma(color=c2dcf0);
            width: 100% !important;
            height: 100% !important;
            min-width: 100% !imprtant;
            min-height: 100% !important;
        }

        .reWrapper_corner, .reWrapper_center {
            display: none !important; /* for FF */
            width: 100% !important;
            height: 100% !important;
        }

        td.reWrapper_corner, td.reWrapper_center {
            display: none\9 !important; /* for all versions of IE */
        }

        .reModule {
            display: none !important;
        }
    </style>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            var forceMoreMenuToClose = true;
            function OpenGoogleLocProgramAddressesPicker() {
                var Id = '<%= PM.Asset.ProgramInfo.Id%>';
                if (Id > 0) {
                    var left = (screen.width - 900) / 2;
                    var top = (screen.height - 600) / 2;
                    OpenPOPUp("GoogleAddressesPicker.aspx?RecordType=LOC_PROGRAM&ObjectId=" + Id + "&PickerSender=RecordAddress",
                    'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=900,height=600,top=' + top + ',left=' + left);
                }
                return false;
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }


            function maintoolbarClick(Value) {

                var HasMergeTemplate = '<%= PM.Asset.ProgramInfo.HasMergeTemplate%>';
                var HasReports = '<%= PM.Asset.ProgramInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.Asset.ProgramInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.Asset.ProgramInfo.Name)%>';
                var Id = '<%= PM.Asset.ProgramInfo.Id%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("LOC_PROGRAM")%>';

                switch (Value) {

                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            var left = (screen.width - 1045) / 2;
                            var top = (screen.height - 515) / 2;
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=LOC_PROGRAM&Id=" +
                            '<%= PM.Asset.ProgramInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=0&EntityType=0",
                            'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=1045,height=515,top=' + top + ',left=' + left);
                        }
                        break;

                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=LOC_PROGRAM&Id=" +
                 '<%= PM.Asset.ProgramInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=0&EntityType=0", "Notification",
                'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=800,height=500,top=' + top + ',left=' + left);
                        break;
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=LOC_PROGRAM&Id=" +
                            '<%= PM.Asset.ProgramInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=0&EntityType=0",
                            'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;

                    case 'Print':

                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=LOC_PROGRAM&Id=" +
                            '<%= PM.Asset.ProgramInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=0&EntityType=0",
                            'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
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
                            OpenPOPUp("PMWebReports.aspx?ObjectType=LOC_PROGRAM&Id=" + Id
                    + "&EntityId=0&EntityType=0",
                    'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;
                    case 'New':
                        window.location = "LocationPrograms.aspx";
                        break;

                    default:
                        //                        eventArgs.set_cancel(false);
                        break;
                }
            }
            function Upload() {

                var upload = document.querySelector('.Upload');
           
                upload.click();
                return false;
            }

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

            function LoadImage(FileUpload) {
                if (FileUpload.files) {
                    var btnlogo = document.querySelector(".UploadImage");
                    btnlogo.style.visibility = 'visible';
                    var btnclearimage = document.querySelector(".btnclearimage");
                    btnclearimage.style.visibility = 'visible';
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        var result = e.target.result;
                        document.querySelector('.UploadImage').src = result;
                    }
                    reader.readAsDataURL(FileUpload.files[0]);

                }


                return false;
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

        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="mlpLocationProgram">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpLocationProgram" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpLocationProgram" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <%--<telerik:RadStyleSheetManager ID="SSH1" EnableStyleSheetCombine="true" runat="server">
        <StyleSheets>
            <telerik:StyleSheetReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Skins.Editor.css" />
            <telerik:StyleSheetReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Skins.Office2007.Editor.Office2007.css" />
            <telerik:StyleSheetReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Skins.Window.css" />
            <telerik:StyleSheetReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Skins.Office2007.Window.Office2007.css" />
        </StyleSheets>
    </telerik:RadStyleSheetManager>--%>
    <table class="ToolBar LargeToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:HyperLink runat="server" ID="btnSearchDocument" CssClass="lnkPage" NavigateUrl="SearchDocument.aspx?O=206">
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
            <td style="width: 240px" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                <telerik:RadComboBox ID="ddlLocationPrograms" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                    OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging" Skin="Default" Width="100%" AutoPostBack="false" NoWrap="True" AllowCustomText="True"
                    CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" meta:resourcekey="ddlBIMModelManagers"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" DropDownCssClass="ToolbarDropdown">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True">
                    <Items>
                        <%--        <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                                                    Value="Search">
                                                </telerik:RadToolBarButton>--%>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" ValidationGroup="Save" CausesValidation="true" AccessKey="s">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">

                            <Buttons>
                                <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                    CommandName="New" AccessKey="n" CausesValidation="false" PostBack="false">
                                </telerik:RadToolBarButton>

                                <telerik:RadToolBarButton Width="150px" ImageUrl="Images/ToolBar/Revision.png"
                                    CommandName="Copy" Value="CopyRecord"  ValidationGroup="Save">
                                </telerik:RadToolBarButton>
                            </Buttons>

                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" Value="Delete">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <%-- <telerik:RadToolBarButton SecurityButtonType="Copy" CommandName="Copy" Value="CopyRecord"
                                                    ImageUrl="Images/ToolBar/CopyRecord.png">
                                                </telerik:RadToolBarButton>--%>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false"
                            CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print"
                            SecurityButtonType="Read" EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif"
                                    CommandName="ViewReports" Value="ViewReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif"
                                    CommandName="ViewPMWebReports" Value="ViewPMWebReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewTemplates" Value="ViewTemplates">
                                </telerik:RadToolBarButton>
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
                                                        <telerik:RadMenuItem Text="Go To Bi Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="ViewPMWebReports" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="ViewTemplates" Value="ViewTemplates"></telerik:RadMenuItem>

                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Active" Value="Active" CssClass="ActiveLocation" EnableImageSprite="true"></telerik:RadMenuItem>

                                                <telerik:RadMenuItem Text="InActive" Value="InActive" CssClass="InactiveLocation" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('LOC_PROGRAM');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Help" Value="Help" onclick="helpClick();" CssClass="Help" EnableImageSprite="true"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>

                        <%--<telerik:RadToolBarButton SecurityButtonType="Add" CommandName="CreateRevision" ImageUrl="Images/ToolBar/Revision.png"
                                                    Visible="false">
                                                </telerik:RadToolBarButton>--%>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Active.png" OuterCssClass="HideOnMobileToolbar"
                            Value="Activate" CommandName="Activation" ToolTip="Activate">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>

    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        runat="server" MultiPageID="mlpLocationProgram" Skin="Default" Width="100%"
        EnableViewState="True" CausesValidation="False">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True"></telerik:RadTab>

            <telerik:RadTab Text="Specifications" Value="Spec" />
            <telerik:RadTab Text="Locations" Value="Locations" />
            <%-- <telerik:RadTab Value="Payments" Text="Payments" />--%>
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpLocationProgram" runat="server" SelectedIndex="0" CssClass="documentMultiPages"
        RenderSelectedPageOnly="True">
        <telerik:RadPageView ID="pvHeader" runat="server">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" HorizontalAlign="NotSet" Width="100%" EnableAJAX="false">
                <div class="PMMainPage">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProgramId" meta:Resourcekey="lblProgramId" runat="server"></asp:Label>
                                    </td>
                                    <td class="Wrap controlWidth">
                                        <asp:TextBox ID="txtProgramId" MaxLength="20" runat="server" Width="100%"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvProgramID" meta:resourcekey="rfv_Required" runat="server"
                                            ErrorMessage="Required" ControlToValidate="txtProgramID" ValidationGroup="Save"
                                            Display="Dynamic" CssClass="Validator">
                                        </asp:RequiredFieldValidator>
                                        <asp:Label ID="lblCommIDUnique" runat="server" Text="ID must be unique" meta:Resourcekey="lblCommIDUnique"
                                            Visible="False" Class="Validator"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblName" meta:Resourcekey="lblName" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtName" MaxLength="100" runat="server" Width="100%"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvName" meta:resourcekey="rfv_Required" runat="server"
                                            ControlToValidate="txtName" ValidationGroup="Save" Display="Dynamic" CssClass="Validator">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblType" meta:Resourcekey="lblType"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlTypes" runat="server" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true" Width="100%" meta:Resourcekey="ddlTypes" Skin="Default">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblCategory" meta:Resourcekey="lblCategory"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCategories" runat="server" Filter="Contains" MarkFirstMatch="true" AllowCustomText="True" Width="100%" meta:Resourcekey="ddlCategories" Skin="Default">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblProgramStatus" meta:Resourcekey="lblProgramStatus"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProgramStatus" runat="server" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true" Width="100%" meta:Resourcekey="ddlProgramStatus" Skin="Default">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRevision" meta:Resourcekey="lblRevision" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table width="100%" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td style="width: 182px; padding-right: 8px">
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Width="100%" meta:Resourcekey="ddlStatus" Skin="Default">
                                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td style="width: 50px">
                                                    <asp:TextBox ID="txtRevisionNumber" runat="server" Width="100%" ReadOnly="true" class="PositiveInteger"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label runat="server" ID="lblCurrency" meta:Resourcekey="hplCurrency" Text="Currency11"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton CssClass="SearchButton" runat="server" ID="imgCurrency">
                                                                                    <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCurrencies" runat="server" Width="100%" Height="250px" meta:Resourcekey="ddlCurrencies" Skin="Default">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblTargetBudget" meta:Resourcekey="lblTargetBudget" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtTargetBudget" MaxLength="15" CssClass="Currency" runat="server" Width="100%"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblTargetRevenue" meta:Resourcekey="lblTargetRevenue" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtTargetRevenue" MaxLength="15" CssClass="Currency" runat="server" Width="100%"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDirector" meta:Resourcekey="lblDirector" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtDirector" MaxLength="100" runat="server" Width="100%"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblManager" meta:Resourcekey="lblManager" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtManager" MaxLength="100" runat="server" Width="100%"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProgramManager" meta:Resourcekey="lblProgramManager" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProgramManagers" runat="server" Width="100%" DropDownWidth="385px"
                                            Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" meta:Resourcekey="ddlProgramManagers"
                                            NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                            EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                            Height="250px">
                                            <HeaderTemplate>
                                                <table style="width: 385px" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td style="width: 250px;">
                                                            <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal>
                                                        </td>
                                                        <td style="width: 135px;">
                                                            <asp:Literal ID="Literal4" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table style="width: 385px" cellspacing="0" cellpadding="2">
                                                    <tr>
                                                        <td style="width: 250px;">
                                                            <%#DataBinder.Eval(Container, "Attributes['CompanyName']")%>
                                                        </td>
                                                        <td style="width: 135px;">
                                                            <%#DataBinder.Eval(Container, "Attributes['ContactName']")%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                            </table>
                            <fieldset runat="server">
                                <legend>
                                    <asp:Label ID="lblAddress" meta:Resourcekey="lblAddress" runat="server" CssClass="legend"></asp:Label>
                                </legend>
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblAddress1" meta:Resourcekey="lblAddress1" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtAddress1" MaxLength="255" runat="server" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblAddress2" meta:Resourcekey="lblAddress2" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtAddress2" MaxLength="255" runat="server" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblCity" meta:Resourcekey="lblCity" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtCity" MaxLength="255" runat="server" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblState" meta:resourcekey="lblState" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <table class="TableNoSpacingNoBorder">
                                                <tr>
                                                    <td width="50%" style="padding-right: 5px;">
                                                        <telerik:RadComboBox ID="ddlStates" runat="server" Width="100%" Skin="Default"
                                                            NoWrap="true" Height="200px" AllowCustomText="true" Filter="Contains">
                                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                                        </telerik:RadComboBox>
                                                    </td>
                                                    <td width="50%" style="padding-left: 5px;">
                                                        <asp:TextBox ID="TxtZip" MaxLength="255" runat="server" Width="100%"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblCountry" meta:resourcekey="lblCountry" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlCountries" Width="100%" Height="200px" AllowCustomText="true"
                                                Filter="Contains" runat="server" Skin="Default">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPhone" meta:Resourcekey="lblPhone" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtPhone" MaxLength="255" runat="server" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblFax" meta:Resourcekey="lblFax" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtFax" MaxLength="255" runat="server" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblTags" meta:Resourcekey="lblTags" runat="server" CssClass="legend"></asp:Label>
                                </legend>
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <div style="float: left;">
                                                <asp:Label runat="server" ID="lblGoogleAddress" meta:resourcekey="lblGoogleAddress" Text="Geolocation"></asp:Label>
                                            </div>
                                            <div style="float: right;">
                                                <asp:LinkButton CssClass="SearchButton" runat="server" ID="btnGoogleAddress" OnClientClick="return OpenGoogleLocProgramAddressesPicker();">
                                                                                                <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </div>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtGoogleAddress" MaxLength="255" runat="server" Width="100%"></asp:TextBox>
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
                                        <td style="vertical-align: top;" class="labelWidth">
                                            <div style="float: left;">
                                                <asp:Label ID="lblUploadLogo" meta:Resourcekey="lblUploadLogo" runat="server" Text="Upload Logo"></asp:Label>
                                            </div>
                                            <div style="float: right">
                                                <asp:LinkButton CssClass="SearchButton" Style="cursor: pointer" runat="server" ID="btnUpload" OnClientClick="return Upload();">
                                                                            <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </div>

                                            <div style="width: 16px; height: 16px; margin-right: 13px; margin-top: 25px; float: right;">
                                                <asp:Button ID="btnClearImage" runat="server" Style="background-color: unset !important" CssClass="btnclearimage" />
                                            </div>
                                        </td>
                                        <td class="controlWidth">
                                            <div>
                                                <asp:Image ID="imglogo" runat="server" CssClass="UploadImage" ImageUrl="Images/Global/WhiteDot.gif" Style="height: 80px; width: 240px" />
                                            </div>
                                            <div style="display: none">
                                                <asp:FileUpload ID="FileToUpload" onchange="LoadImage(this)" runat="server" CssClass="Upload" />
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </div>
                        <div class="col-4 col-4-middle">
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblLocationDefaults" meta:resourcekey="lblLocationDefaults" runat="server" CssClass="legend"></asp:Label>
                                </legend>
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblDefLocType" meta:resourcekey="lblDefLocType" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlDefLocTypes" runat="server" AllowCustomText="True" Width="100%" meta:Resourcekey="ddlTypes" Filter="Contains" MarkFirstMatch="true"
                                                Skin="Default">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblOperatingProject" runat="server" meta:resourcekey="lblOperatingProject"
                                                Text="Operating Project"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlOperatingProject" runat="server" AutoPostBack="false"
                                                Skin="Default" meta:resourcekey="ddlOperatingProject" OnItemsRequested="ddl_ItemsRequested"
                                                NoWrap="true" Width="100%" Height="300px" EnableLoadOnDemand="true" ShowMoreResultsBox="True"
                                                EnableVirtualScrolling="True">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblDefCurrency" meta:resourcekey="lblDefCurrency" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlDefCurrency" runat="server" Width="100%" Skin="Default">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblDefTargetBudget" meta:resourcekey="lblDefTargetBudget" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtDefTargetBudget" MaxLength="15" CssClass="Currency" runat="server" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblDefAreaUOM" meta:resourcekey="lblDefAreaUOM" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlwidth">
                                            <telerik:RadComboBox ID="ddlDefAreaUOM" Filter="Contains" Height="200px" AllowCustomText="true"
                                                runat="server" Width="100%" Skin="Default">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblDefTargetRevenue" meta:resourcekey="lblDefTargetRevenue" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtDefTargetRevenue" MaxLength="15" CssClass="Currency" runat="server" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblDefGrossArea" meta:resourcekey="lblDefGrossArea" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtDefGrossArea" MaxLength="15" CssClass="Double" runat="server" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblDefTargetOccupancy" meta:resourcekey="lblDefTargetOccupancy" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtDefTargetOccupancy" runat="server" CssClass="Percent" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblDefRentable" meta:resourcekey="lblDefRentable" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtDefRentable" MaxLength="15" CssClass="Double" runat="server" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblDefCapacity" meta:resourcekey="lblDefCapacity" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtDefCapacity" CssClass="PositiveInteger" MaxLength="9" runat="server" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblDefUsable" meta:resourcekey="lblDefUsable" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtDefUsable" MaxLength="15" CssClass="Double" runat="server" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblPersonnel" meta:Resourcekey="lblPersonnel" runat="server" CssClass="legend"></asp:Label>
                                </legend>
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPersOwner" meta:Resourcekey="lblPersOwner" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlPersOwner" runat="server" Width="100%"
                                                Skin="Default" CloseDropDownOnBlur="true" NoWrap="True" AllowCustomText="true"
                                                meta:Resourcekey="ddlPersOwner" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Height="250px">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblPersOwnerContact" meta:resourcekey="lblPersOwnerContact"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlPersOwnerContacts" runat="server" Width="100%" DropDownWidth="385px"
                                                Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" meta:Resourcekey="ddlPersOwnerContacts"
                                                NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Height="250px">
                                                <HeaderTemplate>
                                                    <table style="width: 385px" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td style="width: 250px;">
                                                                <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal>
                                                            </td>
                                                            <td style="width: 135px;">
                                                                <asp:Literal ID="Literal4" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 385px" cellspacing="0" cellpadding="2">
                                                        <tr>
                                                            <td style="width: 250px;">
                                                                <%#DataBinder.Eval(Container, "Attributes['CompanyName']")%>
                                                            </td>
                                                            <td style="width: 135px;">
                                                                <%#DataBinder.Eval(Container, "Attributes['ContactName']")%>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPersClient" meta:Resourcekey="lblPersClient" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="ddlPersClients" runat="server" Width="100%"
                                                Skin="Default" CloseDropDownOnBlur="true" NoWrap="True" AllowCustomText="true"
                                                meta:Resourcekey="ddlPersClients" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Height="250px">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPersManager" meta:Resourcekey="lblPersManager" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlPersManager" runat="server" Width="100%" DropDownWidth="385px"
                                                Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" meta:Resourcekey="ddlPersManager"
                                                NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Height="250px">
                                                <HeaderTemplate>
                                                    <table style="width: 385px" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td style="width: 250px;">
                                                                <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal>
                                                            </td>
                                                            <td style="width: 135px;">
                                                                <asp:Literal ID="Literal4" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 385px" cellspacing="0" cellpadding="2">
                                                        <tr>
                                                            <td style="width: 250px;">
                                                                <%#DataBinder.Eval(Container, "Attributes['CompanyName']")%>
                                                            </td>
                                                            <td style="width: 135px;">
                                                                <%#DataBinder.Eval(Container, "Attributes['ContactName']")%>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPersTenant" meta:Resourcekey="lblPersTenant" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlPersTenants" runat="server" Width="100%"
                                                Skin="Default" CloseDropDownOnBlur="true" NoWrap="True" AllowCustomText="true"
                                                meta:Resourcekey="ddlPersTenants" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Height="250px">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPersSuperintendent" meta:Resourcekey="lblPersSuperintendent" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlPersSuperintendents" runat="server" Width="100%" DropDownWidth="385px"
                                                Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" meta:Resourcekey="ddlPersSuperintendents"
                                                NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Height="250px">
                                                <HeaderTemplate>
                                                    <table style="width: 385px" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td style="width: 250px;">
                                                                <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal>
                                                            </td>
                                                            <td style="width: 135px;">
                                                                <asp:Literal ID="Literal4" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <table style="width: 385px" cellspacing="0" cellpadding="2">
                                                        <tr>
                                                            <td style="width: 250px;">
                                                                <%#DataBinder.Eval(Container, "Attributes['CompanyName']")%>
                                                            </td>
                                                            <td style="width: 135px;">
                                                                <%#DataBinder.Eval(Container, "Attributes['ContactName']")%>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPersAgent" meta:Resourcekey="lblPersAgent" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlPersAgents" runat="server" Width="100%"
                                                Skin="Default" CloseDropDownOnBlur="true" NoWrap="True" AllowCustomText="true"
                                                meta:Resourcekey="ddlPersAgents" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Height="250px">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPersSecurity" meta:Resourcekey="lblPersSecurity" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtPersSecurity" MaxLength="255" runat="server" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPersAuthority" meta:Resourcekey="lblPersAuthority" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlPersAuthorities" runat="server" Width="100%"
                                                Skin="Default" CloseDropDownOnBlur="true" NoWrap="True" AllowCustomText="true"
                                                meta:Resourcekey="ddlPersAuthorities" EnableLoadOnDemand="True" ShowMoreResultsBox="true"
                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested" Height="250px">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPersMaintenance" meta:Resourcekey="lblPersMaintenance" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPersMaintenance" MaxLength="255" runat="server" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPersPropertyManager" meta:Resourcekey="lblPersPropertyManager"
                                                runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtPersPropertyManager" MaxLength="255" runat="server" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblPersMunicipality" meta:Resourcekey="lblPersMunicipality" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtPersMunicipality" MaxLength="255" runat="server" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc8:AssetRotator ID="PMrot" runat="server" />
                            <uc9:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <%-- <telerik:RadPageView ID="PvDetails" runat="server">
                                    <uc1:LocationProgramsDetails ID="LocationProgramsDetails1" runat="server" />
                                </telerik:RadPageView>--%>
        <telerik:RadPageView ID="pvSpec" runat="server">
            <uc2:DocumentSpecifications ID="Specification1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvLocations" runat="server" Visible="False">
            <uc3:LocationProgramsLocations ID="LocationProgramsLocations1" runat="server" />
        </telerik:RadPageView>
        <%--<telerik:RadPageView ID="pvPayments" runat="server" Visible="False">
                        <uc4:ProjectProgramPaymentApplications ID="ProjectProgramPaymentApplications1" runat="server" />
                    </telerik:RadPageView>--%>
        <telerik:RadPageView ID="pvNotes" runat="server" Visible="False">
            <uc5:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server" Visible="False">
            <uc6:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc7:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>

</asp:Content>
