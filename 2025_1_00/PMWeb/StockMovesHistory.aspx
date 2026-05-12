<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="StockMovesHistory.aspx.vb" Inherits="Website.StockMovesHistory" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <script type="text/javascript">

            function rdvLocationNodeClicking(sender, args) {
                var comboBox = $find($("[id$=ddlLocation]")[0].id);
                var node = args.get_node();

                var strText = "";
                var strValue = "";
                strValue = node.get_value();
                if (strValue.indexOf("I") < 0) {
                    return;
                }
                while (node != null && node._element.id.toString().indexOf(comboBox._element.id) == -1) {
                    strText = "/" + node.get_text() + strText;
                    node = node.get_parent();
                }
                strText = strText.substr(1, strText.toString().length - 1);

                comboBox.set_text(strText);
                comboBox.trackChanges();
                comboBox.get_items().getItem(0).set_value(strValue);
                comboBox.commitChanges();
                comboBox.hideDropDown();
            }
            function MovedChecked() {

                var chkMoved = $("[id$=chkMoved]")[0];
                var chkUsed = $("[id$=chkUsed]")[0];
                var chkUnusable = $("[id$=chkUnusable]")[0];

                if (chkMoved.checked == true) {
                    chkUsed.checked = false;
                    chkUnusable.checked = false;
                }
                else {
                    chkUsed.checked = true;
                    chkUnusable.checked = false;
                }

            }
            function UsedChecked() {

                var chkMoved = $("[id$=chkMoved]")[0];
                var chkUsed = $("[id$=chkUsed]")[0];
                var chkUnusable = $("[id$=chkUnusable]")[0];

                if (chkUsed.checked == true) {
                    chkMoved.checked = false;
                    chkUnusable.checked = false;
                }
                else {
                    chkUsed.checked = true
                    chkMoved.checked = false;
                    chkUnusable.checked = false;
                }

            }
            function UnusableChecked() {

                var chkMoved = $("[id$=chkMoved]")[0];
                var chkUsed = $("[id$=chkUsed]")[0];
                var chkUnusable = $("[id$=chkUnusable]")[0];

                if (chkUnusable.checked == true) {
                    chkMoved.checked = false;
                    chkUsed.checked = false;
                }
                else {
                    chkUsed.checked = true
                    chkMoved.checked = false;
                    chkUnusable.checked = false;
                }

            }

        </script>
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>

        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgInventoryMove">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgInventoryMove" LoadingPanelID="ldpAssets" />

                    </UpdatedControls>
                </telerik:AjaxSetting>

            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpAssets" runat="server" BackgroundPosition="Center" Skin="Default" />

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" Width="100%" runat="server" Skin="Default" AutoPostBack="true">
                        <Items>
                            <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Close" EnableImageSprite="true" CssClass="ToolbarCancel"
                                Value="Close">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row row-8-4">
                <div class="col-4">
                    <table class="colTable" border="0">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblLocation" meta:resourcekey="lblLocation" Text="Location" runat="server"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtLocation" ReadOnly="true" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblLinkedTo" meta:resourcekey="lblLinkedTo" Text="Linked to" runat="server"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox runat="server" ReadOnly="true" ID="txtLinkedTo"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblSubLocation" meta:resourcekey="lblSubLocation" Text="Sub-location" runat="server"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox runat="server" ReadOnly="true" ID="TextSublocation"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblStockNumber" meta:resourcekey="lblStockNumber" Text="Stock #" runat="server"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox runat="server" ReadOnly="true" ID="txtStockNumber" Style="text-align: right;"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblLotNumber" meta:resourcekey="lblLotNumber" Text="Lot #" runat="server"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox runat="server" ReadOnly="true" ID="txtLotNumber"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblSerialNumber" meta:resourcekey="lblSerialNumber" Text="Serial #" runat="server"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox runat="server" ReadOnly="true" ID="txtSerialNumber"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblItem" meta:resourcekey="lblItem" Text="Item" runat="server"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox runat="server" ReadOnly="true" ID="txtItem" Style="text-align: right;"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDescription" meta:resourcekey="lblDescription" Text="Description" runat="server"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox runat="server" ReadOnly="true" ID="txtDescription"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCondition" meta:resourcekey="lblCondition" Text="Condition" runat="server"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox runat="server" ReadOnly="true" ID="txtCondition"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblConditionDate" meta:resourcekey="lblConditionDate" Text="Condition Date" runat="server"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox runat="server" ReadOnly="true" ID="txtConditionDate" Style="text-align: right;"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblManufacturer" meta:resourcekey="lblManufacturer" Text="Manufacturer" runat="server"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox runat="server" ReadOnly="true" ID="txtManufacturer"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblMfrNumber" meta:resourcekey="lblMfrNumber" Text="Mfr. Number" runat="server"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox runat="server" ReadOnly="true" ID="txtMfrNumber"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblUOM" meta:resourcekey="lblUOM" Text="UOM" runat="server"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox runat="server" ReadOnly="true" ID="txtUOM"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblQtyOnHand" meta:resourcekey="lblQuantityOnHand" Text="Quantity on Hand" runat="server"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox runat="server" ReadOnly="true" ID="txtOnHand" Style="text-align: right;"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-8">
                    <telerik:RadGrid ID="rdgInventoryMove" AllowMultiRowSelection="true" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                        HeaderStyle-Font-Size="8" Width="100%" ShowGroupPanel="true" GroupHeaderItemStyle-Width="1%"
                        AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" PageSize="250" AllowPaging="true">
                        <MasterTableView DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="None"
                            InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Moved Quantity" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false" HeaderStyle-Width="150px" SortExpression="Qty"
                                    GroupByExpression="Qty [GridColumn_QtyMoved] Group By Qty ASC" UniqueName="QtyMoved">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("Qty") Is DBNull.Value, "&nbsp;", FormatNumber(Container.DataItem("Qty")))%></span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Inventory Location" HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center"
                                    HeaderStyle-Width="150px" SortExpression="LocationName" UniqueName="InventoryLocation" GroupByExpression="LocationName [GridColumn_InventoryLocation] Group By LocationName ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("LocationName").ToString = String.Empty, "&nbsp;", Container.DataItem("LocationName").ToString)%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Used" HeaderStyle-Width="100px" ItemStyle-Wrap="false" GroupByExpression="Use [GridColumn_Used] Group By Use ASC"
                                    SortExpression="Use" UniqueName="Used" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false">
                                    <ItemTemplate>
                                        <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Use")) = CBool(1), "checked.png", "unchecked.png"))%>"
                                            alt="" />
                                    </ItemTemplate>

                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Unusable" HeaderStyle-Width="80px" ItemStyle-Wrap="false" GroupByExpression="Unusable [GridColumn_Unusable] Group By Unusable ASC"
                                    SortExpression="Unusable" UniqueName="Unusable" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false">
                                    <ItemTemplate>
                                        <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Unusable")) = CBool(1), "checked.png", "unchecked.png"))%>"
                                            alt="" />
                                    </ItemTemplate>

                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Moved" HeaderStyle-Width="120px" ItemStyle-Wrap="false" GroupByExpression="Move [GridColumn_Moved] Group By Move ASC"
                                    SortExpression="Move" UniqueName="Moved" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false">
                                    <ItemTemplate>
                                        <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Move")) = CBool(1), "checked.png", "unchecked.png"))%>"
                                            alt="" />
                                    </ItemTemplate>

                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Notes" HeaderStyle-HorizontalAlign="Center" GroupByExpression="Notes [GridColumn_Notes] Group By Notes ASC"
                                    HeaderStyle-Width="100px" SortExpression="Notes" UniqueName="Notes">
                                    <ItemTemplate>
                                        <span><%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%></span>
                                    </ItemTemplate>

                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Add Date" HeaderStyle-Wrap="false" DataField="AddDate"
                                    HeaderStyle-Width="100px" SortExpression="AddDate" UniqueName="AddDate" GroupByExpression="AddDate [GridColumn_AddDate] Group By AddDate ASC">
                                    <ItemTemplate>
                                        <span><%#IIf(FormatDate(Container.DataItem("AddDate")) = String.Empty, "&nbsp;", FormatDate(Container.DataItem("AddDate")))%></span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                            </Columns>


                        </MasterTableView>
                        <HeaderStyle Font-Size="8pt"></HeaderStyle>
                        <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="True" AllowRowsDragDrop="False"
                            Resizing-AllowColumnResize="False">
                            <Selecting AllowRowSelect="True" />
                        </ClientSettings>
                    </telerik:RadGrid>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
