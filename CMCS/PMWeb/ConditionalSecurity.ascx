<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ConditionalSecurity.ascx.vb" Inherits="Website.ConditionalSecurity" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadCodeBlock ID="CodeBlock" runat="server">
    <script language="javascript" type="text/javascript" src="JS/workflow/Rules.js"></script>
    <style type="text/css">
        table#RAD_SPLITTER_ctl00_CPH1_ConditionalSecurity1_RadSplitter1 {
            width: 100% !important;
             padding-top:27px;
        }

        .RadAjaxPanel {
            display: inline !important;
        }

        .AssetExplorerVerticalSplitter {
            padding-top: 89px;
        }

        .ToolBar {
            top: 150px;
        }
        .RadSplitter_Default .rspResizeBar{
            top: 147px;
        }

        @media screen and (min-width:320px) and (max-width:880px) {
            .ToolBar {
                top: 97px !important;
            }

            .BiReportingTree {
                height: calc(100vh - 119px) !important;
            }
        }

        @media screen and (min-width:767px) {
            .treeSplitter td.rspPane.rspFirstItem {
                display: block !important;
                visibility: visible !important;
            }
        }



        @media screen and (min-width:320px) and (max-width:880px) {

            td#ctl00_CPH1_ConditionalSecurity1_rpRecordTypeRules {
                position: absolute;
            }

            .RadTreeView.largeTree {
                max-height: 100% !important;
            }
        }

        div#RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_ConditionalSecurity1_rpRadContentPaneCS {
            width: 100% !important;
        }

        td#ctl00_CPH1_ConditionalSecurity1_rpRecordTypeRules {
            max-width: 290px !important;
            margin-left: -2px;
            margin-top: -1px;
            width: 290px !important;
        }

        @media screen and (max-width: 843px) and (min-width: 320px) {
            .RadTreeView {
                max-height: 100% !important;
            }
            .divContentHolder {
                margin-top: 60px !important;
            }
            .rspCollapseBarCollapse {
                margin-top: calc(50vh - 89px) !important;
            }

            .AssetExplorerVerticalSplitter {
                padding-top: 0px !important;
            }

            .PMMainPage {
                margin: 0 !important;
            }


            .HideOnTabletMobile {
                display: none;
            }

            .RequiredFieldsLeftSplitterPane {
                margin-top: 147px !important;
                position: fixed;
                width: 60vw !important;
                top: 0;
                height: calc(100vh - 125px) !important;
                z-index: 996;
                border: 1px solid #999;
                left: 0 !important;
            }

            .RequiredFieldsLayoutSplitter {
                position: fixed;
                left: calc(60vw);
                z-index: 3000;
                height: calc(100vh - 125px) !important;
                top: 89px;
            }

            .RequiredFieldsSplitterPane {
                height: calc(100vh - 126px) !important;
                width: calc(100vw - 3px) !important;
                margin-top:88px;
            }
        }

        * {
            box-sizing: border-box;
        }




        body, html, form {
            height: 100%;
            margin: 0px;
            padding: 0px;
        }

        .removeLeft {
            left: 0 !important;
        }

        #ctl00_CPH1_ConditionalSecurity1_RadSplitter1 {
            width: 100% !important;
        }

        @media screen and (min-width:844px) {

            .RequiredFieldsSplitterPane {
                height: calc(100vh - 180px) !important;
            }

            .RequiredFieldsLayoutSplitter {
                height: calc(100vh - 150px) !important;
            }

            .RequiredFieldsLeftSplitterPane {
                height: calc(100vh - 151px) !important;
            }

            .BiReportingTree {
                height: calc(100vh - 180px);
            }
        }

        .TemplateColumnLeft {
            width: 140px;
        }

        .RuleInfoHeaderElement {
            width: 450px;
        }

        .WidthLeft {
            width: 140px;
        }

        .TitleRules {
            font-size: x-large;
            font-style: italic;
        }

        #ctl00_ctl00_CPH1_ucRules_ddlTemplatesPanel {
            text-align: right;
        }

        /*rtTop .rtSp {
            background-image: url('CSS/Images/ResponsiveIcons/16White.png') !important;
            width: 16px !important;
            height: 22px !important;
            margin-left: -3px !important;
            margin-right: -14px !important;
            background-position: -1568px 0px !important;
            background-repeat: no-repeat !important;
            margin-top: 2px !important;
        }

        .rtBot .rtSp {
            background-image: url('CSS/Images/ResponsiveIcons/16White.png') !important;
            width: 16px !important;
            height: 22px !important;
            margin-left: -3px !important;
            margin-right: -14px !important;
            background-position: -1136px 0px !important;
            background-repeat: no-repeat !important;
            margin-top: 2px !important;
        }*/

        /*.rtLast .rtTop .rtSp, .rtBot:last-child .rtSp {
            display: none;
        }*/

        .trvDocument .rtSp, .NoChildren .rtSp {
            background-image: url(CSS/Images/ResponsiveIcons/16White.png) !important;
            width: 16px !important;
            height: 22px !important;
            margin-left: -3px !important;
            margin-right: -14px !important;
            background-position: -272px 0px !important;
            background-repeat: no-repeat !important;
            margin-top: 2px !important;
        }

        .trvFolder .rtSp, .trvPBSFolder .rtSp, .trvEngineering .rtSp, .trvCostManagement .rtSp, .trvScheduling .rtSp, .trvPBSFolder .rtSp, .trvAsset .rtSp, .trvPortfolioModule .rtSp, .trvPlanning .rtSp,
        .trvtoolbox .rtSp,
        .trvWorkflow .rtSp, .HasChildren .rtSp {
            background-image: url(CSS/Images/ResponsiveIcons/16White.png) !important;
            width: 16px;
            height: 22px;
            margin-left: -3px;
            margin-right: -14px;
            background-position: -1568px 0px;
            background-repeat: no-repeat;
            margin-top: 2px;
        }

        .rtUL .rtIn {
            margin-left: 16px;
        }

        .RadTreeView_Default .rtPlus, .RadTreeView_Default .rtMinus {
            background-image: url(CSS/Images/PlusMinusWhite.png) !important;
        }
    </style>
