<%@ Page Language="vb" AutoEventWireup="false" Title="Budget Request Projection" CodeBehind="CostManagementSpreadedBudgetRequestDetail.aspx.vb" Inherits="Website.CostManagementSpreadedBudgetRequestDetail" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Charting" TagPrefix="telerik" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/11009/xhtml">
<head id="Head1" runat="server">
    <%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />--%>
    <script src="JS/Costs/BudgetRequest.js" type="text/javascript"></script>
    <script type="text/javascript">

        function pageLoad() {

            var value = $('#hdnopenDiv').val()
            if (value == '') return false;
            openDivByCommandName(value);
        }


        function ClearText(CntrlId) {
            document.getElementById(CntrlId).innerText = '';
        }
        function ddlField_OnClientSelectedIndexChanged(sender, eventArgs) {
            var item = eventArgs.get_item();

            $("input[id$=txtBudgetedAmount]").val(item.get_attributes().getAttribute("Amount"));
            $("input[id$=txtUnitCost]:first").val(item.get_attributes().getAttribute("UnitCost"));

        }

        function maintoolbarClick(sender, args) {

            var value = args.get_item().get_commandName()
            $('#hdnopenDiv').val(value)
            openDivByCommandName(value)
        }

        function openDivByCommandName(value) {
            switch (value) {
                case 'OpenHeadDiv':
                    var popup = $('#headpopup')[0];
                    popup.style.display = 'block';
                    break;
            }
        }

        function headToolbarClick(sender, args) {

            if (args.get_item().get_commandName() == 'ToggleSplitter' || args.get_item().get_commandName() == 'SaveExit') {
                var popup = $('#headpopup')[0];
                popup.style.display = 'none';
                $('#hdnopenDiv').val('')
                return false;
            }
        }

    </script>
    <style type="text/css">
        .chart-width {
            width: calc(100vw) !important;
        }

        @media screen and (max-width: 843px) and (min-width: 320px) {
            .popupDiv .documentSinglePage {
                margin-top: 0px !important;
            }
        }

        .documentSinglePage {
            margin-bottom: 0px !important;
        }

        .rfdSkinnedButton {
            text-decoration: none;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" EnableSkinTransparency="true"
            BackgroundPosition="Center" Skin="Default" />
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" EnablePageHeadUpdate="true">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgBudgetCosts">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgBudgetCosts" LoadingPanelID="ldpPM" />
                        <telerik:AjaxUpdatedControl ControlID="chrtCashFlow" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnSave">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgBudgetCosts" LoadingPanelID="ldpPM" />
                        <telerik:AjaxUpdatedControl ControlID="chrtCashFlow" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%" CssClass="popup-toolbar" OnClientButtonClicked="maintoolbarClick">
                        <Items>
                            <%-- <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" ValidationGroup="Save"
                                            CommandName="Save" >
                                        </telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"
                                            ValidationGroup="Save">
                                        </telerik:RadToolBarButton>--%>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton IsSeparator="true"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="OpenHeadDiv" EnableImageSprite="true" PostBack="false" CssClass="ToolbarCalculate ShowOnMobile">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Chart" Value="Chart" EnableImageSprite="true" CssClass="ToolbarChart ShowOnMobile">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Grid" Value="Grid" EnableImageSprite="true" CssClass="ToolbarGrid ShowOnMobile">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <div id="headpopup" class="popupDiv">
            <telerik:RadToolBar ID="projectionToolBar" Height="50px" runat="server" Skin="Default" AutoPostBack="true" Width="100%" CssClass="popup-toolbar ShowOnMobile" OnClientButtonClicked="headToolbarClick">
                <Items>
                    <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave TreeToolbarSave" CommandName="Save" Height="50px"></telerik:RadToolBarButton>
                    <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit TreeToolbarSaveExit ShowOnMobile" Height="50px" CommandName="SaveExit"></telerik:RadToolBarButton>
                    <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel TreeToolbarCancel ShowOnMobile" Height="50px" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                </Items>
            </telerik:RadToolBar>

            <div class="PMMainPage PMPopupMainPage documentSinglePage" >
                <div class="row R3Cols">
                    <div class="col-4 col-4-left">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblField" runat="server" meta:resourcekey="lblField" Text="Field"></asp:Label></td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlField" runat="server" Filter="Contains"
                                        MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" NoWrap="True" OnClientSelectedIndexChanged="ddlField_OnClientSelectedIndexChanged">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblBudgetedAmount" runat="server" meta:resourcekey="lblBudgetedAmount" Text="Amount"></asp:Label></td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtBudgetedAmount" CssClass="Currency" runat="server"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblFromPeriod" runat="server" meta:resourcekey="lblFromPeriod" Text="From"></asp:Label></td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlFromPeriod" runat="server" Filter="Contains"
                                        MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" NoWrap="True">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-4 col-4-middle">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblUnitCost" runat="server" meta:resourcekey="lblUnitCost" Text="Unit Cost"></asp:Label></td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtUnitCost" CssClass="Currency" runat="server"></asp:TextBox></td>
                            </tr>

                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblBudgetedQuantity" runat="server" meta:resourcekey="lblBudgetedQuantity" Text="Quantity"></asp:Label></td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtBudgetedQuantity" MinNumber="1" CssClass="Double" runat="server"></asp:TextBox></td>

                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblToPeriod" runat="server" meta:resourcekey="lblToPeriod" Text="To"></asp:Label></td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlToPeriod" runat="server"
                                        Filter="Contains"
                                        MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                        NoWrap="True" AccessibilityMode="True">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div class="col-4 col-4-right">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">

                                    <asp:Label ID="lblCurve" runat="server" meta:resourcekey="lblCurve" Text="Curve"></asp:Label></td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlCurve" runat="server" Filter="Contains"
                                        MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" NoWrap="True">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>


                            <tr>
                                <td class="labelWidth"></td>
                                <td class="controlWidth" align="right">
                                    <asp:Button ID="btnSpread" meta:resourcekey="btnSpread" runat="server" Text="Projection" /></td>
                            </tr>
                        </table>
                    </div>
                </div>

                <div class="row" style="padding-top: 0px; min-width: 100%;">
                    <div class="col-12">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidthChkBox" style="height: auto;">
                                    <asp:Label ID="lblMessage" runat="server" CssClass="Validator"></asp:Label></td>
                            </tr>
                            <tr>
                                <td class="labelWidthChkBox" style="height: auto;">
                                    <asp:Label ID="lblMsgSpread" runat="server" meta:resourcekey="lblMsgSpread"></asp:Label>
                                </td>
                            </tr>
                         </table>
                    </div>                
                </div>                
            </div>
        </div>
        
        <div class="PMMainPage PMPopupMainPage documentSinglePageProjection">
            <div class="row RowWithNoPaddingTop">
                <div class="col-12">
                    <div id="divGrid" style="padding-bottom: 24px;" runat="server">
                        <telerik:RadGrid ID="rdgBudgetCosts" runat="server" Skin="Default" ShowFooter="true" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                            AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="250" setwidth="true" AppendMenus="true"
                            AllowPaging="True" AllowMultiRowEdit="True" AllowMultiRowSelection="True" Width="900px"
                            AllowSorting="True" GridLines="None">
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>

                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" UseAllDataFields="true" TableLayout="Fixed" Width="100%"
                                InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="False">
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="Line #" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Right"
                                        UniqueName="LineNumber" HeaderStyle-Wrap="false" Groupable="false" Reorderable="false" DataField="LineNumber" AllowFiltering="false">
                                        <ItemTemplate>
                                            <%#Container.DataItem("LineNumber").ToString%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <%#Eval("LineNumber").ToString%>
                                        </EditItemTemplate>
                                        <HeaderStyle Wrap="False" Width="99px"></HeaderStyle>

                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Period" Groupable="false" UniqueName="Period" DataField="Period">

                                        <ItemTemplate>
                                            <telerik:RadComboBox
                                                ID="ddlPeriods" runat="server" Height="200px" Skin="Default" Width="100%"
                                                CloseDropDownOnBlur="true" meta:resourcekey="ddlPeriods" EmptyMessage="Select Period..." NoWrap="False"
                                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                OnItemsRequested="ddl_ItemsRequested">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </ItemTemplate>
                                        <HeaderStyle Width="220px"></HeaderStyle>

                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Description" Groupable="false" ItemStyle-Wrap="false" SortExpression="Description"
                                        UniqueName="Description" DataField="Description"
                                        meta:resourcekey="GridTemplateColumn4">
                                        <%--    <ItemTemplate>
                    <%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%>
                </ItemTemplate>--%>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtDescription" MaxLength="200" runat="server" Text='<%# Eval("Description") %>'
                                                Width="100%"></asp:TextBox>
                                        </ItemTemplate>
                                        <HeaderStyle Width="220px"></HeaderStyle>
                                        <ItemStyle Wrap="False"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Quantity" Groupable="false" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right" DataField="Quantity"
                                        SortExpression="Quantity" UniqueName="Quantity">
                                        <%--  <ItemTemplate>
                    <%#FormatNumber(CDbl(Container.DataItem("Quantity")))%>
                </ItemTemplate>--%>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtQuantity" runat="server" Width="100%" MaxLength="15" Text='<%# FormatNumber(CDbl(IIf(Eval("Quantity") Is System.DBNull.Value, 1, Eval("Quantity")))) %>'
                                                CssClass="Double"></asp:TextBox>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lblTotalQuantity" runat="server"></asp:Label>
                                        </FooterTemplate>
                                        <HeaderStyle Width="220px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Unit Cost" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right" DataField="UnitCost"
                                        SortExpression="UnitCost" UniqueName="UnitCost">
                                        <%--    <ItemTemplate>
                    <%#FormatCurrency(CDbl(Container.DataItem("UnitCost")))%>
                </ItemTemplate>--%>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtUnitCost" runat="server" Width="100%" MaxLength="15" Text='<%# FormatCurrency(IIf(Eval("UnitCost") Is System.DBNull.Value, 0, Eval("UnitCost")), CurrencyId:=CurrencyId)%>'
                                                CssClass="Currency"></asp:TextBox>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lblTotalUnitCost" runat="server"></asp:Label>
                                        </FooterTemplate>
                                        <HeaderStyle Width="220px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Total Cost" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right"
                                        SortExpression="TotalAmount" UniqueName="TotalCost" DataField="TotalCost">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtTotalAmount" runat="server" Width="100%" MaxLength="25" Text='<%# FormatCurrency(Eval("TotalAmount"), CurrencyId:=CurrencyId) %>'
                                                CssClass="Currency"></asp:TextBox>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lblTotalOfTotalAmount" runat="server"></asp:Label>
                                        </FooterTemplate>
                                        <HeaderStyle Width="220px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>



                                    <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM" SortExpression="UOM" DataField="UOM">
                                        <%--  <ItemTemplate>
                    <%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%>
                </ItemTemplate>--%>
                                        <ItemTemplate>
                                            <telerik:RadComboBox ID="ddlUOMs" Width="100%" runat="server" Filter="Contains" MarkFirstMatch="true"
                                                Skin="Default" CloseDropDownOnBlur="true" NoWrap="true" AllowCustomText="true"
                                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                OnItemsRequested="ddlUOMs_ItemsRequested" Style="font-size: 11px" Height="150px">
                                            </telerik:RadComboBox>
                                        </ItemTemplate>
                                        <HeaderStyle Width="220px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Notes"
                                        SortExpression="Notes" UniqueName="Notes" DataField="Notes">
                                        <%--  <ItemTemplate>
                    <%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%>
                </ItemTemplate>--%>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>' Width="100%"
                                                MaxLength="200"></asp:TextBox>
                                        </ItemTemplate>
                                        <HeaderStyle Width="220px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <FooterStyle CssClass="GridFooter" />
                                <SortExpressions>
                                    <telerik:GridSortExpression FieldName="LineNumber"></telerik:GridSortExpression>
                                </SortExpressions>
                                <EditFormSettings>
                                    <EditColumn InsertImageUrl="Update.gif" UpdateImageUrl="Update.gif" EditImageUrl="Edit.gif"
                                        CancelImageUrl="Cancel.gif">
                                    </EditColumn>
                                </EditFormSettings>
                                <CommandItemTemplate>
                                    <div style="padding: 2px">
                                        &nbsp;&nbsp;
            <%--    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows"
                    SecurityButtonType="ItemMode_Edit" Visible='<%# rdgBudgetCosts.EditIndexes.Count = 0 AND (Not rdgBudgetCosts.MasterTableView.IsItemInserted) %>'>
                    <img style="border: 0px; vertical-align: middle;" src="Images/Global/EditLine.png" />
                    <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>--%>
                                        <%--<asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited"
                    SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgBudgetCosts.EditIndexes.Count > 0 %>'>
                    <img style="border: 0px; vertical-align: middle;" src="Images/Global/Save.png" />
                    <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>--%>

                                        <%--       <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll"
                    SecurityButtonType="AddEditMode" Visible='<%# rdgBudgetCosts.EditIndexes.Count > 0 Or rdgBudgetCosts.MasterTableView.IsItemInserted %>'>
                    <img style="border: 0px; vertical-align: middle;" src="Images/Global/cancel.png" />
                    <asp:Label ID="lblCancel" runat="server"></asp:Label>
                    &nbsp;&nbsp;
                </asp:LinkButton>--%>
                                        <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                            SecurityButtonType="ItemMode_Add" Visible=''>
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblAddLine" runat="server"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnSave" runat="server" CausesValidation="False" CommandName="Save" CssClass="GridCmdSave">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblSave" runat="server"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="return ConfirmDelete()"
                                            SecurityButtonType="ItemMode_Delete" Visible='<%# rdgBudgetCosts.EditIndexes.Count = 0 And (Not rdgBudgetCosts.MasterTableView.IsItemInserted) %>'
                                            runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>

                                        <asp:LinkButton ID="btnSaveState" Visible="false" runat="server" SecurityButtonType="ItemMode" CausesValidation="False"
                                            CommandName="SaveState">
                                            <asp:Label ID="Label1" runat="server"></asp:Label>
                                            &nbsp;&nbsp;|&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnLoadDefaultState" Visible="false" runat="server" SecurityButtonType="ItemMode"
                                            CausesValidation="False" CommandName="LoadDefaultState">
                                            <asp:Label ID="Label2" runat="server"></asp:Label>
                                        </asp:LinkButton>
                                    </div>
                                </CommandItemTemplate>
                            </MasterTableView>
                            <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" Selecting-AllowRowSelect="true" AllowColumnHide="true" AllowColumnsReorder="true">
                                <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                                <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                    AllowColumnResize="True"></Resizing>
                            </ClientSettings>
                        </telerik:RadGrid>
                        <asp:Button ID="btnClose" meta:resourcekey="btnClose" runat="server" Text="Close" Visible="false" />
                    </div>
                    <div style="width: 100%; overflow: auto;" id="divChart" class="HideOnMobilePopup" runat="server">
                        <telerik:RadChart ID="chrtCashFlow" runat="server" Height="500px" cssclass="chart-width"
                            AutoLayout="True" AutoTextWrap="True" Legend-Visible="false"
                            CreateImageMap="False" IntelligentLabelsEnabled="True" UseSession="False"
                            Legend-Appearance-Dimensions-Width="400px" Skin="LightBlue">
                            <Series>
                                <telerik:ChartSeries Name="">
                                    <Appearance BarWidthPercent="30">
                                        <FillStyle FillType="ComplexGradient" MainColor="162, 215, 125">
                                            <FillSettings>
                                                <ComplexGradient>
                                                    <telerik:GradientElement Color="162, 215, 125" />
                                                    <telerik:GradientElement Color="133, 202, 85" Position="0.5" />
                                                    <telerik:GradientElement Color="112, 182, 57" Position="1" />
                                                </ComplexGradient>
                                            </FillSettings>
                                        </FillStyle>
                                        <TextAppearance TextProperties-Color="112, 93, 56">
                                        </TextAppearance>
                                        <Border Color="83, 162, 37" />
                                    </Appearance>
                                </telerik:ChartSeries>
                                <telerik:ChartSeries Name="" Type="Spline" YAxisType="Secondary">
                                    <Appearance BarWidthPercent="30">
                                        <FillStyle FillType="ComplexGradient" MainColor="235, 132, 100">
                                            <FillSettings>
                                                <ComplexGradient>
                                                    <telerik:GradientElement Color="235, 132, 100" />
                                                    <telerik:GradientElement Color="235, 132, 100" Position="0.5" />
                                                    <telerik:GradientElement Color="235, 132, 100" Position="1" />
                                                </ComplexGradient>
                                            </FillSettings>
                                        </FillStyle>
                                        <TextAppearance TextProperties-Color="112, 93, 56">
                                        </TextAppearance>
                                        <Border Color="235, 132, 100" />
                                    </Appearance>
                                </telerik:ChartSeries>
                            </Series>

                            <PlotArea>
                                <DataTable Visible="true">
                                    <Appearance>
                                        <FillStyle MainColor="255, 255, 238" SecondColor="Transparent">
                                        </FillStyle>
                                        <Border Color="153, 187, 208" />
                                    </Appearance>
                                </DataTable>
                                <XAxis>
                                    <Appearance Color="153, 187, 208" MajorTick-Color="153, 187, 208">
                                        <MajorGridLines Color="153, 187, 208" Width="0" PenStyle="Solid" />
                                        <TextAppearance TextProperties-Color="72, 124, 160">
                                        </TextAppearance>
                                    </Appearance>
                                    <AxisLabel>
                                        <TextBlock>
                                            <Appearance TextProperties-Color="72, 124, 160">
                                            </Appearance>
                                        </TextBlock>
                                    </AxisLabel>
                                </XAxis>
                                <YAxis>
                                    <Appearance Color="112, 182, 57" MajorTick-Color="153, 187, 208"
                                        MinorTick-Color="153, 187, 208">
                                        <MajorGridLines Color="153, 187, 208" />
                                        <MinorGridLines Color="153, 187, 208" />
                                        <TextAppearance TextProperties-Color="112, 182, 57">
                                        </TextAppearance>
                                    </Appearance>
                                    <AxisLabel>
                                        <TextBlock>
                                            <Appearance TextProperties-Color="72, 124, 160">
                                            </Appearance>
                                        </TextBlock>
                                    </AxisLabel>
                                </YAxis>
                                <YAxis2>
                                    <Appearance Color="235, 132, 100">
                                        <TextAppearance TextProperties-Color="235, 132, 100">
                                        </TextAppearance>
                                    </Appearance>
                                </YAxis2>
                                <Appearance Dimensions-Margins="18%, 23%, 12%, 10%">
                                    <FillStyle MainColor="255, 255, 238" SecondColor="Transparent" FillType="Solid">
                                    </FillStyle>
                                    <Border Color="153, 187, 208" />
                                </Appearance>
                            </PlotArea>
                            <Appearance Corners="Round, Round, Round, Round, 7">
                                <FillStyle MainColor="240, 252, 255" FillType="ComplexGradient">
                                    <FillSettings GradientMode="Horizontal">
                                        <ComplexGradient>
                                            <telerik:GradientElement Color="236, 236, 236" />
                                            <telerik:GradientElement Color="248, 248, 248" Position="0.5" />
                                            <telerik:GradientElement Color="236, 236, 236" Position="1" />
                                        </ComplexGradient>
                                    </FillSettings>
                                </FillStyle>
                                <Border Color="182, 224, 249" />
                            </Appearance>
                            <ChartTitle>
                                <Appearance>
                                    <FillStyle MainColor="">
                                    </FillStyle>
                                </Appearance>
                                <TextBlock Text="Cash Flow">
                                    <Appearance TextProperties-Color="8, 103, 166"
                                        TextProperties-Font="Arial, 18pt">
                                    </Appearance>
                                </TextBlock>
                            </ChartTitle>
                            <Legend>
                                <Appearance Corners="Round, Round, Round, Round, 6"
                                    Dimensions-Margins="17%, 3%, 1px, 1px"
                                    Dimensions-Paddings="2px, 8px, 6px, 3px" Position-AlignedPosition="TopRight">
                                    <ItemTextAppearance TextProperties-Color="62, 117, 154">
                                    </ItemTextAppearance>
                                    <ItemMarkerAppearance Figure="Square">
                                        <Border Width="0" />
                                    </ItemMarkerAppearance>
                                    <FillStyle MainColor="">
                                    </FillStyle>
                                    <Border Color="208, 237, 255" Width="0" />
                                </Appearance>
                            </Legend>
                        </telerik:RadChart>
                        <div style="width: 100%; height: 480px; border: 1px solid black; box-sizing: border-box; padding: 20px;" id="divEmpty" runat="server" class="Hide">
                            <asp:Label ID="lblEmptyChart" Text="No Data to Display" meta:resourcekey="lblEmptyChart" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <asp:HiddenField runat="server" ID="hdnopenDiv" Value="" />
    </form>
</body>
    </html>
