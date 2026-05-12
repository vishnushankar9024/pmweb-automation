<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BIReporting.ascx.vb" Inherits="Website.BIReporting" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<link href="CSS/ControlsCSS/Tree.css" rel="stylesheet" />
<link href="CSS/MainCss.css" rel="stylesheet" />
<telerik:RadCodeBlock ID="CodeBlock" runat="server">

    <script type="text/javascript">
        
    </script>
</telerik:RadCodeBlock>
<style>
    .BiReportingExplorerBar {
        left: 285px !important;
    }

    .BIReportingLabel {
        font-size: 16px !important;
        font-style: italic !important;
        color: #666666 !important;
    }
    .AssetSplitterRightPane {
        height: calc(100vh - 153px) !important;
    }
    @media screen and (min-width:320px) and (max-width:1056px) {
        .HideForReportingTabToolbar {
            display: none !important;
        }
    }

    @media screen and (max-width: 843px) and (min-width: 320px) {
        .AssetSplitterPane {
            margin-top: 0px !important;
            height: calc(100vh - 38px) !important;
        }

        .AssetSplitter {
            margin-top: 0px !important;
            top: 0px !important;
        }

        .AssetSplitterRightPane {
            width: calc(100vw - 20x) !important;
        }
        .AssetSplitterRightPane {
            height: calc(100vh - 129px) !important;
        }
    }

    .ddlWidth {
        min-width: 220px;
        width: 240px !important;
    }

    @media screen and (min-width: 843px) and (max-width: 934px) {
        .ddlWidth {
            width: 120px !important;
            min-width: 120px !important;
        }

        .AssetSplitterRightPane {
            width: 100% !important;
        }
    }

    @media screen and (min-width: 844px) {
        .AssetExplorerVerticalSplitter {
            height: calc(100vh - 151px) !important;
        }

        .AssetSplitterPane {
            height: calc(100vh - 151px) !important;
        }
    }

    .BiReportingTree {
        height: 100% !important;
        padding: 0px !important;
    }

    .removeLeft {
        left: 0 !important;
    }

    .AssetSplitterPane {
        background-color: #666666 !important;
    }
