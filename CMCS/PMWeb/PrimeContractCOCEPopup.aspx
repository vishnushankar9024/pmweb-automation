<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PrimeContractCOCEPopup.aspx.vb" Inherits="Website.PrimeContractCOCEPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
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
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" Value="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table> 

        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row">
                <div class="col-4 col-4-left">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblContract" runat="server" meta:resourcekey="lblContract" Text="Contract"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtContract" runat="server" Enabled="false" Text=""></asp:TextBox>
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
                            <asp:Label runat="server" ID="lblFilter" meta:resourcekey="lblFilter" Text="Filter" />
                        </legend>
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblContractFilter" meta:resourcekey="lblContract" runat="server" Text="Contract">
                                    </asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddContractFilter" Width="100%" runat="server">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td class="SearchToolBar">
                                    <asp:LinkButton ID="btnFilter" meta:resourcekey="lblFilter" runat="server" Text="Filter" CssClass="Link"></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgLinkCE" AllowMultiRowSelection="false" runat="server" Width="100%" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                        ShowGroupPanel="true" HeaderStyle-Font-Size="8" FitPageHeightOffset="24"
                        AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="false"
                        PageSize="1">
                        <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>

                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="None" Width="100%"
                            InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" Name="Master">
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

                            <ExpandCollapseColumn Visible="True"></ExpandCollapseColumn>
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Select %>" HeaderStyle-Width="40px" UniqueName="MasterSelect"
                                    HeaderStyle-Wrap="false" Groupable="false" Reorderable="false">
                                    <ItemTemplate>
                                        <asp:CheckBox runat="server" ID="chkMasterSelect" />
                                    </ItemTemplate>

                                    <HeaderStyle Wrap="False" Width="50"></HeaderStyle>

                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="CE #" HeaderStyle-Width="10%" UniqueName="CENumber"
                                    GroupByExpression="CENumber [GridColumn_CENumber] Group By CENumber ASC" HeaderStyle-Wrap="false"
                                    Groupable="true" Reorderable="false">
                                    <ItemTemplate>
                                        <%#Container.DataItem("CENumber").ToString%>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="10%"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Date" UniqueName="Date"
                                    GroupByExpression="Date [GridColumn_Date] Group By Date ASC" HeaderStyle-Wrap="false"
                                    Groupable="true" Reorderable="true">
                                    <ItemTemplate>
                                        <%#FormatDate(Container.DataItem("Date"))%>
                                    </ItemTemplate>

                                    <HeaderStyle Wrap="False" Width="100px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Description" HeaderStyle-Width="40%" GroupByExpression="Description [GridColumn_Description] Group By Description ASC"
                                    UniqueName="Description">
                                    <ItemTemplate>
                                        <%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%>
                                    </ItemTemplate>

                                    <HeaderStyle Width="200px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Requested By" HeaderStyle-Width="15%" UniqueName="RequestedBy"
                                    GroupByExpression="RequestedBy [GridColumn_RequestedBy] Group By RequestedBy ASC" HeaderStyle-Wrap="false"
                                    Groupable="true" Reorderable="false">
                                    <ItemTemplate>
                                        <%#Container.DataItem("RequestedBy") %>
                                    </ItemTemplate>

                                    <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Cause" UniqueName="Cause" HeaderStyle-HorizontalAlign="Center"
                                    HeaderStyle-Wrap="false" HeaderStyle-Width="200px"
                                    GroupByExpression="Cause [GridColumn_Cause] Group By Cause ASC">
                                    <ItemTemplate>
                                        <%#Container.DataItem("Cause")%>
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
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Select %>" HeaderStyle-Width="40px" UniqueName="DetailSelect"
                                            HeaderStyle-Wrap="false" Groupable="false" Reorderable="false">
                                            <ItemTemplate>
                                                <asp:CheckBox runat="server" ID="chkDetailSelect" />
                                            </ItemTemplate>
                                            <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Description %>" HeaderStyle-HorizontalAlign="Center"
                                            Groupable="false" UniqueName="Description" HeaderStyle-Width="30%" SortExpression="Description"
                                            GroupByExpression="Description [Description] Group By Description ASC">
                                            <ItemTemplate>
                                                <%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" Width="200px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_UOM %>" HeaderStyle-Width="100px" Groupable="false"
                                            GroupByExpression="UOM [UOM] Group By UOM ASC">
                                            <ItemTemplate>
                                                <%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%>
                                            </ItemTemplate>
                                            <HeaderStyle Width="10%"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Quantity %>" HeaderStyle-Width="150px" Groupable="false"
                                            GroupByExpression="Quantity [Quantity] Group By Quantity ASC">
                                            <ItemTemplate>
                                                <%#ParseDouble(Eval("Quantity"))%>
                                            </ItemTemplate>
                                            <HeaderStyle Width="15%"></HeaderStyle>
                                            <ItemStyle CssClass="Right" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_UnitPrice %>" UniqueName="UnitPrice" Groupable="false"
                                            HeaderStyle-Width="150px" GroupByExpression="UnitPrice [UnitPrice] Group By UnitPrice ASC">
                                            <ItemTemplate>
                                                <%#FormatCurrency(Eval("UnitPrice"), CurrencyId:=Eval("CurrencyId"))%>
                                            </ItemTemplate>
                                            <HeaderStyle Width="15%"></HeaderStyle>
                                            <ItemStyle CssClass="Right" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_OwnerBudget %>" UniqueName="OwnerBudget" Groupable="false"
                                            HeaderStyle-Width="150px" GroupByExpression="OwnerBudget [OwnerBudget] Group By OwnerBudget ASC">
                                            <ItemTemplate>
                                                <%#FormatCurrency(Eval("OwnerBudget"), CurrencyId:=Eval("CurrencyId"))%>
                                            </ItemTemplate>
                                            <HeaderStyle Width="15%"></HeaderStyle>
                                            <ItemStyle CssClass="Right" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_CostCode %>" UniqueName="CostCode" Groupable="false"
                                            HeaderStyle-Width="200px">
                                            <ItemTemplate>
                                                <%#IIf(Eval("CostCode") = String.Empty, "&nbsp;", Eval("CostCode"))%>
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
