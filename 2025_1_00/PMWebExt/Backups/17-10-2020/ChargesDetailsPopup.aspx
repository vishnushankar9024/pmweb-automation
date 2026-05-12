<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="ChargesDetailsPopup.aspx.vb" Inherits="Website.ChargesDetailsPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <style type="text/css">
        .col-150{
            width: 150px;
            float: left;
        }

        @media screen and (min-width:668px) {
            .row {
                padding-top: 0px !important;
            }

            .col-150 {
                padding: 24px 24px 0 0;
                border-right: 1px solid rgb(153, 153, 153);
            }

            .col-4 {
                padding-top: 24px;
                padding-left: 24px;
            }
        }
        @media screen and (max-width:597px) {
            .col-4{    
                padding-top: 24px;
            }
        }
        
        @media screen and (min-width:598px) and (max-width:1020px) {
            .col-150{    
                height: calc(100vh - 159px) !important;
            }
        }
        @media screen and (min-width:1020px) {
            .col-150 {
                height: calc(100vh - 160px) !important;
            }
        }
    </style>
    <script type="text/javascript">
        function HideTextBox(txtId) {
            var id = "input[id$=" + txtId + "]"
            $(id).hide();

        }
        function HideTable(tblId) {
            var tbl = $("#" + tblId);
            tbl.hide();

        }
        function ShowTable(tblId) {
            var tbl = $("#" + tblId);
            tbl.show();

        }
        function pageLoad() {
            //        $('input[id$=txtRoundToNearest]').change(function (sender) {
            //            var result = CDbl($("input[id$=txtRoundToNearest]").val());
            //            if (result <= 0)
            //                $("input[id$=txtRoundToNearest]").val(CCur(1));


            //        });
            //        $('input[id$=txtRecoveryRoundToNearest]').change(function (sender) {
            //            var result = CDbl($("input[id$=txtRecoveryRoundToNearest]").val());
            //            if (result <= 0)
            //                $("input[id$=txtRecoveryRoundToNearest]").val(CCur(1));


            //        });

            $('input[id$=txtLowerThreshold]').change(function (sender) {
                var res = $("input[id=chkNoUpperThreshold]")[0].checked;
                if (res == false) {
                    CheckUpperThreshold();
                }


            });
            //        $("input[id=chkNoRoundToNearest]").click(function (sender) {

            //            var res = $("input[id=chkNoRoundToNearest]")[0].checked;
            //            if (res == true) {
            //                $("input[id$=txtRoundToNearest]").hide();

            //            }
            //            else {
            //                $("input[id$=txtRoundToNearest]").show();
            //            }
            //        });
            //        $("input[id=chkRecoveryNoRoundToNearest]").click(function (sender) {

            //            var res = $("input[id=chkRecoveryNoRoundToNearest]")[0].checked;
            //            if (res == true) {
            //                $("input[id$=txtRecoveryRoundToNearest]").hide();

            //            }
            //            else {
            //                $("input[id$=txtRecoveryRoundToNearest]").show();
            //            }
            //        });
            $("input[id=chkNoLowerThreshold]").click(function (sender) {

                var res = $("input[id=chkNoLowerThreshold]")[0].checked;
                if (res == true) {
                    $("input[id$=txtLowerThreshold]").hide();

                }
                else {
                    $("input[id$=txtLowerThreshold]").show();



                }
            });
            $("input[id=chkNoUpperThreshold]").click(function (sender) {

                var res = $("input[id=chkNoUpperThreshold]")[0].checked;
                if (res == true) {
                    $("input[id$=txtUpperThreshold]").hide();

                }
                else {
                    $("input[id$=txtUpperThreshold]").show();



                }
            });
            $('input[id$=txtUpperThreshold]').change(function (sender) {
                var res = $("input[id=chkNoLowerThreshold]")[0].checked;
                if (res == false) {
                    CheckUpperThreshold();
                }

            });

            $('input[id$=txtRecoveryLowerThreshold]').change(function (sender) {
                var res = $("input[id=chkRecoveryNoUpperThreshold]")[0].checked;
                if (res == false) {
                    CheckRecoveryUpperThreshold();
                }


            });

            $('input[id$=txtRecoveryUpperThreshold]').change(function (sender) {
                var res = $("input[id=chkRecoveryNoLowerThreshold]")[0].checked;
                if (res == false) {
                    CheckRecoveryUpperThreshold();
                }

            });


            $("input[id=chkRecoveryNoLowerThreshold]").click(function (sender) {

                var res = $("input[id=chkRecoveryNoLowerThreshold]")[0].checked;
                if (res == true) {
                    $("input[id$=txtRecoveryLowerThreshold]").hide();

                }
                else {
                    $("input[id$=txtRecoveryLowerThreshold]").show();



                }
            });
            $("input[id=chkRecoveryNoUpperThreshold]").click(function (sender) {

                var res = $("input[id=chkRecoveryNoUpperThreshold]")[0].checked;
                if (res == true) {
                    $("input[id$=txtRecoveryUpperThreshold]").hide();

                }
                else {
                    $("input[id$=txtRecoveryUpperThreshold]").show();



                }
            });


        }

        function CheckUpperThreshold() {
            //     LowerThreshold = CDbl($("input[id$=txtLowerThreshold]").val());
            //            UpperTheashold = CDbl($("input[id$=txtUpperThreshold]").val());

            //            if (LowerThreshold > UpperTheashold) {
            //                $("input[id$=txtUpperThreshold]").val(CCur(LowerThreshold));

            //            }


        }
        function CheckRecoveryUpperThreshold() {
            //          var  LowerThreshold = CDbl($("input[id$=txtRecoveryLowerThreshold]").val());
            //          var  UpperTheashold = CDbl($("input[id$=txtRecoveryUpperThreshold]").val());

            //            if (LowerThreshold > UpperTheashold) {
            //                $("input[id$=txtRecoveryUpperThreshold]").val(CCur(LowerThreshold));

            //            }


        }
        function NodeChecked(sender, eventArgs) {
            var combo = $find("ddlCostCodes");
            var node = eventArgs.get_node();
            var checked = node.get_checked();
            var childNodes = node.get_nodes();
            if (checked == true) {
                UncheckAllChildren(childNodes);
                UncheckAllParent(node);
                var tree = $find(node.get_treeView().get_id());
                if (node.get_value() == "-1") {
                    var allCheckedNodes = tree.get_checkedNodes();
                    var TotalChecked = allCheckedNodes.length
                    for (var i = TotalChecked - 1; i >= 0; i--) {
                        var CkeckedNode = allCheckedNodes[i];
                        if (CkeckedNode.get_value() != "-1") {
                            CkeckedNode.set_checked(false);

                        }

                    }



                }
                else {
                    var AllNode = tree.findNodeByValue("-1");
                    if (AllNode != null)
                        AllNode.set_checked(false);
                }
                var selectedCount = tree.get_checkedNodes()
                if (selectedCount.length == 1) {

                    var SelectedNode = tree.get_checkedNodes()[0];
                    if (SelectedNode.get_value() == "-1")
                        combo.set_text(SelectedNode.get_text());
                    else
                        combo.set_text($("input[id$=hdnCostCodeSelectedMsg]").val());


                }
                else if (selectedCount.length > 1) {

                    combo.set_text($("input[id$=hdnCostCodeSelectedMsg]").val());
                }
                else
                    combo.set_text("");

                return;
            }

            var rdvtree = $find(node.get_treeView().get_id());
            var AllCheckedCount = rdvtree.get_checkedNodes().length;
            if (AllCheckedCount == 0) {
                combo.set_text("");

            }


        }
        function UncheckAllParent(node) {

            node = node.get_parent();
            while (node != null && node._element.id.toString().indexOf("ddlCostCodes") == -1) {
                node.set_checked(false);
                node = node.get_parent();
            }
        }
        function UncheckAllChildren(nodes) {
            var i;
            for (i = 0; i < nodes.get_count() ; i++) {
                nodes.getNode(i).set_checked(false);

                if (nodes.getNode(i).get_nodes().get_count() > 0)
                    UncheckAllChildren(nodes.getNode(i).get_nodes());

            }

        }

        //        function OnClientDropdownClosing(sender, args) {
        //          
        //      
        //            if (args.get_domEvent().target == sender.get_imageDomElement()) {

        //                args.set_cancel(false);
        //            }

        //            if (typeof args.get_domEvent().target == 'undefined')
        //                args.set_cancel(true);
        //            else
        //                args.set_cancel(false);
        //        
        //        }

    </script>
