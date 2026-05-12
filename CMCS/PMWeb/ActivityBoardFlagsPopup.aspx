<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ActivityBoardFlagsPopup.aspx.vb" Inherits="Website.ActivityBoardFlagsPopup"
    meta:resourcekey="Page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>

        <telerik:RadCodeBlock ID="CodeBlock" runat="server">
            <style>
                .RadGrid.RadGrid_Default tr.rgSelectedRow > td, .RadGrid_Default tr.rgActiveRow > td, .RadGrid_Default tr.rgEditRow > td {
                    padding-left: 7px;
                }

                .RadGrid_Default .rgMasterTable .rgSelectedCell, .RadGrid_Default .rgSelectedRow {
                    background: white !important;
                }

                .RadGrid.RadGrid_Default .rgRow > td, .RadGrid.RadGrid_Default .rgAltRow > td, .RadGrid.RadGrid_Default, .RadGrid div.rgHeaderWrapper {
                    border: 0;
                }

                .RadGrid.RadGrid_Default {
                    outline: none;
                    border: 0 !important;
                }

                    .RadGrid.RadGrid_Default .rgSelectedRow > td, .RadGrid_Default .rgActiveRow > td, .RadGrid_Default .rgEditRow > td {
                        padding-left: 8px;
                        border-color: #c5c5c5 !important;
                    }

                .rgRow, .rgAltRow, .rgEditRow {
                    height: 41px;
                }

                .RadGrid_Default tr.rgEditRow {
                    background: white !important;
                }

                .RadGrid .rgMasterTable .rgCommandRow {
                    display: none;
                }

                .flagBox {
                    Width: 258px !important;
                    Height: 32px !important;
                }

                    .flagBox:focus {
                        color: #666666 !important;
                        background-color: #FFFFFF !important;
                        border-color: #666666 !important;
                    }
            </style>
            <script type="text/javascript">
                function ChangeFlagStatus(ele) {
                    if (ele.className == "UncheckedButton") {
                        ele.className = "CheckedButton";
                        $($(ele).parents('td')[0]).find('[id$=hdnIsShown]').val("1");
                    }
                    else{
                        ele.className = "UncheckedButton";
                        $($(ele).parents('td')[0]).find('[id$=hdnIsShown]').val("0");
                    }
                    return false;
                }
            </script>
        </telerik:RadCodeBlock>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgFlags">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgFlags" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>

         <div class="ProfileTitle">
            
             <asp:label runat="server" ID="TitleUser"></asp:label>
    <asp:LinkButton runat="server" CssClass="closepopup closesize" ID="btnCloseProfilePopup" OnClientClick="window.close()">
        <div class="CloseProfilePopup closesize">
                                                                                 &nbsp;
                                                                            </div></asp:LinkButton>
    </div>
        <table border="0" width="100%" cellpadding="0" cellspacing="0">
            <tr class="ToolBar NewStylePopupToolbar">
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" Value="SaveExit" CommandName="SaveExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage PMPopupMainPage documentSinglePage TitleToolbarTop">
            <div class="row">
                <div class="col-4">
                    <telerik:RadGrid ID="rdgFlags" runat="server" Height="100%" AllowPaging="false" Style="width: 300px !important; margin: auto;" SetWidth="true" ClientSettings-Scrolling-AllowScroll="false" ShowHeader="false"
                        AutoGenerateColumns="False" HeaderStyle-Font-Size="8" AllowMultiRowEdit="false" AllowMultiRowSelection="false" ShowGroupPanel="false" AllowSorting="false" AllowFilteringByColumn="false">
                        <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="FlagId" CommandItemDisplay="None" Width="100%" TableLayout="Fixed" InsertItemDisplay="Top"
                            InsertItemPageIndexAction="ShowItemOnFirstPage" UseAllDataFields="true" EnableHeaderContextMenu="true" EditMode="InPlace">
                            <Columns>
                                <telerik:GridTemplateColumn Reorderable="false" UniqueName="TemplateColumn" Groupable="False" AllowFiltering="false">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="chkFlag" runat="server" CssClass="UncheckedButton" OnClientClick="return ChangeFlagStatus(this);">
                                             <span class="Icon"></span>
                                        </asp:LinkButton>
                                        <asp:HiddenField ID="hdnIsShown" runat="server" Value="0" />
                                    </ItemTemplate>
                                    <HeaderStyle Width="25px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Record Type" UniqueName="RecordType" Groupable="False">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtFlag" runat="server" class="flagBox"></asp:TextBox>
                                    </ItemTemplate>
                                    <HeaderStyle Width="260px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <ItemStyle Wrap="false" />
                            <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                        </MasterTableView>
                    </telerik:RadGrid>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