</telerik:RadCodeBlock>

<telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy134" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgRuleConditions">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgRuleConditions" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rdgGroups">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgGroups" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rtvRecordTypeRules">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="tblRuleInfo" LoadingPanelID="ldpPM"></telerik:AjaxUpdatedControl>
             <telerik:AjaxUpdatedControl ControlID="mainToolBar" LoadingPanelID="ldpPM"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>

        <telerik:AjaxSetting AjaxControlID="mainToolBar">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="tblRuleInfo" LoadingPanelID="ldpPM"></telerik:AjaxUpdatedControl>
            </UpdatedControls>
        </telerik:AjaxSetting>

    </AjaxSettings>

</telerik:RadAjaxManagerProxy>

<div class="ToolBar SecurityHomePageToolbar" style="width: 100%; height: 50px;">
    <table style="width: auto !important; table-layout: fixed; padding-left: 24px;" cellpadding="0" cellspacing="0">
        <tr>
            <td class="HideOnMobileToolbar" style="width: 160px">
                <asp:Label ID="lblTitle" meta:Resourcekey="lblTitle" runat="server" Text="Level"></asp:Label>
            </td>
            <td style="width: 240px;">
                <telerik:RadComboBox ID="ddlEntities" runat="server" Skin="Default" CloseDropDownOnBlur="true"
                    EmptyMessage="Select Entity..." Width="240px" AutoPostBack="True" AllowCustomText="true"
                    CausesValidation="False" Height="400px" NoWrap="true" OnClientTextChange="LOD_DropDownTextChange"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" meta:Resourcekey="ddlEntities"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td style="vertical-align: middle; padding-left: 24px;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True" OnClientButtonClicking="conditionaltoolbarclick">
                    <Items>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton Value="Edit" SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" ValidationGroup="Save" CausesValidation="true" AccessKey="s">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton Value="Add" SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                            CommandName="New" AccessKey="n" CausesValidation="false">
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" Value="Delete">
                        </telerik:RadToolBarButton>

                    </Items>




                </telerik:RadToolBar>
            </td>
        </tr>
    </table>

