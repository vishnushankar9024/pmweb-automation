<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="AllowAccesTostampsPopUp.aspx.vb" Inherits="Website.AllowAccesTostampsPopUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Allow Access to Stamps</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>

        <telerik:RadFormDecorator ID="rfdMaster" runat="server" DecoratedControls="Buttons,CheckBoxes,H4H5H6,Label,LoginControls,RadioButtons,Select,ValidationSummary" />
        <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
            <script type="text/javascript">
                function SaveStampImageIds(StampImageIds) {
                    $(window.parent.document)[0].getElementById(querySt('hdnStampImagesIds')).value = StampImageIds;
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
        </telerik:RadScriptBlock>
        <table class="ToolBar" style="width: 100%" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%" CssClass="">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" ValidationGroup="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit" ValidationGroup="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
                <td style="width: 100%"></td>

            </tr>
        </table>


        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgAllowAccess" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" CssClass="ResponsiveMargin"
                        HeaderStyle-Font-Size="8" Width="200px" AutoGenerateColumns="False" AllowMultiRowEdit="True" PageSize="10" AllowPaging="true"
                        AllowMultiRowSelection="true" AllowSorting="true" ShowStatusBar="False" FitPageHeightOffset="24">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" CommandItemDisplay="None" EditMode="InPlace" InsertItemPageIndexAction="ShowItemOnFirstPage">
                            <Columns>
                                <telerik:GridClientSelectColumn HeaderText="Select" Groupable="false" UniqueName="Select"
                                    Reorderable="true" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                </telerik:GridClientSelectColumn>
                                <telerik:GridTemplateColumn HeaderText="Image" UniqueName="Image" HeaderStyle-Width="200px">
                                    <ItemTemplate>
                                        <asp:Image ID="imgStampImage" runat="server" Width="100px" />&nbsp;
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Image ID="imgStampImage" runat="server" Width="100px" />&nbsp;
                                    </EditItemTemplate>
                                    <ItemStyle Wrap="false" HorizontalAlign="left" />
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                        <HeaderStyle Font-Size="8pt"></HeaderStyle>
                        <ClientSettings Resizing-AllowColumnResize="true" Selecting-AllowRowSelect="true">
                        </ClientSettings>
                    </telerik:RadGrid>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
