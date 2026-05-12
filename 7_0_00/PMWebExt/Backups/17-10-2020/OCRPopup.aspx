<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="OCRPopup.aspx.vb" Inherits="Website.OCRPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" EnableSkinTransparency="true"
            BackgroundPosition="Center" Skin="Default" />
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" EnablePageHeadUpdate="true"
            DefaultLoadingPanelID="ldpPM">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgLinkOCR">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgLinkOCR" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <script src="JS/Costs/OCRPopup.js" type="text/javascript"></script>


        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="220px" CssClass="popup-toolbar">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>


        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row">
                <div class="col-4">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblProject" runat="server" meta:resourcekey="lblProject" Text="Project"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtProject" runat="server" Enabled="false" Text=""></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCommitment" runat="server" meta:resourcekey="lblCommitment" Text="Commitment"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtCommitment" runat="server" Enabled="false" Text=""></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCompany" runat="server" meta:resourcekey="lblCompany" Text="Company"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtCompany" runat="server" Enabled="false" Text=""></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblChangeOrderNumber" runat="server" meta:resourcekey="lblChangeOrderNumber" Text="Change Order #"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtChangeOrder" runat="server" Enabled="false" ReadOnly="true"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDescription" runat="server" meta:resourcekey="lblDescription" Text="Description"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtDescription" Enabled="false" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblChangeOrderDate" runat="server" meta:resourcekey="lblChangeOrderDate" Text="Change Order Date"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtChangeOrderDate" Enabled="false" runat="server" ReadOnly="true"  style="text-align:right"></asp:TextBox>
                            </td>
                        </tr>   
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="lblCostCodeRequired" Visible="false" runat="server" CssClass="Validator" meta:Resourcekey="lblCostCodeRequired"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row"> 
                <div class="col-12">
                    <telerik:RadGrid ID="rdgLinkOCR" AllowMultiRowSelection="false" runat="server" Width="100%" FitPageHeightOffset="24"
                        ShowGroupPanel="true" HeaderStyle-Font-Size="8" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                        AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="false" PageSize="1">
                        <HeaderContextMenu EnableViewState="false">
                        </HeaderContextMenu>
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="None" Width="100%"
                            InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" Name="Master">
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                            <ExpandCollapseColumn Visible="True">
                            </ExpandCollapseColumn>
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Select" HeaderStyle-Width="40px" UniqueName="MasterSelect"
                                    HeaderStyle-Wrap="false" Groupable="false" Reorderable="false">
                                    <ItemTemplate>
                                        <asp:CheckBox runat="server" ID="chkMasterSelect" />
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="40px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Status" UniqueName="Status"
                                    GroupByExpression="Status [GridColumn_Status] Group By Status ASC" ItemStyle-CssClass="NoWrap"
                                    HeaderStyle-Wrap="false" Groupable="true" Reorderable="false">
                                    <ItemTemplate>
                                        <%#Container.DataItem("Status").ToString%>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="120px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="OCR #" ItemStyle-CssClass="NoWrap"
                                    UniqueName="OCRNumber" GroupByExpression="OCRNumber [GridColumn_OCRNumber] Group By OCRNumber ASC"
                                    HeaderStyle-Wrap="false" Groupable="true" Reorderable="false">
                                    <ItemTemplate>
                                        <%#Container.DataItem("OCRNumber").ToString%>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Description" GroupByExpression="Description [GridColumn_Description] Group By Description ASC"
                                    UniqueName="Description">
                                    <ItemTemplate>
                                        <%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%>
                                    </ItemTemplate>
                                    <HeaderStyle Width="255px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Requested Date" ItemStyle-HorizontalAlign="Right" UniqueName="RequestedDate"
                                    GroupByExpression="RequestedDate [GridColumn_RequestedDate] Group By RequestedDate ASC"
                                    HeaderStyle-Wrap="false" Groupable="true" Reorderable="false">
                                    <ItemTemplate>
                                        <%#FormatDate(Container.DataItem("RequestedDate"))%>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Needed By" UniqueName="NeededBy" ItemStyle-HorizontalAlign="Right"
                                    GroupByExpression="NeededBy [GridColumn_NeededBy] Group By NeededBy ASC" HeaderStyle-Wrap="false"
                                    Groupable="true" Reorderable="false">
                                    <ItemTemplate>
                                        <%#FormatDate(Container.DataItem("NeededBy"))%>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Cause" UniqueName="Cause" HeaderStyle-HorizontalAlign="Center"
                                    HeaderStyle-Wrap="false" HeaderStyle-Width="100px" GroupByExpression="Cause [GridColumn_Cause] Group By Cause ASC">
                                    <ItemTemplate>
                                        <%#Container.DataItem("Cause")%>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Width="20%"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <FooterStyle CssClass="GridFooter" />
                            <DetailTables>
                                <telerik:GridTableView SkinID="PM" ShowHeader="True" ShowStatusBar="false" CommandItemDisplay="None"
                                    AllowSorting="false" DataKeyNames="Id,ChangeRequestId" Width="100%" EditMode="InPlace"
                                    Name="OCRDetails">
                                    <ParentTableRelation>
                                        <telerik:GridRelationFields DetailKeyField="ChangeRequestId" MasterKeyField="Id" />
                                    </ParentTableRelation>
                                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_DetailSelect %>"
                                            HeaderStyle-Width="40px" UniqueName="DetailSelect" HeaderStyle-Wrap="false" Groupable="false"
                                            Reorderable="false">
                                            <ItemTemplate>
                                                <asp:CheckBox runat="server" ID="chkDetailSelect" />
                                            </ItemTemplate>
                                            <HeaderStyle Wrap="False" Width="40px"></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_LineNumber %>" HeaderStyle-HorizontalAlign="Center"
                                            Groupable="false" UniqueName="LineNumber" SortExpression="LineNumber"
                                            GroupByExpression="LineNumber [LineNumber] Group By LineNumber ASC">
                                            <ItemTemplate>
                                                <%#IIf(CStr(Eval("LineNumber")) = String.Empty, "&nbsp;", Eval("LineNumber").ToString)%>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" Width="90px"></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Right" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Description %>"
                                            HeaderStyle-Wrap="false" GroupByExpression="Description [Description] Group By Description ASC"
                                            Groupable="false" Reorderable="false">
                                            <ItemTemplate>
                                                <span><%#Container.DataItem("Description")%>&nbsp;</span>
                                            </ItemTemplate>
                                            <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_UOM %>"
                                            Groupable="false" GroupByExpression="UOM [UOM] Group By UOM ASC">
                                            <ItemTemplate>
                                                <%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%>
                                            </ItemTemplate>
                                            <HeaderStyle Width="90px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Quantity %>"
                                            Groupable="false" GroupByExpression="Quantity [Quantity] Group By Quantity ASC">
                                            <ItemTemplate>
                                                <%# IIf(CDbl(ParseDouble(Eval("Quantity"), 1)) = CInt(ParseDouble(Eval("Quantity"), 1)), FormatNumber(ParseDouble(Eval("Quantity"), 1)), FormatNumber(ParseDouble(Eval("Quantity"), 1), 5).TrimEnd("0"))%>
                                            </ItemTemplate>
                                            <HeaderStyle Width="90px"></HeaderStyle>
                                            <ItemStyle CssClass="Right" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_UnitCost %>" UniqueName="UnitCost"
                                            Groupable="false" GroupByExpression="UnitCost [UnitCost] Group By UnitCost ASC">
                                            <ItemTemplate>
                                                <%#FormatCurrency(Eval("UnitCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>
                                            </ItemTemplate>
                                            <HeaderStyle Width="90px"></HeaderStyle>
                                            <ItemStyle CssClass="Right" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_TotalCost %>" UniqueName="TotalCost"
                                            Groupable="false" GroupByExpression="TotalCost [TotalCost] Group By TotalCost ASC">
                                            <ItemTemplate>
                                                <%#FormatCurrency(Eval("TotalCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>
                                            </ItemTemplate>
                                            <HeaderStyle Width="90px"></HeaderStyle>
                                            <ItemStyle CssClass="Right" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_CommitmentLine %>"
                                            HeaderStyle-Width="120px" HeaderStyle-Wrap="false" GroupByExpression="CommitmentLine [Commitment Line] Group By CommitmentLine ASC"
                                            Groupable="false" Reorderable="false">
                                            <ItemTemplate>
                                                <span><%#Container.DataItem("CommitmentLine")%>&nbsp;</span>
                                            </ItemTemplate>
                                            <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_CostCode %>"
                                            HeaderStyle-Width="90px" HeaderStyle-Wrap="false" GroupByExpression="CostCode [CostCode] Group By CostCode ASC"
                                            Groupable="false" Reorderable="false">
                                            <ItemTemplate>
                                                <span><%#Container.DataItem("CostCode")%>&nbsp;</span>
                                            </ItemTemplate>
                                            <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Phase %>" HeaderStyle-Width="100px"
                                            HeaderStyle-Wrap="false" GroupByExpression="Phase [Phase] Group By Phase ASC"
                                            Groupable="false" Reorderable="false">
                                            <ItemTemplate>
                                                <span><%#Container.DataItem("Phase")%>&nbsp;</span>
                                            </ItemTemplate>
                                            <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <FooterStyle CssClass="GridFooter" />
                                </telerik:GridTableView>
                            </DetailTables>
                        </MasterTableView>
                        <HeaderStyle Font-Size="8pt"></HeaderStyle>
                        <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="True" AllowRowsDragDrop="False">
                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="False" />
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