</head>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdbChargeDetails">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="tblDetails" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel" Value="Cancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <div class="PMMainPage PMPopupMainPage documentSinglePage" style="padding: 0px; margin-bottom: 0px;">
            <div class="row" style="padding-top: 0px;">
                <telerik:RadGrid ID="rdgLeaseCharges" runat="server" AutoGenerateColumns="False" ShowStatusBar="False" HeaderStyle-Font-Size="8" setwidth="true"
                    ShowGroupPanel="false" AllowMultiRowEdit="True" PageSize="20" AllowPaging="False" AllowMultiRowSelection="False" AllowSorting="False" ItemStyle-Height="20px" GridLines="None">
                    <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="None"
                        InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true" EditMode="InPlace"
                        EnableHeaderContextMenu="False">

                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" HeaderStyle-Wrap="false"
                                Groupable="false" Reorderable="false" AllowFiltering="false">
                                <ItemTemplate>
                                    <span><%#Container.DataItem("LineNumber").ToString%></span>
                                </ItemTemplate>

                                <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Start" UniqueName="StartDate"
                                HeaderStyle-Width="120px">
                                <ItemTemplate>
                                    <span><%#FormatDate(Container.DataItem("StartDate"))%>&nbsp;</span>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="End" UniqueName="EndDate"
                                HeaderStyle-Width="120px">
                                <ItemTemplate>
                                    <span><%#FormatDate(Container.DataItem("EndDate"))%>&nbsp;</span>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderStyle-Width="100px" ItemStyle-Wrap="false" HeaderText="Type" UniqueName="Type" DataField="Type"
                                Groupable="false">
                                <ItemTemplate>
                                    <span><%#Eval("Type").ToString%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="100px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderStyle-Width="120px" HeaderText="Description" ItemStyle-Wrap="false" UniqueName="Description" DataField="Description"
                                Groupable="false">
                                <ItemTemplate>
                                    <span><%#Eval("Description").ToString%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="120px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderStyle-Width="90px" ItemStyle-Wrap="false" HeaderText="Post Every" UniqueName="PostEvery" DataField="PostEvery"
                                Groupable="false">
                                <ItemTemplate>
                                    <span><%# Eval("PostEvery").ToString%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="90px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderStyle-Width="70px" ItemStyle-Wrap="false" HeaderText="Est." UniqueName="Est" DataField="Est"
                                Groupable="false">
                                <ItemTemplate>
                                    <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("Est"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                                <HeaderStyle Width="70px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Amount" ItemStyle-Wrap="false" UniqueName="Amount" DataField="Amount"
                                Groupable="false" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <span><%# FormatCurrency(Eval("Amount"))%>&nbsp;</span>
                                </ItemTemplate>
                                <HeaderStyle Width="100px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Annualized" ItemStyle-Wrap="false" UniqueName="Annualized" DataField="Annualized"
                                Groupable="false" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <span><%# FormatCurrency(Eval("Annualized"))%>&nbsp;</span>
                                </ItemTemplate>
                                <HeaderStyle Width="100px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Annual" ItemStyle-Wrap="false" UniqueName="Annual" DataField="Annual"
                                Groupable="false" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <span><%# FormatCurrency(Eval("Annual"))%>&nbsp;</span>
                                </ItemTemplate>
                                <HeaderStyle Width="100px"></HeaderStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderStyle-Width="100px" ItemStyle-Wrap="false" HeaderText="Cost Code" UniqueName="CostCode" DataField="CostCode"
                                Groupable="false">
                                <ItemTemplate>
                                    <span><%# Eval("CostCode").ToString%>&nbsp;</span>
                                </ItemTemplate>
                                <HeaderStyle Width="100px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Last Posted" UniqueName="LastPostedDate"
                                HeaderStyle-Width="90px">
                                <ItemTemplate>
                                    <span><%#FormatDate(Container.DataItem("LastPostedDate"))%>&nbsp;</span>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Next Posting" UniqueName="NextPostingDate"
                                HeaderStyle-Width="90px">
                                <ItemTemplate>
                                    <span><%#FormatDate(Container.DataItem("NextPostingDate"))%>&nbsp;</span>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn HeaderText="Asset(s)" UniqueName="LinkedAssets" HeaderStyle-Width="175px">
                                <ItemTemplate>
                                    <%#IIf(Container.DataItem("LinkedAssets").ToString = String.Empty, "&nbsp;", Container.DataItem("LinkedAssets").ToString)%>&nbsp;
                                                           
                                </ItemTemplate>

                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderStyle-Width="200px" HeaderText="Notes" ItemStyle-Wrap="false" UniqueName="Notes" DataField="Notes"
                                Groupable="false">
                                <ItemTemplate>
                                    <span><%#Eval("Notes").ToString%>&nbsp;</span>
                                </ItemTemplate>
                                <HeaderStyle Width="200px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderStyle-Width="70px" HeaderText="Charge ID" ItemStyle-Wrap="false" UniqueName="ChargeID" DataField="ChargeID"
                                Groupable="false">
                                <ItemTemplate>
                                    <span><%# Eval("ChargeID").ToString%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="70px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderStyle-Width="70px" ItemStyle-Wrap="false" HeaderText="Inactive" UniqueName="Inactive" DataField="Inactive"
                                Groupable="false">
                                <ItemTemplate>
                                    <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("Inactive"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                                <HeaderStyle Width="70px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderStyle-Width="70px" HeaderText="System Id" ItemStyle-Wrap="false" UniqueName="Id" DataField="Id"
                                Groupable="false">
                                <ItemTemplate>
                                    <span><%# Eval("Id").ToString%></span>
                                </ItemTemplate>
                                <HeaderStyle Width="70px" />
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                    <ClientSettings AllowDragToGroup="False" Resizing-AllowColumnResize="true">
                        <Selecting AllowRowSelect="False" EnableDragToSelectRows="false" />
                    </ClientSettings>
                </telerik:RadGrid>
            </div>
        </div>
        <div class="PMMainPage PMPopupMainPage">
            <div class="row">
                <div class="col-6">
                    <div class="col-150">
                        <asp:RadioButtonList ID="rdbChargeDetails" Enabled="true" AutoPostBack="true" runat="server" RepeatDirection="Vertical" CssClass="RadioCss RadioPadding">
                            <asp:ListItem Text="ESCALATION" meta:resourcekey="rdbEscalation" Value="Escalation" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="RECOVERY" meta:resourcekey="rdbRecovery" Value="Recovery"></asp:ListItem>
                            <asp:ListItem Text="OVERAGE" meta:resourcekey="rdbOverage" Value="Overage"></asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                    <div class="col-4" style="float: left;">
                        <table id="tblEsc" runat="server" class="colTable">
                            <tr>
                                <td class="labelWidth" style="width: 160px !important;">
                                    <asp:Label ID="lblIndex" runat="server" meta:resourcekey="lblIndex" Text="Index"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <table width="100%" class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td width="70%">
                                                <telerik:RadComboBox ID="ddlIndex" AllowCustomText="true" Filter="Contains" runat="server"
                                                    Skin="Default" Style="font-size: 11px" Width="100%"
                                                    AutoPostBack="True" NoWrap="true" CausesValidation="False" Height="300px"
                                                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" OnItemsRequested="ddl_ItemsRequested"
                                                    EnableVirtualScrolling="True">
                                                </telerik:RadComboBox>
                                            </td>
                                            <td width="30%" style="padding-left: 8px;">
                                                <asp:TextBox ID="txtIndex" runat="server" CssClass="Percent"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth" style="width: 160px !important;">
                                    <asp:Label ID="lblNextIndex" runat="server" meta:resourcekey="lblNextIndex" Text="Next Index"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <table width="100%" class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td width="70%">
                                                <telerik:RadComboBox ID="ddlNextIndex" AllowCustomText="true" Filter="Contains" runat="server"
                                                    Skin="Default" Style="font-size: 11px" Width="100%"
                                                    AutoPostBack="True" NoWrap="true" CausesValidation="False" Height="300px"
                                                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" OnItemsRequested="ddl_ItemsRequested"
                                                    EnableVirtualScrolling="True">
                                                </telerik:RadComboBox>
                                            </td>
                                            <td width="30%" style="padding-left: 8px;">
                                                <asp:TextBox ID="txtNextIndex" Enabled="false" runat="server" CssClass="Double"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth" style="width: 160px !important;">
                                    <asp:Label ID="lblPreviousIndex" runat="server" meta:resourcekey="lblPreviousIndex" Text="Previous Index"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <table width="100%" class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td width="70%">
                                                <telerik:RadComboBox ID="ddlPreviousIndex" AllowCustomText="true" Filter="Contains" runat="server"
                                                    Skin="Default" Style="font-size: 11px" Width="100%"
                                                    AutoPostBack="True" NoWrap="true" CausesValidation="False" Height="300px"
                                                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" OnItemsRequested="ddl_ItemsRequested"
                                                    EnableVirtualScrolling="True">
                                                </telerik:RadComboBox>
                                            </td>
                                            <td width="30%" style="padding-left: 8px;">
                                                <asp:TextBox ID="txtPreviousIndex" Enabled="false" runat="server" CssClass="Double"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth" style="width: 160px !important;">
                                    <asp:Label ID="lblPercentageOfIndexChange" runat="server" meta:resourcekey="lblPercentageOfIndexChange" Text="% Of Index Change"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <table width="100%" class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td width="70%"></td>
                                            <td width="30%" style="padding-left: 8px;">
                                                <asp:TextBox ID="txtPercentageOfIndexChange" runat="server" CssClass="Percent" MaxNumber="100" MinNumber="0"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth" style="width: 160px !important;">
                                    <asp:Label ID="lblBase" runat="server" meta:resourcekey="lblBase" Text="Base"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <table width="100%" class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td width="70%">
                                                <telerik:RadComboBox ID="ddlBase" AllowCustomText="true" Filter="Contains"
                                                    runat="server" Skin="Default" Style="font-size: 11px" Width="100%"
                                                    AutoPostBack="True" NoWrap="true" CausesValidation="False" Height="300px"
                                                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" OnItemsRequested="ddl_ItemsRequested"
                                                    EnableVirtualScrolling="True">
                                                </telerik:RadComboBox>
                                            </td>
                                            <td width="30%" style="padding-left: 8px;">
                                                <asp:TextBox ID="txtBase" CssClass="Currency" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth" style="width: 160px !important;">
                                    <asp:Label ID="lblLowerThreshold" runat="server" meta:resourcekey="lblLowerThreshold" Text="Lower Threshold"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <table width="100%" class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td width="70%" class="mobile-switch">
                                                <asp:CheckBox ID="chkNoLowerThreshold" AutoPostBack="false" runat="server" />
                                            </td>
                                            <td width="30%" style="padding-left: 8px;">
                                                <asp:TextBox ID="txtLowerThreshold" CssClass="Currency" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth" style="width: 160px !important;">
                                    <asp:Label ID="lblUpperThreshold" runat="server" meta:resourcekey="lblUpperThreshold" Text="Upper Threshold"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <table width="100%" class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td width="70%" class="mobile-switch">
                                                <asp:CheckBox ID="chkNoUpperThreshold" AutoPostBack="false" runat="server" />
                                            </td>
                                            <td width="30%" style="padding-left: 8px;">
                                                <asp:TextBox ID="txtUpperThreshold" CssClass="Currency" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    <asp:Label ID="lblUpperThresholdValidator" Visible="false" CssClass="Validator" runat="server" meta:resourcekey="lblUpperThresholdValidator" Text="Upper Threshold must be greater than or equal to Lower Threshold"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth" style="width: 160px !important;">
                                    <asp:Label ID="lblNewLine" runat="server" meta:resourcekey="chkNewLine" Text="New Line"></asp:Label></td>
                                <td class="controlWidth">
                                    <table width="100%" class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td width="70%" class="mobile-switch">
                                                <asp:CheckBox ID="chkNewLine" runat="server" />
                                            </td>
                                            <td width="30%" style="padding-left: 8px;"></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth" style="width: 160px !important;">
                                    <asp:Label ID="lblEscalateEvery" runat="server" meta:resourcekey="lblEscalateEvery" Text="Escalate Every"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <table width="100%" class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td width="70%">
                                                <telerik:RadComboBox ID="ddlPostEvery" runat="server" AllowCustomText="false"
                                                    Skin="Default" CloseDropDownOnBlur="true" Width="100%" NoWrap="true" CausesValidation="False"
                                                    TabIndex="2">
                                                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                </telerik:RadComboBox>
                                            </td>
                                            <td width="30%" style="padding-left: 8px;"></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth" style="width: 160px !important;">
                                    <asp:Label ID="lblLastEscalation" runat="server" meta:resourcekey="lblLastEscalation" Text="Last Escalation"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <table width="100%" class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td width="70%">
                                                <asp:TextBox runat="server" ID="txtLastEscalation" Enabled="false"></asp:TextBox>
                                            </td>
                                            <td width="30%" style="padding-left: 8px;"></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth" style="width: 160px !important;">
                                    <asp:Label runat="server" ID="lblNextEscalation" Text="Next Escalation" meta:resourcekey="lblNextEscalation"></asp:Label>
                                </td>
                                <td class="controlWidth">

                                    <table width="100%" class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td width="70%">
                                                <telerik:RadDatePicker ID="dtpNextEscalation" Enabled="false" AutoPostBack="false" runat="server" Width="100%" MinDate="1901-01-01" MaxDate="2100-01-01" Skin="Default" EnableTyping="True">
                                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" Skin="Default"></Calendar>
                                                    <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                                    <DateInput ID="DateInput7" Skin="Default" runat="server" AutoPostBack="false"></DateInput>
                                                </telerik:RadDatePicker>
                                            </td>
                                            <td width="30%" style="padding-left: 8px;"></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr runat="server" visible="false">
                                <td class="labelWidth" style="width: 160px !important;">
                                    <asp:Label ID="lblRoundToNearest" Visible="false" runat="server" meta:resourcekey="lblRoundToNearest" Text="Round To Nearest"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <table width="100%" class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td width="70%" class="mobile-switch">
                                                <asp:CheckBox ID="chkNoRoundToNearest" Visible="false" AutoPostBack="false" runat="server" />
                                            </td>
                                            <td width="30%" style="padding-left: 8px;">
                                                <asp:TextBox ID="txtRoundToNearest" Visible="false" CssClass="Currency" runat="server" Width="100px"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr runat="server" visible="false">
                                <td class="labelWidth" style="width: 160px !important;"></td>
                                <td class="controlWidth">
                                    <table width="100%" class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td width="70%"></td>
                                            <td width="30%" style="padding-left: 8px;" class="mobile-switch">
                                                <asp:CheckBox ID="chkReconcil" Visible="false" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>

                        <%--  <table>
                            <tr>
                                <td>
                                    <asp:LinkButton ID="imgActive" meta:resourcekey="imgActive" runat="server">
                                    <span class="Icon"></span>
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </table>--%>
                        <%--</fieldset>--%>

                        <table id="tblRecovery" width="100%" border="0" runat="server" class="colTable">
                            <tr>
                                <td class="labelWidth" style="width: 160px !important;">
                                    <asp:Label ID="lblProrationMethod" runat="server" meta:resourcekey="lblProrationMethod" Text="Proration Method"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <table width="100%" class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td width="70%">
                                                <telerik:RadComboBox ID="ddlProrationMethod" AllowCustomText="true" Filter="Contains" runat="server" AutoPostBack="true" Skin="Default" Style="font-size: 11px" Width="100%"></telerik:RadComboBox>
                                            </td>
                                            <td width="30%" style="padding-left: 8px;">
                                                <asp:TextBox ID="txtProrationMethod" runat="server" CssClass="Percent" MaxNumber="100" MinNumber="0"></asp:TextBox></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth" style="width: 160px !important;">
                                    <asp:Label ID="lblPercentageFactor" runat="server" meta:resourcekey="lblPercentageFactor" Text="Percentage Factor"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <table width="100%" class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td width="70%"></td>
                                            <td width="30%" style="padding-left: 8px;">
                                                <asp:TextBox ID="txtPercentageFactor" runat="server" CssClass="Percent" MaxNumber="100" MinNumber="0"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth" style="width: 160px !important;">
                                    <asp:Label ID="lblRecoveryLowerThreshold" runat="server" meta:resourcekey="lblLowerThreshold" Text="Lower Threshold"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <table width="100%" class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td width="70%" class="mobile-switch">
                                                <asp:CheckBox ID="chkRecoveryNoLowerThreshold" runat="server" /></td>
                                            <td width="30%" style="padding-left: 8px;">
                                                <asp:TextBox ID="txtRecoveryLowerThreshold" CssClass="Currency" runat="server"></asp:TextBox></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth" style="width: 160px !important;">
                                    <asp:Label ID="lblRecoveryUpperThreshold" runat="server" meta:resourcekey="lblUpperThreshold" Text="Upper Threshold"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <table width="100%" class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td width="70%" class="mobile-switch">
                                                <asp:CheckBox ID="chkRecoveryNoUpperThreshold" runat="server" />
                                            </td>
                                            <td width="30%" style="padding-left: 8px;">
                                                <asp:TextBox ID="txtRecoveryUpperThreshold" CssClass="Currency" runat="server"></asp:TextBox>

                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth"></td>
                                <td class="controlWidth">
                                    <asp:Label ID="lblRecoveryUpperThresholdValidator" Visible="false" CssClass="Validator" runat="server" meta:resourcekey="lblUpperThresholdValidator" Text="Upper Threshold must be greater than or equal to Lower Threshold"></asp:Label>
                                </td>
                            </tr>
                            <tr runat="server" visible="false">
                                <td class="labelWidth" style="width: 160px !important;">
                                    <asp:Label ID="lblRecoveryRoundToNearest" Visible="false" runat="server" meta:resourcekey="lblRoundToNearest" Text="Round To Nearest"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <table width="100%" class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td width="70%" class="mobile-switch">
                                                <asp:CheckBox ID="chkRecoveryNoRoundToNearest" Visible="false" runat="server" /></td>
                                            <td width="30%" style="padding-left: 8px;">
                                                <asp:TextBox ID="txtRecoveryRoundToNearest" Visible="false" CssClass="Currency" runat="server"></asp:TextBox></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth" style="width: 160px !important;">
                                    <asp:Label ID="lblCostCodes" runat="server" meta:resourcekey="lblCostCodes" Text="Cost Codes"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <table width="100%" class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td width="70%">
                                                <telerik:RadComboBox ID="ddlCostCodes" AllowCustomText="false"
                                                    runat="server" Skin="Default" Style="font-size: 11px" Width="100%"
                                                    CloseDropDownOnBlur="true" DropDownCssClass="ddlTreeviewTemplate">
                                                    <Items>
                                                        <telerik:RadComboBoxItem Text="" />
                                                    </Items>
                                                    <ItemTemplate>
                                                        <telerik:RadTreeView ID="rdvCostCodes" Skin="Default" runat="server" CheckBoxes="true"
                                                            Height="250px" MultipleSelect="false" ShowLineImages="false" OnClientNodeChecked="NodeChecked"
                                                            OnNodeExpand="rdvCostCodes_NodeExpand" OnNodeDataBound="rdvCostCodes_NodeDataBound">
                                                        </telerik:RadTreeView>
                                                    </ItemTemplate>
                                                </telerik:RadComboBox>

                                            </td>
                                            <td width="30%" style="padding-left: 8px;"></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr runat="server" visible="false">
                                <td class="labelWidth" style="width: 160px !important;"></td>
                                <td class="controlWidth">
                                    <table width="100%" class="TableNoSpacingNoBorder">
                                        <tr>
                                            <td width="70%"></td>
                                            <td width="30%" class="mobile-switch" style="padding-left: 8px;">
                                                <asp:CheckBox ID="chkRecoveryReconcil" Visible="false" runat="server" />

                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>


                        <%-- <table>
                            <tr>
                                <td>
                                    <asp:LinkButton ID="imgRecoveryActive" meta:resourcekey="imgActive" runat="server">
                                                <span class="Icon"></span>
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </table>--%>
                        <table id="tblOverage" style="width: 100%" runat="server" class="colTable">
                            <tr>
                                <td>
                                    <telerik:RadGrid ID="rdgOverage" runat="server" AutoGenerateColumns="False" ShowStatusBar="False" HeaderStyle-Font-Size="8" Width="70%" setwidth="true" FitPageHeightOffset="24"
                                        ShowGroupPanel="False" AllowMultiRowEdit="true" PageSize="15" AllowPaging="False" AllowMultiRowSelection="true" AllowSorting="False" ItemStyle-Height="20px" GridLines="None">
                                        <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="false" />

                                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="None"
                                            InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true" EditMode="InPlace"
                                            EnableHeaderContextMenu="false">

                                            <Columns>
                                                <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false" HeaderText="Break Point" UniqueName="BreakPoint" DataField="BreakPoint">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtBreakPoint" CssClass="Currency" runat="server" Width="100%" Text='<%#FormatCurrency(Eval("BreakPoint"))%>'></asp:TextBox>
                                                    </ItemTemplate>

                                                    <HeaderStyle Width="120px" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderStyle-Width="120px" ItemStyle-Wrap="false" HeaderText="%" UniqueName="Percent" DataField="Percent">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtPercent" CssClass="Percent" MaxNumber="100" MinNumber="0" runat="server" Width="100%" Text='<%#FormatPercent(Eval("Percent"))%>'></asp:TextBox>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="120px" />
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                        </MasterTableView>
                                        <ClientSettings AllowDragToGroup="False" Resizing-AllowColumnResize="true">
                                            <Selecting AllowRowSelect="true" EnableDragToSelectRows="true" />
                                        </ClientSettings>
                                    </telerik:RadGrid>
                                </td>
                            </tr>
                            <%--<tr>
                                    <td>
                                        <asp:LinkButton ID="imgOverageActive" meta:resourcekey="imgActive" runat="server">
                                    <span class="Icon"></span>
                                        </asp:LinkButton>
                                    </td>
                                </tr>--%>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <asp:HiddenField runat="server" ID="hdnCostCodeSelectedMsg" />
    </form>
</body>
</html>
