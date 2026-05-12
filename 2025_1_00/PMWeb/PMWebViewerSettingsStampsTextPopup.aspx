<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="PMWebViewerSettingsStampsTextPopup.aspx.vb" Inherits="Website.PMWebViewerSettingsStampsTextPopup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script type="text/javascript">
        function SelectParent(chk) {
            var rdgStampText = $("div[id$='rdgStampText']");
            if (rdgStampText.find("input[type='checkbox']")[0] == null) return;
            var chkPArent = rdgStampText.find("input[type='checkbox']")[0];

            var i = 0;
            var isChecked = true;
            rdgStampText.find("input[type='checkbox']").each(function () {
                if (i > 0) {
                    if (chk.checked) {
                        if (!this.checked) isChecked = false;
                    }
                }
                i++;
            });
            var row = $find("rdgStampText")._getRow(chk.parentElement.parentElement.id);
            if (row.get_selected() == false && chk.checked == true) {
                row.set_selected(true);
            }
            else {
                row.set_selected(false);

            }
            if (!chk.checked) {
                chkPArent.checked = false;



            } else {
                chkPArent.checked = isChecked;

            }

            return false;
        }
        function AllCheckClicked(iObj) {
            var i = 0;
            var rdgStampText = $("div[id$='rdgStampText']");
            var chk = rdgStampText.find("input[type='checkbox']");
            var grid = $find("rdgStampText");
            var selected = iObj.checked;
            chk.each(function () {
                if (i > 0) {
                    if (this.parentElement.parentElement.id == '') return;
                    this.checked = selected;
                    grid._getRow(this.parentElement.parentElement.id).set_selected(selected);
                }
                i++;
            });

        }
        function SaveStampTextIds(StampTextIds) {
            $(window.parent.document)[0].getElementById(querySt('hdnStampTextIds')).value = StampTextIds;
            return false;
        }
        function querySt(ji) {
            hu = window.location.search.substring(1);
            gy = hu.split("&");
            for (i = 0; i < gy.length; i++) {
                ft = gy[i].split("=");
                if (ft[0] == ji) {
                    return ft[1];
                }
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" ValidationGroup="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit" ValidationGroup="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgStampText" runat="server" CssClass="ResponsiveMargin" AllowMultiRowEdit="true" AllowPaging="true" PageSize="250" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                        AllowMultiRowSelection="True" AutoGenerateColumns="False" GridLines="None" HeaderStyle-Font-Size="8" Width="100%" FitPageHeightOffset="24">
                        <HeaderStyle Font-Size="8pt" />
                        <ClientSettings Selecting-AllowRowSelect="true" AllowRowsDragDrop="true">
                            <Selecting AllowRowSelect="True" />
                        </ClientSettings>
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                        <MasterTableView CssClass="MaxWidth" DataKeyNames="Id">
                            <Columns>
                                <telerik:GridClientSelectColumn HeaderText="Select" Groupable="false" UniqueName="Select"
                                    Reorderable="true" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                </telerik:GridClientSelectColumn>
                                <telerik:GridTemplateColumn UniqueName="Text" HeaderText="Text"
                                    ItemStyle-Width="120px" HeaderStyle-Width="200px">
                                    <ItemTemplate>
                                        <asp:Label ID="lblStamp" runat="server" Text='<%#Eval("Stamp")%>' />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
