<%@ Page Title="Funding Selector" meta:resourcekey="Page" Language="vb" AutoEventWireup="true" CodeBehind="FundingSelectorPopup.aspx.vb" Inherits="Website.FundingSelectorPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<script language="javascript" type="text/javascript">



    var OldAmountVal = 0;
    function AdjustCostCalculation(gridId) {
        var grid = $("#" + gridId);

        $("input[id*=" + gridId + "][id$=txtAmount]").change(function () {
            var me = $(this);
            var row = me.parents("tr:first");
            var NewAmountVal = CDbl(me.val());

            var total = CDbl($("input[id$=txtTotalAuthorized]").val());
            var fundedAmount = CDbl(row.find("input[id$='hdnFunded']").val());
            var txtPercent = row.find("input[id$=txtPercent]")

            txtPercent.val(CPrct((NewAmountVal * 1.0 / fundedAmount) * 100));


            total = total + NewAmountVal - OldAmountVal;
            $("input[id$=txtTotalAuthorized]").val(CCur(total));

        }
    ).focus(function () {
        OldAmountVal = CDbl($(this).val());

    }
   );
        $("input[id*=" + gridId + "][id$=txtPercent]").change(function () {
            var me = $(this);
            var row = me.parents("tr:first");

            var txtAmount = row.find("input[id$=txtAmount]")
            var fundedAmount = CDbl(row.find("input[id$='hdnFunded']").val());
            var oldAmount = CDbl(txtAmount.val());
            var percent = CDbl(me.val());
            var total = CDbl($("input[id$=txtTotalAuthorized]").val());

            var newAmount = (percent / 100.00) * fundedAmount;
            txtAmount.val(CCur(newAmount));

            total = total + newAmount - oldAmount;
            $("input[id$=txtTotalAuthorized]").val(CCur(total));


        });
    }
