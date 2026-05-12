<%@ Page Language="vb" AutoEventWireup="false" meta:resourcekey="Page" CodeBehind="UnitRecap.aspx.vb" Inherits="Website.UnitRecap" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />
    <link href="CSS/Grid.PM.css" rel="stylesheet" type="text/css" />--%>
    <title>Commitment Line Recap</title>
    <style type="text/css">
        .padding {
            padding-left: 24px;
            padding-top: 24px;
            padding-right: 24px;
        }

        .paddingLeft {
            padding-left: 24px;
        }

         @media screen and (min-width:844px) and (max-width:1323px) {
            .padding {
                padding-left: 16px !important;
                padding-top: 24px !important;
                padding-right: 16px !important;
            }

            .paddingLeft {
                padding-left: 16px !important;
            }
        }

        @media screen and (min-width:320px) and (max-width:843px) {
            .padding {
                padding-left: 4px !important;
                padding-top: 24px !important;
                padding-right: 4px !important;
            }
        }
    </style>
</head>

<telerik:RadCodeBlock runat="server" ID="rdc1">
    <script language="javascript" type="text/javascript">
        function rdgUnitRecap_OnRowClick(sender, args) {

            var grid = $("[id$=rdgUnitRecap]");
            var grid1 = $find($("[id$=rdgUnitRecap]")[0].id);
            var disableEvent = "javascript:void(0);";
            var ret = 'true';

            for (var i = 0; i < grid1.MasterTableView.get_selectedItems().length; i++) {
                var row = grid1.MasterTableView.get_selectedItems()[i];
                if ((row.findElement("hdnCanDelete")) && (row.findElement("hdnCanDelete").value == 'False')) {
                    ret = 'false';

                }
            }
            if ($(grid).find("a[id$=btnDelete]").length > 0) {
                if (ret == 'false') {
                    $(grid).find("a[id$=btnDelete]").hide();
                }
                else { $(grid).find("a[id$=btnDelete]").show().removeClass("Hide"); }

            }
        }

    </script>
</telerik:RadCodeBlock>


