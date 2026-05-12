<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="AdjustmentGroups.aspx.vb" Inherits="Website.AdjustmentGroups" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="ddlGroups">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rtvAdjustments" LoadingPanelID="ldpCostCodes" />
                    <telerik:AjaxUpdatedControl ControlID="ddlGroups" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rdgAdjustments">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgAdjustments" LoadingPanelID="ldpCostCodes" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rtvAdjustments">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgAdjustments" LoadingPanelID="ldpCostCodes" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="ldpCostCodes" runat="server" Skin="Default" />
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script language="javascript" type="text/javascript">
            var gridId = "ctl00_CPH1_rdgAdjustments";
            var forceMoreMenuToClose = true;
            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                    sender.close(true);
                    maintoolbarClick(args.get_item().get_value())
                }
            }
            function MoreMenuClosing(sender, args) {
                if (forceMoreMenuToClose) {
                    //forceradmenuToClose = false;
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
            function OnClientLoad(editor, args) {
                editor.get_contentArea().style.backgroundColor = "white";
                editor.get_contentArea().style.backgroundImage = "none";
               
            }

            function isMouseOverGrid(target) {
                parentNode = target;
                while (parentNode != null) {
                    if (parentNode.id == gridId) {
                        return parentNode;
                    }
                    parentNode = parentNode.parentNode;
                }
                return null;
            }

            function onNodeDragging(sender, args) {
                var target = args.get_htmlElement();

                if (!target) return;

                if (target.tagName == "INPUT") {
                    target.style.cursor = "hand";
                }

                var grid = isMouseOverGrid(target)
                if (grid) {
                    grid.style.cursor = "hand";
                }
            }

            function droppedOnGrid(args) {
                var target = args.get_htmlElement();

                while (target) {
                    if (target.id == gridId) {
                        args.set_htmlElement(target);
                        return;
                    }

                    target = target.parentNode;
                }
                args.set_cancel(true);
            }

            function maintoolbarClick(Value) {
                var Id = '<%=PM.AdjustmentGroupInfo.Id%>';
                var HasReports = '<%= PM.AdjustmentGroupInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.AdjustmentGroupInfo.Code & " - " & PM.AdjustmentGroupInfo.Description)%>';
                switch (Value) {
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            window.open("ReportsPreviewPopup.aspx?ObjectType=ADJUSTMENT_GROUPS&Id=" +
                                        Id
                                        + "&RecordDescription=" + RecordDescription
                                        + "&EntityId=0&EntityType=0",
                                        'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;
                    case 'BIReporting':

                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        args.set_cancel(true);

                    case 'Print':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            window.open("ReportsPreviewPopup.aspx?ObjectType=ADJUSTMENT_GROUPS&Id=" +
                                        Id
                                        + "&RecordDescription=" + RecordDescription
                                        + "&EntityId=0&EntityType=0",
                                        'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        } else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                            args.set_cancel(true);
                        }
                        break;

                    case 'New':
                        window.location = "AdjustmentGroups.aspx";
                        break;
                    default:

                        break;
                }
            }

            function onNodeDropping(sender, args) {
                if (droppedOnGrid(args)) return;
            }
        </script>
    </telerik:RadCodeBlock>
    <style>
        .Default.reWrapper, .Default.RadEditor .reContentCell, .Default.reColorPicker, .Default.reInsertTable, .Default.reCustomLinks a:hover {
            border: 1px solid #828282;
            width: 100% !important;
        }

        .btnTreeDropItems {
            display: inline-block !important;
        }
        @media screen and (min-width:1643px) {
            .PMMainPage > .row > .col-8 {
                width: 954px;
            }
        }

        @media screen and (min-width:1515px) {
          .rail .PMMainPage > .row > .col-8 {
                width: 954px;
            }
        }

        @media screen and (min-width:320px) and (max-width:843px) {
            .AdjustmentGroupsTopOnMobile {
                margin-top: 105px !important;
            }
        }

        .dash + ul.rtUL li.rtLI {
            list-style: decimal;
            margin-left: 35px;
        }

            .dash + ul.rtUL li.rtLI > div {
                padding-left: 0 !important;
            }
    </style>


    <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0" class="ToolBar SmallToolbar">
        <tr>
            <td class="ToolbarTd">
                <asp:HyperLink runat="server" ID="btnSearchDocument" CssClass="lnkPage" NavigateUrl="SearchDocument.aspx?O=153">
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
            <td style="width: 240px;" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                <telerik:RadComboBox ID="ddlAdjustmentGroups" meta:Resourcekey="ddlAdjustmentGroups" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                    Skin="Default" CloseDropDownOnBlur="true" AllowCustomText="true" EmptyMessage="Select Adjustment Group"
                    Width="240px" AutoPostBack="True" NoWrap="true" CausesValidation="False"
                    Height="400px" EnableLoadOnDemand="true" ShowMoreResultsBox="True"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" CheckForDirt="True" DropDownCssClass="ToolbarDropdown">
                </telerik:RadComboBox>
            </td>
            <td style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True">
                    <Items>
                        <%--<telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                                        Value="Search" NavigateUrl="SearchDocument.aspx?O=153" CausesValidation="false">
                                    </telerik:RadToolBarButton>--%>
                        <%--<telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                        CommandName="New" AccessKey="n" ToolTip="New (Alt+n)" CausesValidation="false">
                                    </telerik:RadToolBarButton>--%>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" AccessKey="s" ToolTip="Save (Alt+s)" ValidationGroup="Save">
                        </telerik:RadToolBarButton>
                    

                        <telerik:RadToolBarButton  SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"  CausesValidation="False" CommandName="New" 
                                                 EnableDefaultButton="false" PostBack="true" ToolTip="New (Alt+n)">
                                               
                         </telerik:RadToolBarButton>
                        
                        
                           <%-- <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="true">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="true" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="New">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>--%>
                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" CausesValidation="false" AccessKey="d" ToolTip="Delete (Alt+d)"
                            Value="Delete">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                            EnableDefaultButton="false" PostBack="false" CssClass="ToolbarPrint" OuterCssClass="HideOnMobileToolbar">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>
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
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('ADJUSTMENT_GROUPS');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Help" Value="Help" onclick="helpClick();" CssClass="Help"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Active" Value="Active" CssClass="ActiveLocation"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="InActive" Value="InActive" CssClass="InactiveLocation"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                        <%--  <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Office-icon.png" CommandName="WordMerge" SecurityButtonType="Read"
                                        EnableDefaultButton="false" PostBack="false" >
                                        <Buttons>
                                              <telerik:RadToolBarButton PostBack="false"  CommandName="ViewTemplates">
                                            </telerik:RadToolBarButton>
                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>--%>
                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/Active.png" OuterCssClass="HideOnMobileToolbar"
                            Value="Activate" CommandName="Activation" ToolTip="Activate">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton ImageUrl="Images/Toolbar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_CostControl.htm#Contracts"></telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>


    <%--       <tr>
            <td>
                <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" LoadingPanelID="ldpPM">
                    <fieldset style="margin-top: 5px">
                        <table style="width: 1050px !important;" cellspacing="0"
                            class="Padding7">
                            <tr valign="top">
                                <td valign="top" style="width: 550px">

                                    <table style="width: 100%;" cellspacing="0" cellpadding="2">
                                    </table>

                                </td>



                            </tr>
                        </table>
                    </fieldset>
                </telerik:RadAjaxPanel>
            </td>

        </tr>--%>
    <%--        <tr>
            <td>
                <telerik:RadSplitter ID="RadSplitter1" runat="server" Skin="Default" Width="100%"
                    Height="440px" SplitBarsSize="">
                    <telerik:RadPane ID="rpnAdjustmentTree" runat="server" Width="280px" CssClass="NormalWhiteBack"
                        EnableEmbeddedBaseStylesheet="False" Index="0" Skin="">
                    </telerik:RadPane>

                    <telerik:RadSplitBar ID="Splitter" runat="server" EnableEmbeddedBaseStylesheet="False"
                        Index="1" Skin="" />

                </telerik:RadSplitter>


            </td>
        </tr>--%>

    <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" Width="100%" LoadingPanelID="ldpPM">
        <div class="PMMainPage documentSinglePage">
            <div class="row">
                <div class="col-4 col-4-left">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblId" runat="server" Text="ID*" meta:Resourcekey="lblId"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtCode" runat="server" MaxLength="30"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvCode" runat="server" ValidationGroup="Save" ControlToValidate="txtCode"
                                    CssClass="Validator" Display="Dynamic" ErrorMessage="<%$ Resources:CostManagement, WarningMsg_RequiredID %>"
                                    ForeColor=""></asp:RequiredFieldValidator>
                                <asp:Label ID="lblIDUnique" meta:Resourcekey="lblIDUnique" runat="server" Text="ID must be unique."
                                    Visible="False" Class="Validator"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDescription" runat="server" Text="<%$ Resources:CostManagement, Label_Description %>"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtDescription" runat="server" MaxLength="255"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCompany" runat="server" Text="<%$ Resources:CostManagement, Label_Company %>"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlCompanies" meta:Resourcekey="ddlCompanies" runat="server"
                                    Skin="Default" NoWrap="true" Height="300px"
                                    EnableLoadOnDemand="true" ShowMoreResultsBox="True"
                                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblAdjustmentGroupType" meta:Resourcekey="lblAdjustmentGroupType" runat="server" Text="Adjustment Group Type"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlAdjustmentGroupType" runat="server" Skin="Default" AllowCustomText="True"></telerik:RadComboBox>
                            </td>
                        </tr>
                        <%-- <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblInactive" meta:resourcekey="lblInactive" runat="server" Height="16px" Text="Inactive"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:CheckBox ID="chkInactive" class="mobile-switch" runat="server" Text="" />
                                        </td>
                                    </tr>--%>
                    </table>
                </div>
                <div class="col-4 col-4-right">
                    <asp:Label ID="lblNotes" meta:resourcekey="lblNotes" runat="server" Height="16px" Text="Notes" Style="padding-bottom: 10px; color: #666666; width: inherit !important"></asp:Label>
                    <telerik:RadEditor ToolsFile="~/ToolsFile.xml" Height="100%" DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css"
                        ID="edtNotes" Skin="Default" runat="server" Style="box-sizing: border-box;" DialogsScriptFile="~/JS/RadEditorDialog.js" 
                        OnClientLoad="OnClientLoad">
                        <Content>
                        </Content>
                        <ImageManager MaxUploadFileSize="204000000" ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                        <MediaManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                        <FlashManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared" SearchPatterns="*.*" />
                        <TemplateManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared"
                            SearchPatterns="*.*" />
                        <DocumentManager ViewPaths="~/Images/Shared" UploadPaths="~/Images/Shared" DeletePaths="~/Images/Shared"
                            SearchPatterns="*.*" />
                    </telerik:RadEditor>
                </div>
            </div>
            <div class="row row-8-4">
                <div class="col-4">
                    <fieldset style="margin-top: -12px">
                        <legend>
                            <asp:Label ID="lblAdjustments" CssClass="legend" meta:resourcekey="lblAdjustments" runat="server" Text="ADJUSTMENTS"></asp:Label>
                        </legend>
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblGroupBy" meta:Resourcekey="lblGroupBy" runat="server" Text="Group By"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlGroups" runat="server" AutoPostBack="true" Width="40px">
                                        <Items>
                                            <telerik:RadComboBoxItem meta:Resourcekey="ListItemNone" Value="0" Text="None" />
                                            <telerik:RadComboBoxItem meta:Resourcekey="ListItemColumn" Value="1" Text="Column" Selected="True" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="padding-top:11px;">
                                    <telerik:RadTreeView ID="rtvAdjustments" runat="server" EnableDragAndDrop="True" CheckBoxes="true" TriStateCheckBoxes="true"
                                        OnClientNodeDropping="onNodeDropping" EnableDragAndDropBetweenNodes="false" OnClientNodeChecked="ShowHidebtnTreeDropItems"
                                        OnClientNodeDragging="onNodeDragging" Style="height: auto; max-height: 360px; overflow: auto;"
                                        Skin="Default" MultipleSelect="True">
                                        <ExpandAnimation Duration="100"></ExpandAnimation>
                                        <CollapseAnimation Duration="100" Type="OutQuint" />
                                    </telerik:RadTreeView>
                                    <asp:LinkButton runat="server" ID="btnTreeDropItems" CssClass="Hide">
                                        <div class="btnTreeDropItems">&nbsp;</div>
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </div>
                <div class="col-8">
                    <telerik:RadGrid ID="rdgAdjustments" runat="server" SetWidth="true"
                        Width="100%" AutoGenerateColumns="False" ShowStatusBar="True" AllowMultiRowSelection="True"
                        GridLines="None">
                        <ClientSettings>
                            <Selecting AllowRowSelect="True" />
                        </ClientSettings>
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" CommandItemDisplay="Top">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Column" SortExpression="AdjustmentColumn" GroupByExpression="AdjustmentColumn [GridColumn_AdjustmentColumn] Group By AdjustmentColumn ASC" UniqueName="AdjustmentColumn">
                                    <ItemTemplate>
                                        <span><%#IIf(CStr(Eval("AdjustmentColumn")) = String.Empty, "&nbsp;", Eval("AdjustmentColumn"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="120px" />
                                </telerik:GridTemplateColumn>


                                <telerik:GridTemplateColumn HeaderText="ID*" SortExpression="Code" Groupable="false" UniqueName="Code">
                                    <ItemTemplate>
                                        <span><%#IIf(CStr(Eval("Code")) = String.Empty, "&nbsp;", Eval("Code"))%></span>
                                    </ItemTemplate>

                                    <HeaderStyle Width="80px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Description" SortExpression="Description" UniqueName="Description"
                                    GroupByExpression="Description [GridColumn_Description] Group By Description ASC">
                                    <ItemTemplate>
                                        <span>
                                            <span><%#IIf(CStr(Eval("Description")) = String.Empty, "&nbsp;", Eval("Description"))%></span>
                                    </ItemTemplate>

                                    <HeaderStyle Width="120px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Company" SortExpression="Company" UniqueName="Company"
                                    GroupByExpression="Company [GridColumn_Company] Group By Company ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("CompanyId") = -1 Or Container.DataItem("CompanyId") = 0, "&nbsp;", Container.DataItem("Company"))%></span>
                                    </ItemTemplate>

                                    <HeaderStyle Width="150px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Rate %" GroupByExpression="Percentage [GridColumn_Percentage] Group By Percentage ASC" UniqueName="Percentage"
                                    SortExpression="Percentage">
                                    <ItemTemplate>
                                        <span><%#IIf(CStr(Eval("Percentage")) = "0", "&nbsp;", FormatPercent(Container.DataItem("Percentage")))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="72px" HorizontalAlign="Center"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Cost Type" SortExpression="CostTypes" GroupByExpression="CostTypes [GridColumn_CostTypes] Group By CostTypes ASC" UniqueName="CostTypes">
                                    <ItemTemplate>
                                        <span><%#IIf(CStr(Eval("CostTypes")) = String.Empty, "&nbsp;", Eval("CostTypes"))%></span>
                                    </ItemTemplate>

                                    <HeaderStyle Width="120px" />
                                </telerik:GridTemplateColumn>


                                <telerik:GridTemplateColumn HeaderText="Inactive" GroupByExpression="Inactive [GridColumn_Inactive] Group By Inactive ASC" UniqueName="Inactive">
                                    <ItemTemplate>
                                        <img src='Images/Global/<%# CStr(IIf(Eval("Inactive"), "checked.png", "unchecked.png")) %>' />
                                    </ItemTemplate>
                                    <HeaderStyle Width="90px" HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <FooterStyle HorizontalAlign="Right"></FooterStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" UniqueName="Notes"
                                    GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC" meta:resourcekey="GridTemplateColumnResource15">
                                    <ItemTemplate>
                                        <span>
                                            <%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="200px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                            </Columns>
                            <CommandItemTemplate>
                                <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="False" CommandName="DeleteRows" CssClass="GridCmdDeleteRows"
                                    OnClientClick="return ConfirmDelete()" Visible="<%#rdgAdjustments.EditIndexes.Count = 0 And (Not rdgAdjustments.MasterTableView.IsItemInserted) %>">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                                </asp:LinkButton>
                            </CommandItemTemplate>
                        </MasterTableView>
                        <HeaderStyle Font-Size="8pt" />
                    </telerik:RadGrid>
                </div>
            </div>
        </div>
    </telerik:RadAjaxPanel>
</asp:Content>
