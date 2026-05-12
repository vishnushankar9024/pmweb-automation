<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinkAssetsPopup.aspx.vb" Inherits="Website.LinkAssetsPopup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Linked Assets</title>
    <script>
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

     
        function openSelectAssetPopup() {
            var objecttype = querySt("ObjectType");
            switch (objecttype) {
                case 'PROJECT':
                    return OpenPOPUp('SelectAsset.aspx?Id=4', 1035, 710, true, 'rdgLinkedAssets');
                    break;
                case 'ASSET_SUITES':
                    return OpenPOPUp('SelectAsset.aspx?Id=3', 1035, 710, true);
                    break;
                case 'LEASE':
                    return OpenPOPUp('SelectAsset.aspx?Id=2', 1035, 710, true);
                    break;
                case 'WORKORDER':
                    return OpenPOPUp('SelectAsset.aspx?Id=1&IsInstalled=0&IsServiced=0', 1035, 710, true, 'rdgLinkedAssets');
                    break;
                case 'ASSET_TENANTREQUEST':
                    return OpenPOPUp('SelectAsset.aspx?Id=0', 1035, 710, true);
                    break;
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadWindowManager ID="PMWindowManager" runat="server" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
            Top="">
        </telerik:RadWindowManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgLinkedAssets">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgLinkedAssets" LoadingPanelID="ldpLinkAsset" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpLinkAsset" runat="server" Skin="Default" />

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="150px" CssClass="popup-toolbar">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarDone" CommandName="Close"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgLinkedAssets" runat="server" SetWidth="true" AppendMenus="true" FitParentContainer="true"
                        HeaderStyle-Font-Size="8" Width="100%" FitPageHeightOffset="24"
                        AutoGenerateColumns="False" AllowSorting="True" ShowStatusBar="true" TabIndex="11"
                        AllowMultiRowSelection="true" AllowPaging="true" PageSize="250">
                        <MasterTableView DataKeyNames="Id" CommandItemDisplay="Top" NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>">
                            <Columns>
                                <telerik:GridTemplateColumn SortExpression="IsPrimary" HeaderText="Primary" HeaderStyle-HorizontalAlign="Center" ItemStyle-Wrap="false" UniqueName="Primary" HeaderStyle-Width="70px">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkPrimary" OnCheckedChanged="chkPrimary_OnChekedChanged" AutoPostBack="true" runat="server" class="switch-mobile" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Location" UniqueName="Property" ItemStyle-Wrap="false"
                                    HeaderStyle-Width="130px" Groupable="false" SortExpression="Property">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblLocation" Text='<%#IIf(Container.DataItem("Property").ToString = String.Empty, "&nbsp;", Container.DataItem("Property").ToString)%>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Building" UniqueName="Building" ItemStyle-Wrap="false"
                                    HeaderStyle-Width="120px" Groupable="false" SortExpression="Building">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblBuilding" Text='<%#IIf(Container.DataItem("Building").ToString = String.Empty, "&nbsp;", Container.DataItem("Building").ToString)%>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Floor" UniqueName="Floor" ItemStyle-Wrap="false"
                                    HeaderStyle-Width="105px" Groupable="false" SortExpression="Floor">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblFloor" Text='<%#IIf(Container.DataItem("Floor").ToString = String.Empty, "&nbsp;", Container.DataItem("Floor").ToString)%>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Space" UniqueName="Space" ItemStyle-Wrap="false"
                                    HeaderStyle-Width="105px" Groupable="false" SortExpression="Space">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblSpace" Text='<%#IIf(Container.DataItem("Space").ToString = String.Empty, "&nbsp;", Container.DataItem("Space").ToString)%>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Equipment" UniqueName="Equipment" ItemStyle-Wrap="false"
                                    HeaderStyle-Width="120px" Groupable="false" SortExpression="Equipment">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblEquipment" Text='<%#IIf(Container.DataItem("Equipment").ToString = String.Empty, "&nbsp;", Container.DataItem("Equipment").ToString)%>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Add" CssClass="GridCmdlinkAsset" CommandName="linkAsset" OnClientClick="openSelectAssetPopup(); return false;">
                                        <span class="Icon"></span>
                                        <asp:Label runat="server" ID="lblAddAsset" Text="link Asset(s)"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdUnlinkAsset"
                                        runat="server" SecurityButtonType="ItemMode_Delete" CommandName="UnlinkAsset">
                                        <span class="Icon"></span>
                                        <asp:Label runat="server" ID="lblDeleteAssets" Text="Delete Assets"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnRefresh" runat="server" SecurityButtonType="ItemMode" CausesValidation="false" CommandName="RebindGrid" CssClass="GridCmdRebindGrid">
                                        <span class="Icon"></span>
                                        <asp:Label runat="server" ID="lblRefresh" Text="Refresh"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                </div>
                            </CommandItemTemplate>
                        </MasterTableView>
                        <HeaderStyle Font-Size="8pt"></HeaderStyle>
                        <ClientSettings Resizing-AllowColumnResize="true">
                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
                        </ClientSettings>
                    </telerik:RadGrid>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
