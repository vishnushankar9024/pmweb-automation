<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="AssemblyPassPopup.aspx.vb" Inherits="Website.AssemblyPassPopup" Culture="auto" meta:resourcekey="Page"
    UICulture="auto" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <title></title>
    <style type="text/css">
        .ShowOnMobilePopup {
            display: none !important;
        }

        @media screen and (max-width: 843px) and (min-width: 320px) {
            .ShowOnMobilePopup {
                display: table !important;
            }
        }

        td.labelWidth {
            width: 160px !important;
        }

        span#lblUOMText, span#lblUOM, span#lblQuantityText {
            font-size: 9px;
        }

        .rgFooterDiv {
            margin-right: 0 !important;
        }

        .RadGrid.RadGrid_Default .rgRow > td, .RadGrid.RadGrid_Default .rgAltRow > td {
            background: #EDEDED;
        }

        .txtNotes {
            margin-right: 8px;
            border: 0 !important;
            background: #ededed;
            outline: 0 !important;
            cursor: default !important;
        }
    </style>
</head>
<body>


    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadWindowManager ID="PMWindowManager" runat="server" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
            Top="">
        </telerik:RadWindowManager>

        <script type="text/javascript">
            $(document).ready(function () {
                $('#txtQuantity').change(function () {
                    $('#txtQuantityMobile').val($('#txtQuantity').val())
                })
                $('#txtQuantityMobile').change(function () {
                    $('#txtQuantity').val($('#txtQuantityMobile').val())
                })
            });

            function OpenSmallNoteDetailPopup(txtNoteId, EditMode, Source, AssemblyVariableId) {
                OpenSmallPOPUp('NotesPopup.aspx?txtNotesId=' + txtNoteId + '&EditMode=' + EditMode + '&Source=' + Source + '&AssemblyVariableId=' + AssemblyVariableId, 400, 200, false);
                return false;
            }
        </script>

        <div class="ToolBar" style="z-index: 1999 !important; top: 0px !important;">
            <table cellpadding="0" cellspacing="0" style="table-layout: fixed; width: auto !important;">
                <tr>
                    <td valign="middle" style="vertical-align: middle; width: 172px !important" class="ToolbarTd">
                        <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                            <Items>
                                <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                            </Items>
                        </telerik:RadToolBar>
                    </td>
                </tr>
            </table>
        </div>

        <div class="PMMainPage">
            <div class="row JustifyContent " style="padding-top: 75px;">
                <div class="col-4 col-4-left">
                    <table class="colTable" runat="server">
                        <tr>
                            <td class="labelWidth NoWrap">
                                <asp:Label ID="lblUOMText" runat="server" meta:resourcekey="lblTextUOM"></asp:Label>
                                <asp:Label ID="lblUOM" runat="server"></asp:Label>
                                <asp:Label ID="lblQuantityText" runat="server" meta:resourcekey="lblQuantity"></asp:Label>
                                <asp:Label ID="lblQuantityResult" runat="server"></asp:Label>
                            </td>
                            <td class="controlWidth" style="text-align: right">
                                <asp:TextBox ID="txtQuantity" MaxLength="9" runat="server" Text="1" CssClass="Integer" Enabled="false"></asp:TextBox>
                            </td>
                        </tr>

                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblPhase" runat="server" meta:resourcekey="lblPhase"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtPhase" runat="server" Enabled="false"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblLocation" runat="server" meta:resourcekey="lblLocation"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtLocations" runat="server" Enabled="false"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCostCode" runat="server" meta:resourcekey="lblCostCode"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtCostCode" runat="server" Enabled="false"></asp:TextBox>
                            </td>
                        </tr>

                    </table>
                </div>
                <div class="col-4 col-4-middle">
                    <table class="colTable" runat="server">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCompany" runat="server" meta:resourcekey="lblCompany"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtCompany" runat="server" Enabled="false"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblType" runat="server" meta:resourcekey="lblType"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtType" runat="server" Enabled="false"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblPeriod" runat="server" Text="Period" meta:resourcekey="lblPeriod"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtPeriod" runat="server" Enabled="false"></asp:TextBox>
                            </td>
                        </tr>

                        <tr style="display: none">
                            <td class="labelWidth NoWrap">
                                <asp:Label ID="lblUOMTextMobile" runat="server" meta:resourcekey="lblUOMText"></asp:Label>

                                <asp:Label ID="lblUOMMobile" runat="server"></asp:Label>
                                <asp:Label ID="lblQuantityTextMobile" runat="server" meta:resourcekey="lblQuantityText"></asp:Label>
                            </td>
                            <td class="controlWidth" style="text-align: right">
                                <asp:TextBox Width="100px" ID="txtQuantityMobile" MaxLength="9" runat="server" Text="1" CssClass="Integer" Enabled="false"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="col-4 col-4-right">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <div style="float: left;">
                                    <asp:Label ID="lblPassNotes" runat="server" Text="Pass Notes" meta:resourcekey="lblPassNotes"></asp:Label>
                                </div>
                                <div style="float: right;">
                                    <asp:LinkButton CssClass="SearchButton" runat="server" ID="imgNotes">
                                                <span class="Icon"></span>
                                    </asp:LinkButton>
                                </div>
                            </td>
                            <td class="controlWidth">
                                <textarea id="txtNotes" runat="server" style="overflow: auto; background-color: #FFFFFF !important; border: 0;" readonly="readonly"></textarea>
                            </td>
                        </tr>
                    </table>
                </div>

            </div>



            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgAssemblyVariables" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                        AutoGenerateColumns="False" GridLines="None" Width="100%" FitParentContainer="true" Height="200px" Style="overflow: auto;">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                        <HeaderContextMenu EnableViewState="false">
                        </HeaderContextMenu>
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Variable" UniqueName="Variable" HeaderStyle-Width="100px">
                                    <ItemTemplate>
                                        <%#Container.DataItem("Variable")%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" HeaderStyle-Width="120px">
                                    <ItemTemplate>
                                        <%#Container.DataItem("Description")%>&nbsp;
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="UOM" HeaderStyle-Width="80px" UniqueName="UOM" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <%#Container.DataItem("UOM")%>&nbsp;
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Quantity" UniqueName="Quantity" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <%#Container.DataItem("Quantity")%>&nbsp;
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right" Wrap="false"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Notes" UniqueName="Notes" HeaderStyle-Width="130px" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <div style="display: inline-flex; width: 99%;">
                                            <asp:TextBox ID="txtNotes" runat="server" Width="90%" class="txtNotes" Style="text-overflow: ellipsis !important; overflow: hidden !important; color: black !important;"
                                                ReadOnly="true" Enabled="false"></asp:TextBox>
                                            <asp:LinkButton runat="server" ID="imgNotes" CssClass="SearchButton">
                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <EditFormSettings>
                                <EditColumn InsertImageUrl="Update.gif" UpdateImageUrl="Update.gif" EditImageUrl="Edit.gif"
                                    CancelImageUrl="Cancel.gif">
                                </EditColumn>
                            </EditFormSettings>
                        </MasterTableView>
                        <HeaderStyle Font-Size="8pt"></HeaderStyle>
                        <ClientSettings EnableRowHoverStyle="true">
                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                AllowColumnResize="True" />
                        </ClientSettings>
                    </telerik:RadGrid>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgItems" runat="server" SetWidth="true" FitParentContainer="true" FitPageHeightOffset="24"
                        Width="100%" AutoGenerateColumns="false" GridLines="None" ClientSettings-Scrolling-AllowScroll="true" ClientSettings-Scrolling-UseStaticHeaders="true">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                        <HeaderContextMenu EnableViewState="false">
                        </HeaderContextMenu>
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Item" HeaderStyle-Width="80px" SortExpression="ItemId"
                                    ItemStyle-HorizontalAlign="Left" UniqueName="Item">
                                    <ItemTemplate>
                                        <%#Container.DataItem("ItemId").ToString%>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Description" UniqueName="Description" HeaderStyle-Width="80px" SortExpression="Description">
                                    <ItemTemplate>
                                        <%#Container.DataItem("Description")%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="UOM" UniqueName="UOM" HeaderStyle-Width="80px" SortExpression="UOM">
                                    <ItemTemplate>
                                        <%#IIf(Container.DataItem("UOM") = String.Empty, "&nbsp;", Container.DataItem("UOM"))%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Currency" UniqueName="Currency" HeaderStyle-Width="80px"
                                    ItemStyle-HorizontalAlign="Right" SortExpression="Currency">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCurrency" runat="server" Width="100%"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Default Cost" UniqueName="DefaultCost" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Right"
                                    SortExpression="DefaultCost">
                                    <ItemTemplate>
                                        <%#FormatNumber(CDbl(Container.DataItem("DefaultCost")))%>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right" Wrap="false"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Variable" UniqueName="Variable" HeaderStyle-Width="80px"
                                    SortExpression="Variable">
                                    <ItemTemplate>
                                        <%#CStr(Container.DataItem("Variable"))%>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Quantity" UniqueName="Quantity" HeaderStyle-Width="80px"
                                    ItemStyle-HorizontalAlign="Right" SortExpression="Quantity">
                                    <ItemTemplate>
                                        <%#FormatNumber(Container.DataItem("Quantity"))%>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Total Cost" UniqueName="TotalCost" HeaderStyle-Width="80px"
                                    ItemStyle-HorizontalAlign="Right" SortExpression="TotalCost" FooterStyle-HorizontalAlign="Right"
                                    meta:resourcekey="GridTemplateColumn11">
                                    <ItemTemplate>
                                        <%#FormatNumber(CDbl(Container.DataItem("Quantity")) * CDbl(Container.DataItem("DefaultCost")))%>
                                    </ItemTemplate>
                                    <FooterTemplate>

                                        <asp:Label ID="lblSumTotalCosts" runat="server" meta:resourcekey="lblSumTotalCosts"></asp:Label>
                                    </FooterTemplate>
                                    <FooterStyle HorizontalAlign="Right"></FooterStyle>
                                    <ItemStyle HorizontalAlign="Right" Wrap="false"></ItemStyle>
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <EditFormSettings>
                                <EditColumn InsertImageUrl="Update.gif" UpdateImageUrl="Update.gif" EditImageUrl="Edit.gif"
                                    CancelImageUrl="Cancel.gif">
                                </EditColumn>
                            </EditFormSettings>
                        </MasterTableView>
                        <HeaderStyle Font-Size="8pt"></HeaderStyle>
                        <ClientSettings EnableRowHoverStyle="true" Resizing-AllowColumnResize="true">
                            <Resizing AllowColumnResize="True"></Resizing>

                        </ClientSettings>


                    </telerik:RadGrid>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
