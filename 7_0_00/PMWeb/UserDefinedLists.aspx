<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="UserDefinedLists.aspx.vb" Inherits="Website.UserDefinedLists" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="AdvancedList.ascx" TagName="AdvancedList" TagPrefix="uc1" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

  
        <style>
            .SelectionListsTabs {
                background-color: RGB(255,255,255) !important;
                padding-top: 5px !important;
                font-weight: lighter !important;
                position:fixed;
                z-index:999;
            }
            .RadTabStrip.SelectionListsTabs .rtsUL{
                display: table !important;
                width: 100% !important;
            }
            .RadTabStrip.SelectionListsTabs .rtsLI {
                display: table-cell !important;
                float: none !important;
                vertical-align: top;
            }

            .mlpDocuments{padding-top:38px;}
            .RadTabStrip_Office2007 .rtsLevel1 .rtsLink.SelectionListsTabs {
                font-size: 20px !important;
            }

            .SelectionListsTabs.RadTabStrip .rtsSeparator {
                background-color: white !important;
                width: 2px !important;
                height: 23px !important;
                margin-top: 5px !important;
            }

            @media screen and (max-width: 843px) and (min-width: 320px) {
                .col-4-middle{
                    padding-left:0px !important;
                }
                .mlpDocuments{padding-bottom:36px}
                .RadTreeView {
                    max-height: 320px;
                    overflow: auto;
                }

                .col-4-middle {
                    margin-top: 24px;
                }

                .EmailSetupTabs .rtsLevel.rtsLevel1 {
                    width: 97vw !important;
                    padding-top: 5px;
                }

                 .SelectionListsTabs.RadTabStrip {
                margin-top: 0px !important;
                top:0px !important;
                }
            }
            .RadTreeView_Default .rtEdit .rtIn {
                background-color: #7396AA !important;
            }
        </style>
        <script type="text/javascript">


            function ClientNodeEdited(sender, args) {
                var node = args.get_node();

                var Val = node.get_value()

                if ((Val == "NEWITEM" || Val == "NEWLIST") && node.get_text() == "") {
                    document.getElementById("<%= hfNode.ClientID %>").value = node.get_value()
                    var updatepanel = $find('<%=  RadAjaxPanel1.ClientID %>')

                    __doPostBack('<%=  RadAjaxPanel1.ClientID %>');
                }
            }
            function ClientNodeEditedCustom(sender, args) {
                var node = args.get_node();

                var Val = node.get_value()

                if ((Val == "NEWITEM" || Val == "NEWLIST") && node.get_text() == "") {
                    document.getElementById("<%= hfNodeCustom.ClientID %>").value = node.get_value()
                    var updatepanel = $find('<%=  RadAjaxPanel2.ClientID %>')

                    __doPostBack('<%=  RadAjaxPanel2.ClientID %>');
                }
            }
        </script>
        <script src="JS/Lists/UserDefinedLists.js" type="text/javascript"></script>

    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpList" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="treeList">
                <UpdatedControls>
                   <telerik:AjaxUpdatedControl ControlID="treeList" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="treeListCustom">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="treeListCustom" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

    </telerik:RadAjaxManagerProxy>






    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" CssClass="SelectionListsTabs"
        runat="server" MultiPageID="mlpList" Skin="Default" Width="100%" EnableViewState="True"
        CausesValidation="False">
        <Tabs>
            <telerik:RadTab Value="Standard" Text="Standard" Selected="True" />
            <telerik:RadTab Text="Advanced" Value="Advanced"></telerik:RadTab>
        </Tabs>
    </telerik:RadTabStrip>

    <telerik:RadMultiPage ID="mlpList" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="True" CssClass="mlpDocuments">
        <telerik:RadPageView ID="pvDetails" runat="server" Selected="True">

            <div class="PMMainPage">
                <div class="row">
                    <div class="col-4 col-4-left">
                        <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" Height="100%" Width="100%">
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblSystemLists" meta:Resourcekey="lblSystemLists" runat="server" Text="System Lists"></asp:Label>
                                </legend>
                                <asp:HiddenField ID="hfNode" runat="server" />
                                <telerik:RadTreeView ID="treeList" CheckBoxes="true" EnableNodeTextHtmlEncoding="true" OnClientContextMenuItemClicking="onClientContextMenuItemClicking" OnClientContextMenuShowing="onClientContextMenuShowing" runat="server" EnableDragAndDrop="True" MultipleSelect="true"
                                    OnClientNodeEdited="ClientNodeEdited" OnClientNodeEditStart="OnClientNodeEditStartHandler" CssClass="CheckBoxesTreeview" TriStateCheckBoxes="True" OnClientLoad="OnClientLoad">
                                    <ContextMenus>
                                        <telerik:RadTreeViewContextMenu ID="MainContextMenu" runat="server" Skin="Default" CssClass="trvContextMenu">
                                            <Items>
                                                <telerik:RadMenuItem Value="Rename" meta:Resourcekey="MenuItem_Rename" Text="Rename"
                                                    EnableImageSprite="true" CssClass="MenuRename">
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Value="MakeInactive" meta:Resourcekey="MenuItem_MakeInactive" Text="New Item"
                                                    EnableImageSprite="true" CssClass="MenuCheckedInDisabled">
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Value="MakeActive" meta:Resourcekey="MenuItem_MakeActive" Text="New Item"
                                                    EnableImageSprite="true" CssClass="MenuCheckedIn">
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Value="NewItem" meta:Resourcekey="MenuItem_NewItem" Text="New Item"
                                                    EnableImageSprite="true" CssClass="MenuAdd">
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Value="Delete" meta:Resourcekey="MenuItem_Delete" Text="Delete"
                                                    EnableImageSprite="true" CssClass="MenuDelete">
                                                </telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadTreeViewContextMenu>
                                    </ContextMenus>
                                    <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                                    <ExpandAnimation Duration="100"></ExpandAnimation>
                                </telerik:RadTreeView>
                            </fieldset>

                        </telerik:RadAjaxPanel>
                    </div>
                    <div class="col-4 col-4-middle">
                        <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" Height="100%" Width="100%">
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblCustomLists" meta:Resourcekey="lblCustomLists" runat="server" Text="Custom Lists"></asp:Label>
                                </legend>
                                <asp:HiddenField ID="hfNodeCustom" runat="server" />
                                <telerik:RadTreeView ID="treeListCustom" CheckBoxes="true" EnableNodeTextHtmlEncoding="true" OnClientContextMenuItemClicking="onClientContextMenuItemClicking" OnClientContextMenuShowing="onClientContextMenuShowing" runat="server" EnableDragAndDrop="True" MultipleSelect="true"
                                    OnClientNodeEdited="ClientNodeEditedCustom" OnClientNodeEditStart="OnClientNodeEditStartHandler" CssClass="CheckBoxesTreeview" TriStateCheckBoxes="True" OnClientLoad="OnClientLoad">
                                    <ContextMenus>
                                        <telerik:RadTreeViewContextMenu ID="RadTreeViewContextMenu1" runat="server" Skin="Default" CssClass="trvContextMenu">
                                            <Items>
                                                <telerik:RadMenuItem Value="Rename" meta:Resourcekey="MenuItem_Rename" Text="Rename"
                                                    EnableImageSprite="true" CssClass="MenuRename">
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Value="MakeInactive" meta:Resourcekey="MenuItem_MakeInactive" Text="New Item"
                                                    EnableImageSprite="true" CssClass="MenuCheckedInDisabled">
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Value="MakeActive" meta:Resourcekey="MenuItem_MakeActive" Text="New Item"
                                                    EnableImageSprite="true" CssClass="MenuCheckedIn">
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Value="NewItem" meta:Resourcekey="MenuItem_NewItem" Text="New Item"
                                                    EnableImageSprite="true" CssClass="MenuAdd">
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Value="NewList" meta:Resourcekey="MenuItem_NewList" Text="New List"
                                                    EnableImageSprite="true" CssClass="MenuAdd">
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Value="Delete" meta:Resourcekey="MenuItem_Delete" Text="Delete"
                                                    EnableImageSprite="true" CssClass="MenuDelete">
                                                </telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadTreeViewContextMenu>
                                    </ContextMenus>
                                    <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                                    <ExpandAnimation Duration="100"></ExpandAnimation>
                                </telerik:RadTreeView>
                            </fieldset>
                        </telerik:RadAjaxPanel>
                    </div>
                </div>
            </div>

            <telerik:RadAjaxLoadingPanel ID="ldpList" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvSpec" runat="server">

            <uc1:AdvancedList ID="AdvancedList1" runat="server" />
        </telerik:RadPageView>

    </telerik:RadMultiPage>


</asp:Content>

