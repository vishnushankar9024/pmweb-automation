<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="QueryBuilderDetails.ascx.vb" Inherits="Website.QueryBuilderDetails" %>
<%@ Register Src="QueryBuilderChart.ascx" TagName="QueryBuilderChart" TagPrefix="uc2" %>
<%@ Register Src="QueryBuilderHeaders.ascx" TagName="QueryBuilderHeaders" TagPrefix="uc7" %>
<telerik:RadCodeBlock ID="CodeBlock" runat="server">
    <style>
        .RadTabStripVertical .rtsLevel {
            text-transform: uppercase;
        }

        @media screen and (min-width: 1051px) {
            .PMHead .row .col-2 {
                flex: 0 0 16.66667%;
                max-width: 16.66667%;
                float: left;
                display: inline-block;
                box-sizing: border-box;
                width: 16.66667%;
            }

            .PMHead .row .col-10 {
                flex: 0 0 83.33333%;
                max-width: 83.33333%;
                display: inline-block;
                box-sizing: border-box;
                float: left;
                width: 83.33333%;
            }
        }

        @media screen and (max-width: 1640px) and (min-width: 844px) {
            .PMHeader .row .col-4 {
                flex: 0 0 35% !important;
                max-width: 35% !important;
            }

            .PMHeader .row .col-8 {
                flex: 0 0 65% !important;
                max-width: 65% !important;
            }
        }

        #ctl00_CPH1_Qd1_tbsDesign .rtsScroll {
            left: 0 !important;
            width: 100% !important;
        }

        #ctl00_CPH1_Qd1_tbsDesign .rtsLevel.rtsLevel1 {
            width: 100% !important;
        }

        @media screen and (max-width: 843px) {
            #ctl00_CPH1_Qd1_tbsDesign {
                height: 32px !important;
            }
        }

        @media screen and (max-width: 1050px) {
            .PMHead .row .col-2, .PMHead .row .col-10 {
                flex: 0 0 100% !important;
                max-width: 100% !important;
            }

            .SettingsMainTab {
                margin-top: 6px;
            }
        }
    </style>

    <script type="text/javascript">
        var gridId1 = "<%= rdgSelect.ClientID %>";
        var gridId2 = "<%= rdgWhere.ClientID %>";



        function dropOnHtmlElement(args) {
            if (droppedOnGrid(args))
                return;
        }
        function droppedOnGrid(args) {
            var target = args.get_htmlElement();
            while (target) {
                if ((target.id == gridId1) || (target.id == gridId2)) {
                    args.set_htmlElement(target);
                    return;
                }
                target = target.parentNode;
            }
            args.set_cancel(true);
        }

        function openCalculationPopup(FieldId) {
            return OpenPOPUp('QueryBuilderCalculatedField.aspx?Id=' + FieldId, 728, 550, true, 'rdgSelect');
        }
        function GridCreated(sender, args) {
            $("[id*='txtLeftBrackets']").keypress(function (e) {
                var intKey = (window.Event) ? e.which : e.keyCode;
                if (!((intKey == 40) || (intKey == 41))) {
                    return false;
                }

            });
            $("[id*='txtRightBrackets']").keypress(function (e) {
                var intKey = (window.Event) ? e.which : e.keyCode;
                if (!((intKey == 40) || (intKey == 41))) {
                    return false;
                }

            });
            $("[id*='txtBrackets']").keypress(function (e) {
                var intKey = (window.Event) ? e.which : e.keyCode;
                if (!((intKey == 40) || (intKey == 41))) {
                    return false;
                }
            });
        }
        function ShowHidebtnTreeFilterDropItems(sender, args) {
            if (sender.get_checkedNodes().length > 0) {
                $("[id$=btnFilterDropItems]").removeClass("Hide");
            }
            else
                $("[id$=btnFilterDropItems]").addClass("Hide");
        }

        function TabStyle() {
            var tab = $find("<%=tbsDesign.ClientID%>");
            if (window.innerWidth <= "1050") {
                tab.removeCssClass("RadTabStripVertical");
                tab.removeCssClass("tbsSpecPC");
                tab.removeCssClass("tbsFolderManagerSpecs");
                tab.removeCssClass("tbsDocSpec");
                tab.removeCssClass("SettingsDetailTab");
                tab.removeCssClass("RadTabStripLeft");
                tab.removeCssClass("RadTabStripLeft_Default");
                tab.addCssClass("RadTabStopTop");
                tab.addCssClass("RadTabStrip");
                tab.addCssClass("RadTabStrip_Default");
                tab.addCssClass("RadTabStripTop_Default");
                tab.addCssClass("RadTabStripTop");
                tab.addCssClass("SettingsMainTab");
                window.resizeTo(document.documentElement.clientWidth - 1, document.documentElement.clientHeight);
            }
            else {
                tab.removeCssClass("SettingsDetailTab");
                tab.removeCssClass("SettingsMainTab");
                tab.removeCssClass("RadTabStripTop_Default");
                tab.removeCssClass("RadTabStrip");
                tab.removeCssClass("RadTabStopTop");
                tab.addCssClass("tbsSpecPC");
                tab.addCssClass("tbsFolderManagerSpecs");
                tab.addCssClass("tbsDocSpec");
                tab.addCssClass("RadTabStripLeft");
                tab.addCssClass("RadTabStripLeft_Default");
                tab.addCssClass("RadTabStrip_Default");
                tab.addCssClass("RadTabStripVertical");

            }
        }
        window.onload = function () {
            TabStyle();
        }
        window.onresize = function () {
            TabStyle();
        }
    </script>
