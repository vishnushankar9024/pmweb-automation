<%@ Page Language="vb" Title="Production" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="ProductionPopup.aspx.vb" Inherits="Website.ProductionPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>

<script language="javascript" type="text/javascript">


    function SelectParent(chk) {
        var chkParent = $("#rdgCommitmentCOs").find("input[type='checkbox']")[0];


        $("#rdgCommitmentCOs").find("input[type='checkbox']").each(function () {
            if (chk.id != this.id) {
                if (this.checked) {
                    this.checked = false;
                }
            }

        });



        return false;
    }

    function LoadTd() {
        var tds = document.querySelectorAll('.controlWidth');
        var arrTd = Array.prototype.slice.call(tds);
        for (var i = 0; i < arrTd.length; i++) {
            if (arrTd[i].innerHTML.trim() === "")
                arrTd[i].parentElement.style.display = 'none';
        }
        return false;
    }

</script>
<body onload="return LoadTd()">

    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" EnableSkinTransparency="true"
            BackgroundPosition="Center" Skin="Default" />
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" EnablePageHeadUpdate="true"
            DefaultLoadingPanelID="ldpPM">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgCommitmentCOs">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgCommitmentCOs" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage PMPopupMainPage">
            <div class="row documentSinglePage">
                <div class="col-4 col-4-left">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblProject" runat="server" meta:resourcekey="lblProject" Text="Project"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtProject" runat="server" ReadOnly="true"  Text="" Width="100%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCommitment" runat="server" meta:resourcekey="lblCommitment" Text="Contract"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtCommitment" runat="server" ReadOnly="true"  Text="" Width="100%" ></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCompany" runat="server" meta:resourcekey="lblCompany" Text="Company"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtCompany" ReadOnly="true"  runat="server" Text="" Width="100%"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-4 col-4-right">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblInvoiceNumber" runat="server" meta:resourcekey="lblInvoiceNumber" Text="Invoice #"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtInvoiceNumber" runat="server" ReadOnly="true" Width="100%" style="text-align:right"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDescription" runat="server" meta:resourcekey="lblDescription" Text="Description"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtDescription" runat="server" ReadOnly="true" Width="100%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDate" runat="server" meta:resourcekey="lblDate" Text="Invoice Date"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtDate" runat="server" ReadOnly="true" Width="100%" style="text-align:right"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid CssClass="ResponsiveMargin" ID="rdgCommitmentCOs" AllowMultiRowSelection="false" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                        ShowGroupPanel="true" HeaderStyle-Font-Size="8" FitPageHeightOffset="24"
                        AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" AllowPaging="true"
                        PageSize="250">
                        <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" Width="100%"
                            InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed">

                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Select" UniqueName="MasterSelect"
                                    Groupable="false" Reorderable="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkIsIncluded" runat="server" Checked="False"
                                            onclick="SelectParent(this);" />
                                    </ItemTemplate>

                                    <HeaderStyle HorizontalAlign="Center" Width="50px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </telerik:GridTemplateColumn>


                                <telerik:GridTemplateColumn HeaderText="Production" UniqueName="Production"
                                    GroupByExpression="Production [GridColumn_Production] Group By Production ASC">
                                    <ItemTemplate>
                                        <span><%# IIf(Eval("Production") = String.Empty, "&nbsp;", Eval("Production"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="150px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Production #" UniqueName="ProductionNumber"
                                    GroupByExpression="ProductionNumber [GridColumn_ProductionNumber] Group By ProductionNumber ASC">
                                    <ItemTemplate>
                                        <span><%# Eval("ProductionNumber").ToString%></span>&nbsp;
                                    </ItemTemplate>
                                     <ItemStyle HorizontalAlign="right"></ItemStyle>
                                    <HeaderStyle Width="50px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="From" SortExpression="FromDate" GroupByExpression="FromDate [GridColumn_FromDate] Group By FromDate"
                                    UniqueName="FromDate">
                                    <ItemTemplate>
                                        <span><%# FormatDate(Container.DataItem("FromDate"))%> &nbsp;</span>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="70px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" Wrap="false"></ItemStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="To" SortExpression="ToDate" GroupByExpression="ToDate [GridColumn_ToDate] Group By ToDate"
                                    UniqueName="ToDate">
                                    <ItemTemplate>
                                        <span><%# FormatDate(Container.DataItem("ToDate"))%> &nbsp;</span>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="70px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right" Wrap="false"></ItemStyle>
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <FooterStyle CssClass="GridFooter" />
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    &nbsp;&nbsp;
                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="Undo" CssClass="GridCmdUndo"
                                        Visible='<%# rdgCommitmentCOs.EditIndexes.Count = 0 And (Not rdgCommitmentCOs.MasterTableView.IsItemInserted) %>'>
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

