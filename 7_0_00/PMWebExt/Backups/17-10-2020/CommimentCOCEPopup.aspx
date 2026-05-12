<%@ Page Language="vb" Title="Link CE" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="CommimentCOCEPopup.aspx.vb" Inherits="Website.CommimentCOCEPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script type="text/javascript">
        function CloseAndSave() {
            var btnSave = $(window.parent.document).find("[id$=btnSave]");
            CloseRadWnd();
            btnSave.click();
        } 
    </script>
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
                <telerik:AjaxSetting AjaxControlID="rdgLinkCE">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgLinkCE" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnFilter">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgLinkCE" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>

        <script src="JS/Costs/CommitmentCOPopup.js" type="text/javascript"></script>

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td class="ToolbarTd">

                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>


        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row">
                <div class="col-4 col-4-left">
                    <table class="colTable" >
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
                                <asp:Label ID="lblProject" runat="server" meta:resourcekey="lblProject" Text="Project"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtProject" runat="server" Enabled="false" Text=""></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCompany" runat="server" meta:resourcekey="lblCompany" Text="Company"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtCompany" runat="server" Text="" Enabled="false"></asp:TextBox>
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
                                <asp:Label ID="lblChangeOrderDate" runat="server" meta:resourcekey="lblChangeOrderDate" Text="Change Order Date"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtChangeOrderDate" runat="server" Enabled="false" ReadOnly="true" style="text-align:right"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDescription" runat="server" meta:resourcekey="lblDescription" Text="Description"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtDescription" runat="server" Enabled="false"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-4 col-4-right">
                    <fieldset>
                            <legend>
                                <asp:Label runat="server" ID="lblFilter" Text="Filter" meta:resourcekey="lblFilter" /></legend>
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCommitmentFilter" meta:resourcekey="lblDescription" runat="server" Text="Commitment"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCommitmentFilter" runat="server">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td class="SearchToolBar">
                                        <asp:LinkButton ID="btnFilter" meta:resourcekey="btnFilter" runat="server" Text="Filter" CssClass="Link"></asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgLinkCE" AllowMultiRowSelection="false" runat="server" Width="99%" ClientSettings-Scrolling-AllowScroll="true"
                        ShowGroupPanel="true" HeaderStyle-Font-Size="8" setwidth="true" FitPageHeightOffset="24"
                        AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="false"
                        PageSize="1">
                        <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>

                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="None" Width="100%"
                            InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" Name="Master">

                            <EditFormSettings>
                                <EditColumn InsertImageUrl="Update.gif" UpdateImageUrl="Update.gif" EditImageUrl="Edit.gif" CancelImageUrl="Cancel.gif"></EditColumn>
                            </EditFormSettings>

                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

                            <ExpandCollapseColumn Visible="True"></ExpandCollapseColumn>
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Select" HeaderStyle-Width="40px" UniqueName="MasterSelect"
                                    HeaderStyle-Wrap="false" Groupable="false" Reorderable="false">
                                    <ItemTemplate>
                                        <asp:CheckBox runat="server" ID="chkMasterSelect" />
                                    </ItemTemplate>

                                    <HeaderStyle Wrap="False" Width="50"></HeaderStyle>

                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="CE #" HeaderStyle-Width="16%" UniqueName="CENumber"
                                    GroupByExpression="CENumber [GridColumn_CENumber] Group By CENumber ASC" ItemStyle-CssClass="NoWrap" HeaderStyle-Wrap="false"
                                    Groupable="true" Reorderable="false">
                                    <ItemTemplate>
                                        <%# IIf(Container.DataItem("CENumber") = String.Empty, "&nbsp;", Container.DataItem("CENumber"))%>
                                    </ItemTemplate>

                                    <HeaderStyle Wrap="False" Width="10%"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Description" HeaderStyle-Width="40%" GroupByExpression="Description [GridColumn_Description] Group By Description ASC"
                                    UniqueName="Description">
                                    <ItemTemplate>
                                        <%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%>
                                    </ItemTemplate>
                                    <HeaderStyle Width="200px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="COR #" HeaderStyle-Width="100px" ItemStyle-CssClass="NoWrap" UniqueName="CORNumber"
                                    GroupByExpression="CORNumber [GridColumn_CORNumber] Group By CORNumber ASC" HeaderStyle-Wrap="false"
                                    Groupable="true" Reorderable="false">
                                    <ItemTemplate>
                                        <%# IIf(Container.DataItem("CORNumber") = String.Empty, "&nbsp;", Container.DataItem("CORNumber").ToString)%>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Requested By" HeaderStyle-Width="15%" UniqueName="RequestedBy"
                                    GroupByExpression="RequestedBy [GridColumn_RequestedBy] Group By RequestedBy ASC" HeaderStyle-Wrap="false"
                                    Groupable="true" Reorderable="false">
                                    <ItemTemplate>
                                        <%# IIf(Container.DataItem("RequestedBy") = String.Empty, "&nbsp;", Container.DataItem("RequestedBy"))%>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Cause" UniqueName="Cause" HeaderStyle-HorizontalAlign="Center"
                                    HeaderStyle-Wrap="false" HeaderStyle-Width="200px"
                                    GroupByExpression="Cause [GridColumn_Cause] Group By Cause ASC">
                                    <ItemTemplate>
                                        <%# IIf(Container.DataItem("Cause") = String.Empty, "&nbsp;", Container.DataItem("Cause"))%>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Width="20%"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <FooterStyle CssClass="GridFooter" />

                            <DetailTables>
                                <telerik:GridTableView SkinID="PM" ShowHeader="True" ShowStatusBar="false" CommandItemDisplay="None"
                                    AllowSorting="false" DataKeyNames="Id,ChangeEventId" Width="100%"
                                    EditMode="InPlace" Name="ChangeEventDetails">
                                    <ParentTableRelation>
                                        <telerik:GridRelationFields DetailKeyField="ChangeEventId" MasterKeyField="Id" />
                                    </ParentTableRelation>

                                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_DetailSelect %>" HeaderStyle-Width="40px" UniqueName="DetailSelect"
                                            HeaderStyle-Wrap="false" Groupable="false" Reorderable="false">
                                            <ItemTemplate>
                                                <asp:CheckBox runat="server" ID="chkDetailSelect" />
                                            </ItemTemplate>

                                            <HeaderStyle Wrap="False" Width="40px"></HeaderStyle>

                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Description %>" HeaderStyle-Width="15%" HeaderStyle-Wrap="false"
                                            GroupByExpression="Description [Description] Group By Description ASC" Groupable="false"
                                            Reorderable="false">
                                            <ItemTemplate>
                                                <%# IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%>
                                            </ItemTemplate>

                                            <HeaderStyle Wrap="False" Width="15%"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Commitment %>" HeaderStyle-Width="15%" HeaderStyle-Wrap="false"
                                            GroupByExpression="Commitment [Commitment] Group By Commitment ASC" Groupable="false"
                                            Reorderable="false">
                                            <ItemTemplate>
                                                <%# IIf(Container.DataItem("Commitment") = String.Empty, "&nbsp;", Container.DataItem("Commitment"))%>
                                            </ItemTemplate>

                                            <HeaderStyle Wrap="False" Width="15%"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Company %>" HeaderStyle-HorizontalAlign="Center" Groupable="false"
                                            UniqueName="CompanyName" HeaderStyle-Width="30%" SortExpression="CompanyName" GroupByExpression="CompanyName [Company] Group By CompanyName ASC">
                                            <ItemTemplate>
                                                <%#IIf(Container.DataItem("CompanyName").ToString = String.Empty, "&nbsp;", Container.DataItem("CompanyName").ToString)%>
                                            </ItemTemplate>

                                            <HeaderStyle HorizontalAlign="Center" Width="30%"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_UOM %>" HeaderStyle-Width="10%" Groupable="false" GroupByExpression="UOM [UOM] Group By UOM ASC">
                                            <ItemTemplate>
                                                <%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%>
                                            </ItemTemplate>

                                            <HeaderStyle Width="10%"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Quantity %>" HeaderStyle-Width="15%" Groupable="false" GroupByExpression="Quantity [Quantity] Group By Quantity ASC">
                                            <ItemTemplate>
                                                <%# IIf(CDbl(ParseDouble(Eval("Quantity"), 1)) = CInt(ParseDouble(Eval("Quantity"), 1)), FormatNumber(ParseDouble(Eval("Quantity"), 1)), FormatNumber(ParseDouble(Eval("Quantity"), 1), 5).TrimEnd("0"))%>
                                            </ItemTemplate>

                                            <HeaderStyle Width="15%"></HeaderStyle>

                                            <ItemStyle CssClass="Right" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_TotalCost %>" UniqueName="TotalCost" Groupable="false" HeaderStyle-Width="15%"
                                            GroupByExpression="TotalCost [TotalCost] Group By TotalCost ASC">
                                            <ItemTemplate>
                                                <%# FormatCurrency(Eval("TotalCost"), CurrencyId:=IIf(Eval("CurrencyId") Is DBNull.Value, 0, Eval("CurrencyId")))%>
                                            </ItemTemplate>

                                            <HeaderStyle Width="15%"></HeaderStyle>

                                            <ItemStyle CssClass="Right" />
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
