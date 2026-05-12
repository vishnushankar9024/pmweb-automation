<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="WorkflowRules.ascx.vb"
    Inherits="Website.WorkflowRules" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />--%>
<telerik:RadCodeBlock ID="CodeBlock" runat="server">

    <script language="javascript" type="text/javascript" src="JS/workflow/Rules.js"></script>
    <style type="text/css">
        .removeLeft {
            left: 0 !important;
        }

        div#ctl00_CPH1_ucRules_rtvRecordTypeRules {
            color: #ffffff !important;
            background-color: #666666 !important;
        }

        .AssetExplorerTree {
            padding-left: 10px !important;
            padding-top: 20px !important;
        }

        .AssetSplitterPane  {
            height: calc(100vh - 128px) !important;
            color: #ffffff !important;
            background-color: #666666 !important;
            margin-top: 66px !important;
        }
        .AssetSplitterRightPane.WorkflowSinglePage, .AssetSplitter{
            height: calc(100vh - 128px) !important;
        }

        @media screen and (max-width: 880px) and (min-width: 844px) {
            .AssetSplitterPane {
                margin-top: 29px !important;
            }
        }

        @media screen and (max-width: 843px) and (min-width: 320px) {
            .AssetSplitterPane {
                height: calc(100vh - 103px) !important;
                margin-top: 0px;
            }

            .AssetSplitterRightPane.WorkflowSinglePage {
                margin-top: 111px !important;
                height:calc(100vh - 150px) !important;
            }

            .AssetSplitterRightPane {
                height: calc(100vh - 149px) !important;
                width: calc(100vw - 3px) !important;
            }

            .AssetSplitter{
                margin-top:66px !important;
                height:calc(100vh - 102px) !important
            }

            .ReportManagerTree; {
                height: calc(100vh) !important;
                bottom: 36px !important;
            }

            .AssetExplorerTree {
                padding-left: 10px !important;
                margin-top: 0px !important;
            }

            .MobileAssetExplorerBar {
                bottom: 36px !important;
            }
        }

        @media screen and (min-width:1094px) {
            .col-4-8 {
                width: calc(100% - 448px) !important;
                min-width: 400px !important;
            }
        }

        @media screen and (min-width:320px) and (max-width:1093px) {
            .col-4-8 {
                width: 100% !important;
                padding-left: 0px !important;
                margin-top: 20px !important;
            }
        }

        @media screen and (min-width:1385px) {
            .col-6-Exp {
                width: calc(100% - 424px) !important;
                min-width: 400px !important;
            }
        }

        @media screen and (min-width:320px) and (max-width:1384px) {
            .col-6-Exp {
                width: 100% !important;
                min-width: 400px !important;
                padding-left: 0px !important;
            }

            .col-4-Fields {
                padding-left: 0px !important;
            }
        }

        .RadTreeViewFields .rtIn {
            margin-left: 0px !important;
        }

        .RadTreeViewFields .trvFolder .rtSp {
            background-image: none !important;
        }
    </style>
</telerik:RadCodeBlock>

<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgRuleConditions">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgRuleConditions" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="lblMessage" />
            </UpdatedControls>
        </telerik:AjaxSetting>

        <telerik:AjaxSetting AjaxControlID="rtvFields">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rtvFields" />
                <telerik:AjaxUpdatedControl ControlID="rdgRuleConditions" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default" />

