<%@ Page Language="vb" AutoEventWireup="false" meta:resourcekey="Page" Title="Link Initiatives" CodeBehind="PlanWorksheetInitiativesPopup.aspx.vb" Inherits="Website.PlanWorksheetInitiativesPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>

<script language="javascript" type="text/javascript">

    function SelectAll(chk) {
        $("#rdgInitiatives").find("input[type='checkbox']").each(function () {
            this.checked = chk.checked;
        });
    }

    function SelectParent(chk) {
        var chkParent = $("#rdgInitiatives").find("input[type='checkbox']")[0];

        var i = 0;
        var isChecked = true;
        $("#rdgInitiatives").find("input[type='checkbox']").each(function () {
            if (i != 0) {
                if (chk.checked) {
                    if (!this.checked) isChecked = false;
                }
            }
            i++;
        });

        if (!chk.checked) {
            chkParent.checked = false;
        } else {
            chkParent.checked = isChecked;
        }


        return false;
    }

</script>
<body>

    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" EnableSkinTransparency="true"
            BackgroundPosition="Center" Skin="Default" />
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" EnablePageHeadUpdate="true"
            DefaultLoadingPanelID="ldpPM">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgInitiatives">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgInitiatives" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>


        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CausesValidation="true" ValidationGroup="Save" EnableImageSprite="true" CssClass="ToolbarSaveAndExit"
                                CommandName="SaveAndExit" Value="SaveAndExit">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>


        <div class="PMMainPage PMPopupMainPage">
            <div class="row">
                <div class="col-4 col-4-left">
                    <table class="colTable" border="0">
                        <tr>
                            <td class="labelWidth" style="width: 160px !important">
                                <asp:Label ID="lblPlanYear" runat="server" meta:resourcekey="lblPlanYear" Text="Plan Year"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtPlanYear" ReadOnly="true" runat="server" Text="" Style="text-align: right;"></asp:TextBox>
                            </td>

                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblPortfolioName" runat="server" meta:resourcekey="lblPortfolioName" Text="Portfolio Name"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtPortfolioName" ReadOnly="true" runat="server" Text=""></asp:TextBox>
                            </td>

                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCurrency" runat="server" meta:resourcekey="lblCurrency" Text="Currency"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtCurrency" ReadOnly="true" runat="server" Text=""></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgInitiatives" AllowMultiRowSelection="false" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" FitPageHeightOffset="1"
                        ShowGroupPanel="true" HeaderStyle-Font-Size="8"
                        AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" AllowPaging="true"
                        PageSize="250">
                        <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>

                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" Width="100%"
                            InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed">
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Select" UniqueName="MasterSelect"
                                    Groupable="false" Reorderable="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkIsIncluded" runat="server" Checked="True"
                                            onclick="SelectParent(this);" />
                                    </ItemTemplate>
                                    <HeaderTemplate>
                                        <asp:Label ID="lblSelect" runat="server" Text="Select" meta:resourcekey="lblSelect"></asp:Label>
                                        <asp:CheckBox ID="chkIsIncluded" runat="server" Checked="True" TextAlign="Left"
                                            onclick="SelectAll(this);" />
                                    </HeaderTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Width="60px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Initiative ID" UniqueName="InitiativeID" SortExpression="InitiativeID"
                                    GroupByExpression="InitiativeID [GridColumn_InitiativeID] Group By InitiativeID ASC">
                                    <ItemTemplate>
                                        <span><%#Eval("InitiativeID").ToString%></span>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="70px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Initiative" UniqueName="Initiative" SortExpression="Initiative"
                                    GroupByExpression="Initiative [GridColumn_Initiative] Group By Initiative ASC">
                                    <ItemTemplate>
                                        <span><%#Eval("Initiative").ToString%></span>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="170px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" SortExpression="Currency"
                                    GroupByExpression="Currency [GridColumn_Currency] Group By Currency">
                                    <ItemTemplate>
                                        <span>
                                            <%#IIf(Eval("Currency") = String.Empty, "&nbsp;", Eval("Currency"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="150px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Type" UniqueName="Type" SortExpression="Type"
                                    GroupByExpression="Type [GridColumn_Type] Group By Type ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Eval("Type") = String.Empty, "&nbsp;", Eval("Type"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="90px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Category" UniqueName="Category" SortExpression="Category"
                                    GroupByExpression="Category [GridColumn_Category] Group By Category ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Eval("Category") = String.Empty, "&nbsp;", Eval("Category"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="90px"></HeaderStyle>
                                </telerik:GridTemplateColumn>


                                <telerik:GridTemplateColumn HeaderText="Funding Year" UniqueName="BudgetYear" SortExpression="BudgetYear"
                                    GroupByExpression="BudgetYear [GridColumn_BudgetYear] Group By BudgetYear ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Eval("BudgetYear") Is System.DBNull.Value, "&nbsp;", Eval("BudgetYear"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="90px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Priority" UniqueName="Priority" SortExpression="Priority"
                                    GroupByExpression="Priority [GridColumn_Priority] Group By Priority ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Eval("Priority") = String.Empty, "&nbsp;", Eval("Priority"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="110px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Sponsor" UniqueName="Sponsor" SortExpression="Sponsor"
                                    GroupByExpression="Sponsor [GridColumn_Sponsor] Group By Sponsor ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Eval("Sponsor") = String.Empty, "&nbsp;", Eval("Sponsor"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="120px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Funding Source" UniqueName="FundingSource" SortExpression="FundingSource"
                                    GroupByExpression="FundingSource [GridColumn_FundingSource] Group By FundingSource ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Eval("FundingSource") = String.Empty, "&nbsp;", Eval("FundingSource"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="120px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Project Manager" UniqueName="ProjectManager" SortExpression="ProjectManager"
                                    GroupByExpression="ProjectManager [GridColumn_ProjectManager] Group By ProjectManager ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Eval("ProjectManager") = String.Empty, "&nbsp;", Eval("ProjectManager"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="120px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Start" UniqueName="Start" DataField="Start" SortExpression="Start"
                                    GroupByExpression="Start [GridColumn_Start] Group By Start ASC">
                                    <ItemTemplate>
                                        <span><%#If(Eval("Start") Is System.DBNull.Value, "&nbsp;", FormatDate(Eval("Start")))%></span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle Width="80px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Finish" UniqueName="Finish" DataField="Finish" SortExpression="Finish"
                                    GroupByExpression="Finish [GridColumn_Finish] Group By Finish ASC">
                                    <ItemTemplate>
                                        <span><%#If(Eval("Finish") Is System.DBNull.Value, "&nbsp;", FormatDate(Eval("Finish")))%></span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle Width="80px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Score" UniqueName="WeightedScore" SortExpression="WeightedScore"
                                    Groupable="false" Reorderable="false">
                                    <ItemTemplate>
                                        <span><%#FormatNumber(Eval("WeightedScore"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="80px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Total" UniqueName="Total" SortExpression="Total"
                                    Groupable="false" Reorderable="false">
                                    <ItemTemplate>
                                        <span><%#FormatCurrency(Container.DataItem("Total"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="110px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>

                            </Columns>
                            <FooterStyle CssClass="GridFooter" />
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    &nbsp;&nbsp;
                                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="Undo" CssClass="GridCmdUndo"
                                                    Visible='<%# rdgInitiatives.EditIndexes.Count = 0 And (Not rdgInitiatives.MasterTableView.IsItemInserted) %>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblUndo" runat="server"></asp:Label>
                                                </asp:LinkButton>
                                </div>
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
        </div>
    </form>
</body>
</html>
