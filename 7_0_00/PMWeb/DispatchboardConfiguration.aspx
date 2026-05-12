<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="DispatchboardConfiguration.aspx.vb" Inherits="Website.DispatchboardConfiguration" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            var forceMoreMenuToClose = true;
            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
                maintoolbarClick(args.get_item().get_value())
            }
            function MoreMenuClosing(sender, args) {
                if (forceMoreMenuToClose) {
                    //forceradmenuToClose = false;
                    return;
                }
                args.set_cancel(true);
            }
            function MoreMenuOpening(sender, args) {
                if (!forceMoreMenuToClose) { args.set_cancel(true); return; }
            }
            function maintoolbarClick(Value) {
                switch (Value) {

                    case 'Print':
                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        args.set_cancel(true);
                        break;

                    case 'BIReporting':
                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        args.set_cancel(true);
                        break;

                    default:
                        break;
                }
            }
            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }
        </script>
    </telerik:RadCodeBlock>
    <style type="text/css">
        .RightAlign input{
            text-align:right;
        }
    </style>
    <telerik:RadAjaxManagerProxy ID="RamDispatchboard" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgLabors">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgLabors" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rdgEquipment">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgEquipment" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <table class="ToolBar SmallToolbar" style="width: 100%;" id="test" runat="server" cellpadding="0" cellspacing="0">
        <tr>
            <td style="width: 240px !important;" class="ToolbarTd">
                <telerik:RadComboBox ID="ddlBoards" runat="server"
                    Skin="Default" OnClientTextChange="LOD_DropDownTextChange"
                    Width="100%" AutoPostBack="True" NoWrap="true"
                    CausesValidation="False" EnableLoadOnDemand="true" Height="400px"
                    ShowMoreResultsBox="True" CheckForDirt="True"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" DropDownCssClass="ToolbarDropdown">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="click_handler">
                    <Items>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)">
                        </telerik:RadToolBarButton>

                        <%--<telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png" 
                            CommandName="New" AccessKey="n" ToolTip="New (Alt+n)" CausesValidation="false">
                        </telerik:RadToolBarButton>--%>

                        <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/Global/AddLine.png"
                            CommandName="New">
                        </telerik:RadToolBarButton>


                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                            CssClass="ToolbarPrint" OuterCssClass="HideOnMobileToolbar" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Print" Value="Print" CssClass="Print">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Go To Bi Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" CssClass="Help" onclick="helpClick();"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton ImageUrl="Images/Toolbar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>"
                            CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_AssetManagement.htm#Dispatchboard">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>

    <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%">
        <div class="PMMainPage documentSinglePage">
            <div class="row">
                <div class="col-4">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblBoardName" meta:resourceKey="lblBoardName" runat="server" Text="Board Name"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtBoardName" MaxLength="100" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDefaultBoard" meta:resourceKey="lblDefaultBoard" runat="server" Text="Default Board"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:CheckBox ID="chbDefaultBoard" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDefaultStartTime" meta:resourceKey="lblDefaultStart" runat="server" Text="Default Start Time"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadTimePicker ID="rdpDefaultStratTime" runat="server" Skin="Default" Width="100%" MinDate="1900-01-01"></telerik:RadTimePicker>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDefaultHours" meta:resourceKey="lblDefaultHours" runat="server" Text="Default Hours"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlDefaultHours" runat="server" Width="100%" CssClass="RightAlign"></telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblNotes" meta:resourceKey="lblNotes" runat="server" Text="Notes"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtNotes" MaxLength="2000" TextMode="MultiLine" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="PMHeader">
                <div class="row">
                    <div class="col-12">
                        <fieldset>
                            <legend>
                                <asp:Label ID="lblLabors" CssClass="legend" runat="server" Text="Labor" meta:resourcekey="lblLabors"></asp:Label>
                            </legend>
                            <telerik:RadGrid ID="rdgLabors" AllowMultiRowSelection="true" runat="server"
                                HeaderStyle-Font-Size="8" Width="100%" AutoGenerateColumns="False" SetWidth="true" FitParentContainer="true" ClientSettings-Scrolling-AllowScroll="false"
                                AllowSorting="true" ShowStatusBar="true" AllowPaging="true" PageSize="10">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="None" InsertItemDisplay="Top"
                                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="Display" HeaderStyle-HorizontalAlign="Left"
                                            HeaderStyle-Width="60px" UniqueName="Display">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chbDisplay" Checked='<%# CBool(IIf(Eval("IsDisplayed") Is System.DBNull.Value, 0, Eval("IsDisplayed")))%>' runat="server" />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="ID" HeaderStyle-HorizontalAlign="Center"
                                            HeaderStyle-Width="80px" SortExpression="Code" UniqueName="ID">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Code").ToString.Trim = String.Empty, "&nbsp;", "L" & Container.DataItem("Code").ToString)%></span>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Sub" HeaderStyle-Width="10%" ItemStyle-Wrap="false"
                                            SortExpression="Sub" UniqueName="Sub" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false">
                                            <ItemTemplate>
                                                <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Sub")) = CBool(1), "checked.png", "unchecked.png"))%>"
                                                    alt="" />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn UniqueName="Description" HeaderText="Description" HeaderStyle-HorizontalAlign="Center"
                                            HeaderStyle-Width="300px" SortExpression="Description">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Description").ToString.Trim = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%></span>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn UniqueName="Company" HeaderText="Company" HeaderStyle-HorizontalAlign="Center"
                                            HeaderStyle-Width="200px" SortExpression="CompanyName">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("CompanyName").ToString.Trim = String.Empty, "&nbsp;", Container.DataItem("CompanyName").ToString)%></span>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn UniqueName="Contact" HeaderText="Contact" HeaderStyle-HorizontalAlign="Center"
                                            HeaderStyle-Width="200px" SortExpression="ContactName">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("ContactName").ToString.Trim = String.Empty, "&nbsp;", Container.DataItem("ContactName").ToString)%></span>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <FooterStyle CssClass="GridFooter" />
                                </MasterTableView>
                                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="False" Resizing-AllowColumnResize="False">
                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="False" />
                                </ClientSettings>
                            </telerik:RadGrid>
                        </fieldset>
                        <fieldset>
                            <legend>
                                <asp:Label ID="lblEquipment" CssClass="legend" meta:resourceKey="lblEquipment" runat="server" Text="Equipment"></asp:Label>
                            </legend>
                            <telerik:RadGrid ID="rdgEquipment" AllowMultiRowSelection="true" runat="server"
                                HeaderStyle-Font-Size="8" Width="100%" AutoGenerateColumns="False" SetWidth="true" FitParentContainer="true"
                                AllowSorting="true" AllowPaging="true" PageSize="10" ShowStatusBar="true" ClientSettings-Scrolling-AllowScroll="true">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="None" InsertItemDisplay="Top"
                                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Display %>" HeaderStyle-HorizontalAlign="Left"
                                            HeaderStyle-Width="60px">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chbDisplay" Checked='<%# CBool(IIf(Eval("IsDisplayed") Is System.DBNull.Value, 0, Eval("IsDisplayed")))%>' runat="server" />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_ID %>" HeaderStyle-HorizontalAlign="Right"
                                            HeaderStyle-Width="80px" SortExpression="Code">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Code").ToString = String.Empty, "&nbsp;", "E" & Container.DataItem("Code").ToString)%></span>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Description %>" HeaderStyle-HorizontalAlign="Center"
                                            HeaderStyle-Width="300px" SortExpression="Description">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("Description").ToString = String.Empty, "&nbsp;", Container.DataItem("Description").ToString)%></span>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_LaborResource %>" HeaderStyle-HorizontalAlign="Center"
                                            HeaderStyle-Width="200px" SortExpression="LaborName">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("LaborName").ToString = String.Empty, "&nbsp;", Container.DataItem("LaborName").ToString)%></span>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="<%$Resources: GridColumn_Equipment %>" HeaderStyle-HorizontalAlign="Center"
                                            HeaderStyle-Width="200px" SortExpression="EquipmentName">
                                            <ItemTemplate>
                                                <span><%#IIf(Container.DataItem("EquipmentName").ToString = String.Empty, "&nbsp;", Container.DataItem("EquipmentName").ToString)%></span>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <FooterStyle CssClass="GridFooter" />
                                </MasterTableView>
                                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="False" Resizing-AllowColumnResize="False">
                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="False" />
                                </ClientSettings>
                            </telerik:RadGrid>
                        </fieldset>
                    </div>
                </div>
            </div>
        </div>
    </telerik:RadAjaxPanel>
</asp:Content>
