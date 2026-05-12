<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="AdaptiveFormBuilder.aspx.vb" Inherits="Website.AdaptiveFormBuilder" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="AdaptiveFormPermissions.ascx" TagName="AdaptiveFormPermissions" TagPrefix="uc1" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <style>
        .rgDataDiv {
            width: auto !important;
            max-height: 184px !important;
            height: auto !important;
            overflow: auto !important;
        }
    </style>

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script language="javascript" type="text/javascript">
            function ToolbarGlobalClientButtonClicking(sender, args) {
                var value = args.get_item().get_commandName();
                if (value == 'Save') {
                    const targetWindow = document.getElementById('ctl00_CPH1_ngFrame');
                    if (targetWindow) {
                        const messageData = {
                            event_id: 'SaveTemplate',
                            FromId: 'nothing'
                        };
                        targetWindow.contentWindow.postMessage(messageData, '*');
                        args.set_cancel(true);
                    }
                }
                else if (value == "Delete") {
                    if (!confirm(Msg_ConfirmDeleteDocument)) {
                        args.set_cancel(true);
                    }
                }
            }

            window.addEventListener('message', function (event) {
                if (event.data.event_id === 'TemplateSaved') {
                    var hdnFormId = document.getElementById('<%= hdnFormId.ClientID %>');
                    hdnFormId.value = event.data.TemplateId;
                    __doPostBack('<%= btnPost.UniqueID %>', '');
                }
            });

            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                    sender.close(true);

                    if (args.get_item().get_value() == "Print") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("Print");
                        button.click();
                    }

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
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName(), args.get_item().get_element())
            }


            function maintoolbarClick(Value, ItemElement) {
                switch (Value) {
                    case 'Print':

                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        args.set_cancel(true);

                        break;
                    case 'BIReporting':

                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        args.set_cancel(true);
                        break;

                    default:
                        break;
                }
            }
            var forceMoreMenuToClose = true;
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

            function CheckViewRight(chkViewOnly) {
                var tr = $(chkViewOnly).parents("tr:first");
                if (!chkViewOnly.checked) {
                    tr.find("input[id $= 'chkFullControl']")[0].checked = false;
                    tr.find("input[id $= 'chkCanAdd']")[0].checked = false;
                    tr.find("input[id $= 'chkCanDelete']")[0].checked = false;
                    tr.find("input[id $= 'chkCanEdit']")[0].checked = false;
                    tr.find("input[id $= 'chkEditPermissions']")[0].checked = false;

                }
            }


            function CheckRight(chkRight) {
                var tr = $(chkRight).parents("tr:first");
                var chkFullControl = tr.find("input[id $= 'chkFullControl']")[0];
                var chkCanRead = tr.find("input[id $= 'chkCanRead']")[0];
                var chkCanAdd = tr.find("input[id $= 'chkCanAdd']")[0];
                var chkCanEdit = tr.find("input[id $= 'chkCanEdit']")[0];
                var chkCanDelete = tr.find("input[id $= 'chkCanDelete']")[0];
                var chkEditPermissions = tr.find("input[id $= 'chkEditPermissions']")[0];
                if (chkRight.checked) {
                    chkCanRead.checked = true;
                    if (chkCanAdd.checked && chkCanEdit.checked && chkCanDelete.checked && chkEditPermissions.checked)
                        chkFullControl.checked = true;
                } else {
                    chkFullControl.checked = false;
                }
            }


            function CheckAdd(chkRight) {
                var tr = $(chkRight).parents("tr:first");
                var chkFullControl = tr.find("input[id $= 'chkFullControl']")[0];
                var chkCanRead = tr.find("input[id $= 'chkCanRead']")[0];
                var chkCanAdd = tr.find("input[id $= 'chkCanAdd']")[0];
                var chkCanEdit = tr.find("input[id $= 'chkCanEdit']")[0];
                var chkCanDelete = tr.find("input[id $= 'chkCanDelete']")[0];
                var chkEditPermissions = tr.find("input[id $= 'chkEditPermissions']")[0];
                if (chkRight.checked) {
                    chkCanRead.checked = true;
                    if (chkCanAdd.checked && chkCanEdit.checked && chkCanDelete.checked && chkEditPermissions.checked)
                        chkFullControl.checked = true;
                } else {
                    chkFullControl.checked = false;
                }
                if (chkCanAdd.checked) {
                    chkCanEdit.checked = true;
                }
            }

            function CheckFullControlRight(chkFullControl) {
                var tr = $(chkFullControl).parents("tr:first");
                var chkCanRead = tr.find("input[id $= 'chkCanRead']")[0];
                var chkCanAdd = tr.find("input[id $= 'chkCanAdd']")[0];
                var chkCanEdit = tr.find("input[id $= 'chkCanEdit']")[0];
                var chkCanDelete = tr.find("input[id $= 'chkCanDelete']")[0];
                var chkEditPermissions = tr.find("input[id $= 'chkEditPermissions']")[0];
                if (chkFullControl.checked) {
                    chkCanRead.checked = true;
                    chkCanAdd.checked = true;
                    chkCanEdit.checked = true;
                    chkCanDelete.checked = true;
                    chkEditPermissions.checked = true;
                } else {
                    chkCanRead.checked = false;
                    chkCanAdd.checked = false;
                    chkCanEdit.checked = false;
                    chkCanDelete.checked = false;
                    chkEditPermissions.checked = false;
                }
            }

            function CheckSelectViewRight(chkViewOnly) {
                var tr = $(chkViewOnly).parents("tr:first");
                if (!chkViewOnly.checked) {
                    tr.find("input[id $= 'chkSelectFullControl']")[0].checked = false;
                    tr.find("input[id $= 'chkSelectCanAdd']")[0].checked = false;
                    tr.find("input[id $= 'chkSelectCanDelete']")[0].checked = false;
                    tr.find("input[id $= 'chkSelectCanEdit']")[0].checked = false;
                    tr.find("input[id $= 'chkSelectEditPermissions']")[0].checked = false;

                }
            }


            function CheckSelectRight(chkRight) {
                var tr = $(chkRight).parents("tr:first");
                var chkSelectFullControl = tr.find("input[id $= 'chkSelectFullControl']")[0];
                var chkSelectCanRead = tr.find("input[id $= 'chkSelectCanRead']")[0];
                var chkSelectCanAdd = tr.find("input[id $= 'chkSelectCanAdd']")[0];
                var chkSelectCanEdit = tr.find("input[id $= 'chkSelectCanEdit']")[0];
                var chkSelectCanDelete = tr.find("input[id $= 'chkSelectCanDelete']")[0];
                var chkSelectEditPermissions = tr.find("input[id $= 'chkSelectEditPermissions']")[0];
                if (chkRight.checked) {
                    chkSelectCanRead.checked = true;
                    if (chkSelectCanAdd.checked && chkSelectCanEdit.checked && chkSelectCanDelete.checked && chkSelectEditPermissions.checked)
                        chkSelectFullControl.checked = true;
                } else {
                    chkSelectFullControl.checked = false;
                }
            }

            function CheckSelectFullControlRight(chkFullControl) {
                var tr = $(chkFullControl).parents("tr:first");
                var chkSelectCanRead = tr.find("input[id $= 'chkSelectCanRead']")[0];
                var chkSelectCanAdd = tr.find("input[id $= 'chkSelectCanAdd']")[0];
                var chkSelectCanEdit = tr.find("input[id $= 'chkSelectCanEdit']")[0];
                var chkSelectCanDelete = tr.find("input[id $= 'chkSelectCanDelete']")[0];
                var chkSelectEditPermissions = tr.find("input[id $= 'chkSelectEditPermissions']")[0];
                if (chkFullControl.checked) {
                    chkSelectCanRead.checked = true;
                    chkSelectCanAdd.checked = true;
                    chkSelectCanEdit.checked = true;
                    chkSelectCanDelete.checked = true;
                    chkSelectEditPermissions.checked = true;
                } else {
                    chkSelectCanRead.checked = false;
                    chkSelectCanAdd.checked = false;
                    chkSelectCanEdit.checked = false;
                    chkSelectCanDelete.checked = false;
                    chkSelectEditPermissions.checked = false;
                }
            }
        </script>

    </telerik:RadCodeBlock>
     <asp:HiddenField ID="hdnFormId" runat="server" /> <asp:Button ID="btnPost" runat="server" style="display:none" />
    <table class="ToolBar LargeToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
           <%-- <td style="width: 240px;" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                <telerik:RadComboBox ID="ddlAdaptiveFormTemplates" LoadingMessage="<%$ Resources:PMWeb, Loading %>" OnItemsRequested="ddl_ItemsRequested"
                    runat="server" Skin="Default" Width="99%" ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True"
                    AutoPostBack="false" AllowCustomText="True" CausesValidation="False" Height="400px"
                    meta:resourcekey="ddlAdaptiveFormTemplates" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging" DropDownCssClass="ToolbarDropdown">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>--%>
            <td valign="middle" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True" >
                    <Items>
                       <%-- <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>--%>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" ValidationGroup="Save" CausesValidation="true" AccessKey="s">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png" CausesValidation="False" CommandName="New"
                            EnableDefaultButton="false" PostBack="true" ToolTip="New (Alt+n)">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" Value="Delete">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                            CssClass="ToolbarPrint" OuterCssClass="HideOnMobileToolbar" EnableDefaultButton="false" PostBack="false" Value="Print">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Print" Value="Print" CssClass="Print">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Go To Bi Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Active" Value="Active" CssClass="ActiveLocation" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="InActive" Value="InActive" CssClass="InactiveLocation" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" onclick="helpClick();" CssClass="Help"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Active.png" CssClass="ToolbarActive HideOnMobileToolbar"
                            Value="Activate" CausesValidation="false" CommandName="Active" ToolTip="Activate">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>

    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" ScrollChildren="true" ScrollButtonsPosition="Left"
        runat="server" MultiPageID="mlpCustomFormType" Skin="Default" Width="100%" EnableViewState="True" CssClass="documentTabs"
        CausesValidation="False">
        <Tabs>
            <telerik:RadTab meta:resourcekey="tab_DesignForm" Text="Design Form1" Value="DesignForm" Selected="True" />
            <telerik:RadTab meta:resourcekey="tab_AssignPermissions" Text="Assign Permissions1" Value="AssignPermissions" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpCustomFormType" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPages"
        RenderSelectedPageOnly="True">
        <telerik:RadPageView ID="pvHDefineFields" runat="server" Selected="True" >
            <telerik:RadAjaxPanel ID="pnlDetailPane" LoadingPanelID="ldpPM" runat="server" Width="100%" HorizontalAlign="NotSet">
                <iframe runat="server" id="ngFrame" style="width:100%; height:Calc(100VH - 240px); z-index:7000; position:relative; background-color: white" frameborder="0"></iframe>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvPermissions" runat="server" Visible="False">
            <uc1:AdaptiveFormPermissions ID="AdaptiveFormPermissions" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>

</asp:Content>
