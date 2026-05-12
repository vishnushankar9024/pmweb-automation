<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="MoveManagement.aspx.vb" Inherits="Website.MoveManagement" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="MoveManagementDetails.ascx" TagName="MoveManagementDetails" TagPrefix="uc1" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc2" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc3" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc4" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc5" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc6" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <script src="JS/Asset/MoveManagement.js" type="text/javascript"></script>
    <script type="text/javascript">

        var forceMoreMenuToClose = true;

        function Move_OnRowSelecting(sender, eventArgs) {
            var CanSelect = $("#" + eventArgs.get_id())[0].getAttribute("CanSelect")

            if (CanSelect == "false")
                eventArgs.set_cancel(true);
        }

        function MoreMenuClicked(sender, args) {
            if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                sender.close(true);

                maintoolbarClick(args.get_item().get_value())
            }
        }

        function click_handler(sender, args) {
            maintoolbarClick(args.get_item().get_commandName())
        }


        function maintoolbarClick(Value) {
            switch (Value) {

                case 'New':
                    window.location = "MoveManagement.aspx";
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
                return;
            }
            args.set_cancel(true);
        }

    </script>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings> 
                <telerik:AjaxSetting AjaxControlID="mlpMoveManagement">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpMoveManagement" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpMoveManagement" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
       
            <telerik:AjaxSetting AjaxControlID="ddlProjects">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ddlSchedule" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="ddlProjects" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <table class="ToolBar SmallToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=159">
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
                <telerik:RadComboBox ID="ddlMoveDocuments" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                    Skin="Default" CloseDropDownOnBlur="true" Width="240px"
                    AutoPostBack="False" NoWrap="true" CausesValidation="False" OnItemsRequested="ddl_ItemsRequested"
                    Height="400px" ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True"
                    OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True">
                    <Items>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" ValidationGroup="Save" CausesValidation="true" AccessKey="s">
                        </telerik:RadToolBarButton>


                        <telerik:RadToolBarButton  SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"  CausesValidation="False" CommandName="New" 
                                                 EnableDefaultButton="false" PostBack="false" ToolTip="New (Alt+n)">
                                               
                         </telerik:RadToolBarButton>


                        <%--<telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                    CommandName="New" AccessKey="n" CausesValidation="false" PostBack="false">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>--%>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" Value="Delete">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('MOVEMANAGEMENT');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>

                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" onclick="helpClick();" CssClass="Help"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>


    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        runat="server" MultiPageID="mlpMoveManagement" Skin="Default" Width="100%" EnableViewState="True"
        CausesValidation="False">
        <Tabs>
            <telerik:RadTab Value="Header" Text="Header" Selected="True" />
            <telerik:RadTab Value="Details" Text="Details" CssClass="HideTabWhenDetailShownInHeader" />
            <telerik:RadTab Value="Notes" Text="Notes" />
            <telerik:RadTab Value="Attachments" Text="Attachments" />
            <telerik:RadTab Value="Workflow" Text="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpMoveManagement" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPages"
        RenderSelectedPageOnly="True">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" LoadingPanelID="ldpPM" runat="server" Width="100%" HorizontalAlign="NotSet" EnableAJAX="false">
                <div class="PMMainPage JustifyContent">
                    <div class="row">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCode" Text="Code*" meta:resourcekey="lblCode" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" MaxLength="20" ID="txtCode" Width="100%"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="cmpCode" runat="server" ControlToValidate="txtCode"
                                            CssClass="Validator" ErrorMessage="Required" Display="Dynamic" ForeColor=""
                                            ValidationGroup="Save" Operator="NotEqual" meta:resourcekey="cmp_Code">
                                        </asp:RequiredFieldValidator>
                                        <asp:Label ID="lblCodeUnique" meta:resourcekey="lblCodeUnique" Text="<br>Code must be unique."
                                            runat="server" CssClass="Validator" Visible="false">
                                        </asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" meta:resourcekey="lblDescription" Text="Description" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" MaxLength="500" ID="txtDescription" Width="100%"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblReason" meta:resourcekey="lblReason" Text="Reason" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" MaxLength="500" ID="txtReason" Width="100%"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblScheduledDate" meta:resourcekey="lblScheduledDate" runat="server" Text="Scheduled Date"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpScheduledDate" style="display: block">
                                            <telerik:RadDatePicker ID="dtpScheduledDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                Width="100%" Skin="Default" EnableTyping="True">
                                                <DateInput ID="DateInput5" Skin="Default" runat="server"></DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblMoveType" meta:resourcekey="lblMoveType" runat="server" Text="Move Type"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlMoveType" runat="server" Width="100%" Skin="Default" Filter="Contains" MarkFirstMatch="true"
                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>" AllowCustomText="True">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCost" meta:resourcekey="lblCost" Text="Cost" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" MaxLength="15" ID="txtCost" CssClass="PositiveDouble" Width="100%"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" meta:resourcekey="lblProject" runat="server" Text="Project"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProjects" runat="server" AutoPostBack="true" meta:resourcekey="ddlProjects"
                                            Skin="Default" NoWrap="true" Width="100%" Height="300px" EnableLoadOnDemand="true"
                                            ShowMoreResultsBox="True" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblSchedule" meta:resourcekey="lblSchedule" runat="server" Text="Schedule"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlSchedule" runat="server" AutoPostBack="True" meta:resourcekey="ddlSchedule"
                                            Skin="Default" Height="300px" OnItemsRequested="ddl_ItemsRequested"
                                            EnableLoadOnDemand="true" ShowMoreResultsBox="True" EnableVirtualScrolling="True" NoWrap="true" Width="100%">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatus" meta:resourcekey="lblStatus" runat="server" Text="Status"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlStatus" runat="server" Width="100%" Skin="Default"
                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>

                            </table>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc6:assetrotator id="PMrot" runat="server" />
                        </div>
                    </div>
                </div>
                <div class="PMMainPage">
                    <div class="row">
                        <div class="col-4 col-4-left">
                            <telerik:RadTabStrip ID="RadTabStrip1" CssClass="MovePlanRadTabStrip" runat="server" Skin="Vista" MultiPageID="RadMultiPage1" SelectedIndex="1">
                                <Tabs>
                                    <telerik:RadTab Text="Occupants" PageViewID="RadPageView1" Value="Occupants" Selected="True"></telerik:RadTab>
                                    <telerik:RadTab Text="Companies" PageViewID="RadPageView2" Value="Companies"></telerik:RadTab>
                                </Tabs>
                            </telerik:RadTabStrip>
                            <telerik:RadMultiPage ID="RadMultiPage1" runat="server" SelectedIndex="0" CssClass="pageView" Width="99%">
                                <telerik:RadPageView ID="RadPageView1" runat="server" Selected="true">
                                    <div class="RL_PolylineHeader" style="width: 98%;">
                                        <a>
                                            <asp:Label ID="Label1" runat="server" Text="Property" meta:resourcekey="lblLocation"></asp:Label></a>
                                    </div>
                                    <div class="RL_Users" style="height: 25px; width: 99%;">
                                        <telerik:RadComboBox ID="ddlProperties" runat="server" meta:resourcekey="ddlProperties" OnClientTextChange="LOD_DropDownTextChange"
                                            Skin="Default" CloseDropDownOnBlur="true"  Width="99%"
                                            AutoPostBack="True" NoWrap="true" CausesValidation="False" Height="200px" ShowMoreResultsBox="True"
                                            EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                    </div>
                                    <div class="RL_ActionHeader" style="width: 98%;">
                                        <table>
                                            <tr>
                                                <td>
                                                    <span class="drawing-iconSpace"></span>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblAction" Width="99%" CssClass="Bold" runat="server" Text="Assets" meta:resourcekey="lblAsset" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="dvTreeSection" style="width: 100%;">
                                        <telerik:RadTreeView ID="rdvAssets" Skin="Default" runat="server" Height="250px" Width="100%"
                                            MultipleSelect="false" ShowLineImages="false" CheckBoxes="true"
                                            OnClientNodeDropping="UserAccess_onEntitiesNodeDropping" OnClientNodeChecked="ShowHidebtnTreeDropItems"
                                            OnClientNodeDragging="UserAccess_onNodeDragging" OnNodeDrop="rdvAssets_NodeDrop">
                                        </telerik:RadTreeView>
                                        <asp:LinkButton runat="server" ID="btnTreeDropItems" CssClass="Hide">
                                            <div class="btnTreeDropItems">&nbsp;</div>
                                        </asp:LinkButton>
                                    </div>
                                    <div class="RL_ActionFooter">&nbsp;</div>
                                </telerik:RadPageView>
                                <telerik:RadPageView ID="RadPageView2" runat="server">
                                    <asp:Panel ID="pnlPolyline" runat="server">
                                        <div class="RL_PolylineHeader" style="width: 98%;">
                                            <a>
                                                <asp:Label ID="lblCompanies" runat="server" Text="Company" meta:resourcekey="lblCompanies"></asp:Label></a>
                                        </div>
                                        <div class="RL_Users" style="height: 25px; width: 99%;">
                                            <telerik:RadComboBox AutoPostBack="true"
                                                ID="ddlCompanies" runat="server" Height="200px" Width="99%"
                                                CloseDropDownOnBlur="true" meta:resourcekey="ddlCompanies"  NoWrap="False"
                                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                OnItemsRequested="ddl_ItemsRequested">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </div>
                                        <div class="RL_Users" style="height: 77px; width: 99%;">
                                            <telerik:RadListBox ID="rlstCompanies" AllowReorder="false" EnableDragAndDrop="True" AutoPostBack="True" SelectionMode="Multiple" DataTextField="CompanyName"
                                                DataKeyField="Id" OnClientDragStart="onListBoxDragStart" OnClientDropping="onListBoxDropping" CheckBoxes="true" OnItemCheck="chkSelectCompany_OnChekedChanged"
                                                OnClientDragging="onListBoxDragging" OnDropped="rlstCompanies_Dropped" runat="server" Skin="Vista" Width="99%" Height="74px">
                                            </telerik:RadListBox>
                                        </div>
                                        <div class="RL_PolylineHeader" style="width: 98%;">
                                            <a>
                                                <asp:Label ID="lblDepartment" runat="server" Text="Department" meta:resourcekey="lblDepartment"></asp:Label></a>
                                        </div>
                                        <div class="RL_Users" style="height: 71px; width: 99%; overflow: visible; border-bottom: 0px">
                                            <telerik:RadListBox ID="rlstDepartment" AllowReorder="false" OnClientDragStart="onListBoxDragStart" OnClientDropping="onListBoxDropping"
                                                OnClientDragging="onListBoxDragging"
                                                EnableDragAndDrop="True" AutoPostBack="True" SelectionMode="Multiple" OnDropped="rlstDepartment_Dropped" CheckBoxes="true"
                                                DataKeyField="Id" DataTextField="DepartmentName" OnItemCheck="chkSelectDepartment_OnChekedChanged" runat="server" Skin="Vista" Width="99%" Height="74px">
                                            </telerik:RadListBox>
                                        </div>
                                        <div class="RL_PolylineHeader" style="width: 98%;">
                                            <a>
                                                <asp:Label ID="lblContact" runat="server" Text="Contact" meta:resourcekey="lblContact"></asp:Label></a>
                                        </div>
                                        <div class="RL_Users" style="height: 72px; width: 99%; overflow: visible">
                                            <telerik:RadListBox ID="rlstContacts" AllowReorder="false" OnClientDragStart="onListBoxDragStart" OnClientDropping="onListBoxDropping"
                                                OnClientDragging="onListBoxDragging" EnableDragAndDrop="True" CheckBoxes="true"
                                                AutoPostBack="True" SelectionMode="Multiple" OnDropped="rlstContacts_Dropped"
                                                DataKeyField="Id" runat="server" Skin="Vista" Width="99%" Height="74px" DataTextField="ContactName" OnItemCheck="chkSelectContacts_OnChekedChanged">
                                            </telerik:RadListBox>
                                        </div>
                                        <div class="RL_ActionFooter">
                                            &nbsp;
                                        </div>
                                    </asp:Panel>
                                </telerik:RadPageView>
                            </telerik:RadMultiPage>
                        </div>
                        <div class="col-4 col-4-right">
                            <telerik:RadTabStrip ID="RadTabStrip2" CssClass="MovePlanRadTabStrip" runat="server" Skin="Vista" MultiPageID="RadMultiPage2" SelectedIndex="0">
                                <Tabs>
                                    <telerik:RadTab PageViewID="RadPageView3" Text="Destination" Value="Destination" Selected="True"></telerik:RadTab>
                                </Tabs>
                            </telerik:RadTabStrip>
                            <telerik:RadMultiPage ID="RadMultiPage2" runat="server" SelectedIndex="0" CssClass="pageView" Width="99%">
                                <telerik:RadPageView ID="RadPageView3" runat="server" Selected="true">
                                    <div class="RL_PolylineHeader" style="width: 98%;">
                                        <a>
                                            <asp:Label ID="Label2" runat="server" Text="Property" meta:resourcekey="lblLocation"></asp:Label></a>
                                    </div>
                                    <div class="RL_Users" style="height: 25px; width: 99%;">
                                        <telerik:RadComboBox ID="ddlTargetProperty" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                                            Skin="Default" CloseDropDownOnBlur="true"  Width="99%"
                                            AutoPostBack="True" NoWrap="true" CausesValidation="False" Height="200px" ShowMoreResultsBox="True"
                                            EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                    </div>
                                    <div class="RL_ActionHeader" style="width: 98%;">
                                        <table>
                                            <tr>
                                                <td>
                                                    <span class="drawing-iconSpace"></span>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label3" Width="99%" CssClass="Bold" runat="server" Text="Assets" meta:resourcekey="lblAsset" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="dvTreeSection" style="width: 100%;">
                                        <telerik:RadTreeView ID="rdvTargetAssetTree" Skin="Default" runat="server" Height="250px" Width="100%"
                                            MultipleSelect="false" OnClientMouseOver="onTreeViewMouseOver" ShowLineImages="false">
                                            <NodeTemplate>
                                                <asp:Literal ID="lblNode" Mode="Encode" runat="server"></asp:Literal>
                                            </NodeTemplate>
                                        </telerik:RadTreeView>
                                    </div>
                                    <div class="RL_ActionFooter">
                                        &nbsp;
                                    </div>
                                </telerik:RadPageView>
                            </telerik:RadMultiPage>
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" CssClass="ShowInHeaderWhenFit Responsive">
            <uc1:MoveManagementDetails ID="MoveManagementDetails1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server" Visible="False">
            <uc3:DocumentNotes ID="DocumentNotes1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server" Visible="False">
            <uc2:DocumentAttachments ID="DocumentAttachments1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server" Visible="False">
            <uc4:WorkflowDocument ID="WorkflowDocument1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc5:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>

</asp:Content>
