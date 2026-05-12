<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="ReissueBidsPopUp.aspx.vb" Inherits="Website.ReissueBidsPopUp" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script type="text/javascript">
        function pageLoad() {
            CheckParentBox();
        }

        function AllCheckClicked(iObj, Name) {
            var i = 0;
            var rdgRights = $("div[id$='rdgManageBids']");
            rdgRights.find("input[type='checkbox']").each(function () {
                if (i > 0) {
                    if (!this.disabled)
                        if (this.id.indexOf(Name) > 0)
                            this.checked = iObj.checked;
                }
                i++;
            });
        }
        function SelectParent(chk, Name) {
            var rdgRights = $("div[id$='rdgManageBids']");
            var chkPArent;
            if (Name == 'chkSelect')
                chkPArent = rdgRights.find("input[type='checkbox']")[0];
            if (Name == 'chkLockPriorBids')
                chkPArent = rdgRights.find("input[type='checkbox']")[3];
            if (Name == 'chkSendNotification')
                chkPArent = rdgRights.find("input[type='checkbox']")[2];
            if (Name == 'chkCopyBid')
                chkPArent = rdgRights.find("input[type='checkbox']")[1];
            var i = 0;
            var isChecked = true;
            rdgRights.find("input[type='checkbox']").each(function () {
                if (i != 0 && i != 2 && i != 1 && i != 3) {
                    if (chk.checked) {
                        if (!this.checked) {

                            if (this.id.indexOf(Name) > 0)
                                isChecked = false;
                        }
                    }
                }
                i++;
            });

            if (!chk.checked) {
                chkPArent.checked = false;

            } else {
                chkPArent.checked = isChecked;
            }

            return false;
        }

        function CheckParentBox() {


            var rdgRights = $("div[id$='rdgManageBids']");
            var ParentIsNotChecked = true;
            var PriorIsNotChecked = true;
            var NotificationIsNotChecked = true;
            var CopyBidIsNotChecked = true;
            var i = 0;
            rdgRights.find("input[type='checkbox']").each(function () {
                if (i != 0 && i != 2 && i != 1 && i != 3) {
                    if (!this.checked) {
                        if (this.id.indexOf("chkSelect") > 0)
                            ParentIsNotChecked = false;
                        if (this.id.indexOf("chkLockPriorBids") > 0)
                            PriorIsNotChecked = false;
                        if (this.id.indexOf("chkSendNotification") > 0)
                            NotificationIsNotChecked = false;
                        if (this.id.indexOf("chkCopyBid") > 0)
                            CopyBidIsNotChecked = false;
                    }
                }
                i++;
            });

            if (!ParentIsNotChecked) {
                rdgRights.find("input[type='checkbox']")[0].checked = false;
            } else {
                if (i > 0) {
                    rdgRights.find("input[type='checkbox']")[0].checked = true;
                }

            }
            if (!PriorIsNotChecked) {
                rdgRights.find("input[type='checkbox']")[3].checked = false;
            } else {
                if (i > 0) {
                    rdgRights.find("input[type='checkbox']")[3].checked = true;
                }

            }

            if (!NotificationIsNotChecked) {
                rdgRights.find("input[type='checkbox']")[2].checked = false;
            } else {
                if (i > 0) {
                    rdgRights.find("input[type='checkbox']")[2].checked = true;
                }

            }
            if (!CopyBidIsNotChecked) {
                rdgRights.find("input[type='checkbox']")[1].checked = false;
            } else {
                if (i > 0) {
                    rdgRights.find("input[type='checkbox']")[1].checked = true;
                }

            }

        }
        function DisablePanelAjax() {
            var updatePanel1 = $find($("[id$=pnl]")[0].id);
            updatePanel1.set_enableAJAX(false);
        }

        function CloseStopPopup(LogId) {
            $(window.parent.document).find("[id$=hdnCreatedNotificationLog]").val(LogId);
            CloseRadWnd();
            return true;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">

        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxLoadingPanel ID="ldpItems" runat="server" Skin="Default" />

        <telerik:RadAjaxPanel ID="pnl" LoadingPanelID="ldpItems" runat="server">

            <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        <div class="PMHeader">
                            <div class="row">
                                <div class="col-12">
                                    <table class="colTable" border="0">
                                        <tr>
                                            <td>
                                                <telerik:RadGrid ID="rdgManageBids" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                                    AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8"
                                                    PageSize="10" AllowPaging="true" ShowFooter="False" ShowGroupPanel="False"
                                                    AllowSorting="true" ItemStyle-Height="20px">
                                                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />

                                                    <HeaderContextMenu EnableViewState="false">
                                                    </HeaderContextMenu>
                                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                        DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" TableLayout="Fixed" InsertItemDisplay="Top"
                                                        InsertItemPageIndexAction="ShowItemOnFirstPage" UseAllDataFields="true" EditMode="InPlace"
                                                        EnableHeaderContextMenu="false">

                                                        <Columns>
                                                            <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" UniqueName="Select" HeaderText="" Groupable="False" HeaderStyle-Width="80px">
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="chkSelect" onClick="SelectParent(this,'chkSelect')" runat="server" />
                                                                </ItemTemplate>
                                                                <HeaderTemplate>
                                                                    <asp:CheckBox ID="chkSelectAll" onClick="AllCheckClicked(this,'chkSelect')" runat="server" />
                                                                </HeaderTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn HeaderText="Company"
                                                                SortExpression="Company" UniqueName="Company"
                                                                CurrentFilterFunction="Contains" DataField="Company" DataType="System.String"
                                                                AutoPostBackOnFilter="true" FilterListOptions="VaryByDataType"
                                                                GroupByExpression="Company [GridColumn_Company] Group By Company ASC">
                                                                <ItemTemplate>
                                                                    <span><%#IIf(Container.DataItem("Company") = String.Empty, "&nbsp;", Container.DataItem("Company"))%></span>
                                                                </ItemTemplate>
                                                                <HeaderStyle Width="200px"></HeaderStyle>
                                                                <ItemStyle Wrap="false" />
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Center" UniqueName="CopyBidAmount" HeaderText="" Groupable="False" HeaderStyle-Width="80px">
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="chkCopyBid" onClick="SelectParent(this,'chkCopyBid')" runat="server" />
                                                                </ItemTemplate>
                                                                <HeaderTemplate>
                                                                    <asp:Label runat="server" ID="lblCopyBid" Text="Copy Bid Amounts"></asp:Label>
                                                                    <asp:CheckBox ID="chkCopyBidAll" onClick="AllCheckClicked(this,'chkCopyBid')" runat="server" />
                                                                </HeaderTemplate>
                                                                <HeaderStyle Width="200px" />
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn HeaderStyle-HorizontalAlign="Center" UniqueName="SendNotification" HeaderText="Send Notification" Groupable="False" HeaderStyle-Width="80px">
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="chkSendNotification" onClick="SelectParent(this,'chkSendNotification')" runat="server" />
                                                                </ItemTemplate>
                                                                <HeaderTemplate>
                                                                    <asp:Label runat="server" ID="lblSendNotification" Text="Send Notification"></asp:Label>
                                                                    <asp:CheckBox ID="chkSendNotificationAll" onClick="AllCheckClicked(this,'chkSendNotification')" runat="server" />
                                                                </HeaderTemplate>
                                                                <HeaderStyle Width="200px" />
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" UniqueName="LockPriorBids" HeaderText="Lock Prior Bids" Groupable="False" HeaderStyle-Width="80px">
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="chkLockPriorBids" onClick="SelectParent(this,'chkLockPriorBids')" runat="server" />
                                                                </ItemTemplate>
                                                                <HeaderTemplate>
                                                                    <div style="width: 100%">
                                                                        <asp:Label runat="server" ID="lblPrior" Text="Lock Prior Bids"></asp:Label>
                                                                        <asp:CheckBox ID="chkLockPriorBidsAll" onClick="AllCheckClicked(this,'chkLockPriorBids')" runat="server" />
                                                                    </div>
                                                                </HeaderTemplate>
                                                                <HeaderStyle Width="200px" />
                                                            </telerik:GridTemplateColumn>
                                                        </Columns>
                                                        <CommandItemTemplate>
                                                            <div style="padding: 2px">
                                                                &nbsp;&nbsp;
             
                                                                <asp:LinkButton ID="btnReissue" runat="server" OnClientClick="DisablePanelAjax()" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CommandName="Reissue" CssClass="GridCmdReissue">
                                                                    <span class="Icon"></span>
                                                                    <asp:Label ID="lblReissue" runat="server" Text="Reissue" meta:resourcekey="lblReissueBids"></asp:Label>
                                                                    &nbsp;&nbsp;
                                                                </asp:LinkButton>
                                                                <asp:LinkButton ID="btnCancel" runat="server" OnClientClick="DisablePanelAjax()" CausesValidation="False" CommandName="Cancel" CssClass="GridCmdCancel">
                                                                    <span class="Icon"></span>
                                                                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancel"></asp:Label>
                                                                    &nbsp;&nbsp;
                                                                </asp:LinkButton>
                                                            </div>
                                                        </CommandItemTemplate>

                                                    </MasterTableView>
                                                </telerik:RadGrid>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>


        </telerik:RadAjaxPanel>

    </form>
</body>
</html>