<telerik:RadSplitter ID="RadSplitter1" runat="server" Skin="Default" Width="100%" CssClass="AssetExplorerVerticalSplitter" SplitBarsSize="" OnClientLoad="onResized">
    <telerik:RadPane ID="treeGroupsAndItemsPane" runat="server" CssClass="AssetSplitterPane" Width="30%" EnableEmbeddedBaseStylesheet="False" Index="0" Skin=""
        OnClientCollapsed="OnClientCollapsed" OnClientExpanded="OnClientExpanded" OnClientResized="AssetSplitterResized">
        <telerik:RadTreeView ID="rtvRecordTypeRules" runat="server" EnableDragAndDrop="True" OnClientNodeClicking="Validate_OnNodeClick"
            OnClientContextMenuItemClicking="onClientContextMenuItemClicking" OnClientContextMenuShowing="onContextMenuShowing"
            Skin="Default" CausesValidation="False" BorderWidth="0" CssClass="WhitePlusMinus AssetExplorerTree">
            <ContextMenus>
                <telerik:RadTreeViewContextMenu ID="MainContextMenu" runat="server" Skin="Default" CssClass="trvContextMenu">
                    <Items>
                        <telerik:RadMenuItem Value="AddAPMRule" meta:Resourcekey="MenuItem_AddAPMRule" Text="Add APM Rule" EnableImageSprite="true" CssClass="MenuAdd"></telerik:RadMenuItem>
                        <telerik:RadMenuItem Value="DuplicateAPMRule" meta:Resourcekey="MenuItem_DuplicateAPMRule" Text="Duplicate APM Rule" EnableImageSprite="true" CssClass="MenuCopy"></telerik:RadMenuItem>
                        <telerik:RadMenuItem Value="EditRule" meta:Resourcekey="MenuItem_EditRule" Text="Edit Rule" EnableImageSprite="true" CssClass="MenuEdit"></telerik:RadMenuItem>
                        <telerik:RadMenuItem Value="DeleteRule" meta:Resourcekey="MenuItem_DeleteRule" Text="Delete Rule" EnableImageSprite="true" CssClass="MenuDelete"></telerik:RadMenuItem>
                    </Items>
                </telerik:RadTreeViewContextMenu>
            </ContextMenus>
        </telerik:RadTreeView>
    </telerik:RadPane>
    <telerik:RadSplitBar ID="Splitter" runat="server" Index="1" Skin="Default" meta:resourcekey="Splitter" CssClass="AssetSplitter" CollapseMode="Forward" />
    <telerik:RadPane ID="RadContentPane" runat="server" Width="70%" Index="2" Skin="Default" CssClass="AssetSplitterRightPane WorkflowSinglePage" OnClientResized="ClientResized" Style="margin-top: 68px;">
        <table style="width: 100%; background-color: RGB(237,237,237) !important;" border="0" cellpadding="0" cellspacing="0" class="ToolBarWorkflowRoles SmallToolbar">
            <tr>
                <td style="width: 240px !important;" class="ToolbarTd showOnIpad">
                    <telerik:RadComboBox ID="ddlAPMRules" runat="server" AllowCustomText="true" Skin="Default"
                        Height="400px" OnClientTextChange="LOD_DropDownTextChange" EmptyMessage="Select APM Rule..." OnItemsRequested="ddl_ItemsRequested"
                        Width="240px" AutoPostBack="True" NoWrap="true" CausesValidation="False" meta:Resourcekey="ddlAPMRules"
                        ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True" CheckForDirt="True">
                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                    </telerik:RadComboBox>
                </td>
                <td style="vertical-align: middle; width: 70%" class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicking="click_confirm">
                        <Items>
                            <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Edit" EnableImageSprite="true"
                                CssClass="ToolbarSave" CausesValidation="true" CommandName="Save" AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Add" EnableImageSprite="true"
                                CssClass="ToolbarNew" CommandName="New" AccessKey="n" ToolTip="New (Alt+n)" CausesValidation="false">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Delete" EnableImageSprite="true"
                                CssClass="ToolbarDelete" CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete" CausesValidation="false">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
                <td style="width: 10%"></td>
            </tr>
        </table>

        <div class="PMMainPage marginBottomOnMobile ">
            <div class="row " style="margin-right: unset; margin-bottom: 0;">
                <div class="col-4 col-4-left">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblRecordType" runat="server" Text="Record Type" meta:Resourcekey="lblRecordType"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlRecordType" AutoPostBack="true" AllowCustomText="true" Filter="Contains" runat="server"
                                    Skin="Default" Height="200px">
                                </telerik:RadComboBox>
                                <asp:Label ID="lblErrorRecordType" Visible="False" CssClass="Validator" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblRuleID" runat="server" Text="Rule ID*" meta:Resourcekey="lblRuleID"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtRuleID" MaxLength="100" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="rfvRuleID" CssClass="Validator" ValidationGroup="Save" ControlToValidate="txtRuleID"
                                    Display="Dynamic" meta:resourcekey="rfvRuleID">
                                </asp:RequiredFieldValidator>
                                <asp:Label ID="lblError" CssClass="Validator" runat="server" Visible="False"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblRuleName" runat="server" Text="Rule Name" meta:Resourcekey="lblRuleName"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtRuleName" MaxLength="500" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-4 col-4-right ">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblBPMTemplate" runat="server" Text="Use This BPM Template" meta:Resourcekey="lblBPMTemplate"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlBPMTemplate" AllowCustomText="false" Filter="Contains" Height="200px" runat="server" Skin="Default"></telerik:RadComboBox>
                                <asp:CompareValidator ID="rfvBPMTemplates" ControlToValidate="ddlBPMTemplate" runat="server" ValueToCompare="0" CssClass="Validator"
                                    ForeColor="" Operator="GreaterThan" meta:resourcekey="rfvBPMTemplates" ValidationGroup="Save" Display="Dynamic">
                                </asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCurrency" runat="server" Text="Currency" meta:resourcekey="lblCurrency"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlCurrencies" AllowCustomText="false" Filter="Contains" Height="200px" runat="server" Skin="Default" Width="100%"></telerik:RadComboBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row" style="margin-right: unset;">
                <div class="col-4 col-4-left">
                    <table class="colTable">
                        <tr>
                            <td>
                                <fieldset>
                                    <legend>
                                        <asp:Label ID="lblFields" runat="server" meta:resourcekey="lblFields" CssClass="legend" Text="Fields"></asp:Label>
                                    </legend>

                                </fieldset>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 13px; max-width: 400px; width: 100% !important; background-color: #EDEDED; border: 1px solid #999999; border-bottom: none;">
                                <table cellpadding="0" cellspacing="0" style="width: 100%" border="0">
                                    <tr>
                                        <td>
                                            <telerik:RadTextBox runat="server" ID="txtUser" AutoPostBack="true" meta:resourcekey="txtUsers" Width="100%"></telerik:RadTextBox>
                                        </td>
                                        <td style="width: 30px; padding-left: 10px;">
                                            <asp:LinkButton runat="server" ID="imgbtnfilterUsers" CssClass="LoopButton" Width="30px">
                                                                        <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="max-width: 400px; border: 1px solid #999999">
                                <div style="overflow: auto; height: 286px;">
                                    <telerik:RadTreeView ID="rtvFields" runat="server" OnClientNodeDropping="onNodeDropping" Skin="Default" CausesValidation="False"
                                        CheckBoxes="true" TriStateCheckBoxes="true" CssClass="RadTreeViewFields" OnClientNodeChecked="ShowHidebtnTreeDropItems">
                                    </telerik:RadTreeView>
                                    <asp:LinkButton runat="server" ID="btnTreeDropItems">
                                        <div class="btnTreeDropItems">&nbsp;</div>
                                    </asp:LinkButton>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-6 col-4-middle col-6-Exp" id="dvExpression">
                    <fieldset>
                        <legend>
                            <asp:Label ID="lblExpression" runat="server" CssClass="legend" meta:resourcekey="lblExpression" Text="Expression"></asp:Label>
                        </legend>
                        <table class="colTable">
                            <tr>
                                <td>
                                    <asp:Label ID="lblMessage" runat="server" meta:resourcekey="lblMessage" CssClass="Validator"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadGrid ID="rdgRuleConditions" UseEditFormInMobile="true" runat="server" AutoGenerateColumns="False" SetWidth="true" FitParentContainer="true" Width="100%"
                                        ShowStatusBar="True" Font-Size="8px" PageSize="10" ShowFooter="false" AllowPaging="True" ShowGroupPanel="False"
                                        AllowMultiRowEdit="True" AllowMultiRowSelection="True" AllowSorting="True" GridLines="None">
                                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" ShowPagerText="false"></PagerStyle>
                                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                            DataKeyNames="Id" CommandItemDisplay="Top" TableLayout="Fixed" EditMode="InPlace">
                                            <Columns>
                                                <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" HeaderStyle-Wrap="false" SortExpression="LineNumber"
                                                    Groupable="false" Reorderable="false" AllowFiltering="false">
                                                    <ItemTemplate>
                                                        <span><%#Container.DataItem("LineNumber").ToString%></span>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <%#Eval("LineNumber").ToString%>
                                                    </EditItemTemplate>
                                                    <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="()" UniqueName="LeftBrackets">
                                                    <ItemTemplate>
                                                        <%# Eval("LeftBrackets")%>&nbsp;
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="txtLeftBrackets" runat="server" Text='<%# Eval("LeftBrackets") %>' Width="100%"></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <HeaderStyle Width="100px" />
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="And/Or" UniqueName="LogicalOperators">
                                                    <ItemTemplate>
                                                        <asp:Label runat="server" ID="lblLogicalOperators" Text=' <%# Eval("LogicalOperators") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <telerik:RadComboBox ID="ddlAndOr" runat="server">
                                                            <Items>
                                                            <telerik:RadComboBoxItem Text="" Value=""></telerik:RadComboBoxItem>
                                                            <telerik:RadComboBoxItem Text="And" Value="AND" Selected="True" meta:resourcekey="ListItem_AND"></telerik:RadComboBoxItem>
                                                            <telerik:RadComboBoxItem Text="Or" Value="OR" Selected="False" meta:resourcekey="ListItem_OR"></telerik:RadComboBoxItem>
                                                             </Items>
                                                        </telerik:RadComboBox>
                                                    </EditItemTemplate>
                                                    <HeaderStyle Width="80px" />
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="()" UniqueName="RightBrackets">
                                                    <ItemTemplate>
                                                        <%# Eval("RightBrackets")%>&nbsp;
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="txtRightBrackets" runat="server" Text='<%# Eval("RightBrackets") %>' Width="100%"></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <HeaderStyle Width="100px" />
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Field" UniqueName="FieldDescription">
                                                    <ItemTemplate>
                                                        <%# Eval("FieldDescription")%>&nbsp;
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <%# Eval("FieldDescription")%>
                                                    </EditItemTemplate>
                                                    <HeaderStyle Width="150px" />
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Operator" UniqueName="OperatorName">
                                                    <ItemTemplate>
                                                        <%# Eval("OperatorName")%>&nbsp;
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <telerik:RadCombobox ID="ddlOperators" Width="100%" runat="server" />
                                                    </EditItemTemplate>
                                                    <HeaderStyle Width="150px" />
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Value" UniqueName="Value">
                                                    <ItemTemplate>
                                                        <asp:Image runat="server" ID="imgCheck" />
                                                        <asp:Label runat="server" ID="lblValue"></asp:Label>&nbsp;
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="txtValueString" Width="100%" runat="server" Visible="false"></asp:TextBox>
                                                        <asp:TextBox ID="txtValueNumber" Width="100px" runat="server" Visible="false"></asp:TextBox>
                                                        <asp:RequiredFieldValidator runat="server" ID="rfvValueNumber" CssClass="Validator" ValidationGroup="SaveConditions"
                                                            ControlToValidate="txtValueNumber" Display="Dynamic" meta:resourcekey="InvalidValue">
                                                        </asp:RequiredFieldValidator>
                                                        <asp:TextBox ID="txtValueInteger" Width="100px" CssClass="Integer" runat="server" Visible="false"></asp:TextBox>
                                                        <asp:RequiredFieldValidator runat="server" ID="rfvValueInteger" CssClass="Validator" ValidationGroup="SaveConditions"
                                                            ControlToValidate="txtValueInteger" Display="Dynamic" meta:resourcekey="InvalidValue">
                                                        </asp:RequiredFieldValidator>
                                                        <telerik:RadNumericTextBox ID="rntValueYear" ShowSpinButtons="true" IncrementSettings-InterceptArrowKeys="true"
                                                            IncrementSettings-InterceptMouseWheel="true" Label="" runat="server" Width="70px" Visible="false"
                                                            EmptyMessage="<%$Resources:PMWeb, ListItem_NONE %>" MaxValue="2100" MinValue="1899">
                                                            <NumberFormat DecimalDigits="0" GroupSeparator="" />
                                                        </telerik:RadNumericTextBox>
                                                        <asp:RequiredFieldValidator runat="server" ID="rfvValueYear" CssClass="Validator"
                                                            ValidationGroup="SaveConditions" ControlToValidate="rntValueYear" Display="Dynamic"
                                                            meta:resourcekey="InvalidValue">
                                                        </asp:RequiredFieldValidator>
                                                        <telerik:RadDatePicker ID="txtValueDate" Height="25px" runat="server" Visible="false"
                                                            MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>' Width="110px" Skin="Default">
                                                            <Calendar Skin="Default" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False" ViewSelectorText="x"></Calendar>
                                                            <DateInput LabelCssClass="radLabelCss_Office2007" Skin="Default" CausesValidation="True" Height="13px" ValidationGroup="SaveConditions"></DateInput>
                                                            <DatePopupButton CssClass="" HoverImageUrl="" ImageUrl="" />
                                                        </telerik:RadDatePicker>
                                                        <asp:RequiredFieldValidator runat="server" ID="rfvValueDate" CssClass="Validator" ValidationGroup="SaveConditions"
                                                            ControlToValidate="txtValueDate" Display="Dynamic" meta:resourcekey="InvalidValue">
                                                        </asp:RequiredFieldValidator>
                                                        <telerik:RadTimePicker ID="txtValueTime" runat="server" Skin="Default" Width="94px" SelectedDate="7:00 AM"></telerik:RadTimePicker>
                                                        <asp:RequiredFieldValidator runat="server" ID="rfvValueTime" CssClass="Validator" ValidationGroup="SaveConditions"
                                                            ControlToValidate="txtValueTime" Display="Dynamic" meta:resourcekey="InvalidValue">
                                                        </asp:RequiredFieldValidator>
                                                        <asp:CheckBox ID="chkValueBoolean" Checked="true" runat="server" class="mobile-switch" Visible="false"></asp:CheckBox>
                                                    </EditItemTemplate>
                                                    <HeaderStyle Width="200px" />
                                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="()" UniqueName="Brackets">
                                                    <ItemTemplate>
                                                        <%# Eval("Brackets")%>&nbsp;
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="txtBrackets" runat="server" Text='<%# Eval("Brackets")%>' Width="100%"></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <HeaderStyle Width="100px" />
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                            <CommandItemTemplate>
                                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CssClass="GridCmdEditRows"
                                                    CommandName="EditRows" Visible='<%# rdgRuleConditions.EditIndexes.Count = 0 And (Not rdgRuleConditions.MasterTableView.IsItemInserted) And (PM.Workflow.RuleInfo.Id > 0) %>'
                                                    SecurityButtonType="ItemMode_Edit">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="SaveConditions" CssClass="GridCmdUpdateEdited"
                                                    CommandName="UpdateEdited" Visible='<%# rdgRuleConditions.EditIndexes.Count > 0 %>'
                                                    SecurityButtonType="AddEditMode_Edit" CausesValidation="true">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="False" CommandName="DeleteRows" CssClass="GridCmdDeleteRows"
                                                    SecurityButtonType="ItemMode_Edit" OnClientClick="return ConfirmDelete()" Visible='<%# rdgRuleConditions.EditIndexes.Count = 0 And (Not rdgRuleConditions.MasterTableView.IsItemInserted) And (PM.Workflow.RuleInfo.Id > 0) %>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnCancel" SecurityButtonType="AddEditMode" runat="server" CausesValidation="False" CssClass="GridCmdCancelAll"
                                                    CommandName="CancelAll" Visible="<%# rdgRuleConditions.EditIndexes.Count > 0 %>">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblCancel" runat="server"></asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid"
                                                    CommandName="RebindGrid" Visible='<%# rdgRuleConditions.EditIndexes.Count = 0 And (Not rdgRuleConditions.MasterTableView.IsItemInserted) And (PM.Workflow.RuleInfo.Id > 0) %>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblRefresh" runat="server"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                            </CommandItemTemplate>
                                        </MasterTableView>
                                        <ClientSettings AllowColumnHide="false" AllowColumnsReorder="false" AllowDragToGroup="false" AllowRowsDragDrop="true">
                                            <Selecting AllowRowSelect="true" EnableDragToSelectRows="true" />
                                            <ClientEvents OnRowDblClick="RowDblClick" OnGridCreated="GridCreated"></ClientEvents>
                                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true" AllowColumnResize="True" />
                                        </ClientSettings>
                                        <ItemStyle Wrap="false" />
                                        <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </div>
            </div>
        </div>

    </telerik:RadPane>
</telerik:RadSplitter>

