<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="AssetAPPayment.aspx.vb" Inherits="Website.AssetAPPayment" %>

<%@ Register Src="AssetApPaymentLedger.ascx" TagName="AssetApPaymentLedger" TagPrefix="uc1" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc2" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc3" %>
<%@ Register Src="DocumentClauses.ascx" TagName="DocumentClauses" TagPrefix="uc4" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc5" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc6" %>
<%@ Register Src="WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc7" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc8" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc9" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc10" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc11" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script type="text/javascript">
            var CurrentRecordProjectId = 0;
            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
                maintoolbarClick(args.get_item().get_value())
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }

            function maintoolbarClick(Value) {
                var HasMergeTemplate = '<%= PM.Asset.APPaymentInfo.HasMergeTemplate%>';
                var RecordDescription = '<%=JSEscape( PM.Asset.APPaymentInfo.RecordNumber & " - " & PM.Asset.APPaymentInfo.Description)%>';
                var Description = '<%=JSEscape(PM.Asset.APPaymentInfo.Description)%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("APTENANTPAYMENTS")%>';
                var HasReports = '<%= PM.Asset.APPaymentInfo.HasReports%>';
                var Id = '<%= PM.Asset.APPaymentInfo.Id%>';
                switch (Value) {

                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=APTENANTPAYMENTS&Id=" + Id
                                + "&EntityId=" + '<%=PM.Asset.APPaymentInfo.LocationId%>' + "&EntityType=1",
                    'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=APTENANTPAYMENTS&Id=" +
                                        Id
                                        + "&RecordDescription=" + RecordDescription
                                        + "&EntityId=" + '<%=PM.Asset.APPaymentInfo.LocationId%>' + "&EntityType=1",
                            'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;

                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=APTENANTPAYMENTS&Id=" +
                                    '<%= PM.Asset.APPaymentInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Asset.APPaymentInfo.LocationId%>' + "&EntityType=1", 1045, 515, false);
                        }
                        break;
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=APTENANTPAYMENTS&Id=" +
                         '<%= PM.Asset.APPaymentInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Asset.APPaymentInfo.LocationId%>' + "&EntityType=1", "Notification",
                'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=800,height=500,top=' + top + ',left=' + left);
                        break;

                    case 'New':
                        window.location = "AssetAPPayment.aspx";
                        break;
                    default:
                        //                        eventArgs.set_cancel(false);
                        break;

                }
            }

        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
              <telerik:AjaxSetting AjaxControlID="mlpPayment">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpPayment" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpPayment" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <%--        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="tbldropdown">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Comp" />
                    <telerik:AjaxUpdatedControl ControlID="tblmain" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbldropdown" />

                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings--%>
    </telerik:RadAjaxManagerProxy>



    <table class="ToolBar SmallToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr>
            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=215">
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
                <telerik:RadComboBox ID="ddlPayments" runat="server" AllowCustomText="true" Skin="Default"
                    Height="400px" OnClientTextChange="LOD_DropDownTextChange" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging"
                    EmptyMessage="Select a Payment..." Width="100%" AutoPostBack="false" NoWrap="true" CausesValidation="False" meta:Resourcekey="ddlPayments"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                    <%--OnItemsRequested="ddl_ItemsRequested">--%>
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle;" class="ToolbarTd">

                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="click_handler">
                    <Items>
                        <%--<telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                                        Value="Search" NavigateUrl="SearchDocument.aspx?O=215" CausesValidation="false">
                                    </telerik:RadToolBarButton>--%>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CausesValidation="true" CommandName="Save" AccessKey="s" ValidationGroup="Save"
                            ToolTip="Save (Alt+s)">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                            CommandName="New" AccessKey="n" PostBack="false" ToolTip="New (Alt+n)" CausesValidation="false">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete" CausesValidation="false">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>


                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>


                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                            EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint">
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
                                <telerik:RadMenu runat="server" CssClass="MoreMenu" ID="radmen" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked">
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
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('APTENANTPAYMENTS');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Help" Value="Help" onclick="helpClick();" EnableImageSprite="true" CssClass="Help"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton ImageUrl="Images/ToolBar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_AssetManagement.htm#payments"></telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>



    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="1" OnClientTabSelecting="onTabSelecting" CssClass="documentTabs"
        runat="server" MultiPageID="mlpPayment" Skin="Default" ScrollChildren="true" ScrollButtonsPosition="Left"
        Width="100%" EnableViewState="true" CausesValidation="false">
        <%--OnTabClick="tbsDocument_TabClick"--%>
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="true" />
            <telerik:RadTab Text="Additional Applications" Value="AdditionalApplications" CssClass="HideTabWhenDetailShownInHeader"></telerik:RadTab>
            <telerik:RadTab Text="Specifications" Value="Spec"></telerik:RadTab>
            <telerik:RadTab Text="Tasks" Value="Checklists" />
            <telerik:RadTab Text="Clauses" Value="Clauses" />
            <telerik:RadTab Text="Notes" Value="Notes"></telerik:RadTab>
            <telerik:RadTab Text="Attachments" Value="Attachments"></telerik:RadTab>
            <telerik:RadTab Text="Workflow" Value="Workflow"></telerik:RadTab>
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog"></telerik:RadTab>
        </Tabs>
    </telerik:RadTabStrip>

    <telerik:RadMultiPage ID="mlpPayment" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="true" CssClass="documentMultiPages">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" EnableAJAX="false" Width="100%">
                <div class="PMMainPage">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProgramLocation" runat="server" Text="Program*" meta:Resourcekey="lblProgramLocation"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProgram" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true"
                                            runat="server" AutoPostBack="true" Skin="Default" NoWrap="true" Width="100%"
                                            Height="200px" ShowMoreResultsBox="True" EnableVirtualScrolling="True" EnableLoadOnDemand="true" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>

                                        <asp:RequiredFieldValidator ID="rfvProgram" meta:Resourcekey="rfv_Required" runat="server" ControlToValidate="ddlProgram"
                                            CssClass="Validator" InitialValue="" 
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>

                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLocation" runat="server" Text="Location*" meta:Resourcekey="lblLocation"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlLocations" runat="server" AutoPostBack="True" CausesValidation="False"
                                            CloseDropDownOnBlur="true" EmptyMessage="Select a Project..." Height="300px" meta:Resourcekey="ddlLocations"
                                            NoWrap="true" Skin="Default" Width="100%" ShowMoreResultsBox="True"
                                            EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="rfvLocations" meta:Resourcekey="rfv_Required" runat="server" ControlToValidate="ddlLocations"
                                            CssClass="Validator" InitialValue="" 
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>

                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliLease" meta:Resourcekey="hliLease" Text="Lease"></asp:HyperLink>

                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlLease" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true"
                                            runat="server" AutoPostBack="true" Skin="Default" NoWrap="true" Width="100%"
                                            Height="200px" ShowMoreResultsBox="True" OnItemsRequested="ddl_ItemsRequested" EnableVirtualScrolling="True" EnableLoadOnDemand="true">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliTenantInvoice" meta:Resourcekey="hliTenantInvoice" Text="Linked A/P Invoice"></asp:HyperLink>

                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlLinkedAPInvoice" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true"
                                            runat="server" AutoPostBack="true" Skin="Default" NoWrap="true" Width="100%"
                                            Height="200px" ShowMoreResultsBox="True" OnItemsRequested="ddl_ItemsRequested" EnableVirtualScrolling="True" EnableLoadOnDemand="true">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblId" runat="server" Text="ID*" meta:Resourcekey="lblId"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtCode" runat="server" MaxLength="30"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCode" runat="server" ValidationGroup="Save" ControlToValidate="txtCode" meta:Resourcekey="rfv_Code"
                                            CssClass="Validator" Display="Dynamic" ErrorMessage="Required."
                                            ForeColor=""></asp:RequiredFieldValidator>

                                        <asp:Label ID="lblCommIDUnique" runat="server" Text="ID must be unique" meta:Resourcekey="lblCommIDUnique"
                                            Visible="False" Class="Validator"></asp:Label>

                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" runat="server" Text="Description" meta:Resourcekey="lblDescription"></asp:Label>

                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtDescription" Text=""></asp:TextBox>

                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCurrency" meta:Resourcekey="lblCurrency" runat="server" Text="Currency"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtCurrency" Enabled="false" Text=""></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliPaymentBatch" meta:Resourcekey="lblPaymentBatch" Text="Payment Batch"></asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtPaymentBatch" runat="server" ReadOnly="true"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" runat="server" Text="Status" meta:Resourcekey="lblStatusRevision"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlStatus" runat="server" Style="width: 182px !important" Skin="Default"></telerik:RadComboBox>
                                                </td>
                                                <td style="width: 50px; padding-left: 8px; text-align: right;">
                                                    <asp:TextBox ID="txtRevisionNumber" CssClass="PositiveInteger" MaxLength="9" runat="server" Width="100%"></asp:TextBox>

                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left">
                                            <asp:Label ID="lblCompany" runat="server" Text="<%$ Resources:CostManagement, Label_Company %>"></asp:Label>
                                        </div>

                                        <div style="float: right">
                                            <asp:LinkButton runat="server" ID="imgfilter1" CssClass="SearchButton" OnClientClick="return OpenCompanyFilterPopupProjectNotRequired(this.id.replace('imgfilter1','HiddenField2'),this.id.replace('imgfilter1','ddlCompanies'),'Companies')">
                                                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCompanies" runat="server" Height="200px" Skin="Default" Width="100%"
                                            CloseDropDownOnBlur="true" meta:resourcekey="ddlCompanies" EmptyMessage="Select Company..." NoWrap="False"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
                                            OnClientDropDownClosed="dllcompClientClosed" OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                        <asp:HiddenField ID="HiddenField2" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblType" meta:resourcekey="lblType" runat="server" Text="Type"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlType" AllowCustomText="true" Filter="Contains" runat="server" Width="100%" Skin="Default" Style="font-size: 11px"></telerik:RadComboBox>

                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCategory" meta:resourcekey="lblCategory" runat="server" Text="Category"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCategory" AllowCustomText="true" Filter="Contains" runat="server" Width="100%" Skin="Default" Style="font-size: 11px"></telerik:RadComboBox>

                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblReference" runat="server" Text="Reference" meta:resourcekey="lblReference"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtReference" runat="server"></asp:TextBox>

                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblNotes" runat="server" Text="Notes" meta:resourcekey="lblNotes"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" TextMode="MultiLine" ID="txtNotes" Height="60px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblAppliedInFull" runat="server" Text="Applied In Full" meta:resourcekey="lblAppliedInFull"></asp:Label>
                                    </td>
                                    <td class="controlWidth chkBox">
                                        <asp:CheckBox ID="chkAppliedInFull" runat="server" ClientIDMode="Static" />
                                        <label for="chkAppliedInFull">
                                            <i class="icon"></i>
                                        </label>
                                    </td>
                                </tr>
                            </table>

                        </div>

                        <div class="col-4  col-4-middle">
                            <uc9:AssetRotator ID="PMrot" runat="server" />

                            <table class="colTable">
                                <tr>

                                    <td class="labelWidth">
                                        <asp:Label ID="lblOpenBalance" runat="server" Text="Open Balance" meta:Resourcekey="lblOpenBalance"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtOpenBalance" CssClass="Currency" runat="server"></asp:TextBox>

                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPaymentAmount" runat="server" Text="Payment Amount" meta:Resourcekey="lblPaymentAmount"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtPaymentAmount" CssClass="Currency" MinNumber="0" runat="server"></asp:TextBox>

                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float:left;">
                                            <asp:Label ID="lblCostCode" runat="server" meta:Resourcekey="lblCostCode" CssClass="Link"></asp:Label>
                                        </div>
                                        <div style="float:right;">
                                            <asp:LinkButton ID="btnCostCode" runat="server" CausesValidation="False"  CssClass="SearchButton"> 
                                                        <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCostCode" runat="server" Width="100%" Filter="Contains"
                                            EnableItemCaching="false" MarkFirstMatch="true" meta:Resourcekey="ddlCostCode"
                                            Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Cost Code..." OnItemsRequested="ddl_ItemsRequested"
                                            NoWrap="True" AllowCustomText="true" ValidationGroup="Save" Style="font-size: 11px" Height="250px"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPeriod" runat="server" Text="<%$Resources:CostManagement, Label_Period %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPeriods" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true"
                                            runat="server" AutoPostBack="False" Skin="Default" NoWrap="true" Width="100%"
                                            Height="200px" OnItemsRequested="ddl_ItemsRequested" ShowMoreResultsBox="True" Style="font-size: 11px" EmptyMessage="Select Period..." EnableVirtualScrolling="True" EnableLoadOnDemand="true">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblInvoiceNumber" meta:resourcekey="lblInvoiceNumber" runat="server" Text="Invoice #"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtInvoice" runat="server" MaxLength="50"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPaymentMethod" meta:Resourcekey="lblPaymentMethod" Width="100%" runat="server" Text="Payment Method"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPaymentMethod" AllowCustomText="true" Filter="Contains" runat="server" Skin="Default" Style="font-size: 11px" Width="100%"></telerik:RadComboBox>

                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPaymentNumber" meta:Resourcekey="lblPaymentNumber" Width="100%" runat="server" Text="Payment #"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtPaymentNumber" runat="server" MaxLength="50"></asp:TextBox>

                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPaymentDate" meta:Resourcekey="lblPaymentDate" Width="100%" runat="server" Text="Payment Date"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_rdpPaymentDate" style="display: block">
                                            <telerik:RadDatePicker ID="rdpPaymentDate" runat="server" MinDate="1901-01-01" DateInput-EnabledStyle-HorizontalAlign="Right"
                                                MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default">
                                                <DateInput ID="DateInput3" Skin="Default" runat="server"></DateInput>
                                                <Calendar ID="Calendar3" Skin="Default" runat="server"></Calendar>
                                            </telerik:RadDatePicker>
                                        </span>

                                    </td>
                                </tr>

                                <tr>
                                    <td colspan="2">
                                        <asp:Label ID="lblHidenRows" runat="server" Text="Some of the detail lines are hidden for security reasons." Visible="false" CssClass="Validator" meta:resourcekey="lblHidenRows"></asp:Label></td>
                                </tr>

                            </table>
                        </div>

                        <div class="col-4 col-4-right">
                            <uc11:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvLedger" runat="server" CssClass="ShowInHeaderWhenFit Responsive">
            <uc1:AssetApPaymentLedger ID="AssetApPaymentLedger1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc2:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc3:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvClauses" runat="server">
            <uc4:DocumentClauses ID="DocumentClauses1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc5:DocumentNotes ID="DocumentNotes1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc6:DocumentAttachments ID="DocumentAttachments1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <uc7:WorkflowDocument ID="WorkflowDocument1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc10:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc8:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>

</asp:Content>





