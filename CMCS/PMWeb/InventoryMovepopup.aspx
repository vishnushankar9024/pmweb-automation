<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="InventoryMovepopup.aspx.vb"
    Inherits="Website.InventoryMovepopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="Message.ascx" TagName="Message" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">

        <script type="text/javascript">
            function HideSaveButton() {
                document.getElementById("btnSave").style.display = "none";

            }
            function ShowSaveButton() {
                document.getElementById("btnSave").style.display = "block";
            }
            function rdvLocationNodeClicking(sender, args) {
                var comboBox = $find(sender.get_id().substring(0, sender.get_id().lastIndexOf('_ddlLocation')) + '_ddlLocation');
                var node = args.get_node();
                var strText = "";
                var strValue = "";
                strValue = node.get_value();
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
            function MovedChecked(sender, args) {

                var chkMoved = $("[id$=" + sender.id + "]")[0];
                var chkUsed = $("[id$=" + sender.id.substring(0, sender.id.lastIndexOf('_chkMoved')) + '_chkUsed' + "]")[0];
                var chkUnusable = $("[id$=" + sender.id.substring(0, sender.id.lastIndexOf('_chkMoved')) + '_chkUnusable' + "]")[0];

                if (chkMoved.checked == true) {
                    chkUsed.checked = false;
                    chkUnusable.checked = false;
                }
                else {
                    chkUsed.checked = true;
                    chkUnusable.checked = false;
                }

            }
            function UsedChecked(sender, args) {

                var chkMoved = $("[id$=" + sender.id.substring(0, sender.id.lastIndexOf('_chkUsed')) + '_chkMoved' + "]")[0];
                var chkUsed = $("[id$=" + sender.id + "]")[0];
                var chkUnusable = $("[id$=" + sender.id.substring(0, sender.id.lastIndexOf('_chkUsed')) + '_chkUnusable' + "]")[0];

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
            function UnusableChecked(sender, args) {

                var chkMoved = $("[id$=" + sender.id.substring(0, sender.id.lastIndexOf('_chkUnusable')) + '_chkMoved' + "]")[0];
                var chkUsed = $("[id$=" + sender.id.substring(0, sender.id.lastIndexOf('_chkUnusable')) + '_chkUsed' + "]")[0];
                var chkUnusable = $("[id$=" + sender.id + "]")[0];
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
            function AlertMessage(top, left, text, time) {

                var color = "#ffd79d";
                $("#divMsg").stop(true, true);
                $("#divMsg").css({ 'top': top + 'px', 'left': left + 'px', 'visibility': 'visible', 'background-color': color }).show();
                clearTimeout(t);
                var t = setTimeout("$('#divMsg').fadeOut(3000)", time);
                $("#MsgText").text(text);
            }

            function ValidateOnHandQuantity() {
                var txtRemaining = $("[id$=txtRemaining]");
                var a = txtRemaining.id
                var pos = $("#" + txtRemaining.id).offset();
                var width = $("#" + txtRemaining.id).width();
                AlertMessage((pos.top + 150), (pos.left + 700), Msg_ConfirmMove, 6000);
                return false;
            }
        </script>

        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <uc1:Message ID="Message1" runat="server" />

        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgInventoryMove">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgInventoryMove" LoadingPanelID="ldpAssets" />
                        <telerik:AjaxUpdatedControl ControlID="txtMove" />
                        <telerik:AjaxUpdatedControl ControlID="txtRemaining" />
                        <telerik:AjaxUpdatedControl ControlID="txtHand" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpAssets" runat="server" BackgroundPosition="Center"
            Skin="Default" />

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" Width="100%" runat="server" Skin="Default" AutoPostBack="true">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" AccessKey="s">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" ValidationGroup="Save" CommandName="SaveExit"></telerik:RadToolBarButton>
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
                    <table class="colTable">
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
                                <asp:TextBox runat="server" ReadOnly="true" ID="txtStockNumber" style="text-align:right;"></asp:TextBox>
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
                                <asp:TextBox runat="server" ReadOnly="true" ID="txtItem" style="text-align:right;"></asp:TextBox>
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
                                <asp:TextBox runat="server" ReadOnly="true" ID="txtConditionDate" style="text-align:right;"></asp:TextBox>
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
                                <asp:Label ID="lblQtyOnHand" meta:resourcekey="lblQuantityOnHand" Text="Quantity on hand" runat="server"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox runat="server" ReadOnly="true" ID="txtOnHand"  style="text-align:right;"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 99%"></td>
                        </tr>
                    </table>
                </div>
                <div class="col-8">

                    <div class="row">
                        <div class="col-4" style="float: right;">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblMovedate" meta:resourcekey="lblMoveDates" Text="Move Date" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadDatePicker ID="dtpAddDate" MinDate="01/01/1901" MaxDate="12/31/2100"
                                            runat="server" Skin="Default">
                                            <ClientEvents />
                                        </telerik:RadDatePicker>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>

                    <table class="colTable">
                        <tr>
                            <td>
                                <telerik:RadGrid ID="rdgInventoryMove" AllowMultiRowSelection="true" runat="server" SetWidth="true" FitParentContainer="true" AppendMenus="true"
                                    AllowMultiRowEdit="true" UseEditFormInMobile="true"
                                    AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true">
                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                        DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top" TableLayout="fixed"
                                        CommandItemStyle-HorizontalAlign="Left" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage"
                                        EditMode="InPlace">
                                        <Columns>
                                            <telerik:GridTemplateColumn HeaderText="Quantity to Move" HeaderStyle-HorizontalAlign="Center" UniqueName="QtyToMove"
                                                HeaderStyle-Wrap="false" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Right" SortExpression="Qty">
                                                <ItemTemplate>
                                                    <%#FormatNumber(Container.DataItem("Qty"))%>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtQty" runat="server" Width="100%"
                                                        MaxLength="15" Text="1"></asp:TextBox>
                                                    <asp:CompareValidator meta:resourcekey="CmpQtyToMove" Display="Dynamic" runat="server" ID="CmpQuantityToMove" ControlToValidate="txtQty" ValueToCompare="0" CssClass="Validator"
                                                        ValidationGroup="GridSave" Type="Double" Operator="GreaterThan" ErrorMessage="Quantity to Move must be greater than zero"></asp:CompareValidator>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="New Location*" HeaderStyle-Wrap="false" HeaderStyle-HorizontalAlign="Center"
                                                HeaderStyle-Width="150px" SortExpression="NewLocation" UniqueName="NewLocation">
                                                <ItemTemplate>
                                                    <%#IIf(Container.DataItem("NewLocation").ToString = String.Empty, "&nbsp;", Container.DataItem("NewLocation").ToString)%>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadComboBox ID="ddlLocation" AllowCustomText="false" runat="server" Skin="Default"
                                                        CloseDropDownOnBlur="true" Width="100%" NoWrap="true"
                                                        ShowToggleImage="true" DropDownCssClass="ddlTreeviewTemplate">
                                                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                        <Items>
                                                            <telerik:RadComboBoxItem Text="" />
                                                        </Items>
                                                        <ItemTemplate>

                                                            <telerik:RadTreeView ID="rdvAssets" Skin="Default" runat="server" Height="250px"
                                                                MultipleSelect="false" ShowLineImages="false" OnNodeDataBound="rdvAssets_NodeDataBound"
                                                                OnNodeExpand="rdvAssets_NodeExpand" OnClientNodeClicking="rdvLocationNodeClicking">
                                                            </telerik:RadTreeView>
                                                        </ItemTemplate>
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator meta:resourcekey="rfvRequired" ID="rfvLocation" CssClass="Validator" Display="Dynamic" runat="server" ControlToValidate="ddlLocation"
                                                        ErrorMessage="Required" ValidationGroup="GridSave"></asp:RequiredFieldValidator>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Used" HeaderStyle-Width="80px" ItemStyle-Wrap="false"
                                                SortExpression="Used" UniqueName="Used" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false">
                                                <ItemTemplate>
                                                    <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Used")) = CBool(1), "checked.png", "unchecked.png"))%>"
                                                        alt="" />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:CheckBox ID="chkUsed" Checked="true" OnClick='UsedChecked(this, event);' runat="server" />
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Unusable" HeaderStyle-Width="120px" ItemStyle-Wrap="false"
                                                SortExpression="Unusable" UniqueName="Unusable" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false">
                                                <ItemTemplate>
                                                    <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Unusable")) = CBool(1), "checked.png", "unchecked.png"))%>"
                                                        alt="" />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:CheckBox ID="chkUnusable" OnClick='UnusableChecked(this, event);' runat="server" />
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Moved" HeaderStyle-Width="100px" ItemStyle-Wrap="false"
                                                SortExpression="Moved" UniqueName="Moved" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false">
                                                <ItemTemplate>
                                                    <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Moved")) = CBool(1), "checked.png", "unchecked.png"))%>"
                                                        alt="" />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:CheckBox ID="chkMoved" OnClick='MovedChecked(this, event);' runat="server" />
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn UniqueName="Notes" HeaderText="Notes" HeaderStyle-HorizontalAlign="Center"
                                                HeaderStyle-Width="100px" SortExpression="Notes">
                                                <ItemTemplate>
                                                    <%#IIf(Container.DataItem("Notes").ToString = String.Empty, "&nbsp;", Container.DataItem("Notes").ToString)%>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtNotes" runat="server" Width="100%"></asp:TextBox>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                        <FooterStyle CssClass="GridFooter" />
                                        <CommandItemTemplate>
                                            <div style="padding: 2px">
                                                &nbsp;&nbsp;
                                                                        <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                                                            Visible='<%# rdgInventoryMove.EditIndexes.Count = 0 And (Not rdgInventoryMove.MasterTableView.IsItemInserted) %>'
                                                                            meta:resourcekey="btnEditSelectedResource1">
                                                                            <span class="Icon"></span>
                                                                            <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit selected lines" meta:resourcekey="lblEditSelectedLinesResource1"></asp:Label>
                                                                            &nbsp;&nbsp;
                                                                        </asp:LinkButton>
                                                <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="GridSave" CssClass="GridCmdUpdateEdited"
                                                    CommandName="UpdateEdited" Visible='<%# rdgInventoryMove.EditIndexes.Count > 0 %>'
                                                    meta:resourcekey="btnUpdateEditedResource1">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="GridSave" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                                    Visible='<%# rdgInventoryMove.MasterTableView.IsItemInserted %>' meta:resourcekey="btnSaveResource1">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSaveResource1"></asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>

                                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                                    Visible='<%# rdgInventoryMove.EditIndexes.Count > 0 Or rdgInventoryMove.MasterTableView.IsItemInserted %>'
                                                    meta:resourcekey="btnCancelResource1">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>

                                                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                                    Visible='<%# rdgInventoryMove.EditIndexes.Count = 0 And (Not rdgInventoryMove.MasterTableView.IsItemInserted) %>'
                                                    meta:resourcekey="btnAddResource1">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblAddLine" runat="server" Text="Add line" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>

                                                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                                    Visible='<%# rdgInventoryMove.EditIndexes.Count = 0 And (Not rdgInventoryMove.MasterTableView.IsItemInserted) %>'
                                                    runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                                                        meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                                    Visible='<%# rdgInventoryMove.EditIndexes.Count = 0 And (Not rdgInventoryMove.MasterTableView.IsItemInserted) %>'
                                                    meta:resourcekey="btnRefreshResource1">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                                </asp:LinkButton>
                                            </div>
                                        </CommandItemTemplate>
                                    </MasterTableView>
                                    <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                    <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="False" AllowRowsDragDrop="False"
                                        Resizing-AllowColumnResize="True">
                                        <Selecting AllowRowSelect="True" />
                                    </ClientSettings>
                                </telerik:RadGrid>
                            </td>
                        </tr>
                    </table>

                    <div class="row">
                        <div class="col-4" style="float: right;">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" meta:resourcekey="lblQuantityOnHand" ID="lblOnHand" Text="Quantity on Hand"></asp:Label>

                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" Style="text-align: right" ReadOnly="true" ID="txtHand"
                                            CssClass="Double"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblQtyToMove" meta:resourcekey="lblQtyToMove" runat="server" Text="Quantity to Move"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" Style="text-align: right" ID="txtMove" ReadOnly="true"
                                            CssClass="Double"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblQuantityRemaining" meta:resourcekey="lblQtyRemaining" Text="Quantity Remaining" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" Style="text-align: right" ReadOnly="true" ID="txtRemaining"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>

                </div>
            </div>
        </div>

    </form>
</body>
</html>
