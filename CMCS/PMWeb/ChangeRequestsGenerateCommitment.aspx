<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ChangeRequestsGenerateCommitment.aspx.vb" Inherits="Website.ChangeRequestsGenerateCommitment" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script language="javascript" type="text/javascript">
        function pageLoad() {
            CheckParentBox();
        }

        function CheckParentBox() {
            var rdgRights = $("div[id$='rdgLinesToLink']");
            var ParentIsNotChecked = true;
            var i = 0;
            var j = 0;
            var v = 0;
            rdgRights.find("input[type='checkbox']").each(function () {

                if (i > 0) {
                    if (!this.checked && !this.disabled) {
                        if (this.id.indexOf("chkIsIncluded") > 0)
                            ParentIsNotChecked = false;
                    }

                    if (this.disabled && this.id.indexOf("chkIsIncluded") > 0)
                    { j++; }

                    if (this.id.indexOf("chkIsIncluded") > 0) {
                        v++;
                    }
                }
                i++;
            });

            if (!ParentIsNotChecked) {
                rdgRights.find("input[type='checkbox']")[0].checked = false;
            } else {
                if (i > 0) {
                    if (v != j) {
                        rdgRights.find("input[type='checkbox']")[0].checked = true;
                    }
                    else {
                        rdgRights.find("input[type='checkbox']")[0].checked = false;
                    }

                }

            }
        }

        function SelectAll(chk) {
            $("#rdgLinesToLink").find("input[type='checkbox']").each(function () {
                if (!this.disabled && this.id.indexOf("chkIsIncluded") > 0) {
                    this.checked = chk.checked;
                }
            });
        }

        function SelectParent(chk) {
            var chkParent = $("#rdgLinesToLink").find("input[type='checkbox']")[0];

            var i = 0;
            var isChecked = true;
            $("#rdgLinesToLink").find("input[type='checkbox']").each(function () {
                if (i != 0) {
                    if (chk.checked) {
                        if (!this.checked && !this.disabled && this.id.indexOf("chkIsIncluded") > 0) {
                            isChecked = false;
                        }


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
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
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
        <div class="PMMainPage JustifyContent">
            <div class="row documentSinglePage" style="margin-bottom:0px !important;">
                <div class="col-4 col-4-left ">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCompany" runat="server" Text="Company" meta:Resourcekey="lblCompany"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtCompany" Enabled="false" runat="server" Width="100%" ReadOnly="true"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblProject" runat="server" Text="Project*" meta:Resourcekey="lblProject"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtProject" Enabled="false" runat="server" Width="100%" ReadOnly="true"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCommitment" runat="server" Text="Commitment*" meta:Resourcekey="lblCommitment"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtCommitment" Enabled="false" runat="server" Width="100%" ReadOnly="true"></asp:TextBox>
                            </td>
                        </tr>


                    </table>
                </div>
                <div class="col-4 col-4-middle">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDescription" runat="server" Text="Description" meta:Resourcekey="lblDescription"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtDescription" Enabled="false" runat="server" Width="100%" ReadOnly="true"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblReference" runat="server" Text="Reference" meta:Resourcekey="lblReference"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtReference" Enabled="false" runat="server" Width="100%" ReadOnly="true"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblRecordNumber" runat="server" Text="Record #" meta:Resourcekey="lblRecordNumber"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtRecordNumber" Enabled="false" runat="server" Width="100%" ReadOnly="true"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-4 col-4-right">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblType" runat="server" Text="Type" meta:Resourcekey="lblType"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtType" Enabled="false" runat="server" Width="100%" ReadOnly="true"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCategory" runat="server" Text="Category" meta:Resourcekey="lblCategory"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtCategory" Enabled="false" runat="server" Width="100%" ReadOnly="true"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblPostAs" runat="server" Text="Post As" meta:Resourcekey="lblPostAs"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtPostAs" Enabled="false" runat="server" Width="100%" ReadOnly="true"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <table class="colTable">
                        <tr>
                            <td>
                                <asp:Label ID="lblCostCodeRequired" Visible="false" runat="server" CssClass="Validator" meta:Resourcekey="lblCostCodeRequired"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <fieldset>
                                    <legend>
                                        <asp:Label ID="lblLinesToLink" runat="server" meta:resourcekey="lblLinesToLink" Text="Select Lines to Link"></asp:Label></legend>
                                    <telerik:RadGrid ID="rdgLinesToLink" runat="server" AutoGenerateColumns="False" ShowStatusBar="True" HeaderStyle-Font-Size="8"
                                        ShowGroupPanel="false" AllowMultiRowEdit="false" AllowMultiRowSelection="True" AllowSorting="true" ItemStyle-Height="20px" GridLines="None" setwidth="true"
                                        AllowPaging="true" PageSize="250">
                                        <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="None"
                                            TableLayout="Fixed" UseAllDataFields="true" EnableHeaderContextMenu="true">

                                            <Columns>

                                                <telerik:GridTemplateColumn HeaderText="Select" UniqueName="MasterSelect"
                                                    Groupable="false" Reorderable="false">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkIsIncluded" runat="server"
                                                            onclick="SelectParent(this);" />
                                                    </ItemTemplate>
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="chkAll" runat="server" Checked="True" TextAlign="Left"
                                                            onclick="SelectAll(this);" />
                                                    </HeaderTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" Width="60px"></HeaderStyle>
                                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Line #" HeaderStyle-Width="110px" Groupable="false" DataField="LineNumber" ItemStyle-Wrap="false" UniqueName="LineNumber" SortExpression="LineNumber">
                                                    <ItemTemplate>
                                                        <span><%#IIf(CStr(Eval("LineNumber")) = String.Empty, "&nbsp;", Eval("LineNumber").ToString)%></span>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Right" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn ItemStyle-Wrap="false" DataField="ItemCode" HeaderText="Item" HeaderStyle-Width="110px" UniqueName="ItemCode" SortExpression="ItemCode" Groupable="false">
                                                    <ItemTemplate>
                                                        <span><%#IIf(Container.DataItem("ItemCode") = String.Empty, "&nbsp;", Container.DataItem("ItemCode"))%></span>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Description" DataField="Description" ItemStyle-Wrap="false" UniqueName="Description" HeaderStyle-Width="110px" SortExpression="Description" Groupable="false">
                                                    <ItemTemplate>
                                                        <span><%# IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn ItemStyle-Wrap="false" DataField="UOM" HeaderText="UOM" HeaderStyle-Width="110px" UniqueName="UOM" SortExpression="UOM" Groupable="false">
                                                    <ItemTemplate>
                                                        <span><%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%></span>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Quantity" DataField="Quantity" ItemStyle-Wrap="false" UniqueName="Quantity" HeaderStyle-Width="110px" SortExpression="Quantity" Groupable="false">
                                                    <ItemTemplate>
                                                        <span style="float: right"><%# FormatNumber(Container.DataItem("Quantity"))%></span>&nbsp;
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Currency" DataField="Currency" ItemStyle-Wrap="false" UniqueName="Currency" HeaderStyle-Width="110px" SortExpression="Currency" Groupable="false">
                                                    <ItemTemplate>
                                                        <span><%# Container.DataItem("Currency")%></span>&nbsp;
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Unit Cost" DataField="UnitCost" ItemStyle-Wrap="false" UniqueName="UnitCost" HeaderStyle-Width="110px" SortExpression="UnitCost" Groupable="false">
                                                    <ItemTemplate>
                                                        <span><%#FormatCurrency(Container.DataItem("UnitCost"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Right" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Ext. Cost" DataField="ExtCost" ItemStyle-Wrap="false" UniqueName="ExtCost" HeaderStyle-Width="110px" SortExpression="ExtCost" Groupable="false">
                                                    <ItemTemplate>
                                                        <span><%#FormatCurrency(Container.DataItem("ExtCost"), CurrencyId:=Container.DataItem("CurrencyId"))%></span>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Right" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Commitment Line" DataField="CommitmentLine" ItemStyle-Wrap="false" UniqueName="CommitmentLine" HeaderStyle-Width="110px" SortExpression="CommitmentLine" Groupable="false">
                                                    <ItemTemplate>
                                                        <span><%# IIf(Container.DataItem("CommitmentDetail") = String.Empty, "&nbsp;", Container.DataItem("CommitmentDetail"))%></span>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Right" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Cost Code" DataField="CostCode" ItemStyle-Wrap="false" UniqueName="CostCode" HeaderStyle-Width="110px" SortExpression="CostCode" Groupable="false">
                                                    <ItemTemplate>
                                                        <span><%#IIf(Container.DataItem("CostCode") = String.Empty, "&nbsp;", Container.DataItem("CostCode"))%></span>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Cost Type" ItemStyle-Wrap="false" DataField="CostType" UniqueName="CostType" Groupable="false" HeaderStyle-Width="110px" SortExpression="CostType">
                                                    <ItemTemplate>
                                                        <span><%#IIf(Container.DataItem("CostType") = String.Empty, "&nbsp;", Container.DataItem("CostType"))%></span>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Days" ItemStyle-Wrap="false" DataField="Days" UniqueName="Days" HeaderStyle-Width="110px" Groupable="false" SortExpression="Days">
                                                    <ItemTemplate>
                                                        <span><%#FormatNumber(Container.DataItem("Days"))%></span>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Right" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Phase" ItemStyle-Wrap="false" DataField="Phase" UniqueName="Phase" HeaderStyle-Width="110px" Groupable="false" SortExpression="Phase">
                                                    <ItemTemplate>
                                                        <span><%#IIf(Container.DataItem("Phase").ToString = String.Empty, "&nbsp;", Container.DataItem("Phase").ToString)%></span>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="WBS" ItemStyle-Wrap="false" DataField="WBS" UniqueName="WBS" HeaderStyle-Width="110px" Groupable="false" SortExpression="WBS">
                                                    <ItemTemplate>
                                                        <span><%# IIf(Container.DataItem("WBSId") = 0, "&nbsp;", Container.DataItem("WBS"))%></span>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Period" UniqueName="Period" DataField="Period" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Left" Groupable="false" SortExpression="Period">
                                                    <ItemTemplate>
                                                        <span><%#IIf(Container.DataItem("Period").ToString = String.Empty, "&nbsp;", Container.DataItem("Period").ToString)%></span>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Assigned To" UniqueName="AssignedTo" DataField="AssignedTo" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Left" SortExpression="AssignedTo" Groupable="false">
                                                    <ItemTemplate>
                                                        <span><%#IIf(Container.DataItem("AssignedToId") = "-1" Or Container.DataItem("AssignedTo") = "0", "&nbsp;", Container.DataItem("AssignedTo"))%></span>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Manufacturer" UniqueName="Manufacturer" DataField="Manufacturer" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Left" SortExpression="Manufacturer" Groupable="false">
                                                    <ItemTemplate>
                                                        <span><%#IIf(Container.DataItem("MfrId") = "-1" Or Container.DataItem("MfrId") = "0", "&nbsp;", Container.DataItem("Mfr"))%></span>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Mfr. #" UniqueName="MfrNumber" DataField="MfrNumber" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Left" SortExpression="MfrNumber" Groupable="false">
                                                    <ItemTemplate>
                                                        <span><%#IIf(Container.DataItem("MfrNumber") = String.Empty, "&nbsp;", Container.DataItem("MfrNumber"))%></span>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="CE" UniqueName="CE" DataField="CE" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Left" SortExpression="CE" Groupable="false">
                                                    <ItemTemplate>
                                                        <a id="hypCE" href='<%#Eval("ChangeEventPostBackURL")%>'><%# IIf(CStr(Eval("ChangeEvent")) = String.Empty, "&nbsp;", Eval("ChangeEvent"))%></a>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Right" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="CCO" UniqueName="CCO" DataField="CCO" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Left" SortExpression="CCO" Groupable="false">
                                                    <ItemTemplate>
                                                        <a id="hypCCO" href='<%#Eval("CommitmentCOPostBackURL")%>'><%# IIf(CStr(Eval("CommitmentCO")) = String.Empty, "&nbsp;", Eval("CommitmentCO"))%></a>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Right" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes" DataField="Notes" HeaderStyle-Width="70px" ItemStyle-HorizontalAlign="Left" SortExpression="Notes" Groupable="false">
                                                    <ItemTemplate>
                                                        <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                            </Columns>

                                        </MasterTableView>

                                        <ClientSettings AllowDragToGroup="true" Resizing-AllowColumnResize="true" AllowColumnsReorder="true">
                                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                        </ClientSettings>
                                    </telerik:RadGrid>
                                </fieldset>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
