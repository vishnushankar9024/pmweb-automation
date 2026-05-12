<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="InventoryLocations.aspx.vb" Inherits="Website.InventoryLocations" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="PMRotator.ascx" TagName="PMRotator" TagPrefix="uc1" %>
<%@ Register Src="InventoryLocationDetails.ascx" TagName="InventoryLocationDetails" TagPrefix="uc2" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc3" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc4" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc12" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script src="JS/PMRotator/PMRotator.js" type="text/javascript"></script>
        <script type="text/javascript">
            var forceMoreMenuToClose = true;
            function IntegerOnly(sender, eventArgs) {
                var c = eventArgs.get_keyCode();
                if (c == 46)
                    eventArgs.set_cancel(true);
            }

            function OpenLinkedAssetPOPUp(URL, Width, Height, AddClose) {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen(URL);
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.3, browserHeight * 0.9);
                    wnd.Center();
                }
                if (AddClose == true) {
                    wnd.add_close(WindowLinkedAssetClosed);
                }
                wnd.Center();
                return false;
            }

            function WindowLinkedAssetClosed(Opener) {
                var updatePanel = $("[id$=RadAjaxPanel1]")[0];
                if (updatePanel) { __doPostBack(updatePanel.id) }

            }

            var ddlItem;


            function ddlItemLoad(sender) {
                ddlItem = sender;

            }
            function ddlItems_OnClientSelectedIndexChanged(sender, eventArgs) {
                var Item = ddlItem.get_selectedItem();
                if (Item != null) {
                    var ddlUOM = $find($("[id$=ddlUom]")[0].id);
                    var UnitCost = Item._attributes.getAttribute("UnitCost");
                    var ManuFacturerId = Item._attributes.getAttribute("ManufacturerId");
                    var ManuFacturerNumber = Item._attributes.getAttribute("ManufacturerNumber");
                    var UOMId = Item._attributes.getAttribute("UOMId");
                    var txtUnitCost = $("[id$=txtUnitCost]");
                    txtUnitCost.val(CCur(UnitCost));
                    CalculateExtCost();
                    var txtMfrNumber = $("[id$=txtMfrNumber]");
                    txtMfrNumber.val(ManuFacturerNumber);
                    var txtDescription = $("[id$=txtDescription]");
                    txtDescription.val(Item._attributes.getAttribute("Description"));
                    ddlUOM.trackChanges();
                    ddlUOM.set_value(UOMId);
                    var selItem = ddlUOM.findItemByValue(UOMId);
                    if (selItem != null) {
                        selItem.select();

                        ddlUOM.set_text(selItem.get_text());
                    }
                    ddlUOM.commitChanges();

                }


            }
            function MfrNumberLoad(sender, args) {
                txtMfrNumber = sender;
            }


            function OpenInventoryMove(URL, Width, Height, AddClose) {
                var browserWidth = $telerik.$(window).width();
                var browserHeight = $telerik.$(window).height();
                var wnd = window.radopen(URL);
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight);
                    wnd.moveTo(0, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                if (AddClose == true) {
                    wnd.add_close(WindowMovelosed);
                }
                return false;
            }
            function WindowMovelosed(Opener) {
                var btnRefreshId = $("a[id$=btnRefresh]")[1];
                if (btnRefreshId) { eval(btnRefreshId.href.split(":")[1]); }
            }

            function ChangeOnHand() {
                var txtStocked = $("[id$=txtStocked]");
                var OnHand = $("[id$=txtOnHand]");
                var txtUsed = $("[id$=txtUsed]");
                var txtUnusable = $("[id$=txtUnusable]");
                var txtMoved = $("[id$=txtMoved]");
                var Res = CDbl(txtUsed.val()) + CDbl(txtMoved.val()) + CDbl(txtUnusable.val());


                OnHand.val(FPrec(CDbl(txtStocked.val()) - Res));
                CalculateExtCost();

            }

            function CalculateExtCost() {
                var OnHand = $("[id$=txtOnHand]");
                var ExtCost = $("[id$=txtExtCost]");
                var UnitCost = $("[id$=txtUnitCost]");
                ExtCost.val(CCur(CDbl(OnHand.val()) * CDbl(UnitCost.val())));

            }

            //function RowDblClick(sender, eventArgs) {
            //    return OpenPOPUp("StockMovesHistory.aspx?StockId=" + eventArgs.getDataKeyValue("Id"), 1050, 380, false);
            //}


            //var currentTextBox = null;
            //var currentDatePicker = null;
            //function showPopup(sender, e) {

            //    currentTextBox = sender;
            //    var datePicker = $find($("[id$=RadDatePicker1]")[0].id);
            //    currentDatePicker = datePicker;
            //    datePicker.set_selectedDate(currentDatePicker.get_dateInput().parseDate(sender.value));
            //    var position = datePicker.getElementPosition(sender);
            //    datePicker.showPopup(position.x, position.y + sender.offsetHeight);
            //}

            function dateSelected(sender, args) {
                if (currentTextBox != null) {

                    currentTextBox.value = args.get_newValue();
                }
            }


            //function parseDate(sender, e) {
            //    if (currentDatePicker != null) {
            //        var date = currentDatePicker.get_dateInput().parseDate(sender.value);
            //        var dateInput = currentDatePicker.get_dateInput();

            //        if (date == null) {
            //            date = currentDatePicker.get_selectedDate(); 
            //        }

            //        var formattedDate = dateInput.get_dateFormatInfo().FormatDate(date, dateInput.get_displayDateFormat());
            //        sender.value = formattedDate;
            //    }
            //}

            function OnMoveClick() {
                var Grid = $find($("[id$=rdgInventoryDetails]")[0].id);
                if (Grid.get_masterTableView().get_selectedItems().length > 0)
                    return true;
                return false;
            }

            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                    sender.close(true);

                    maintoolbarClick(args.get_item().get_value())
                }
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }


            function maintoolbarClick(Value) {
                var Id = '<%=PM.Asset.InventoryLocationInfo.Id%>';
                var HasReports = '<%= PM.Asset.InventoryLocationInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.Asset.InventoryLocationInfo.LocationId & " - " & PM.Asset.InventoryLocationInfo.Name)%>';
                switch (Value) {
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            window.open("ReportsPreviewPopup.aspx?ObjectType=COMPANY&Id=" +
                            Id
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Asset.InventoryLocationInfo.LocationId%>' + "&EntityType=1",
                            'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
                        }
                        break;
                    case 'New':
                        window.location = "InventoryLocations.aspx";
                        break;
                    default:

                        break;
                }
            }

            function MoreMenuOpening(sender, args) {
                if (!forceMoreMenuToClose) { args.set_cancel(true); return; }
            }

            function MoreMenuClosing(sender, args) {
                if (forceMoreMenuToClose) {
                    return;
                }
                args.set_cancel(true);
            }

            function Inventory_OnRowSelected(sender, args) {                
                var grid = $find($("[id$=rdgInventoryDetails]")[0].id);
                var selectedCount = grid.get_masterTableView().get_selectedItems().length
                if (selectedCount > 0) {
                    var GridCmdMoveOut = $(".GridCmdMoveOut_disabled");
                    var GridCmdMoveHistory = $(".GridCmdMoveHistory_disabled");
                    GridCmdMoveOut.removeClass("GridCmdMoveOut_disabled").addClass("GridCmdMoveOut");
                    GridCmdMoveHistory.removeClass("GridCmdMoveHistory_disabled").addClass("GridCmdMoveHistory");
                }
            }

        </script>

    </telerik:RadCodeBlock>

    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings> 
                 <telerik:AjaxSetting AjaxControlID="mlpInventory">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpInventory" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpInventory" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <table class="ToolBar SmallToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=58">
                            <div class="btnToolbarSearchDocument">
                                &nbsp; 
                            </div>
                </asp:LinkButton>
            </td>
            <td class="ToolbarTd HideOnMobileToolbar showOnIpad Recent">
                <asp:LinkButton runat="server" ID="btnRecent">
                            <div class="btnToolbarRecent">
                                &nbsp; 
                            </div>
                </asp:LinkButton>
            </td>
            <td style="width: 240px !important;" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                <telerik:RadComboBox ID="ddlInventories" runat="server" OnClientTextChange="LOD_DropDownTextChange" Width="240px"
                    Skin="Default" CloseDropDownOnBlur="true" Height="400px" NoWrap="true"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" CausesValidation="False" AutoPostBack="False">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True">
                    <Items>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" ValidationGroup="Save" CausesValidation="true" AccessKey="s">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                            CommandName="New" AccessKey="n" CausesValidation="false" PostBack="false">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" Value="Delete">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                            EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports"></telerik:RadToolBarButton>
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
                                                        <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('INVENTORYLOCATIONS');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" onclick="helpClick();" CssClass="Help"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td style="width: 100%"></td>
        </tr>
    </table>


    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        runat="server" MultiPageID="mlpInventory" Skin="Default" Width="100%" EnableViewState="True"
        CausesValidation="False">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True" />
            <telerik:RadTab Text="Stock" Value="Stock" CssClass="HideTabWhenDetailShownInHeader" />
            <telerik:RadTab Text="Notes" Value="Notes" Visible="True" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
        </Tabs>
    </telerik:RadTabStrip>

    <telerik:RadMultiPage ID="mlpInventory" runat="server" SelectedIndex="0" Width="100%" CssClass="documentMultiPages"
        RenderSelectedPageOnly="True">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <telerik:RadAjaxPanel ID="pnlDetailPane" LoadingPanelID="ldpPM" runat="server" Width="100%" HorizontalAlign="NotSet" EnableAJAX="false">
                <div class="PMMainPage">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="LblLocationId" meta:resourcekey="LblLocationId" Text="Location ID*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtCode" MaxLength="10"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCode" runat="server" ControlToValidate="txtCode"
                                            CssClass="Validator" ValidationGroup="Save" ErrorMessage="Required"
                                            Display="Dynamic" ForeColor="" meta:resourcekey="rfvRequired">
                                        </asp:RequiredFieldValidator>
                                        <asp:Label ID="lblLocationIdUnique" meta:resourcekey="lblLocationIdUnique" Text="<br/> Location ID should be unique."
                                            CssClass="Validator" runat="server" Visible="false">
                                        </asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblName" meta:resourcekey="lblName" Text="Name"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtName" MaxLength="100"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label runat="server" ID="lblLinkedTo" meta:resourcekey="lblLinkedTo" Text="Linked To*" Style="text-decoration: underline;"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton runat="server" ID="imgfilter1" OnClientClick="return OpenLinkedAssetPOPUp('InventoryLinkedAssets.aspx', 300, 400, true)"
                                                CssClass="SearchButton">
                                                                        <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" EnableAJAX="false">
                                            <asp:TextBox runat="server" ID="txtLinkedTo" ReadOnly="true"></asp:TextBox>
                                        </telerik:RadAjaxPanel>
                                        <asp:RequiredFieldValidator ID="rfvLinkedTo" meta:resourcekey="rfvRequired" ControlToValidate="txtLinkedTo"
                                            runat="server" ForeColor="" Display="Dynamic" CssClass="Validator" ErrorMessage="Required" ValidationGroup="Save">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label runat="server" ID="lblLocationType" meta:resourcekey="lblLocationType" Text="Location Type"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlInventoryLocationType" runat="server" Filter="Contains"
                                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                            NoWrap="true" CausesValidation="False">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCapacity" meta:resourcekey="lblCapacity" runat="server" Text="Capacity"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox CssClass="PositiveDouble" MaxLength="15" runat="server" ID="txtCapacity"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblUOM" meta:resourcekey="lblCapacityUOM" runat="server" Text="Capacity UOM"></asp:Label>
                                    </td>
                                    <td class="NoWrap controlWidth">
                                        <telerik:RadComboBox ID="ddlUOM" runat="server" Height="220px" Skin="Default" AllowCustomText="True" Filter="Contains" MarkFirstMatch="true"></telerik:RadComboBox>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <fieldset runat="server" id="fldSubLocations" style="margin-bottom: 5px;">
                                <legend>
                                    <asp:Label ID="lblSubLocations" runat="server" Text="SubLocations" meta:resourcekey="lblSubLocations"></asp:Label>
                                </legend>
                                <telerik:RadGrid ID="rdgSubLocations" AllowMultiRowSelection="true" runat="server" UseEditFormInMobile="true"
                                    HeaderStyle-Font-Size="8"
                                    AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" PageSize="5" AllowPaging="True">
                                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" Width="10%" />

                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" EditMode="InPlace"
                                        DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage">

                                        <Columns>

                                            <telerik:GridTemplateColumn HeaderText="Sub-Location ID*" HeaderStyle-HorizontalAlign="Center"
                                                HeaderStyle-Width="150px" SortExpression="SubLocationId" UniqueName="SubLocationId">
                                                <ItemTemplate>
                                                    <%#IIf(Container.DataItem("SubLocationId").ToString = String.Empty, "&nbsp;", Container.DataItem("SubLocationId"))%>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtSubLocationId" MaxLength="50" Width="100%" Text='<%# Eval("SubLocationId") %>' runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="rfvSubLocationId" runat="server" ControlToValidate="txtSubLocationId"
                                                        ValidationGroup="Save" meta:resourcekey="rfvRequired" Display="Dynamic" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Name" HeaderStyle-HorizontalAlign="Center"
                                                HeaderStyle-Width="150px" SortExpression="Name" UniqueName="Name">
                                                <ItemTemplate>
                                                    <%#IIf(Container.DataItem("Name").ToString = String.Empty, "&nbsp;", Container.DataItem("Name").ToString)%>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtName" MaxLength="100" Width="100%" Text='<%# Eval("Name") %>' runat="server"></asp:TextBox>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>

                                        </Columns>
                                        <FooterStyle CssClass="GridFooter" />
                                        <CommandItemTemplate>
                                            <div style="padding: 2px">
                                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false" CssClass="GridCmdEditRows"
                                                    SecurityButtonType="ItemMode_Edit"
                                                    CommandName="EditRows" Visible='<%# rdgSubLocations.EditIndexes.Count = 0 And (Not rdgSubLocations.MasterTableView.IsItemInserted) %>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnUpdateEdited" runat="server" ValidationGroup="Save" CssClass="GridCmdUpdateEdited"
                                                    SecurityButtonType="AddEditMode_Edit"
                                                    CommandName="UpdateEdited" Visible='<%# rdgSubLocations.EditIndexes.Count > 0 %>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnSave" runat="server" ValidationGroup="Save" CssClass="GridCmdPerformInsert"
                                                    SecurityButtonType="AddEditMode_Add"
                                                    CommandName="PerformInsert" Visible='<%# rdgSubLocations.MasterTableView.IsItemInserted %>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="Label5" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false" CssClass="GridCmdCancelAll"
                                                    SecurityButtonType="AddEditMode"
                                                    CommandName="CancelAll" Visible='<%# rdgSubLocations.EditIndexes.Count > 0 Or rdgSubLocations.MasterTableView.IsItemInserted %>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="Label6" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" CssClass="GridCmdInitNewRow"
                                                    SecurityButtonType="ItemMode_Add"
                                                    CommandName="InitNewRow" Visible='<%# rdgSubLocations.EditIndexes.Count = 0 AND (Not rdgSubLocations.MasterTableView.IsItemInserted) %>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="Label7" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();" CssClass="GridCmdDeleteRows"
                                                    Visible='<%# rdgSubLocations.EditIndexes.Count = 0 And (Not rdgSubLocations.MasterTableView.IsItemInserted) %>'
                                                    SecurityButtonType="ItemMode_Delete" runat="server" CommandName="DeleteRows">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="Label8" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" CssClass="GridCmdRebindGrid"
                                                    SecurityButtonType="ItemMode"
                                                    CommandName="RebindGrid" Visible='<%# rdgSubLocations.EditIndexes.Count = 0 AND (Not rdgSubLocations.MasterTableView.IsItemInserted) %>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="Label9" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                                </asp:LinkButton>
                                            </div>
                                        </CommandItemTemplate>
                                    </MasterTableView>
                                    <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                    <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="False" AllowRowsDragDrop="False"
                                        Resizing-AllowColumnResize="False">
                                        <Selecting AllowRowSelect="True" />
                                    </ClientSettings>
                                </telerik:RadGrid>
                            </fieldset>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc12:AssetRotator ID="PMrot" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvStock" runat="server" CssClass="ShowInHeaderWhenFit">
            <uc2:InventoryLocationDetails ID="InventoryLocationDetails1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc3:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc4:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>



</asp:Content>