</style>
<telerik:RadAjaxPanel runat="server" ID="pnlajax" LoadingPanelID="ldpPM">
    <table style="width: 100%;  height: 40px;" cellpadding="0" cellspacing="0">
        <tr style="background-color: #ededed">
            <td style="width: 80px !important; color: #666666;" class="ToolbarTd HideForReportingTabToolbar HideOnMobileToolbar">
                <asp:HiddenField ID="hdnGroupUserId" runat="server" />
                <asp:HiddenField ID="hdnGroupUserType" runat="server" />
                <asp:Button ID="btnLoadSettings" CssClass="Hide" runat="server" />
                <asp:Label ID="lblGroupUser" meta:resourcekey="lblGroupUser" runat="server" Text="Group/User123"></asp:Label>
            </td>
            <td class="ToolbarTd ddlWidth">
                <telerik:RadComboBox ID="ddlGroupsUsers" runat="server" OnClientDropDownOpened="OnClientDropDownOpened"
                    CloseDropDownOnBlur="true" Width="100%" AutoPostBack="False" DropDownCssClass="ddlTreeviewTemplate"
                    Height="260px" CausesValidation="False" AllowCustomText="True" CssClass="ddlWidth">
                    <Items>
                        <telerik:RadComboBoxItem Text="" />
                    </Items>
                    <ItemTemplate>
                        <div onclick="StopPropagation(event)">
                            <telerik:RadTreeView ID="rdvGroupsUsers" runat="server" Height="250px" Width="100%" OnNodeDataBound="rdvGroupsUsers_NodeDataBound"
                                OnNodeExpand="rdvGroupsUsers_NodeExpand" OnNodeClick="rdvGroupsUsers_NodeClick"
                                MultipleSelect="false" ShowLineImages="true">
                            </telerik:RadTreeView>
                        </div>
                    </ItemTemplate>
                </telerik:RadComboBox>
            </td>
            <asp:Panel ID="pnlToolBar" runat="server">
                <td valign="middle" style="vertical-align: middle" class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" AutoPostBack="true" OnClientButtonClicked="click_handler" OnClientButtonClicking="OnClientButtonClicking">
                        <Items>
                            <telerik:RadToolBarSplitButton EnableDefaultButton="false" PostBack="false" Text="Load...1" meta:resourcekey="ToolBarButton_Load" OuterCssClass="HideOnMobileToolbar">
                                <Buttons>
                                    <telerik:RadToolBarButton PostBack="true" CommandName="LoadDeployed" meta:resourcekey="ToolBarButton_LoadUserDeploy" Text="Load the selection's deployed settings1"></telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton PostBack="false" CommandName="ViewGroups" meta:resourcekey="ToolBarButton_CopyFromGroup" Text="Copy from a group1" SecurityButtonType="Edit"></telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton PostBack="false" CommandName="ViewUsers" meta:resourcekey="ToolBarButton_CopyFromUser" Text="Copy from a user1" SecurityButtonType="Edit"></telerik:RadToolBarButton>
                                </Buttons>
                            </telerik:RadToolBarSplitButton>
                            <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                                <ItemTemplate>
                                    <telerik:RadMenu runat="server" CssClass="MoreMenu" ID="MobileRadmen" ClickToOpen="true" OnClientItemClicking="MoreMenuClicked">
                                        <Items>
                                            <telerik:RadMenuItem CssClass="menuMore">
                                                <Items>
                                                    <telerik:RadMenuItem Text="Load" Value="Load">
                                                        <Items>
                                                            <telerik:RadMenuItem Text="Load the selection's deployed settings1" Value="LoadDeployed"></telerik:RadMenuItem>
                                                            <telerik:RadMenuItem Text="Copy from a group1" Value="ViewGroups"></telerik:RadMenuItem>
                                                            <telerik:RadMenuItem Text="Copy from a user1" Value="ViewUsers"></telerik:RadMenuItem>
                                                        </Items>
                                                    </telerik:RadMenuItem>
                                                    <telerik:RadMenuItem Text="Save1" Value="Save"></telerik:RadMenuItem>
                                                    <%--<telerik:RadMenuItem Text="Toggle tree1" Value="ToggleFlyoutTree"></telerik:RadMenuItem>--%>
                                                    <telerik:RadMenuItem Text="Deploy Settings1" Value="DeploySettings"></telerik:RadMenuItem>
                                                </Items>
                                            </telerik:RadMenuItem>
                                        </Items>
                                    </telerik:RadMenu>
                                </ItemTemplate>
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
                <td style="width: 24px;" class="ToolbarTd HideOnMobileToolbar">
                    <telerik:RadToolBar ID="SaveToolBar" CssClass="popup-toolbar" runat="server" Skin="Default" AutoPostBack="True" OnClientButtonClicking="OnClientButtonClicking">
                        <Items>
                            <telerik:RadToolBarButton SecurityButtonType="Edit" Value="Save" EnableImageSprite="true"
                                CommandName="Save" CssClass="ToolbarSave">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton ID="btnDeploy" PostBack="true" runat="server" CssClass="lnkCreateNext" OuterCssClass="HideOnMobileToolbar" Value="DeploySettings"
                                meta:resourcekey="btn_Deploy" CommandName="DeploySettings" Text="Deploy Settings1" ImageUrl="Images/ToolBar/PMWebW.gif" ValidationGroup="Save"
                                OnClientClick="return OnClientDeployClick('BIReporting');">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                    <%--<asp:Button ID="btnDeploySettings" CssClass="Hide" runat="server" />--%>
                </td>
                <td style="width: unset !important; padding-left: 8px;">
                    <asp:Label ID="lblMessage" Visible="false" Text="SAVED SETTINGS NOT DEPLOYED1" runat="server" meta:resourcekey="lblMessage" CssClass="BIReportingLabel"></asp:Label>
                </td>
            </asp:Panel>
        </tr>
    </table>
    <telerik:RadSplitter ID="RadSplitter1" runat="server" Skin="Default" Width="100%"  CssClass="RDSplitter" SplitBarsSize="">
        <telerik:RadPane ID="treeGroupsAndItemsPane" runat="server" CssClass="RDLeftPane" Width="30%" EnableEmbeddedBaseStylesheet="False" Index="0" Skin="">
            <telerik:RadTreeView ID="treeReports" runat="server" OnClientLoad="OnClientBITreeLoad" CssClass="WhitePlusMinus"
                MultipleSelect="true" EnableDragAndDrop="false" AllowNodeEditing="false" EnableEmbeddedSkins="false" CausesValidation="false" Style="padding: 24px 0 0 24px;height:calc(100% - 24px)">
                <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                <ExpandAnimation Duration="100"></ExpandAnimation>
            </telerik:RadTreeView>
        </telerik:RadPane>
        <telerik:RadSplitBar ID="Splitter" runat="server" Index="1" Skin="Default" meta:resourcekey="Splitter" CssClass="AssetSplitter" CollapseMode="Forward" />
        <telerik:RadPane ID="RadContentPane" runat="server" Width="70%" Index="2" Skin="Default" CssClass="RDLeftPane">
            <div class="PMMainPage JustifyContent">
                <div class="row ">
                    <div class="col-4 col-4-left">

                        <fieldset>
                            <legend>
                                <asp:Label ID="lblParameters" runat="server" Text="Parameters" meta:resourcekey="lblParameters"></asp:Label></legend>
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRecordType" Text="Associate With" runat="server" meta:resourcekey="lblRecordType"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlObjectTypes" runat="server" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true"
                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>" Height="250px" Width="100%" AutoPostBack="True" NoWrap="True" Skin="Default"
                                            CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage="Select" EnableVirtualScrolling="true"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" OnItemsRequested="ddl_ItemsRequested" Style="font-size: 11px">
                                        </telerik:RadComboBox>
                                        <asp:CompareValidator ID="rfvObjectTypes" runat="server"
                                            ControlToValidate="ddlObjectTypes" CssClass="Validator"
                                            meta:resourcekey="csvRecordType" Display="Dynamic" ForeColor="" Operator="NotEqual" ValueToCompare="0">
                                        </asp:CompareValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="width: 100% !important;">
                                        <table class="colTable" style="color: #666666 !important;">
                                            <tr>
                                                <td style="width: 90% !important">
                                                    <asp:Label ID="lblDefaultReport" Text="Make This the Default Report for the Selected Record Type" runat="server" meta:resourcekey="lblDefaultReport"></asp:Label>
                                                </td>
                                                <td style="text-align: right; width: 10% !important;">
                                                    <%--<asp:CheckBox ID="chkDefault" runat="server" class="mobile-switch" />--%>
                                                    <label class="switch">
                                                        <input id="chkDefault" runat="server" type="checkbox" />
                                                        <span class="slider round"></span>
                                                    </label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 90% !important">
                                                    <asp:Label ID="lblAllowUsers" Text="Allow Users to Edit Settings" runat="server" meta:resourcekey="lblAllowUsers"></asp:Label>
                                                </td>
                                                <td style="text-align: right; width: 10% !important;">
                                                    <%--<asp:CheckBox ID="chkAllowEdit" runat="server" class="mobile-switch" />--%>
                                                    <label class="switch">
                                                        <input id="chkAllowEdit" runat="server" type="checkbox" />
                                                        <span class="slider round"></span>
                                                    </label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <telerik:RadGrid ID="rdgReportParameters" Width="100%" runat="server"
                                            AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" GridLines="None">
                                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                CommandItemDisplay="None" DataKeyNames="Id" EditMode="InPlace" InsertItemPageIndexAction="ShowItemOnFirstPage">
                                                <Columns>
                                                    <telerik:GridTemplateColumn HeaderText="Name" UniqueName="Name">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" Text='<%#Container.DataItem("ParameterName")%>' CssClass="NoWrap" ID="lblParamName">
                                                            </asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="60px" />
                                                        <ItemStyle Wrap="false " />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="PMWeb Field" UniqueName="Field">
                                                        <ItemTemplate>
                                                            <telerik:RadComboBox ID="ddlFields" runat="server">
                                                            </telerik:RadComboBox>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="100px" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Default" UniqueName="Default">
                                                        <ItemTemplate>
                                                            <asp:TextBox Width="100%" runat="server" Text='<%#Container.DataItem("FixedValue")%>' ID="txtDefault">
                                                            </asp:TextBox>
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="90px" />
                                                        <ItemStyle />
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                                <EditFormSettings>
                                                    <EditColumn CancelImageUrl="Cancel.gif" EditImageUrl="Edit.gif" InsertImageUrl="Update.gif" UpdateImageUrl="Update.gif">
                                                    </EditColumn>
                                                </EditFormSettings>
                                                <CommandItemTemplate>
                                                </CommandItemTemplate>
                                            </MasterTableView>
                                            <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                            <FilterMenu Skin="Default" EnableTheming="True">
                                                <CollapseAnimation Type="OutQuint" Duration="200"></CollapseAnimation>
                                            </FilterMenu>
                                            <HeaderContextMenu EnableViewState="false">
                                            </HeaderContextMenu>
                                            <ValidationSettings ValidationGroup="ObjectImport" EnableValidation="true" CommandsToValidate="SaveChanges" />
                                        </telerik:RadGrid>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                    <div class="col-4 col-4-right">
                        <fieldset>
                            <legend>
                                <asp:Label ID="lblDetails" runat="server" Text="Parameters" meta:resourcekey="lblDetails"></asp:Label>
                            </legend>
                            <table id="tblReportInfo" runat="server" class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblReportName" meta:resourcekey="lblReportName" runat="server" Text="Report Name*1"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtReportName" MaxLength="100" runat="server" Width="100%"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblServerURL" meta:resourcekey="lblServerURL" runat="server" Text="Server URL*1"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtServerURL" MaxLength="1000" runat="server" Width="100%"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblReportType" meta:resourcekey="lblReportType" runat="server" Text="Report Type1"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlReportType" runat="server" AllowCustomText="true" MarkFirstMatch="True"
                                            Skin="Default" CloseDropDownOnBlur="true" Height="100" Width="100%">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblIsSystem" meta:resourcekey="lblIsSystem" runat="server" Text="Is System1"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <img src="Images/Global/<%=CStr(IIf(PM.ReportInfo.IsSystem, "checked.png", "unchecked.png"))%>" alt="" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblReportingFolder" meta:resourcekey="lblReportingFolder" runat="server" Text="Folder Path1"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtReportingFolder" MaxLength="100" runat="server" Width="100%" Enabled="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPath" runat="server" meta:Resourcekey="lblPath" Text="Path*"></asp:Label>
                                    </td>
                                    <td class="Controlwidth">
                                        <asp:TextBox ID="txtPath" MaxLength="1000" runat="server" Width="100%"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                </div>
            </div>
        </telerik:RadPane>
    </telerik:RadSplitter>
</telerik:RadAjaxPanel>
