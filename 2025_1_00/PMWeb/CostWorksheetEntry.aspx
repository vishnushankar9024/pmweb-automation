<%@ Page Language="vb" AutoEventWireup="false" meta:resourcekey="Page" CodeBehind="CostWorksheetEntry.aspx.vb"
    Title="Cost Worksheet Entry" Inherits="Website.CostWorksheetEntry" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<style type="text/css">
    input.error
    {
        border:1px Solid red !important;   
    }
    input.isValid
    {
          border:1px Solid #c4dbf9 !important;   
    }
    </style>--%>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" EnableSkinTransparency="true"
            BackgroundPosition="Center" Skin="Default" />
        <telerik:RadCodeBlock ID="CodeBlock" runat="server">
            <script type="text/javascript">
                function AdjustCostCalculation() {
                    var CurrentQuantity = $("[id$=lblCurrentQuantity]");
                    if (CurrentQuantity.length == 0) return;
                    var CurrentQuantityVal = CDbl(CurrentQuantity.text());
                    var CurrentUnitCost = $("[id$=lblCurrentUnitCost]");
                    var CurrentUnitCostVal = CDbl(CurrentUnitCost.text());
                    var CurrentTotalCost = $("[id$=lblCurrentTotalCost]");
                    var CurrentTotalCostVal = CDbl(CurrentTotalCost.text());

                    var AdjustmentQuantity = $("input[id$=txtAdjustmentQuantity]");
                    var AdjustmentQuantityVal = CDbl(AdjustmentQuantity.val());
                    var AdjustmentUnitCost = $("input[id$=txtAdjustmentUnitCost]");
                    var AdjustmentUnitCostVal = CDbl(AdjustmentUnitCost.val());
                    var AdjustmentTotalCost = $("input[id$=txtAdjustmentTotalCost]");
                    var AdjustmentTotalCostVal = CDbl(AdjustmentTotalCost.val());

                    var TotalQuantity = $("input[id$=txtTotalQuantity]");
                    var TotalQuantityVal = CDbl(TotalQuantity.val());
                    var TotalUnitCost = $("input[id$=txtTotalUnitCost]");
                    var TotalUnitCostVal = CDbl(TotalUnitCost.val());
                    var TotalCost = $("input[id$=txtTotalCost]");
                    var TotalCostVal = CDbl(TotalCost.val());

                    // On change Adjustment Quantity
                    $("input[id$=txtAdjustmentQuantity]").change(function () {
                        AdjustmentQuantityVal = CDbl(AdjustmentQuantity.val());
                        if (AdjustmentQuantityVal != 0) {
                            AdjustmentTotalCost.val(CCur(AdjustmentQuantityVal * AdjustmentUnitCostVal));
                            AdjustmentTotalCostVal = CDbl(AdjustmentTotalCost.val());
                            TotalCost.val(CCur(CurrentTotalCostVal + AdjustmentTotalCostVal));
                            TotalCostVal = CDbl(TotalCost.val());
                            TotalQuantity.val(CurrentQuantityVal + AdjustmentQuantityVal);
                            TotalQuantityVal = CDbl(TotalQuantity.val());
                            TotalUnitCost.val(CCur(TotalCostVal / TotalQuantityVal));
                            TotalUnitCostVal = CDbl(TotalUnitCost.val());
                        }
                    });

                    //On change Adjustment Unit Cost
                    $("input[id$=txtAdjustmentUnitCost]").change(function () {
                        AdjustmentUnitCostVal = CDbl(AdjustmentUnitCost.val());
                        AdjustmentTotalCost.val(CCur(AdjustmentQuantityVal * AdjustmentUnitCostVal));
                        AdjustmentTotalCostVal = CDbl(AdjustmentTotalCost.val());
                        TotalCost.val(CCur(CurrentTotalCostVal + AdjustmentTotalCostVal));
                        TotalCostVal = CDbl(TotalCost.val());
                        TotalUnitCost.val(CCur(TotalCostVal / TotalQuantityVal));
                        TotalUnitCostVal = CDbl(TotalUnitCost.val());
                    });

                    //On change Adjustment Total Cost
                    $("input[id$=txtAdjustmentTotalCost]").change(function () {
                        AdjustmentTotalCostVal = CDbl(AdjustmentTotalCost.val());
                        AdjustmentUnitCost.val(CCur(AdjustmentTotalCostVal / AdjustmentQuantityVal));
                        AdjustmentUnitCostVal = CDbl(AdjustmentUnitCost.val());
                        TotalCost.val(CCur(CurrentTotalCostVal + AdjustmentTotalCostVal));
                        TotalCostVal = CDbl(TotalCost.val());
                        TotalUnitCost.val(CCur(TotalCostVal / TotalQuantityVal));
                        TotalUnitCostVal = CDbl(TotalUnitCost.val());
                    });

                    // On change Total Quantity
                    $("input[id$=txtTotalQuantity]").change(function () {
                        TotalQuantityVal = CDbl(TotalQuantity.val());
                        if (TotalQuantityVal != 0) {
                            AdjustmentQuantity.val(TotalQuantityVal - CurrentQuantityVal);
                            AdjustmentQuantityVal = CDbl(AdjustmentQuantity.val());
                            AdjustmentTotalCost.val(CCur(AdjustmentQuantityVal * AdjustmentUnitCostVal));
                            AdjustmentTotalCostVal = CDbl(AdjustmentTotalCost.val());
                            TotalCost.val(CCur(CurrentTotalCostVal + AdjustmentTotalCostVal));
                            TotalCostVal = CDbl(TotalCost.val());
                            TotalUnitCost.val(CCur(TotalCostVal / TotalQuantityVal));
                            TotalUnitCostVal = CDbl(TotalUnitCost.val());
                        }
                    });

                    //On change Total Unit Cost
                    $("input[id$=txtTotalUnitCost]").change(function () {
                        TotalUnitCostVal = CDbl(TotalUnitCost.val());
                        TotalCost.val(CCur(TotalQuantityVal * TotalUnitCostVal));
                        TotalCostVal = CDbl(AdjustmentTotalCost.val());
                        AdjustmentTotalCost.val(TotalCostVal - CurrentTotalCostVal);
                        AdjustmentTotalCostVal = CDbl(AdjustmentTotalCost.val());
                        AdjustmentUnitCost.val(CCur(AdjustmentTotalCostVal / AdjustmentQuantityVal));
                        AdjustmentUnitCostVal = CDbl(AdjustmentUnitCost.val());
                    });

                    //On change Total Cost
                    $("input[id$=txtTotalCost]").change(function () {
                        TotalCostVal = CDbl(TotalCost.val());
                        TotalUnitCost.val(CCur(TotalCostVal / TotalQuantityVal));
                        TotalUnitCostVal = CDbl(TotalUnitCost.val());
                        AdjustmentTotalCost.val(TotalCostVal - CurrentTotalCostVal);
                        AdjustmentTotalCostVal = CDbl(AdjustmentTotalCost.val());
                        AdjustmentUnitCost.val(CCur(AdjustmentTotalCostVal / AdjustmentQuantityVal));
                        AdjustmentUnitCostVal = CDbl(AdjustmentUnitCost.val());
                    });
                }


                function rdvReqNodeClicking(sender, args) {
                    var ComboId = sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1);
                    var comboBox = $find(ComboId.substring(ComboId.lastIndexOf('_'), ComboId.lenght - 1));
                    var node = args.get_node();
                    var strText = "";
                    var strValue = "";
                    strValue = node.get_value();
                    if (strValue.indexOf("SELECT") > 0 || strValue.indexOf("Contract") > 0 || strValue.indexOf("ContractCO") > 0) {
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
                }

                function ValidateCostCodesCombo(source, args) {
                    args.IsValid = false;
                    var combo = $find(source.controltovalidate);
                    if (combo != null) {
                        var text = combo.get_text();
                        if (text.length < 1) {
                            args.IsValid = false;
                        }
                        else {
                            var value = combo.get_value();
                            if (value >= 0 && value != '') {
                                args.IsValid = true;
                            }
                            else {
                                args.IsValid = false;
                            }
                        }
                    }
                    else
                        args.IsValid = true;
                }

            </script>
        </telerik:RadCodeBlock>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true"
                        Width="100%" CssClass="popup-toolbar">
                        <Items>
                            <telerik:RadToolBarButton ImageUrl="Images/ToolBar/AddLine.png" Visible="false" ValidationGroup="Save"
                                CommandName="New" Text="New" meta:resourcekey="RadToolBarButton_New">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" ValidationGroup="Save"
                                CommandName="Save">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"
                                ValidationGroup="Save">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <asp:Panel ID="pnlMain" runat="server">
            <div id="trTbsDetails" class="PMMainPage PMPopupMainPage">
                <div class="row documentSinglePage">
                    <div class="col-4 col-4-left">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth" style="width:160px !important">
                                    <asp:Label ID="lblCostCode" runat="server" meta:resourcekey="lblCostCode" Text="Cost Code*"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlCostCodes" runat="server" Width="100%"
                                        EnableItemCaching="false" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Cost Code..."
                                        AutoPostBack="true" NoWrap="True" AllowCustomText="False" EnableLoadOnDemand="True"
                                        ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                        Style="font-size: 11px" Height="150px" TabIndex="1">
                                    </telerik:RadComboBox>
                                    <div>
                                        <asp:RequiredFieldValidator ID="rfvCostCodes" runat="server" ControlToValidate="ddlCostCodes"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb ,WarningMsg_CostCodeRequired%>"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvCostCodes" runat="server" ControlToValidate="ddlCostCodes"
                                            ClientValidationFunction="ValidateCostCodesCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_CostCodeRequired %>">
                                        </asp:CustomValidator>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblWorksheetColumn" runat="server" meta:resourcekey="lblWorksheetColumn"
                                        Text="Worksheet Column*"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlWorksheetColumns" AllowCustomText="True" Filter="Contains"  Width="100%" runat="server" AutoPostBack="true"
                                        ValidationGroup="Save" TabIndex="1">
                                    </telerik:RadComboBox>
                                    <div>
                                         <asp:RequiredFieldValidator ID="cmvWorksheetColumns" runat="server" ControlToValidate="ddlWorksheetColumns"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                            Display="Dynamic" ForeColor="" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                    </div>
                                </td>
                            </tr>
                            <%--<tr>
                        <td>
                            <asp:Label ID="lblCompany" runat="server" meta:resourcekey="lblCompany" Text="Company11"></asp:Label>
                        </td>
                        <td style="padding-left: 10px;">
                            <telerik:RadComboBox ID="ddlCompanies" runat="server" Height="200px"  Skin="Default" Width="200px" DropDownWidth="220px"
                                CloseDropDownOnBlur="true" meta:resourcekey="ddlCompanies" EmptyMessage="Select Company...11" NoWrap="False"
                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged" OnClientDropDownClosed="dllcompClientClosed">
                                <CollapseAnimation Duration="200" Type="OutQuint" />
                            </telerik:RadComboBox>
                            <asp:HiddenField ID="HiddenField1" runat="server" />
                            <asp:ImageButton runat="server" ID="imgfilter" ImageUrl="~/Images/FileManager/preview.png" OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter','HiddenField1'),this.id.replace('imgfilter','ddlCompanies'),'Companies')" />
                        </td>
                    </tr>--%>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatus" Text="Status*"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlStatus" Width="100%" runat="server" AutoPostBack="true"
                                        TabIndex="3">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblDescription" runat="server" meta:resourcekey="lblDescription" Text="Description"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtDescription" runat="server" Text="" TabIndex="4"></asp:TextBox>
                                </td>
                            </tr>

                            <tr>
                                <td colspan="2">
                                    <table id="tblAdjustmentCalculation" runat="server" cellpadding="0" cellspacing="1"
                                        style="border: 1px solid #d5d5d5; border-width: 0px 1px 1px 0px; width: 100%">
                                        <tr>
                                            <td style="width: 75px; text-align: center; background-color: #eef6fd;">
                                                <asp:Label ID="lblField" runat="server" meta:resourcekey="lblField" Text="Field11"></asp:Label>
                                            </td>
                                            <td style="width: 75px; text-align: center; background-color: #eef6fd;">
                                                <asp:Label ID="lblCurrent" runat="server" meta:resourcekey="lblCurrent" Text="Current11"></asp:Label>
                                            </td>
                                            <td style="width: 75px; text-align: center; background-color: #eef6fd;">
                                                <asp:Label ID="lblAdjustment" runat="server" meta:resourcekey="lblAdjustment" Text="Adjustment11"></asp:Label>
                                            </td>
                                            <td style="width: 75px; text-align: center; background-color: #eef6fd;">
                                                <asp:Label ID="lblTotal" runat="server" meta:resourcekey="lblTotal" Text="Totlal11"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr id="trquantity" runat="server">
                                            <td style="background-color: #e4e5f0;">
                                                <asp:Label ID="lblQuantity" runat="server" meta:resourcekey="lblQuantity" Text="Quantity11"></asp:Label>
                                            </td>
                                            <td style="background-color: #e4e5f0; text-align: right">
                                                <asp:Label ID="lblCurrentQuantity" runat="server" CssClass="Double"></asp:Label>
                                            </td>
                                            <td style="text-align: center;">
                                                <asp:TextBox ID="txtAdjustmentQuantity" CssClass="Double" MaxLength="15" runat="server"
                                                    Width="70px" TabIndex="5"></asp:TextBox>
                                            </td>
                                            <td style="text-align: center;">
                                                <asp:TextBox ID="txtTotalQuantity" CssClass="Double" MaxLength="15" runat="server"
                                                    Width="70px" TabIndex="8"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr id="trUnitCost" runat="server">
                                            <td style="background-color: #e4e5f0;">
                                                <asp:Label ID="lblUnitCost" runat="server" meta:resourcekey="lblUnitCost" Text="Unit Cost11"></asp:Label>
                                            </td>
                                            <td style="background-color: #e4e5f0; text-align: right">
                                                <asp:Label ID="lblCurrentUnitCost" runat="server" CssClass="Currency"></asp:Label>
                                            </td>
                                            <td style="text-align: center;">
                                                <asp:TextBox ID="txtAdjustmentUnitCost" CssClass="Currency" MaxLength="15" runat="server"
                                                    Width="70px" TabIndex="6"></asp:TextBox>
                                            </td>
                                            <td style="text-align: center;">
                                                <asp:TextBox ID="txtTotalUnitCost" CssClass="Currency" MaxLength="15" runat="server"
                                                    Width="70px" TabIndex="9"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="background-color: #e4e5f0;">
                                                <asp:Label ID="lblTotalAmount" runat="server" meta:resourcekey="lblTotalAmount" Text="Total Amount11"></asp:Label>
                                            </td>
                                            <td style="background-color: #e4e5f0; text-align: right">
                                                <asp:Label ID="lblCurrentTotalCost" runat="server" CssClass="Currency"></asp:Label>
                                            </td>
                                            <td style="text-align: center;">
                                                <asp:TextBox ID="txtAdjustmentTotalCost" CssClass="Currency" MaxLength="15" runat="server"
                                                    Width="70px" TabIndex="7"></asp:TextBox>
                                            </td>
                                            <td style="text-align: center;">
                                                <asp:TextBox ID="txtTotalCost" CssClass="Currency" MaxLength="15" runat="server"
                                                    Width="70px" TabIndex="10"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-4 col-4-right">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth" style="width:160px !important">
                                    <asp:Label ID="lblUOM" runat="server" meta:resourcekey="lblUOM" Text="UOM"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlUOMs" Width="100%" runat="server" Filter="Contains" MarkFirstMatch="true"
                                        Skin="Default" AllowCustomText="true" Height="150px" TabIndex="11">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <%--<tr>
                        <td>
                            <asp:Label ID="lblCostType" runat="server" meta:resourcekey="lblCostType" Text="Cost Type11"></asp:Label>
                        </td>
                        <td style="padding-left: 10px;">
                            <asp:DropDownList ID="ddlCostType" runat="server" Width="200px"></asp:DropDownList>
                        </td>
                    </tr>--%>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblPeriod" runat="server" meta:resourcekey="lblPeriod" Text="Period"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlPeriods" runat="server" Width="100%"
                                        EnableItemCaching="false" OnItemsRequested="ddl_ItemsRequested"
                                        Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Period..." meta:resourcekey="ddlPeriods"
                                        NoWrap="True" AllowCustomText="False" Style="font-size: 11px" Height="250px"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblReqCode" runat="server" meta:resourcekey="lblReqCode" Text="Req Code"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlReqCodes" runat="server" AllowCustomText="false" Skin="Default"
                                        CloseDropDownOnBlur="true" Width="100%" AutoPostBack="false" DropDownCssClass="ddlTreeviewTemplate"
                                        NoWrap="true" Height="250px" CausesValidation="False" TabIndex="13">
                                        <Items>
                                            <telerik:RadComboBoxItem Text="" />
                                        </Items>
                                        <ItemTemplate>
                                            <telerik:RadTreeView ID="rdvReqCode" Skin="Default" runat="server" Height="220px"
                                                MultipleSelect="false" ShowLineImages="false" OnClientNodeClicking="rdvReqNodeClicking"
                                                OnNodeDataBound="rdvReqCode_NodeDataBound" OnNodeExpand="rdvReqCode_NodeExpand">
                                            </telerik:RadTreeView>
                                        </ItemTemplate>
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblNotes" runat="server" meta:resourcekey="lblNotes" Text="Notes"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtNotes" TextMode="MultiLine" runat="server" Text=""
                                        TabIndex="14"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <asp:Panel ID="pnlScripts" runat="server">
            </asp:Panel>
        </asp:Panel>
    </form>
</body>
</html>