</div>
<div style="width: 100%" id="tblRuleInfo" runat="server">
    <telerik:RadSplitter ID="RadSplitter1" runat="server" Width="100%" Height="100%" Skin="Default" CssClass="AssetExplorerVerticalSplitter" SplitBarsSize="" OnClientLoad="onResized">
        <telerik:RadPane ID="treeGroupsAndItemsPane" runat="server" Width="30%" Index="0" Skin="" CssClass="RequiredFieldsLeftSplitterPane" EnableEmbeddedBaseStylesheet="False" OnClientCollapsed="OnClientCollapsed" OnClientExpanded="OnClientExpanded" OnClientResized="AssetSplitterResized">

            <telerik:RadTreeView ID="rtvRecordTypeRules" runat="server" EnableDragAndDrop="True" CssClass="BiReportingTree WhitePlusMinus" Style="overflow: auto; background-color: #666666; color: #ffffff; position: static;"
                CausesValidation="False" OnClientContextMenuItemClicking="onClientContextMenuItemClicking" OnClientContextMenuShowing="onContextMenuShowing" OnClientNodeClicking="RuleNodeClicking">
                <ContextMenus>
                    <telerik:RadTreeViewContextMenu ID="MainContextMenu" runat="server" Skin="Default" CssClass="trvContextMenu">
                        <Items>
                            <telerik:RadMenuItem Value="AddRule" meta:Resourcekey="MenuItem_AddRule" Text="Add Rule" EnableImageSprite="true" CssClass="MenuAdd">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem Value="EditRule" Text="Edit Rule" meta:Resourcekey="MenuItem_EditRule" EnableImageSprite="true" CssClass="MenuEdit">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem Value="DeleteRule" meta:Resourcekey="MenuItem_DeleteRule" Text="Delete Rule" EnableImageSprite="true" CssClass="MenuDelete">
                            </telerik:RadMenuItem>
                        </Items>
                    </telerik:RadTreeViewContextMenu>
                </ContextMenus>
            </telerik:RadTreeView>

        </telerik:RadPane>
        <telerik:RadSplitBar ID="Splitter" runat="server" Index="1" Skin="Default" meta:resourcekey="Splitter" CssClass="RequiredFieldsLayoutSplitter" CollapseMode="Forward" />
        <telerik:RadPane ID="RadContentPane" CssClass="RequiredFieldsSplitterPane" runat="server" Width="70%" Index="2" Skin="Default" OnClientResized="ClientResized">
            <div class="PMMainPage">
                <div class="row">
                    <div class="col-4">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <div id="spnRuleName" runat="server">
                                        <asp:Label ID="lblRuleName" runat="server" Text="Rule Name*" meta:resourcekey="lblRuleName"></asp:Label>
                                    </div>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtRuleName" MaxLength="50" runat="server" Width="100%"></asp:TextBox>
                                    <span id="divRuleNameError">
                                        <asp:RequiredFieldValidator ID="rfvRuleName" ControlToValidate="txtRuleName"
                                            runat="server" CssClass="Validator" Display="Dynamic"
                                            ValidationGroup="Save" ErrorMessage="<%$ Resources:Warning_Msg_Required%>"></asp:RequiredFieldValidator>
                                        <asp:Label ID="lblError" Text="Rule name must be unique by Record Type and Entity." meta:resourcekey="lblError" CssClass="Validator" runat="server" Visible="False"></asp:Label>
                                    </span>
                                    <%--<div id="divAddConditionError" class="Validator"></div>--%>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <div id="Div1" runat="server">
                                        <asp:Label ID="lblRecordType" runat="server" Text="Record Type*" meta:resourcekey="lblRecordType"></asp:Label>
                                    </div>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlRecordTypes" Height="400px" AllowCustomText="true" Filter="Contains" runat="server" Width="100%"
                                        Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage="Select"
                                        NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" CausesValidation="true"
                                        OnItemsRequested="ddl_ItemsRequested">
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="rfvrec" runat="server" ControlToValidate="ddlRecordTypes"
                                        CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:Warning_Msg_Required%>"
                                        Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    <asp:RequiredFieldValidator ID="rfvrec2" runat="server" ControlToValidate="ddlRecordTypes"
                                        CssClass="Validator" InitialValue="<%$ Resources:PMWeb, DASHSELECT%>" ErrorMessage="<%$ Resources:Warning_Msg_Required%>"
                                        Display="Dynamic" ForeColor="" ValidationGroup="Save"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="rfvrecs" runat="server" ControlToValidate="ddlRecordTypes" ValidateEmptyText="true"
                                        ClientValidationFunction="ValidateCombo" ValidationGroup="Save" Display="Dynamic"
                                        CssClass="Validator" ErrorMessage="<%$ Resources:Warning_Msg_Required%>">
                                    </asp:CustomValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblCurrency" runat="server" Text="Currency" meta:resourcekey="lblCurrency"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlCurrencies" runat="server" Skin="Default"
                                        Width="100%" Height="400px" EmptyMessage="Select Currency1 ..." meta:resourcekey="ddlCurrencies">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblEvaluationOrder" runat="server" Text="Evaluation Order1" meta:resourcekey="lblEvaluationOrder"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlEvaluationOrder" Width="100%" runat="server"></telerik:RadComboBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="row row-8-4">
                    <div class="col-8" style="padding-left: 0">
                        <fieldset>
                            <legend>
                                <asp:Label runat="server" ID="lblDefineCondition" meta:resourcekey="lblDefineCondition" Text="Define Conditional Statement"></asp:Label>
                            </legend>
                            <telerik:RadGrid ID="rdgRuleConditions" runat="server" AutoGenerateColumns="False" SetWidth="true" AppendMenus="true" FitParentContainer="true"
                                HeaderStyle-Font-Size="8" ShowStatusBar="True" HeaderStyle-HorizontalAlign="Center" AllowMultiRowEdit="True" AllowMultiRowSelection="True"
                                Width="100%" EditItemStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                                AlternatingItemStyle-HorizontalAlign="Center" GridLines="None" UseEditFormInMobile="true">
                                <AlternatingItemStyle HorizontalAlign="Center"></AlternatingItemStyle>
                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage"
                                    EditMode="InPlace">
                                    <RowIndicatorColumn>
                                        <HeaderStyle Width="20px"></HeaderStyle>
                                    </RowIndicatorColumn>
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
                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="()" UniqueName="LeftBrackets">
                                            <ItemTemplate>
                                                <%# Eval("LeftBrackets") %>&nbsp;
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtLeftBrackets" runat="server" Text='<%# Eval("LeftBrackets") %>' Width="100%"></asp:TextBox>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="50px" />
                                        </telerik:GridTemplateColumn>


                                        <telerik:GridTemplateColumn HeaderText="And/Or"
                                            UniqueName="And_Or" meta:resourcekey="GC_And_Or">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblLogicalOperators"></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox ID="ddlLogicalOperators" Width="100%" runat="server">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Value="AND" meta:resourcekey="ListItem_AND"></telerik:RadComboBoxItem>
                                                    <telerik:RadComboBoxItem Value="OR" meta:resourcekey="ListItem_OR"></telerik:RadComboBoxItem>
                                                    </Items>
                                                    
                                                </telerik:RadComboBox>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="80px"></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="()" UniqueName="RightBrackets">
                                            <ItemTemplate>
                                                <%# Eval("RightBrackets") %>&nbsp;
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtRightBrackets" runat="server" Text='<%# Eval("RightBrackets") %>' Width="100%"></asp:TextBox>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="50px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Field" meta:resourcekey="GC_Field" HeaderStyle-Width="170px" UniqueName="Field">
                                            <ItemTemplate>
                                                <span><%#Container.DataItem("FieldFriendlyName").ToString%></span>&nbsp;
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox ID="ddlFields" Width="100%" OnSelectedIndexChanged="ddlFields_SelectedIndexChanged" AutoPostBack="True" runat="server">
                                                </telerik:RadComboBox>
                                            </EditItemTemplate>
                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Operator" meta:resourcekey="GC_Operator" HeaderStyle-Width="130px" UniqueName="Operator">
                                            <ItemTemplate>
                                                <span><%#Container.DataItem("Operator").ToString%></span>&nbsp;
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox ID="ddlOperators" Width="100%" runat="server"></telerik:RadComboBox>
                                            </EditItemTemplate>
                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Dynamic Value11" HeaderStyle-Width="130px" UniqueName="DynamicValue">
                                            <ItemTemplate>
                                                <span><%#Container.DataItem("DynamicFieldName").ToString%></span>&nbsp;
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadComboBox ID="ddlDynamicValues" Width="100%" runat="server" AllowCustomText="true"></telerik:RadComboBox>
                                            </EditItemTemplate>
                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Value11" UniqueName="StaticValue" ItemStyle-CssClass="Top"
                                            HeaderStyle-Width="100px">
                                            <ItemTemplate>
                                                <asp:Image runat="server" ID="imgCheck" />
                                                <asp:Label runat="server" ID="lblValue"></asp:Label>&nbsp;
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtValueString" Width="100%" runat="server" MaxLength="200"></asp:TextBox>
                                                <asp:RequiredFieldValidator runat="server" ID="rfvValueString" CssClass="Validator"
                                                    ValidationGroup="SaveConditions" ControlToValidate="txtValueString" Display="Dynamic"
                                                    meta:resourcekey="InvalidValue"></asp:RequiredFieldValidator>
                                                <asp:TextBox ID="txtValueNumber" Width="100%" runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator runat="server" ID="rfvValueNumber" CssClass="Validator"
                                                    ValidationGroup="SaveConditions" ControlToValidate="txtValueNumber" Display="Dynamic"
                                                    meta:resourcekey="InvalidValue"></asp:RequiredFieldValidator>
                                                <telerik:RadDatePicker ID="txtValueDate" runat="server" MinDate="1901-01-01"
                                                    MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default">
                                                    <Calendar Skin="Default" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False"
                                                        ViewSelectorText="x">
                                                    </Calendar>
                                                    <DateInput LabelCssClass="radLabelCss_Office2007" Skin="Default" CausesValidation="True"
                                                        Height="13px" ValidationGroup="SaveConditions">
                                                    </DateInput>
                                                    <DatePopupButton CssClass="" HoverImageUrl="" ImageUrl="" />
                                                </telerik:RadDatePicker>
                                                <asp:RequiredFieldValidator runat="server" ID="rfvValueDate" CssClass="Validator"
                                                    ValidationGroup="SaveConditions" ControlToValidate="txtValueDate" Display="Dynamic"
                                                    meta:resourcekey="InvalidValue"></asp:RequiredFieldValidator>
                                                <asp:CheckBox ID="chkValueBoolean" Checked="true" runat="server" CssClass="mobile-switch"></asp:CheckBox>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="120px"></HeaderStyle>
                                            <%--          <ItemStyle CssClass="Top Left"></ItemStyle>--%>
                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="()" UniqueName="Brackets">
                                            <ItemTemplate>
                                                <%# Eval("Brackets")%>&nbsp;
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtBrackets" runat="server" Text='<%# Eval("Brackets") %>' Width="100%"></asp:TextBox>
                                            </EditItemTemplate>
                                            <HeaderStyle Width="50px" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <CommandItemTemplate>
                                        <div style="padding: 2px">

                                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                                SecurityButtonType="ItemMode_Edit">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="false" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                                SecurityButtonType="AddEditMode_Edit" ValidationGroup="SaveConditions">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnSave" runat="server" CausesValidation="true" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                                SecurityButtonType="AddEditMode_Add" ValidationGroup="SaveConditions">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblSave" runat="server"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                                SecurityButtonType="AddEditMode">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblCancel" runat="server"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                                SecurityButtonType="ItemMode_Add">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblAddLine" runat="server"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="return ConfirmDelete()"
                                                SecurityButtonType="ItemMode_Delete"
                                                runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                                SecurityButtonType="ItemMode">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                        </div>

                                    </CommandItemTemplate>
                                </MasterTableView>
                                <HeaderStyle HorizontalAlign="left" Font-Size="8pt"></HeaderStyle>
                                <ClientSettings>
                                    <ClientEvents OnRowDblClick="RowDblClick" OnGridCreated="rdgRuleConditionsCreated"></ClientEvents>
                                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                        AllowColumnResize="True" />
                                </ClientSettings>
                            </telerik:RadGrid>
                        </fieldset>
                    </div>
                </div>
                <div class="row row-8-4">
                    <div class="col-8" style="padding-left: 0">
                        <fieldset>
                            <legend>
                                <asp:Label runat="server" ID="lblDenyAccess" meta:resourcekey="lblDenyAccess" Text="DenyAccessTo1"></asp:Label>
                            </legend>
                            <telerik:RadGrid ID="rdgGroups" runat="server" SetWidth="true" AppendMenus="true" FitParentContainer="true"
                                AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8" Width="100%"
                                PageSize="250" AllowPaging="true" AllowMultiRowEdit="True" AllowMultiRowSelection="false"
                                AllowSorting="true">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    DataKeyNames="Id" CommandItemDisplay="none" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Center"
                                            HeaderStyle-Width="100px" UniqueName="Apply">
                                            <HeaderTemplate>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:Label runat="server" ID="lblApply" meta:resourcekey="lblApply" Text="Apply1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="chkApplyAll" AutoPostBack="true" runat="server" OnCheckedChanged="chkApplyAll_Changed" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkApply" AutoPostBack="true" OnCheckedChanged="chkApply_Changed" Checked='<%# CBool(IIf(Eval("ApplyRule") Is System.DBNull.Value, 0, Eval("ApplyRule")))%>' runat="server" />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Group" UniqueName="Group">
                                            <ItemTemplate>
                                                <%#IIf(Container.DataItem("Group") = String.Empty, "&nbsp;", Container.DataItem("Group"))%>
                                            </ItemTemplate>
                                            <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                            <HeaderStyle Wrap="false" Width="150px" HorizontalAlign="Center" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description">
                                            <ItemTemplate>
                                                <%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%>
                                            </ItemTemplate>
                                            <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                            <HeaderStyle Wrap="false" Width="150px" HorizontalAlign="Center" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderText="Guest" UniqueName="Guest">
                                            <ItemTemplate>
                                                <img src="Images/Global/<%#CStr(IIf(Eval("IsGuest"), "checked.png", "unchecked.png"))%>" />
                                            </ItemTemplate>
                                            <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                            <HeaderStyle Wrap="false" Width="150px" HorizontalAlign="Center" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <SortExpressions>
                                        <telerik:GridSortExpression FieldName="Group"></telerik:GridSortExpression>
                                    </SortExpressions>
                                    <CommandItemStyle HorizontalAlign="Left" />
                                    <CommandItemTemplate>
                                        &nbsp;
                                    </CommandItemTemplate>
                                </MasterTableView>
                                <ClientSettings EnableRowHoverStyle="true" EnablePostBackOnRowClick="false"
                                    Resizing-AllowColumnResize="true">
                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="false" />
                                </ClientSettings>
                            </telerik:RadGrid>
                        </fieldset>
                    </div>
                </div>
            </div>
        </telerik:RadPane>
    </telerik:RadSplitter>

