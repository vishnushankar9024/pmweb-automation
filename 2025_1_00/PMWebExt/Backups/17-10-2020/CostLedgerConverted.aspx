<%@ Page Language="vb" MasterPageFile="~/PmMaster.Master" AutoEventWireup="false" CodeBehind="CostLedgerConverted.aspx.vb" Inherits="Website.CostLedgerConverted" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RDG">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RDG" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script language="javascript" type="text/javascript">

            function click_handler(sender, args) {

                switch (args.get_item().get_commandName()) {
                    case 'ViewReports':
                        var ddlProjectValue = $find("<%= ddlProjects.ClientID %>").get_value();
                        if (parseInt(ddlProjectValue)) {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=COSTLEDGER&Id=" +
                                ddlProjectValue
                                + "&EntityId=" + ddlProjectValue + "&EntityType=0", 890, 430, false);

                            break;
                        }
                    default:
                        break;
                }
            }

        </script>
    </telerik:RadCodeBlock>
    <style>
        @media screen and (max-width:843px) and (min-width:320px) {
            .documentSinglePage {
                margin-top: 50px;
            }
        }
    </style>  
 <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
        <tr class="ToolBar">
            <td style="width: 240px !important;" class="ToolbarTd">
                <telerik:RadComboBox ID="ddlProjects" UseProjectFilter="1" runat="server"
                    Skin="Default" CloseDropDownOnBlur="true" AllowCustomText="false" 
                    Width="240px" AutoPostBack="True" NoWrap="true" CausesValidation="False"
                    Height="400px" OnClientTextChange="LOD_DropDownTextChange" EnableItemCaching="false"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" CheckForDirt="True"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" OnClientButtonClicked="click_handler"
                    AutoPostBack="true">
                    <Items>
                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                            EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td style="width: 100%"></td>
        </tr>
    </table>
    <table style="width: 100%; vertical-align: top;" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <div class="PMHeader" style="padding-left: 0;">
                    <div class="row documentSinglePage">
                        <div class="col-12">
                            <table class="colTable">
                                <tr>
                                    <td>
                                        <telerik:RadGrid ID="RDG" runat="server" AutoGenerateColumns="True" ShowStatusBar="false" Font-Size="8px" PageSize="20" AllowPaging="True" SetWidth="true" AppendMenus="true" FitParentContainer="true" ClientSettings-Scrolling-AllowScroll="true"
                                            ShowFooter="true" ShowGroupPanel="True" AllowMultiRowEdit="True"
                                            AllowMultiRowSelection="True" AllowSorting="True" GridLines="None" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
                                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" UseAllDataFields="true"
                                                InsertItemPageIndexAction="ShowItemOnFirstPage" Width="100%" EditMode="InPlace"
                                                EnableHeaderContextMenu="true" TableLayout="Fixed" ShowGroupFooter="true" GroupLoadMode="Client">
                                                <Columns>
                                                    <telerik:GridBoundColumn Aggregate="SUM" DataField="Id" Visible="False" UniqueName="AggregatCol" />
                                                </Columns>
                                                <FooterStyle CssClass="GridFooter" />
                                                <HeaderStyle HorizontalAlign="Left" Wrap="false" />
                                                <ItemStyle Wrap="false" />
                                                <CommandItemTemplate>
                                                    <div style="padding: 2px; height: 25px">
                                                        <table style="height: 100%">
                                                            <tr valign="middle">
                                                                <td>
                                                                    <asp:LinkButton ID="btnSaveState" runat="server" CausesValidation="False"
                                                                        CommandName="SaveState" Visible='<%# RDG.EditIndexes.Count = 0 %>'>
                                                                        <asp:Label ID="Label1" runat="server"></asp:Label>
                                                                    </asp:LinkButton>
                                                                </td>
                                                                <td>
                                                                    <asp:LinkButton ID="btnLoadDefaultState" runat="server"
                                                                        CausesValidation="False" CommandName="LoadDefaultState" Visible='<%# RDG.EditIndexes.Count = 0 %>'>
                                                                        &nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label ID="Label2" runat="server"></asp:Label>
                                                                    </asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </CommandItemTemplate>
                                            </MasterTableView>
                                            <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder" ReorderColumnsOnClient="true" AllowDragToGroup="true">
                                                <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                                    AllowColumnResize="True" />
                                                <Selecting AllowRowSelect="true" />
                                            </ClientSettings>
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
</asp:Content>

