<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="CostWorksheetSetup.aspx.vb" Inherits="Website.CostWorksheetSetup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/CostWorksheetColumns.ascx" TagName="CostWorksheetColumns" TagPrefix="uc1" %>


<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <script src="JS/Costs/CostWorksheet.js" type="text/javascript"></script>
    <%--<link href="CSS/CostWorksheet.css" rel="stylesheet" type="text/css" />--%>

    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="ucCostWorksheetColumns">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpWorksheets" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <telerik:RadWindowManager ID="PMWindowManager" runat="server" Skin="Default" VisibleStatusbar="False" IconUrl="Images/Global/favicon.ico"
        ReloadOnShow="True" Modal="True" OnClientClose="onClose" KeepInScreenBounds="True" Behavior="Default"
        InitialBehavior="None" Left="" Style="display: none;"
        Top="">
        <Windows>
        </Windows>
    </telerik:RadWindowManager>
    <style>
        .documentMultiPages{
            margin-top:88px !important;
        }
    </style>
    <table style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr class="ToolBar">
            <%--           <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=134">
                                <div class="btnToolbarSearchDocument">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>--%>
            <td class="ToolbarTd HideOnMobileToolbar" style="display: none;">
                <asp:LinkButton runat="server" ID="btnRecent">
                                <div class="btnToolbarRecent">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>
            <td style="width: 240px;" class="ToolbarTd HideOnMobileToolbar">
                <telerik:RadComboBox ID="ddlWorksheets" runat="server"
                    Skin="Default" CloseDropDownOnBlur="true" AllowCustomText="true" 
                    Width="100%" AutoPostBack="True" NoWrap="true"
                    CausesValidation="False" Height="400px" OnClientTextChange="LOD_DropDownTextChange"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" CheckForDirt="True"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle; " class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="smallToolBa">
                    <Items>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CommandName="Save"
                            AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="NewInitiative"
                            EnableDefaultButton="false" PostBack="true">
                            <Buttons>
                                <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                    CommandName="New" AccessKey="n" ToolTip="New (Alt+n)" CausesValidation="false">
                                </telerik:RadToolBarButton>

                                <telerik:RadToolBarButton SecurityButtonType="Add" CommandName="Copy"
                                    ImageUrl="Images/ToolBar/CopyRecord.png" Value="CopyRecord">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Print" ImageUrl="Images/ToolBar/Printer.png" ToolTip="Print" CssClass="print"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton ImageUrl="Images/Toolbar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_CostControl.htm#WorksheetSetup"></telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>

    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="1" CssClass="documentTabs"
        runat="server" MultiPageID="mlpWorksheets" Skin="Default"
        Width="100%" EnableViewState="False" CausesValidation="false">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True" />
            <telerik:RadTab Text="Details" Value="Details" CssClass="HideTabWhenDetailShownInHeader" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpWorksheets" runat="server" SelectedIndex="0" CssClass="documentMultiPages"
        Width="100%" RenderSelectedPageOnly="true">
        <telerik:RadPageView ID="pvHeader" runat="server" Width="100%">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%">
                <div class="PMMainPage">
                    <div class="row">
                        <div class="col-4 col-4-left ">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblWorksheetName" meta:Resourcekey="lblWorksheetName" runat="server"
                                            Text="Worksheet Name*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtName" runat="server" MaxLength="200"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvName" runat="server" ValidationGroup="Save" ControlToValidate="txtName"
                                            CssClass="Validator" ErrorMessage="<br/>Enter the worksheet name" meta:Resourcekey="rfvWorksheetName"
                                            Display="Dynamic"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" runat="server" Text="<%$Resources:CostManagement, Label_Project %>"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProjects" runat="server" AutoPostBack="true"
                                            Skin="Default" ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr id="trSystemDefault" runat="server">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblSystemDefault" runat="server" Text="System Default"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:CheckBox runat="server" ID="chkSystemDefault" CssClass="mobile-switch" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" Width="100%" CssClass="ShowInHeaderWhenFit Responsive">
            <uc1:CostWorksheetColumns ID="ucCostWorksheetColumns" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>

</asp:Content>
