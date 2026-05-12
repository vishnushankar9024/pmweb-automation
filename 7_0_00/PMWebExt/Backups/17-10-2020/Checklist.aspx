<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="Checklist.aspx.vb" Inherits="Website.Checklist" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc4" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc6" %>
<%@ Register Src="CheckListDetails.ascx" TagName="CheckListDetails" TagPrefix="uc1" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc11" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings> 
                   <telerik:AjaxSetting AjaxControlID="mlpChecklIST">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpChecklIST" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpChecklIST" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <script type="text/javascript">
        function MoreMenuClicked(sender, args) {
            if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                sender.close(true);
            if (args.get_item().get_value() == "Print") {
                var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                var button = mainToolBar.findItemByValue("Print");
                button.click();
            }
        }

    </script>






    <table class="ToolBar SmallToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td>
                <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td class="ToolbarTd">
                            <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=141">
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
                            <telerik:RadComboBox ID="ddlCheckLists" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                                Skin="Default" CloseDropDownOnBlur="true" AllowCustomText="true" meta:resourcekey="ddlCheckLists"
                                Width="240px" AutoPostBack="True" NoWrap="true" CausesValidation="False"
                                Height="400px" EnableLoadOnDemand="true" ShowMoreResultsBox="True" CheckForDirt="True"
                                EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                            </telerik:RadComboBox>
                        </td>
                        <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                            <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True">
                                <Items>
                                    <%-- <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                                        Value="Search" NavigateUrl="SearchDocument.aspx?O=141" CausesValidation="false">
                                    </telerik:RadToolBarButton>--%>

                                    <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                                        CommandName="Save" AccessKey="s" ToolTip="Save (Alt+s)" ValidationGroup="Save">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton  SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"  CausesValidation="False" CommandName="New" 
                                                 EnableDefaultButton="false" PostBack="true" ToolTip="New (Alt+n)">
                                               
                                       </telerik:RadToolBarButton>


                                    <%--<telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                                        SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                                        <Buttons>
                                            <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                                CommandName="New" AccessKey="n" ToolTip="New (Alt+n)" Width="150px" CausesValidation="false">
                                            </telerik:RadToolBarButton>
                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>--%>

                                    <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                                        CommandName="Delete" CausesValidation="false" AccessKey="d" ToolTip="Delete (Alt+d)"
                                        Value="Delete">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton SecurityButtonType="Read" Value="Print" CssClass="ToolbarPrint" OuterCssClass="HideOnMobileToolbar" ImageUrl="Images/ToolBar/Printer.png" ToolTip="Print" CommandName="Print"></telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                                        <ItemTemplate>
                                            <telerik:RadMenu runat="server" ID="radmen" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked">
                                                <Items>
                                                    <telerik:RadMenuItem CssClass="menuMore">
                                                        <Items>
                                                            <telerik:RadMenuItem Text="Print" Value="Print">
                                                            </telerik:RadMenuItem>
                                                             <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('CheckList');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                        </Items>
                                                    </telerik:RadMenuItem>
                                                </Items>
                                            </telerik:RadMenu>
                                        </ItemTemplate>
                                    </telerik:RadToolBarButton>

                                </Items>
                            </telerik:RadToolBar>
                        </td>
                        <td style="width: 100%"></td>
                    </tr>
                </table>
            </td>

        </tr>
    </table>

    <table style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr id="trTbsDetails" runat="server">
            <td>
                <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument"
                    runat="server" MultiPageID="mlpChecklIST" Skin="Default"
                    Width="100%" EnableViewState="true" CausesValidation="False" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs">
                    <Tabs>
                        <telerik:RadTab Text="Header" Value="Header" Selected="true" />
                        <telerik:RadTab Text="Details" Value="Details" CssClass="HideTabWhenDetailShownInHeader"></telerik:RadTab>
                        <telerik:RadTab Text="Notes" Value="Notes"></telerik:RadTab>
                        <telerik:RadTab Text="Attachments" Value="Attachments"></telerik:RadTab>
                    </Tabs>
                </telerik:RadTabStrip>

                <telerik:RadMultiPage ID="mlpChecklIST" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPages"
                    RenderSelectedPageOnly="True">
                    <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
                        <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" LoadingPanelID="ldpPM" EnableAJAX="false">
                            <div class="PMMainPage">
                                <div class="row">
                                    <div class="col-4 col-4-left">
                                        <table class="colTable" id="tblCheckListInfo">
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblCheckListType" meta:resourcekey="lblCheckListType" runat="server"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <telerik:RadComboBox ID="ddlCheckListType" runat="server" AutoPostBack="false" Skin="Default" Filter="Contains" MarkFirstMatch="true"
                                                         AllowCustomText="true" Width="100%"
                                                        NoWrap="true"  Height="300px" EnableLoadOnDemand="false">
                                                    </telerik:RadComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblId" runat="server" meta:Resourcekey="lblIdChecklist"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <asp:TextBox ID="txtCode" runat="server" MaxLength="15"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvCode" runat="server" ValidationGroup="Save" ControlToValidate="txtCode"
                                                        CssClass="Validator" Display="Dynamic" meta:Resourcekey="rfvChecklistCode" ErrorMessage="Enter The Checklist ID."
                                                        ForeColor=""></asp:RequiredFieldValidator>
                                                    <asp:Label ID="lblCommIDUnique" runat="server" meta:Resourcekey="lblCommIDUnique"
                                                        Visible="False" Class="Validator" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="labelWidth">
                                                    <asp:Label ID="lblDescription" meta:Resourcekey="lblDescription" runat="server"></asp:Label>
                                                </td>
                                                <td class="controlWidth">
                                                    <asp:TextBox ID="txtDescription" runat="server" MaxLength="250"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="col-4 col-4-right">
                                        <uc11:AssetRotator ID="PMrot" runat="server" />
                                    </div>
                                </div>
                            </div>
                        </telerik:RadAjaxPanel>
                    </telerik:RadPageView>

                    <telerik:RadPageView ID="pvDetails" runat="server" Width="100%" CssClass="ShowInHeaderWhenFit Responsive">
                        <uc1:CheckListDetails ID="CheckListDetails1" runat="server" />
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvNotes" runat="server"
                        Visible="False">
                        <uc4:DocumentNotes ID="DocumentNotes" runat="server" />
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvAttachments" runat="server"
                        Visible="False">
                        <uc6:DocumentAttachments ID="DocumentAttachments" runat="server" />
                    </telerik:RadPageView>
                </telerik:RadMultiPage>

            </td>
        </tr>
    </table>

</asp:Content>