</div>

<%--     <div style="border: 1px solid #666666; background-color: RGB(237,237,237); background-image: none; width: 289px; position: fixed !important;"
                                class="ShowOnMobile MarginTop52OnMobile">
                                <telerik:RadToolBar ID="TreeToolbar" runat="server" Height="50px" Style="line-height: 45px; background-color: RGB(237,237,237);" Skin="Default"
                                    CssClass="ShowOnMobile" AutoPostBack="true" Width="100%" OnClientButtonClicked="treeToolbarClick">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel ShowOnMobile PaddingLeft10" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </div>--%>

<%--  <tr>
                                 <td class="NoWrap Padding7 Top">
                        <asp:Label ID="lblStatement" runat="server" meta:resourcekey="lblStatement"></asp:Label>
                    </td>
                    <td class="Padding7 Top Right">
                        <asp:DropDownList ID="ddlTemplates"   runat="server" Width="230px">
                        </asp:DropDownList>
                        <div style="width: 100%; float: left; text-align: left">
                            <div id="divTemplateError" style="width: 190px;" class="Left">
                                &nbsp;<asp:CompareValidator ID="rfvTemplates" ControlToValidate="ddlTemplates" runat="server"
                                    ValueToCompare="0" CssClass="Validator" ForeColor="" Operator="GreaterThan" EnableClientScript="False"
                                    Type="Integer" meta:resourcekey="rfvTemplates"></asp:CompareValidator></div>
                        </div>
                    </td>
                            </tr>--%>