<body style="background: White !important;">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" DefaultLoadingPanelID="ldpEstimateContracts">
            <AjaxSettings>

                <telerik:AjaxSetting AjaxControlID="rdgUnitRecap">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgUnitRecap" />
                        <telerik:AjaxUpdatedControl ControlID="txtApproved" />
                        <telerik:AjaxUpdatedControl ControlID="txtPending" />
                        <telerik:AjaxUpdatedControl ControlID="txtTotal" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpEstimateContracts" runat="server" Skin="Default" />

        <div class="PMHeader" id="trTbsDetails">
            <div class="row padding">
                <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" HorizontalAlign="NotSet">
                    <div class="col-6" style="width:400px">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth" style="width:160px !important">
                                    <asp:Label ID="lblContract" Text="Contract" runat="server" meta:resourcekey="lblContract"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtContract" runat="server" Width="99%" ReadOnly="True"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblLine" Text="Line #" runat="server" meta:resourcekey="lblLine"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtLine" runat="server" Width="99%" ReadOnly="True"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lbllUOM" Text="Original UOM" runat="server" meta:resourcekey="lbllUOM"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtUOM" runat="server" Width="99%" ReadOnly="True"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-6 paddingLeft" style="width:400px">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth" style="width:160px !important">
                                    <asp:Label ID="lblApproved" Text="Approved" runat="server" meta:resourcekey="lblApproved"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtApproved" CssClass="Double" runat="server" Width="99%"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblPending" Text="Pending" runat="server" meta:resourcekey="lblPending"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtPending" CssClass="Double" runat="server" Width="99%"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblTotal" Text="Total" runat="server" meta:resourcekey="lblTotal"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtTotal" CssClass="Double" runat="server" Width="99%"></asp:TextBox>
                                </td>
                            </tr>

                        </table>
                    </div>
                </telerik:RadAjaxPanel>
                <div class="col-12">
                    <table class="colTable">
                        <tr>
                            <td style="width: 99%;" align="left" valign="top">
                                <telerik:RadGrid Width="99%" ID="rdgUnitRecap" AllowMultiRowSelection="true" runat="server" AllowFilteringByColumn="false" setwidth="true"
                                    ShowGroupPanel="true" HeaderStyle-Font-Size="8"
                                    AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" AllowPaging="true"
                                    PageSize="10">
                                    <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                        CommandItemDisplay="Top" Width="99%"
                                        InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" ShowFooter="true" ShowGroupFooter="true">

                                        <Columns>
                                            <telerik:GridTemplateColumn HeaderText="Record Type" SortExpression="RecordType" DataField="RecordType"
                                                UniqueName="RecordType" GroupByExpression="RecordType [GridColumn_RecordType] Group By RecordType ASC">
                                                <ItemTemplate>
                                                    <%# IIf(Container.DataItem("RecordType") = String.Empty, "&nbsp;", Container.DataItem("RecordType"))%>
                                                    <asp:HiddenField runat="server" ID="hdnCanDelete" Value='<%#Eval("CanDelete").ToString%>' />
                                                </ItemTemplate>
                                                <HeaderStyle Width="50px"></HeaderStyle>
                                                <ItemStyle />
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Record" SortExpression="Record" DataField="Record"
                                                UniqueName="Record" GroupByExpression="Record [GridColumn_Record] Group By Record ASC">
                                                <ItemTemplate>
                                                    <%# IIf(Container.DataItem("Record") = String.Empty, "&nbsp;", Container.DataItem("Record"))%>
                                                    <asp:HiddenField runat="server" ID="hdnRevisedId" Value='<%#Eval("RevisedId").ToString%>' />
                                                </ItemTemplate>
                                                <HeaderStyle Width="120px"></HeaderStyle>
                                                <ItemStyle />
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Date" DataField="RecordDate" SortExpression="RecordDate" GroupByExpression="RecordDate [GridColumn_Date] Group By RecordDate"
                                                UniqueName="Date">
                                                <ItemTemplate>
                                                    <span><%# FormatDate(Container.DataItem("RecordDate"))%> &nbsp;</span>
                                                </ItemTemplate>
                                                <HeaderStyle Wrap="False" Width="70px"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Right" Wrap="false"></ItemStyle>
                                            </telerik:GridTemplateColumn>


                                            <telerik:GridTemplateColumn HeaderText="Line" SortExpression="Line" DataField="Line"
                                                UniqueName="Line" GroupByExpression="Line [GridColumn_Line] Group By Line ASC">
                                                <ItemTemplate>
                                                    <%# IIf(Container.DataItem("Line") = String.Empty, "&nbsp;", Container.DataItem("Line"))%>
                                                </ItemTemplate>
                                                <HeaderStyle Width="120px"></HeaderStyle>
                                                <ItemStyle />
                                            </telerik:GridTemplateColumn>



                                            <telerik:GridTemplateColumn HeaderText="Status" SortExpression="Status" DataField="Status"
                                                UniqueName="Status" GroupByExpression="Status [GridColumn_Status] Group By Status ASC">
                                                <ItemTemplate>
                                                    <%# IIf(Container.DataItem("Status") = String.Empty, "&nbsp;", Container.DataItem("Status"))%>
                                                </ItemTemplate>
                                                <HeaderStyle Width="70px"></HeaderStyle>
                                                <ItemStyle />
                                            </telerik:GridTemplateColumn>



                                            <telerik:GridTemplateColumn HeaderText="Units" UniqueName="Units" DataField="Units" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                                                Groupable="false" Reorderable="false">
                                                <ItemTemplate>
                                                    <span><%# IIf(CDbl(Container.DataItem("Units")) = CInt(Container.DataItem("Units")), FormatNumber(Container.DataItem("Units")), FormatNumber(Container.DataItem("Units"), 5).TrimEnd("0"))%></span>
                                                </ItemTemplate>
                                                <HeaderStyle Width="70px"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Right" />
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Unit Cost" UniqueName="UnitCost" DataField="UnitCost"
                                                Groupable="false" Reorderable="false">
                                                <ItemTemplate>
                                                    <span><%#FormatCurrency(Eval("UnitCost"), CurrencyId:=Eval("CurrencyId"))%></span>
                                                </ItemTemplate>
                                                <HeaderStyle Width="70px"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Right" />
                                            </telerik:GridTemplateColumn>


                                            <telerik:GridTemplateColumn HeaderText="Total Cost" UniqueName="TotalCost" DataField="TotalCost" Aggregate="Sum" FooterAggregateFormatString="{0:F6}"
                                                Groupable="false" Reorderable="false">
                                                <ItemTemplate>
                                                    <span><%#FormatCurrency(Eval("TotalCost"), CurrencyId:=Eval("CurrencyId"))%></span>
                                                </ItemTemplate>
                                                <HeaderStyle Width="70px"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Right" />
                                            </telerik:GridTemplateColumn>


                                            <telerik:GridBoundColumn Aggregate="SUM" DataField="Units" Visible="False" />

                                        </Columns>
                                        <FooterStyle CssClass="GridFooter" />
                                        <CommandItemTemplate>
                                            <table style="padding: 0px; border: 0px transparent none; height: 30px;" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td style="padding-left: 10px;">

                                                        <b>
                                                            <asp:Label ID="lblDisplay" meta:Resourcekey="lblDisplay" Text="Display" runat="server"></asp:Label></b>
                                                    </td>
                                                    <td style="padding-left: 5px;">
                                                        <telerik:RadComboBox ID="ddlStatus" AutoPostBack="true" Width="150px" DropDownWidth="150px" Height="60px" runat="server"
                                                            AllowCustomText="True" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                                                        </telerik:RadComboBox>

                                                    </td>
                                                    <td>
                                                        <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();"
                                                            Visible='<%# rdgUnitRecap.EditIndexes.Count = 0 And (Not rdgUnitRecap.MasterTableView.IsItemInserted) %>'
                                                            SecurityButtonType="ItemMode_Delete" runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows">
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="Label8" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                                        </asp:LinkButton>
                                                    </td>

                                                    <%--          <td style="padding-left:10px;">
                                       <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid"
                                        Visible='<%# rdgUnitRecap.EditIndexes.Count = 0 AND (Not rdgUnitRecap.MasterTableView.IsItemInserted) %>' 
                                        >
                                        <img style="border: 0px; vertical-align: middle;" src="Images/Global/Refresh.png" />
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
                                                </tr>
                                            </table>
                                        </CommandItemTemplate>
                                    </MasterTableView>
                                    <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                    <ItemStyle Wrap="false" />
                                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                                    <ClientSettings EnableRowHoverStyle="True" ClientEvents-OnRowSelected="rdgUnitRecap_OnRowClick" AllowDragToGroup="True" AllowRowsDragDrop="False">
                                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                        <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                            AllowColumnResize="True" />
                                    </ClientSettings>
                                </telerik:RadGrid>

                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

    </form>
</body>
</html>

