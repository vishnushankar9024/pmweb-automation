<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="WorkflowDefineBranchStep.aspx.vb" Inherits="Website.WorkflowDefineBranchStep" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        function onNodeDropping(sender, args) {
            var dest = args.get_destNode();
            if (dest) {
            }
            else {
                dropOnHtmlElement(args);
            }
        }


        function dropOnHtmlElement(args) {
            if (droppedOnGrid(args))
                return;
        }
        function droppedOnGrid(args) {

            var gridId = $("[id$=rdgRuleConditions]")[0].id;
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

        function cvAction_validate(sender, args) {
            try {
                $("#tdAction").find("input[type='radio']").each(function () {
                    if (this.checked == true) { args.IsValid = true; throw true; }
                });
                args.IsValid = false;
            }
            catch (e) { /*error throw true just to break the each itiration*/ }
        }

        function GridCreated(sender, args) {
            $("[id*='txtLeftBrackets']").keypress(function (e) {
                var intKey = (window.Event) ? e.which : e.keyCode;
                if (!((intKey == 40) || (intKey == 41) || (intKey == 08))) {
                    return false;
                }

            });
            $("[id*='txtRightBrackets']").keypress(function (e) {
                var intKey = (window.Event) ? e.which : e.keyCode;
                if (!((intKey == 40) || (intKey == 41) || (intKey == 08))) {
                    return false;
                }

            });
            $("[id*='txtBrackets']").keypress(function (e) {
                var intKey = (window.Event) ? e.which : e.keyCode;
                if (!((intKey == 40) || (intKey == 41) || (intKey == 08))) {
                    return false;
                }

            });
        }

        function getUrlVars() {
            var vars = [], hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < hashes.length; i++) {
                hash = hashes[i].split('=');
                vars.push(hash[0]);
                vars[hash[0]] = hash[1];
            }
            return vars;
        }


        ///////////////////////// Generate Maps combobox functions ////////////////////////////

        function ddl_OnClientItemChecked(sender, eventArgs) {
            var item = eventArgs.get_item();
            var checked = item.get_checked();
            if (checked == true) {
                if (item.get_value() < 0) {
                    var i;
                    for (i = 1; i < item.get_parent().get_items().get_count() ; i++) {
                        item.get_parent().get_items().getItem(i).uncheck();
                    }
                }
                else {
                    item.get_parent().get_items().getItem(0).uncheck();
                }
            }
            else {
                if (item.get_parent().get_checkedItems().length == 0)
                    item.get_parent().get_items().getItem(0).set_checked(true);
            }
        }

        //////////////////////////////////////////////////////////////////////////////////////

    </script>
    <style>
        span#rfvRuleID {
            height: 24px !important;
        }

        .controlWidth > span:first-of-type {
            width: 100% !important;
            box-sizing: border-box;
            height: 85px !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <script type="text/javascript">
            $(document).ready(function () {
                if (getUrlVars()[0] == 'FromTemplateImage') {
                    $(window).unload(function () {
                        for (var i = 0; i < window.parent.length; i++) {
                            if (typeof window.parent[i].CloseDesigner === 'function') {
                                window.parent[i].CloseDesigner();
                                break;
                            }
                        }
                    });
                }
            });
        </script>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" EnablePageHeadUpdate="true">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgRuleConditions">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgRuleConditions" LoadingPanelID="ldpPM" />
                        <telerik:AjaxUpdatedControl ControlID="lblRuleConditionsMessage" />
                        <telerik:AjaxUpdatedControl ControlID="ddlRecordType" />
                    </UpdatedControls>
                </telerik:AjaxSetting>

                <telerik:AjaxSetting AjaxControlID="rtvFields">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgRuleConditions" LoadingPanelID="ldpPM" />
                        <telerik:AjaxUpdatedControl ControlID="ddlRecordType" />
                    </UpdatedControls>
                </telerik:AjaxSetting>

                <telerik:AjaxSetting AjaxControlID="ddlRecordType">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rtvFields" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default" />
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" ValidationGroup="Save" CommandName="Save"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" ValidationGroup="Save" CommandName="SaveExit"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div class="PMMainPage documentSinglePage">
            <div class="row">
                <div class="col-4 col-4-left">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth" style="width: 160px !important;">
                                <asp:Label ID="lblRecordType" runat="server" Text="Record Type" meta:Resourcekey="lblRecordType"></asp:Label>
                            </td>
                            <td class="controlWidth" style="width: 240px !important;">
                                <telerik:RadComboBox ID="ddlRecordType" AutoPostBack="true" AllowCustomText="true" Filter="Contains"
                                    runat="server" Height="200px" Skin="Default">
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
                                <asp:RequiredFieldValidator runat="server" ID="rfvRuleID" CssClass="Validator"
                                    ValidationGroup="Save" ControlToValidate="txtRuleID" Display="Dynamic"
                                    meta:resourcekey="rfvRuleID">
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
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCurrency" runat="server" Text="Currency" meta:Resourcekey="lblCurrency"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlCurrencies" runat="server" Height="200px" Skin="Default"></telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblRepeatOnApprove" runat="server" Text="Repeat On Approve" meta:Resourcekey="lblRepeatOnApprove"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:CheckBox ID="chkRepeatOnApprove" runat="server" AutoPostBack="true" class="mobile-switch" Style="margin-left: -4px" />
                            </td>
                        </tr>

                    </table>
                </div>
                <div class="col-4 col-4-middle">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth" style="width: 160px !important;">
                                <asp:Label ID="lblMessage" runat="server" Text="Message" meta:Resourcekey="lblMessage"></asp:Label>
                            </td>
                            <td class="controlWidth" style="width: 240px !important;">
                                <telerik:RadTextBox runat="server" TextMode="MultiLine" ID="txtMessage" Height="80px" InputType="Text"></telerik:RadTextBox>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-4 col-4-right">
                    <div id="divGenerateRecords" runat="server">
                        <fieldset>
                            <legend>
                                <asp:Label ID="lblGenerateRecords" runat="server" CssClass="legend" meta:resourcekey="lblGenerateRecords" Text="Generate Records"></asp:Label>
                            </legend>
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth" style="width: 160px !important;">
                                        <asp:Label ID="lblGenerateAction" runat="server" meta:resourcekey="lblGenerateAction" Text="Action"></asp:Label>
                                    </td>
                                    <td class="controlWidth" style="width: 240px !important;">
                                        <asp:Label ID="lblGenerate" runat="server" meta:resourcekey="lblGenerate" Text="Generate"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblBranch" runat="server" meta:resourcekey="lblBranch" Text="Branch"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlBranch" CheckBoxes="true" Filter="Contains" CheckedItemsTexts="DisplayAllInInput"
                                            Height="250px" runat="server" AllowCustomText="True" Skin="Default" OnClientItemChecked="ddl_OnClientItemChecked">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblReturn" runat="server" meta:resourcekey="lblReturn" Text="Return"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlReturn" CheckBoxes="true" Filter="Contains" CheckedItemsTexts="DisplayAllInInput"
                                            Height="250px" runat="server" AllowCustomText="True" Skin="Default" OnClientItemChecked="ddl_OnClientItemChecked">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblReject" runat="server" meta:resourcekey="lblReject" Text="Reject"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlReject" CheckBoxes="true" Filter="Contains" CheckedItemsTexts="DisplayAllInInput"
                                            Height="250px" runat="server" AllowCustomText="True" Skin="Default" OnClientItemChecked="ddl_OnClientItemChecked">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblFinalApprove" runat="server" meta:resourcekey="lblFinalApprove" Text="Final Approve"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlFinalApprove" CheckBoxes="true" Filter="Contains" CheckedItemsTexts="DisplayAllInInput"
                                            Height="250px" runat="server" AllowCustomText="True" Skin="Default" OnClientItemChecked="ddl_OnClientItemChecked">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblSubmitIfWorkflowEnabled" runat="server" Text="Submit if Workflow enabled" meta:resourcekey="chkSubmitIfWorkflowEnabled" ToolTip="Submit if Workflow enabled"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:CheckBox ID="chkSubmitIfWorkflowEnabled" runat="server" class="mobile-switch" Style="margin-left: -4px;" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                </div>
            </div>
            <div class="row row-8-4-fit8">
                <div class="col-4">
                    <fieldset>
                        <legend>
                            <asp:Label ID="lblFields" runat="server" CssClass="legend" meta:resourcekey="lblFields" Text="Fields"></asp:Label>
                        </legend>
                        <div style="overflow: auto; width: 100%; height: 310px;">
                            <telerik:RadTreeView ID="rtvFields" runat="server" EnableDragAndDrop="True" OnClientNodeDropping="onNodeDropping" Skin="Default" CausesValidation="False"
                                CheckBoxes="true" TriStateCheckBoxes="true" OnClientNodeChecked="ShowHidebtnTreeDropItems"></telerik:RadTreeView>
                            <asp:LinkButton runat="server" ID="btnTreeDropItems">
                                <div class="btnTreeDropItems" style="display: inline-block !important;">&nbsp;</div>
                            </asp:LinkButton>
                        </div>
                    </fieldset>
                </div>
                <div class="col-8">
                    <fieldset style="overflow: auto">
                        <legend>
                            <asp:Label ID="lblExpression" CssClass="legend" runat="server" meta:resourcekey="lblExpression" Text="Expression"></asp:Label>
                        </legend>
                        <asp:Label ID="lblRuleConditionsMessage" runat="server" meta:resourcekey="lblRuleConditionsMessage" CssClass="Validator"></asp:Label>
                        <telerik:RadGrid ID="rdgRuleConditions" UseEditFormInMobile="true" runat="server" Width="100%" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                            AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="5" ShowFooter="false"
                            AllowPaging="True" ShowGroupPanel="False" AllowMultiRowEdit="True" AllowMultiRowSelection="True"
                            AllowSorting="True">
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
                                        <HeaderStyle Width="85px" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="And/Or" UniqueName="LogicalOperators">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblLogicalOperators" Text=' <%# Eval("LogicalOperators") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:radcombobox ID="ddlAndOr" runat="server" Width="100%">
                                                <Items>
                                                     <telerik:radcomboboxitem Text="" Value=""></telerik:radcomboboxitem>
                                                <telerik:radcomboboxitem Text="And" Value="AND" Selected="True" meta:resourcekey="ListItem_AND"></telerik:radcomboboxitem>
                                                <telerik:radcomboboxitem Text="Or" Value="OR" Selected="False" meta:resourcekey="ListItem_OR"></telerik:radcomboboxitem>
                                                </Items>
                                               
                                            </telerik:radcombobox>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="70px" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="()" UniqueName="RightBrackets">
                                        <ItemTemplate>
                                            <%# Eval("RightBrackets")%>&nbsp;
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtRightBrackets" runat="server" Text='<%# Eval("RightBrackets") %>' Width="100%"></asp:TextBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="85px" />
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
                                            <telerik:radcombobox ID="ddlOperators" Width="100%" runat="server" />
                                        </EditItemTemplate>
                                        <HeaderStyle Width="120px" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Value" UniqueName="Value">
                                        <ItemTemplate>
                                            <asp:Image runat="server" ID="imgCheck" />
                                            <asp:Label runat="server" ID="lblValue"></asp:Label>&nbsp;
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtValueString" Width="100%" runat="server" Visible="false"></asp:TextBox>

                                            <asp:TextBox ID="txtValueNumber" Width="100px" runat="server" Visible="false"></asp:TextBox>
                                            <asp:RequiredFieldValidator runat="server" ID="rfvValueNumber" CssClass="Validator"
                                                ValidationGroup="SaveConditions" ControlToValidate="txtValueNumber" Display="Dynamic"
                                                meta:resourcekey="InvalidValue">
                                            </asp:RequiredFieldValidator>

                                            <asp:TextBox ID="txtValueInteger" Width="100px" CssClass="Integer" runat="server" Visible="false"></asp:TextBox>
                                            <asp:RequiredFieldValidator runat="server" ID="rfvValueInteger" CssClass="Validator"
                                                ValidationGroup="SaveConditions" ControlToValidate="txtValueInteger" Display="Dynamic"
                                                meta:resourcekey="InvalidValue">
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
                                            <asp:RequiredFieldValidator runat="server" ID="rfvValueDate" CssClass="Validator"
                                                ValidationGroup="SaveConditions" ControlToValidate="txtValueDate" Display="Dynamic"
                                                meta:resourcekey="InvalidValue">
                                            </asp:RequiredFieldValidator>

                                            <telerik:RadTimePicker ID="txtValueTime" runat="server" Skin="Default" Width="94px" SelectedDate="7:00 AM"></telerik:RadTimePicker>
                                            <asp:RequiredFieldValidator runat="server" ID="rfvValueTime" CssClass="Validator"
                                                ValidationGroup="SaveConditions" ControlToValidate="txtValueTime" Display="Dynamic"
                                                meta:resourcekey="InvalidValue">
                                            </asp:RequiredFieldValidator>

                                            <asp:CheckBox ID="chkValueBoolean" Checked="true" runat="server" Visible="false" class="mobile-switch"></asp:CheckBox>

                                        </EditItemTemplate>
                                        <HeaderStyle Width="180px" />
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
                                        CommandName="EditRows" Visible='<%# rdgRuleConditions.EditIndexes.Count = 0 And (Not rdgRuleConditions.MasterTableView.IsItemInserted) And (PM.Workflow.TemplateInfo.TemplateStepId > 0) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="SaveConditions" CausesValidation="true" CssClass="GridCmdUpdateEdited"
                                        CommandName="UpdateEdited" Visible='<%# rdgRuleConditions.EditIndexes.Count > 0 %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="False" CommandName="DeleteRows" CssClass="GridCmdDeleteRows"
                                        OnClientClick="return ConfirmDelete()" Visible='<%# rdgRuleConditions.EditIndexes.Count = 0 And (Not rdgRuleConditions.MasterTableView.IsItemInserted) And (PM.Workflow.TemplateInfo.TemplateStepId > 0) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CssClass="GridCmdCancelAll"
                                        CommandName="CancelAll" Visible="<%# rdgRuleConditions.EditIndexes.Count > 0 %>">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblCancel" runat="server"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CssClass="GridCmdRebindGrid"
                                        CommandName="RebindGrid" Visible='<%# rdgRuleConditions.EditIndexes.Count = 0 And (Not rdgRuleConditions.MasterTableView.IsItemInserted) And (PM.Workflow.TemplateInfo.TemplateStepId > 0) %>'>
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
                    </fieldset>
                    <div id="tdAction" style="padding-top: 20px;">
                        <fieldset style="width: 400px !important; padding-bottom: 20px;">
                            <legend>
                                <asp:Label ID="lblAction" runat="server" meta:resourcekey="lblAction" Text="Action"></asp:Label>
                            </legend>
                            <asp:CustomValidator ID="cvWorkflowAction" runat="server" CssClass="Validator" ClientValidationFunction="cvAction_validate"
                                ValidationGroup="Save" ForeColor="" meta:resourcekey="cvWorkflowAction" Height="25px"></asp:CustomValidator>
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth" style="width: 160px !important;">
                                        <asp:RadioButton ID="rdbBranch" runat="server" Text="Branch" GroupName="Action" meta:resourcekey="rdbBranch" CssClass="RadioCss" />
                                    </td>
                                    <td class="controlWidth" style="width: 240px !important;"></td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:RadioButton ID="rdbFinalApprove" runat="server" Text="Final Approve" GroupName="Action" meta:resourcekey="rdbFinalApprove" CssClass="RadioCss" />
                                    </td>
                                    <td class="controlWidth"></td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:RadioButton ID="rdbReject" runat="server" Text="Reject" GroupName="Action" meta:resourcekey="rdbReject" CssClass="RadioCss" />
                                    </td>
                                    <td class="controlWidth"></td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:RadioButton ID="rdbReturnTo" runat="server" Text="Return To" GroupName="Action" meta:resourcekey="rdbReturnTo" CssClass="RadioCss" />
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlReturnTo" AutoPostBack="false" AllowCustomText="true" Filter="Contains" runat="server" Width="100%" Skin="Default"></telerik:RadComboBox>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
