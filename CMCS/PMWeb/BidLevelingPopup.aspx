<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="BidLevelingPopup.aspx.vb" Inherits="Website.BidLevelingPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Charting" TagPrefix="telerik" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">



<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />

</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadCodeBlock runat="server">
            <script type="text/javascript">
                var OldQuantityVal = 0;
                var OldUnitCostVal = 0;
                var OldTotalCostVal = 0;

                function AdjustCostCalculation(gridId) {
                    var grid = $("#" + gridId);
                    // On change Unit Cost
                    $("input[id*=" + gridId + "][id$=txtUnitCost]").change(function () {
                        var row = $(this).parents("tr:first"); Calculate(row, "UnitCost");
                    }
                ).focus(function () {
                    OldUnitCostVal = $(this).val();
                }
                );

                    // On change quantity
                    $("input[id*=" + gridId + "][id$=txtQuantity]").change(function () {
                        var row = $(this).parents("tr:first"); Calculate(row, "Quantity");
                    }
                ).focus(function () {
                    OldQuantityVal = $(this).val();
                }
                );

                    $("input[id*=" + gridId + "][id$=txtLeveledAmount]").change(function () {
                        var row = $(this).parents("tr:first"); Calculate(row, "LeveledAmount");
                    }
                        ).focus(function () {
                            OldQuantityVal = $(this).val();
                        }
                        );


                }
                function pageLoad() {
                    //   adjustChartImage()
                }
                var MasterRtime;
                var MasterRTimeout = false;
                var MasterRDelta = 100;
                $(window).resize(function () {
                    MasterRtime = new Date();
                    if (MasterRTimeout == false) {
                        MasterRTimeout = true;
                        setTimeout(MasterWindowResizeEnd, MasterRDelta);
                    }
                });

                function MasterWindowResizeEnd() {
                    if (new Date() - MasterRtime < MasterRDelta) {
                        setTimeout(MasterWindowResizeEnd, MasterRDelta);
                    } else {
                        MasterRTimeout = false;

                        // adjustChartImage()

                    }
                }
                function adjustChartImage() {
                    var chart = $get("<%=chrtCashFlow.ClientID%>");
                    var chartImg = chart.getElementsByTagName("img")[0];
                    chart.style.width = (document.documentElement.clientWidth - 24) + "px";
                    chartImg.setAttribute("width", (document.documentElement.clientWidth - 24) + "px");

                }

                function Calculate(row, sender) {
                    var txtLeveledAmount = row.find("input[id$='txtLeveledAmount']");
                    var LeveledAmountVal = txtLeveledAmount.val();

                    var txtQuantity = row.find("input[id$='txtQuantity']");
                    var QantityVal = txtQuantity.val();
                    var txtUnitCost = row.find("input[id$='txtUnitCost']");
                    var UnitCostVal = txtUnitCost.val();





                    if (sender == "UnitCost" || sender == "Quantity") {
                        txtLeveledAmount.val(CCur(CDbl(UnitCostVal) * CDbl(QantityVal)));

                    }
                    if (sender == "LeveledAmount") {
                        if (QantityVal == 0) {
                            txtLeveledAmount.val(CCur(0));
                            txtUnitCost.val(CCur(0));
                        }
                        else {
                            txtUnitCost.val(CCur(CDbl(LeveledAmountVal) / CDbl(QantityVal)));
                        }

                    }

                }
            </script>
        </telerik:RadCodeBlock>
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgBidLeveling">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgBidLeveling" LoadingPanelID="ldpCostCodes" />
                        <telerik:AjaxUpdatedControl ControlID="txtLeveledUOM" />
                        <telerik:AjaxUpdatedControl ControlID="txtLeveledQuantity" />
                        <telerik:AjaxUpdatedControl ControlID="txtLeveledUnitPrice" />
                        <telerik:AjaxUpdatedControl ControlID="txtLeveledTotal" />

                    </UpdatedControls>
                </telerik:AjaxSetting>

            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpCostCodes" runat="server" Skin="Default" />

        <div class="PMMainPage PMPopupMainPage">
            <div class="row R3Cols">
                <div class="col-4 col-4-left">
                    <fieldset>
                        <legend>
                            <asp:Label ID="lblEstimated" runat="server" meta:resourcekey="lblEstimated" Text="Estimated"></asp:Label></legend>
                        <table width="100%" class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblEstimatedUOM" runat="server" Text="UOM" meta:resourcekey="lblUOM"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtEstimatedUOM" runat="server" Enabled="false"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblEstimatedQuantity" runat="server" Text="Quantity" meta:resourcekey="lblQuantity"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtEstimatedQuantity" CssClass="Double" runat="server" MaxLength="15" Enabled="false"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblEstimatedUnitPrice" runat="server" Text="Unit Price" meta:resourcekey="lblUnitPrice"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtEstimatedUnitPrice" CssClass="Currency" runat="server" MaxLength="15" Enabled="false"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblEstimatedTotal" runat="server" Text="Estimated Total" meta:resourcekey="lblEstimatedTotal"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtEstimatedTotal" CssClass="Currency" runat="server" MaxLength="15" Enabled="false"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </div>
                <div class="col-4 col-4-middle">
                    <fieldset>
                        <legend>
                            <asp:Label ID="Label1" runat="server" meta:resourcekey="lblBid" Text="Bid"></asp:Label></legend>
                        <table width="100%" class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblBidUOM" runat="server" Text="UOM" meta:resourcekey="lblUOM"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtBidUOM" runat="server" Enabled="false"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblBidQuantity" runat="server" Text="Quantity" meta:resourcekey="lblQuantity"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtBidQuantity" CssClass="Double" runat="server" MaxLength="15" Enabled="false"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblBidUnitPrice" runat="server" Text="Unit Price" meta:resourcekey="lblUnitPrice"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtBidUnitPrice" CssClass="Currency" runat="server" MaxLength="15" Enabled="false"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblBidTotal" runat="server" Text="Bid Total" meta:resourcekey="lblBidTotal"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtBidTotal" CssClass="Currency" runat="server" MaxLength="15" Enabled="false"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </div>
                <div class="col-4 col-4-right">
                    <fieldset>
                        <legend>
                            <asp:Label ID="lblLeveled" runat="server" meta:resourcekey="lblLeveled" Text="Leveled"></asp:Label></legend>
                        <table width="100%" class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblLeveledUOM" runat="server" Text="UOM" meta:resourcekey="lblUOM"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtLeveledUOM" runat="server" Enabled="false"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblLeveledQuantity" runat="server" Text="Quantity" meta:resourcekey="lblQuantity"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtLeveledQuantity" CssClass="Double" runat="server" MaxLength="15" Enabled="false"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblLeveledUnitPrice" runat="server" Text="Unit Price" meta:resourcekey="lblUnitPrice"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtLeveledUnitPrice" CssClass="Currency" runat="server" MaxLength="15" Enabled="false"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblLeveledTotal" runat="server" Text="Leveled Total" meta:resourcekey="lblLeveledTotal"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtLeveledTotal" CssClass="Currency" runat="server" MaxLength="15" Enabled="false"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </div>
            </div>

            <div class="PMHeader">
                <div class="row">
                    <div class="col-12">
                        <telerik:RadGrid ID="rdgBidLeveling" runat="server" AutoGenerateColumns="False" ShowStatusBar="True" SetWidth="true" AppendMenus="true" FitParentContainer="true"
                            Font-Size="8px" PageSize="250" ShowFooter="true" AllowPaging="True" ShowGroupPanel="False" AllowMultiRowEdit="true" Width="100%"
                            AllowMultiRowSelection="True" AllowSorting="True" GridLines="None" UseEditFormInMobile="true">
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                            <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>

                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
                                Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true">

                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="Line" ItemStyle-HorizontalAlign="Right" SortExpression="LineNumber" Groupable="false" DataField="LineNumber">
                                        <ItemTemplate>
                                            <span><%#Container.DataItem("LineNumber").ToString%></span>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <span><%#Eval("LineNumber").ToString%></span>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="110px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" SortExpression="Description" DataField="Description" Groupable="false">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtDescription" MaxLength="500" Width="100%" runat="server" Text='<%#Eval("Description")%>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="150px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM" SortExpression="UOM" DataField="UOM" Groupable="false">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadComboBox ID="ddlUOMs" runat="server" Width="100%"></telerik:RadComboBox>
                                        </EditItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lblTotal" Text="Total" runat="server" meta:resourcekey="lblTotal"></asp:Label>
                                        </FooterTemplate>
                                        <HeaderStyle Width="110px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Quantity" UniqueName="Quantity" ItemStyle-HorizontalAlign="Right" SortExpression="Quantity" DataField="Quantity" Groupable="false">
                                        <ItemTemplate>
                                            <span><%#FormatNumber(Container.DataItem("Quantity"))%></span>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtQuantity" runat="server" Width="100%" CssClass="Double" MaxLength="15" Text='<%#FormatNumber(IIf(Eval("Quantity") Is System.DBNull.Value, "1", Eval("Quantity"))) %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="110px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Unit Cost" UniqueName="UnitCost" SortExpression="UnitCost" DataField="UnitCost" Groupable="false">
                                        <ItemTemplate>
                                            <span><%#FormatCurrency(Container.DataItem("UnitCost"), CurrencyId:=PM.Estimate.BidderInfo.LevelCurrencyId)%></span>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtUnitCost" CssClass="Currency" runat="server" Width="100%" MaxLength="15" Text='<%# FormatCurrency(Eval("UnitCost"), CurrencyId:=PM.Estimate.BidderInfo.LevelCurrencyId)%>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="110px"></HeaderStyle>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Leveled Amount" UniqueName="LeveledAmount" ItemStyle-HorizontalAlign="Right" Groupable="false" SortExpression="LeveledAmount" DataField="LeveledAmount" Aggregate="Sum" FooterAggregateFormatString="{0:F6}">
                                        <ItemTemplate>
                                            <asp:Label Text='<%#FormatCurrency(Eval("LeveledAmount"), CurrencyId:=PM.Estimate.BidderInfo.LevelCurrencyId)%>' runat="server" ID="lblLeveledAmount" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtLeveledAmount" CssClass="Currency" runat="server" Width="100%" MaxLength="15" Text='<%#FormatCurrency(Eval("LeveledAmount"), CurrencyId:=PM.Estimate.BidderInfo.LevelCurrencyId)%>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                        <FooterTemplate>
                                            <asp:Label ID="lblSumLeveledAmount" runat="server"></asp:Label>
                                        </FooterTemplate>
                                        <HeaderStyle Width="110px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn HeaderText="Notes" SortExpression="Notes" UniqueName="Notes" DataField="Notes" Groupable="false">
                                        <ItemTemplate>
                                            <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>' Width="80%" MaxLength="4000"></asp:TextBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="200px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <ItemStyle Wrap="false" />
                                <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                                <FooterStyle CssClass="GridFooter" />

                                <CommandItemTemplate>
                                    <div style="padding: 2px">
                                        &nbsp;&nbsp; 
                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows" SecurityButtonType="ItemMode_Edit"
                                    Visible='<%# rdgBidLeveling.EditIndexes.Count = 0 And (Not rdgBidLeveling.MasterTableView.IsItemInserted) %>'
                                    meta:resourcekey="btnEditSelectedResource1">
                                    <span class="Icon"></span>
                                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                    &nbsp;&nbsp;
                                </asp:LinkButton>
                                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" SecurityButtonType="AddEditMode_Edit"
                                            Visible='<%# rdgBidLeveling.EditIndexes.Count > 0 %>' meta:resourcekey="btnUpdateEditedResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnSave" runat="server" CausesValidation="False" CommandName="PerformInsert" CssClass="GridCmdPerformInsert" SecurityButtonType="AddEditMode_Add"
                                            Visible='<%# rdgBidLeveling.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll" SecurityButtonType="AddEditMode"
                                            Visible='<%# rdgBidLeveling.EditIndexes.Count > 0 Or rdgBidLeveling.MasterTableView.IsItemInserted %>'
                                            meta:resourcekey="btnCancelResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow" SecurityButtonType="ItemMode_Add"
                                            Visible='<%# rdgBidLeveling.EditIndexes.Count = 0 And (Not rdgBidLeveling.MasterTableView.IsItemInserted) %>'
                                            meta:resourcekey="btnAddResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" SecurityButtonType="ItemMode_Delete"
                                            Visible='<%# rdgBidLeveling.EditIndexes.Count = 0 And (Not rdgBidLeveling.MasterTableView.IsItemInserted) %>'
                                            runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid" SecurityButtonType="ItemMode"
                                            Visible='<%# rdgBidLeveling.EditIndexes.Count = 0 And (Not rdgBidLeveling.MasterTableView.IsItemInserted) %>'
                                            meta:resourcekey="btnRefreshResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>

                                        </span>
                                    </div>
                                </CommandItemTemplate>
                            </MasterTableView>
                            <ClientSettings AllowColumnHide="true" AllowColumnsReorder="false" AllowDragToGroup="false">
                                <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                    AllowColumnResize="True" />
                                <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
                            </ClientSettings>
                        </telerik:RadGrid>
                    </div>
                </div>

                <div class="row">
                    <div class="col-12">
                        <div style="width: 100%; overflow: auto; max-width: calc(100vw - 40px)">
                            <telerik:RadChart ID="chrtCashFlow" runat="server" Width="950px" Height="500px"
                                AutoLayout="True" AutoTextWrap="True" Legend-Visible="false"
                                CreateImageMap="False" IntelligentLabelsEnabled="True" UseSession="False"
                                Skin="LightBlue">
                            </telerik:RadChart>
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </form>
</body>
</html>
