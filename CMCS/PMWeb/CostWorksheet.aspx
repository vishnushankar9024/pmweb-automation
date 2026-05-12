<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="CostWorksheet.aspx.vb" Inherits="Website.CostWorksheet" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/CostWorksheetDetails.ascx" TagName="CostWorksheetDetails" TagPrefix="uc1" %>
<%@ Register Src="ngDocNotes.ascx" TagName="DocumentNotes" TagPrefix="uc2" %>
<%@ Register Src="ngDocAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc3" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <script src="JS/Costs/CostWorksheet.js" type="text/javascript"></script>
    <%--<link href="CSS/CostWorksheet.css" rel="stylesheet" type="text/css" />--%>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script language="javascript" type="text/javascript">

            function click_handler(sender, args) {

                switch (args.get_item().get_commandName()) {

                    case 'New':
                        OpenPOPUp('CostWorksheetEntry.aspx?CostcodeId=0&StatusId=0&Columns=0', 450, 400, true);
                        break;
                    case 'ViewReports':
                        var ProjectValue ='<%= PM.CostManagement.CostWorksheetInfo.ProjectId %>';
                        if (parseInt(ProjectValue)) {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=COSTWORKSHEET&Id=" +
                            ProjectValue
                              + "&EntityId=" + ProjectValue + "&EntityType=0", 890, 430, false);
                        }
                        break;
                    case 'Print':
                        var ProjectValue = '<%= PM.CostManagement.CostWorksheetInfo.ProjectId %>';
                        if (parseInt(ProjectValue)) {
                                OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=COSTWORKSHEET&Id=" +
                             ProjectValue
                               + "&EntityId=" + ProjectValue + "&EntityType=0", 890, 430, false);
                        } else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                            args.set_cancel(true);
                        }
                        break;

                    case 'BIReporting':

                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        args.set_cancel(true);
                        break;
                    case 'Cancel':
                        window.location = "CostWorksheet.aspx";
                        break;
                    default:
                        break;
                }
            }
            function CancelWorksheetEdit() {
                window.location = "CostWorksheet.aspx";
                //            var btnCancelEdit = $("[id$=btnCancelEdit]");
                //            btnCancelEdit.click();
                return false;
            }
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
             <telerik:AjaxSetting AjaxControlID="mlpCostWorksheet">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpCostWorksheet" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpCostWorksheet" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
           
            <%--<telerik:AjaxSetting AjaxControlID="mainToolBar">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="mlpCostWorksheet" LoadingPanelID="ldpPM" />
                 <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
          
                 <telerik:AjaxUpdatedControl ControlID="mainToolBar" />
            </UpdatedControls>
        </telerik:AjaxSetting>  

        <telerik:AjaxSetting AjaxControlID="ddlProjects">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="mlpCostWorksheet" LoadingPanelID="ldpPM" />
                 <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                <telerik:AjaxUpdatedControl ControlID="pnlDetailPane" LoadingPanelID="ldpPM" />
                 <telerik:AjaxUpdatedControl ControlID="mainToolBar" />
            </UpdatedControls>
        </telerik:AjaxSetting>          
        <telerik:AjaxSetting AjaxControlID="ddlWorksheets">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="mlpCostWorksheet" LoadingPanelID="ldpPM" />
                 <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                <telerik:AjaxUpdatedControl ControlID="pnlDetailPane" LoadingPanelID="ldpPM" />
                 <telerik:AjaxUpdatedControl ControlID="mainToolBar" />
            </UpdatedControls>
        </telerik:AjaxSetting>  
        <telerik:AjaxSetting AjaxControlID="ddlPeriodFrom">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="mlpCostWorksheet" LoadingPanelID="ldpPM" />
                 <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                <telerik:AjaxUpdatedControl ControlID="pnlDetailPane" LoadingPanelID="ldpPM" />
                 <telerik:AjaxUpdatedControl ControlID="mainToolBar" />
            </UpdatedControls>
        </telerik:AjaxSetting>  
        <telerik:AjaxSetting AjaxControlID="ddlPeriodTo">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="mlpCostWorksheet" LoadingPanelID="ldpPM" />
                 <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                <telerik:AjaxUpdatedControl ControlID="pnlDetailPane" LoadingPanelID="ldpPM" />
                 <telerik:AjaxUpdatedControl ControlID="mainToolBar" />
            </UpdatedControls>
        </telerik:AjaxSetting>  --%>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>


    <table style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr class="ToolBar">
            <td style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" OnClientButtonClicked="click_handler"
                    AutoPostBack="true">
                    <Items>
                        <telerik:RadToolBarButton Value="Add" ImageUrl="Images/ToolBar/NewDoc.png" Visible="true"
                            PostBack="false" CommandName="New" AccessKey="n" ToolTip="New (Alt+n)" CausesValidation="false">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton ImageUrl="Images/Global/EditLine.png" CommandName="Edit" CssClass="ToolbarEditCost"
                            Value="Edit" AccessKey="s" ToolTip="Edit (Alt+e)" PostBack="true">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton ImageUrl="Images/ToolBar/Save.png" CommandName="Save" Value="Save"
                            PostBack="true" Visible="False" AccessKey="s" ToolTip="Save (Alt+s)">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton Value="Cancel" ImageUrl="Images/toolbar/Cancel.png" Visible="false"
                            PostBack="false" CommandName="Cancel" ToolTip="Cancel" CausesValidation="false">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            Visible="false" CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete"
                            CausesValidation="false">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print"
                            SecurityButtonType="Read" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" ImageUrl="Images/ToolBar/PMWebW.gif"
                                    CommandName="ViewReports">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>
                        <telerik:RadToolBarButton ImageUrl="Images/Toolbar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>"
                            CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_CostControl.htm#WorkSheet">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td style="width: 100%" align="left">
                <asp:CheckBox ID="chkUseUnit" meta:ResourceKey="chkUseUnit" Visible="false" runat="server" CssClass="mobile-switch"
                    Text="Use Units" Checked="False" AutoPostBack="true" />
            </td>
            <td></td>
        </tr>
    </table>

    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="1" OnClientTabSelecting="onTabSelecting" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        runat="server" MultiPageID="mlpCostWorksheet" Skin="Default" OnTabClick="tbsDocument_TabClick"
        Width="100%" EnableViewState="True" CausesValidation="false">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True" />
            <telerik:RadTab Text="Details" Value="Details" CssClass="HideTabWhenDetailShownInHeader" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpCostWorksheet" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPages"
        RenderSelectedPageOnly="true">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="true">
            <div class="PMMainPage">
                <div class="row JustifyContent R3Cols">
                    <div class="col-4 col-4-left ">
                        <table class="colTable">

                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblWorksheet" meta:Resourcekey="lblWorksheet" runat="server" Text="Worksheet"></asp:Label>
                                    <asp:Label ID="lblProject" Visible="false" runat="server" Text="<%$Resources:CostManagement, Label_Project %>"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlWorksheets" runat="server" Filter="Contains" MarkFirstMatch="True"
                                        Skin="Metro" AutoPostBack="true" NoWrap="True" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                        OnSelectedIndexChanged="ddlWorksheets_SelectedIndexChanged">
                                        <%--EmptyMessage="Select worksheet..." >--%>
                                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                    </telerik:RadComboBox>
                                    <telerik:RadComboBox ID="ddlProjects" runat="server" Skin="Metro" Visible="false"
                                        Style="font-size: 11px" AutoPostBack="true" Height="400px" OnSelectedIndexChanged="ddlProjects_SelectedIndexChanged"
                                         ShowMoreResultsBox="True"
                                        EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                    </telerik:RadComboBox>
                                </td>

                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    
                                </td>
                                <td class="controlWidth">

                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-4 col-4-middle">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblPeriodsFrom" meta:ResourceKey="lblPeriodFrom" runat="server" Text="Periods from"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlPeriodFrom" runat="server" AutoPostBack="true"
                                        Skin="Metro" Style="font-size: 11px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                        OnSelectedIndexChanged="ddlPeriodFrom_SelectedIndexChanged">
                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblToDate" meta:Resourcekey="lblToDate" runat="server" Text="to"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlPeriodTo" runat="server" Width="100%" AutoPostBack="true"
                                        Skin="Metro" Style="font-size: 11px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                        OnSelectedIndexChanged="ddlPeriodTo_SelectedIndexChanged">
                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-4 col-4-right">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <div style="float: left;">
                                        <asp:Label runat="server" CssClass="Link" ID="hplCurrency" meta:Resourcekey="hplCurrency" Text="Currency"></asp:Label>

                                    </div>
                                    <div style="float: right;">
                                        <asp:LinkButton CssClass="SearchButton" runat="server" ID="imgfilter1">
                                                                        <span class="Icon"></span>
                                        </asp:LinkButton>
                                    </div>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlCurrencies" runat="server" Skin="Metro" Height="300px"
                                        Style="font-size: 11px" AutoPostBack="true" OnSelectedIndexChanged="ddlCurrencies_SelectedIndexChanged">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblProjectDefault" meta:ResourceKey="lblProjectDefault"
                                        runat="server" Text="Project Default"></asp:Label><br />
                                </td>
                                <td class="controlWidth">
                                    <asp:CheckBox ID="chkProjectDefault" runat="server" Checked="False" AutoPostBack="true" CssClass="mobile-switch" /></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" Width="100%" CssClass="ShowInHeaderWhenFit Responsive">
            <uc1:CostWorksheetDetails ID="ucCostWorksheetDetails" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc2:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc3:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>

    <%-- <asp:button style="display:none" id="btnCancelEdit" runat="server" />--%>
</asp:Content>