</script>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" EnableSkinTransparency="true"
            BackgroundPosition="Center" Skin="Default" />
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" EnablePageHeadUpdate="true">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgFundingLines">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgFundingLines" LoadingPanelID="ldpPM" />
                        <telerik:AjaxUpdatedControl ControlID="txtTotalAuthorized" />
                    </UpdatedControls>

                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCheck" ValidationGroup="Save" CommandName="Save">
                                        </telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel">
                                        </telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <div class="PMMainPage PMPopupMainPage documentSinglePage" style="margin-bottom:0 !important">
            <div class="row">
                <div class="col-4">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblProject" runat="server" meta:resourcekey="lblProject" Text="Project"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:Label ID="lblProjectText" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgFundingLines" AllowMultiRowSelection="false" runat="server" AllowFilteringByColumn="false" Width="100%" AppendMenus="true"
                        ShowGroupPanel="true" HeaderStyle-Font-Size="8" SetWidth="true" FitParentContainer="true" ClientSettings-Scrolling-AllowScroll="true"
                        AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" AllowPaging="true" FitPageHeightOffset="64"
                        PageSize="250">
                        <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="UniqueKey" ClientDataKeyNames="UniqueKey" CommandItemDisplay="Top" Width="100%"
                            InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" ShowFooter="true" ShowGroupFooter="true">

                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="%" UniqueName="Percent"
                                    Groupable="false" Reorderable="false" DataField="Percent">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtPercent" runat="server" Width="100%" Text='<%# FormatPercent(Container.DataItem("Percent")) %>'
                                            CssClass="Percent"></asp:TextBox>
                                    </ItemTemplate>

                                    <HeaderStyle HorizontalAlign="Center" Width="55px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Amount" UniqueName="Amount" DataField="Amount"
                                    Groupable="false" Reorderable="false">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hdnFunded" runat="server" Value='<%#FormatCurrency(Eval("Funded"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>' />
                                        <asp:TextBox ID="txtAmount" runat="server" Width="100%" MaxLength="15" Text='<%# FormatCurrency(Container.DataItem("Amount"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>'
                                            CssClass="Currency"></asp:TextBox>

                                    </ItemTemplate>
                                    <HeaderStyle Width="80px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Funding #" UniqueName="FundingNumber" SortExpression="FundingNumber" DataField="FundingNumber"
                                    GroupByExpression="FundingNumber [GridColumn_FundingNumber] Group By FundingNumber ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("FundingNumber").ToString = String.Empty, "&nbsp;", Container.DataItem("FundingNumber"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="70px"></HeaderStyle>
                                    <ItemStyle />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" DataField="LineNumber" AllowFiltering="false"
                                    HeaderStyle-Wrap="false" GroupByExpression="LineNumber [GridColumn_LineNumber] Group By LineNumber ASC" Reorderable="false">
                                    <ItemTemplate>
                                        <%#Container.DataItem("LineNumber").ToString%>
                                    </ItemTemplate>
                                    <HeaderStyle Width="50px" />
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>


                                <telerik:GridTemplateColumn HeaderText="Year" UniqueName="Year" SortExpression="Year" DataField="Year"
                                    GroupByExpression="Year [GridColumn_Year] Group By Year ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("Year").ToString = "0", "&nbsp;", Container.DataItem("Year"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="50px"></HeaderStyle>
                                    <ItemStyle />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Project" UniqueName="ProjectFullName" SortExpression="ProjectFullName" DataField="ProjectFullName"
                                    GroupByExpression="ProjectFullName [GridColumn_Project] Group By ProjectFullName ASC">
                                    <ItemTemplate>
                                        <%#IIf(Container.DataItem("ProjectFullName") = String.Empty, PM.LanguagesInfo.GlobalResource("Portfolio"), Container.DataItem("ProjectFullName"))%>
                                    </ItemTemplate>
                                    <HeaderStyle Width="150px"></HeaderStyle>
                                    <ItemStyle />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Source" SortExpression="FundingSourceText" DataField="FundingSourceText"
                                    UniqueName="FundingSource" GroupByExpression="FundingSourceText [GridColumn_FundingSource] Group By FundingSourceText ASC">
                                    <ItemTemplate>
                                        <%#IIf(Container.DataItem("FundingSourceText") = String.Empty, "&nbsp;", Container.DataItem("FundingSourceText"))%>
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                    <ItemStyle />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Code" SortExpression="Code"
                                    UniqueName="Code" GroupByExpression="Code [GridColumn_Code] Group By Code ASC" DataField="Code">
                                    <ItemTemplate>
                                        <%#IIf(Container.DataItem("Code") = String.Empty, "&nbsp;", Container.DataItem("Code"))%>
                                    </ItemTemplate>
                                    <HeaderStyle Width="70px"></HeaderStyle>
                                    <ItemStyle />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Funded" UniqueName="Funded" DataField="Funded" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                                    Groupable="false" Reorderable="false">
                                    <ItemTemplate>
                                        <span><%#FormatCurrency(Eval("Funded"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="80px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Authorized" UniqueName="Authorized" DataField="Authorized" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                                    Groupable="false" Reorderable="false">
                                    <ItemTemplate>
                                        <span><%#FormatCurrency(Eval("Authorized"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="80px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Balance" UniqueName="Balance" DataField="Balance" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                                    Groupable="false" Reorderable="false">
                                    <ItemTemplate>
                                        <span><%#FormatCurrency(Eval("Balance"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="80px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn Aggregate="SUM" DataField="Authorized" Visible="False" />

                            </Columns>
                            <FooterStyle CssClass="GridFooter" />
                            <CommandItemTemplate>
                                <table style="padding: 0px; border: 0px transparent none; height: 30px;" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="padding-left: 5px;">
                                            <b>
                                                <asp:Label ID="lblFilterBy" meta:Resourcekey="lblFilterBy" Text="Filter by" runat="server"></asp:Label></b>
                                        </td>
                                        <td style="padding-left: 5px;">
                                            <telerik:RadComboBox ID="ddlEntities" AutoPostBack="true" Width="150px" DropDownWidth="150px" Height="100px" runat="server"
                                                AllowCustomText="True" OnSelectedIndexChanged="ddlEntities_SelectedIndexChanged">
                                            </telerik:RadComboBox>

                                        </td>

                                        <td style="padding-left: 10px;">
                                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                                Visible='<%# rdgFundingLines.EditIndexes.Count = 0 And (Not rdgFundingLines.MasterTableView.IsItemInserted) %>'>
                                                <span class="Icon"></span>
                                                <asp:Label ID="lblUndo" runat="server"></asp:Label>
                                            </asp:LinkButton>
                                            <%--   &nbsp;&nbsp;
                                     <asp:LinkButton ID="btnSaveState" runat="server" SecurityButtonType="ItemMode" CausesValidation="False"
                                        CommandName="SaveState" Visible='true'>
                                        <asp:Label ID="Label2" runat="server"></asp:Label>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode"
                                        CausesValidation="False" CommandName="LoadDefaultState" Visible='true'>
                                        &nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label ID="Label3" runat="server"></asp:Label>
                                    </asp:LinkButton>--%>
                                        </td>
                                    </tr>
                                </table>
                            </CommandItemTemplate>
                        </MasterTableView>
                        <HeaderStyle Font-Size="8pt"></HeaderStyle>
                        <ItemStyle Wrap="false" />
                        <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                        <ClientSettings EnableRowHoverStyle="False" AllowDragToGroup="True" AllowRowsDragDrop="False">
                            <Selecting AllowRowSelect="False" EnableDragToSelectRows="False" />
                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                AllowColumnResize="True" />
                        </ClientSettings>
                    </telerik:RadGrid>
                </div>
            </div>
            <div class="row">
                <div class="col-4">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblTotalAuthorized" runat="server" meta:resourcekey="lblTotalAuthorized" Text="Total Authorized"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtTotalAuthorized" CssClass="Double" runat="server" Text=""></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