</telerik:RadCodeBlock>
<div class="PMHeader">
    <div class="row">
        <div class="col-2">
            <telerik:RadTabStrip ID="tbsDesign" OnClientTabSelecting="onTabSelecting" ScrollChildren="true" ScrollButtonsPosition="Left"
                runat="server" SelectedIndex="0" MultiPageID="mlpDesign" Skin="Default"
                Width="100%" EnableViewState="True">
                <Tabs>
                    <telerik:RadTab Text="1 Select Fields" Value="Fields"></telerik:RadTab>
                    <telerik:RadTab Text="2 Create Filters" Value="Filters"></telerik:RadTab>
                    <telerik:RadTab Text="3 Add a chart" Value="Charts"></telerik:RadTab>
                    <telerik:RadTab Text="4 Headers/Footer" Value="HeadersFooter"></telerik:RadTab>
                </Tabs>
            </telerik:RadTabStrip>
        </div>
        <div class="col-10 SpecificationPadding" id="divGrids">
            <telerik:RadMultiPage ID="mlpDesign" SelectedIndex="0" runat="server">
                <telerik:RadPageView runat="server" ID="pvFields">
                    <div class="PMHeader">
                        <div class="row">
                            <div class="col-4">
                                <fieldset id="tdTreeFields" style="position: relative;">
                                    <legend>
                                        <asp:Label ID="lblFields" runat="server" Text="Fields" meta:resourcekey="lblFields"></asp:Label>
                                    </legend>
                                    <telerik:RadTreeView ID="treeFields" runat="server" EnableDragAndDrop="True" Height="402px" OnClientNodeChecked="ShowHidebtnTreeDropItems"
                                        OnClientNodeDropping="onNodeDropping" MultipleSelect="True" Width="220px" CheckBoxes="true" TriStateCheckBoxes="true">
                                        <ExpandAnimation Duration="100"></ExpandAnimation>
                                        <CollapseAnimation Duration="100" Type="OutQuint" />
                                    </telerik:RadTreeView>
                                    <asp:LinkButton runat="server" ID="btnTreeDropItems">
                                        <div class="btnTreeDropItems" style="display: inline-block !important;">&nbsp;</div>
                                    </asp:LinkButton>
                                </fieldset>
                            </div>
                            <div class="col-8" style="padding-top:12px;">
                                <telerik:RadGrid ID="rdgSelect" runat="server" UseEditFormInMobile="true" Width="100%" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                    AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="10" ShowFooter="false" FitParentContainer="true"
                                    AllowPaging="True" ShowGroupPanel="False" AllowMultiRowEdit="True" AllowMultiRowSelection="True" AppendMenus="True"
                                    AllowSorting="True" GridLines="None">
                                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>

                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                        DataKeyNames="Id" CommandItemDisplay="Top" TableLayout="Fixed" EditMode="InPlace">
                                        <Columns>
                                            <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber">
                                                <ItemTemplate>
                                                    <span><%#Container.DataItem("LineNumber").ToString%></span>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <%#Eval("LineNumber").ToString%>
                                                </EditItemTemplate>
                                                <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Table" UniqueName="TableName">
                                                <ItemTemplate>
                                                    <%# Eval("TableName") %>&nbsp;
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <%# Eval("TableName") %>&nbsp;
                                                </EditItemTemplate>
                                                <HeaderStyle Width="175px" />
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Field" UniqueName="FieldName">
                                                <ItemTemplate>
                                                    <%# Eval("FieldName") %>&nbsp;
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <%# Eval("FieldName") %>&nbsp;
                                                </EditItemTemplate>
                                                <HeaderStyle Width="170px" />
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Alias" UniqueName="AliasName">
                                                <ItemTemplate>
                                                    <%# Eval("AliasName") %>&nbsp;
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtAliasName" runat="server" Text='<%# Eval("AliasName") %>' Width="100%"></asp:TextBox>
                                                </EditItemTemplate>
                                                <HeaderStyle Width="150px" />
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Calculation" UniqueName="Calculation">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="imgCalculation" runat="server" Visible='<%# Eval("IsCalculated") %>'
                                                        OnClientClick='<%# "return openCalculationPopup(" &  Eval("Id") & ");" %>' CssClass="FormulaButton">
                                                <span class="Icon"></span></asp:LinkButton>
                                                    &nbsp;
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    &nbsp; 
                                                </EditItemTemplate>
                                                <HeaderStyle Width="100px" />
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Subtotal" UniqueName="AggregateEnumId">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblAggregate"></asp:Label>&nbsp;
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:DropDownList ID="ddlAggregates" runat="server" Width="100%">
                                                        <asp:ListItem Text="None" Value="0" meta:resourcekey="ListItem_None"></asp:ListItem>
                                                        <asp:ListItem Text="Sum" Value="1" meta:resourcekey="ListItem_Sum"></asp:ListItem>
                                                        <asp:ListItem Text="Min" Value="2" meta:resourcekey="ListItem_Min"></asp:ListItem>
                                                        <asp:ListItem Text="Max" Value="3" meta:resourcekey="ListItem_Max"></asp:ListItem>
                                                        <asp:ListItem Text="Last" Value="4" meta:resourcekey="ListItem_Last"></asp:ListItem>
                                                        <asp:ListItem Text="First" Value="5" meta:resourcekey="ListItem_First"></asp:ListItem>
                                                        <asp:ListItem Text="Count" Value="6" meta:resourcekey="ListItem_Count"></asp:ListItem>
                                                        <asp:ListItem Text="Avg" Value="7" meta:resourcekey="ListItem_Avg"></asp:ListItem>
                                                        <asp:ListItem Text="Count Distinct" Value="8" meta:resourcekey="ListItem_CountDistinct"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </EditItemTemplate>
                                                <HeaderStyle Width="100px" />
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Width" UniqueName="Width">
                                                <ItemTemplate>
                                                    <span><%#CStr(Eval("Width")) & "&nbsp;px"%>&nbsp;</span>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtWidth" runat="server" Text='<%# Eval("Width") %>' Width="100%" CssClass="Integer"></asp:TextBox>
                                                </EditItemTemplate>
                                                <HeaderStyle Width="80px" />
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Show" UniqueName="Show">
                                                <ItemTemplate>
                                                    <span>
                                                        <img alt="" src='<%#IIf(Container.DataItem("Show"), "Images/Global/checked.png", "Images/Global/unchecked.png")%>' /></span>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:CheckBox ID="chkShow" runat="server" Checked=' <%# IIf(Eval("Show") Is System.DBNull.Value, False, Eval("Show")) %>' />
                                                </EditItemTemplate>
                                                <HeaderStyle Width="50px" />
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Header/Footer" UniqueName="ShowInHeader">
                                                <ItemTemplate>
                                                    <span>
                                                        <img alt="" src='<%#IIf(Container.DataItem("ShowInHeader"), "Images/Global/checked.png", "Images/Global/unchecked.png")%>' /></span>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:CheckBox ID="chkShowInHeader" runat="server" Checked=' <%# IIf(Eval("ShowInHeader") Is System.DBNull.Value, False, Eval("ShowInHeader")) %>' />
                                                </EditItemTemplate>
                                                <HeaderStyle Width="90px" />
                                            </telerik:GridTemplateColumn>

                                        </Columns>
                                        <CommandItemTemplate>
                                            <div style="padding: 2px">
                                                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add"
                                                    CommandName="InitNewCalculatedRow" CssClass="GridCmdInitNewCalculatedRow" Visible='<%# rdgSelect.EditIndexes.Count = 0 And (Not rdgSelect.MasterTableView.IsItemInserted) %>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblAddCalculatedLine" meta:resourcekey="lblAddCalculatedLine" runat="server"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit"
                                                    CommandName="EditRows" CssClass="GridCmdEditRows" Visible='<%# rdgSelect.EditIndexes.Count = 0 And (Not rdgSelect.MasterTableView.IsItemInserted) %>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit"
                                                    CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible='<%# rdgSelect.EditIndexes.Count > 0 %>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnSave" runat="server" SecurityButtonType="AddEditMode_Add"
                                                    CommandName="PerformInsert" CssClass="GridCmdPerformInsert" Visible='<%# rdgSelect.MasterTableView.IsItemInserted %>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblSave" runat="server"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode"
                                                    CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible='<%# rdgSelect.EditIndexes.Count > 0 Or rdgSelect.MasterTableView.IsItemInserted %>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblCancel" runat="server"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>

                                                <asp:LinkButton ID="btnDelete" CausesValidation="False" SecurityButtonType="ItemMode_Delete"
                                                    OnClientClick="return ConfirmDelete()" Visible='<%# rdgSelect.EditIndexes.Count = 0 And (Not rdgSelect.MasterTableView.IsItemInserted) %>'
                                                    runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode"
                                                    CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgSelect.EditIndexes.Count = 0 And (Not rdgSelect.MasterTableView.IsItemInserted) %>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblRefresh" runat="server"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                            </div>
                                        </CommandItemTemplate>
                                    </MasterTableView>
                                    <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" AllowColumnHide="false" AllowColumnsReorder="false"
                                        AllowDragToGroup="false" AllowRowsDragDrop="true">
                                        <ClientEvents></ClientEvents>
                                        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                            AllowColumnResize="True" />
                                        <Selecting AllowRowSelect="true" EnableDragToSelectRows="true" />
                                    </ClientSettings>
                                    <ItemStyle Wrap="false" />
                                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                                </telerik:RadGrid>
                            </div>
                        </div>
                    </div>
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="pvFilters">
                    <div class="PMHeader">
                        <div class="row">
                            <div class="col-4">
                                <fieldset style="position: relative;">
                                    <legend>
                                        <asp:Label ID="Label1" runat="server" Text="Fields" meta:resourcekey="lblFields"></asp:Label>
                                    </legend>
                                    <telerik:RadTreeView ID="treeFilter" runat="server" EnableDragAndDrop="True" Height="402px" OnClientNodeChecked="ShowHidebtnTreeFilterDropItems"
                                        OnClientNodeDropping="onNodeDropping" MultipleSelect="True" Width="220px" CheckBoxes="true" TriStateCheckBoxes="true">
                                        <ExpandAnimation Duration="100"></ExpandAnimation>
                                        <CollapseAnimation Duration="100" Type="OutQuint" />
                                    </telerik:RadTreeView>
                                    <asp:LinkButton runat="server" ID="btnFilterDropItems">
                                        <div class="btnTreeDropItems" style="display: inline-block !important;">&nbsp; </div>
                                    </asp:LinkButton>
                                </fieldset>
                            </div>
                            <div class="col-8" style="padding-top:12px;">
                                <telerik:RadGrid ID="rdgWhere" runat="server" UseEditFormInMobile="true" Width="100%" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                    AutoGenerateColumns="False" ShowStatusBar="False" Font-Size="8px" PageSize="5" ShowFooter="false" FitParentContainer="true"
                                    AllowPaging="True" ShowGroupPanel="False" AllowMultiRowEdit="True" AllowMultiRowSelection="True"
                                    AllowSorting="True" GridLines="None">
                                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>

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
                                                    <%# Eval("LeftBrackets") %>&nbsp;
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtLeftBrackets" runat="server" Text='<%# Eval("LeftBrackets") %>' Width="100%"></asp:TextBox>
                                                </EditItemTemplate>
                                                <HeaderStyle Width="50px" />
                                            </telerik:GridTemplateColumn>


                                            <telerik:GridTemplateColumn HeaderText="And/Or" UniqueName="AndOr">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblLogicalOperators" Text=' <%# Eval("AndOr") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:DropDownList ID="ddlAndOr" runat="server">
                                                        <asp:ListItem Text="" Value=""></asp:ListItem>
                                                        <asp:ListItem Text="And" Value="AND" Selected="True" meta:resourcekey="ListItem_AND"></asp:ListItem>
                                                        <asp:ListItem Text="Or" Value="OR" Selected="False" meta:resourcekey="ListItem_OR"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </EditItemTemplate>
                                                <HeaderStyle Width="50px" />
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

                                            <telerik:GridTemplateColumn HeaderText="Field" UniqueName="FieldName">
                                                <ItemTemplate>
                                                    <%# Eval("FieldName") %>&nbsp;
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <%# Eval("FieldName") %>
                                                </EditItemTemplate>
                                                <HeaderStyle Width="150px" />
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Operator" UniqueName="Operator">
                                                <ItemTemplate>
                                                    <%# Eval("Operator") %>&nbsp;
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:DropDownList ID="ddlOperators" Width="100%" runat="server" />
                                                </EditItemTemplate>
                                                <HeaderStyle Width="100px" />
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Value" UniqueName="Value">
                                                <ItemTemplate>
                                                    <asp:Image runat="server" ID="imgCheck" />
                                                    <asp:Label runat="server" ID="lblValue"></asp:Label>&nbsp;
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtValueString" Width="100%" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator runat="server" ID="rfvValueString" CssClass="Validator"
                                                        ValidationGroup="SaveWhere" ControlToValidate="txtValueString" Display="Dynamic"
                                                        meta:resourcekey="InvalidValue"></asp:RequiredFieldValidator>
                                                    <asp:TextBox ID="txtValueNumber" Width="100%" CssClass="PositiveDouble" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator runat="server" ID="rfvValueNumber" CssClass="Validator"
                                                        ValidationGroup="SaveWhere" ControlToValidate="txtValueNumber" Display="Dynamic"
                                                        meta:resourcekey="InvalidValue"></asp:RequiredFieldValidator>
                                                    <telerik:RadDatePicker ID="txtValueDate" Height="25px" runat="server"
                                                        MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default">
                                                        <Calendar Skin="Default" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False"
                                                            ViewSelectorText="x">
                                                        </Calendar>
                                                        <DateInput LabelCssClass="radLabelCss_Office2007" Skin="Default" CausesValidation="True"
                                                            Height="13px" ValidationGroup="SaveWhere">
                                                        </DateInput>
                                                        <DatePopupButton CssClass="" HoverImageUrl="" ImageUrl="" />
                                                    </telerik:RadDatePicker>
                                                    <asp:CheckBox ID="chkValueBoolean" Checked="true" runat="server"></asp:CheckBox>
                                                </EditItemTemplate>
                                                <HeaderStyle Width="155px" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="()" UniqueName="Bracket">
                                                <ItemTemplate>
                                                    <%# Eval("Brackets")%>&nbsp;
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtBrackets" runat="server" Text='<%# Eval("Brackets")%>' Width="100%"></asp:TextBox>
                                                </EditItemTemplate>
                                                <HeaderStyle Width="50px" />
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                        <CommandItemTemplate>
                                            <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False"
                                                CommandName="EditRows" CssClass="GridCmdEditRows" Visible="<%# rdgWhere.EditIndexes.Count = 0 %>"
                                                SecurityButtonType="ItemMode_Edit">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False"
                                                CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" Visible="<%# rdgWhere.EditIndexes.Count > 0 %>"
                                                SecurityButtonType="AddEditMode_Edit">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="False" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" SecurityButtonType="ItemMode_Delete"
                                                OnClientClick="return ConfirmDelete()" Visible="<%# rdgWhere.EditIndexes.Count = 0 And (Not rdgWhere.MasterTableView.IsItemInserted) %>">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnCancel" SecurityButtonType="AddEditMode" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible="<%# rdgWhere.EditIndexes.Count > 0 %>">
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblCancel" runat="server"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode"
                                                CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgWhere.EditIndexes.Count = 0 And (Not rdgWhere.MasterTableView.IsItemInserted) %>'>
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblRefresh" runat="server"></asp:Label>&nbsp;&nbsp;
                                            </asp:LinkButton>
                                        </CommandItemTemplate>
                                    </MasterTableView>
                                    <ClientSettings AllowColumnHide="false" AllowColumnsReorder="false"
                                        AllowDragToGroup="false" AllowRowsDragDrop="true">
                                        <Selecting AllowRowSelect="true" EnableDragToSelectRows="true" />
                                        <ClientEvents OnRowDblClick="RowDblClick" OnGridCreated="GridCreated"></ClientEvents>
                                        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                            AllowColumnResize="True" />
                                    </ClientSettings>
                                    <ItemStyle Wrap="false" />
                                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                                </telerik:RadGrid>
                            </div>
                        </div>
                    </div>
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="pvChart">
                    <uc2:QueryBuilderChart ID="QBC" runat="server" />
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="pvHeadersFooter">
                    <uc7:QueryBuilderHeaders ID="QueryBuilderHeaders1" runat="server" />
                </telerik:RadPageView>
            </telerik:RadMultiPage>
        </div>
    </div>
</div>

<div style="display: none;">
    <fieldset style="height: 380px" id="tdQuery">
        <legend>
            <asp:Label ID="lblSQL" runat="server" Text="SQL" meta:resourcekey="lblSQL"></asp:Label>
        </legend>
        <div style="width: 100%; height: 375px; overflow: auto;">
            <asp:Label ID="lblSqlQuery" runat="server"></asp:Label>
        </div>
    </fieldset>
</div>
