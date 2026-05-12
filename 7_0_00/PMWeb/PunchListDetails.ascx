<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="PunchListDetails.ascx.vb"
    Inherits="Website.PunchListDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="UserDefinedFields.ascx" TagName="UserDefinedFields" TagPrefix="uc1" %>

<telerik:RadAjaxManagerProxy ID="punch" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgPunchListDetails">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgPunchListDetails" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadCodeBlock ID="CodeBlock" runat="server">
    <script language="javascript" type="text/javascript">
        function ToggleAssetMenu() {
            var tdAssetMenu = $('[id$=tdAssetMenu]')[0];
            var tdAssetExplorerBar = $('[id$=tdAssetExplorerBar]')[0];
            var form = $('form')[0]
            var btnToggleAssetMenu = $('[id$=btnToggle]')[0];
            if (tdAssetMenu.style.display == 'none') {
                tdAssetMenu.style.display = '';
                tdAssetExplorerBar.style.left = "290px";
                tdAssetExplorerBar.className = 'AssetExplorerBar MobileFormsExplorerBar'
                btnToggleAssetMenu.className = 'AsserExplorerbutton HideAssetMenu MobileAsserExplorerbutton'
            } else {
                tdAssetMenu.style.display = 'none';
                tdAssetExplorerBar.style.left = "0px";
                tdAssetExplorerBar.className = 'AssetExplorerBar MobileAssetExplorerBarClosed'
                btnToggleAssetMenu.className = 'AsserExplorerbutton ShowAssetMenu MobileAsserExplorerbutton'
            }
            return false;
        }
    </script>
    <style>
        .MobileAssetExplorerBarClosed {
            position: static !important;
            height: calc(100vh - 124px) !important;
        }

        @media screen and (max-width:844px) {
            #ctl00_CPH1_PunchListDetails_tdOnSite {
                position: absolute !important;
            }

            .MobileFormsTree {
                height: calc(100vh - 138px);
            }

            .MobileFormsExplorerBar {
                height: calc(100vh - 124px) !important;
            }

            div#dvTree {
                height: calc(100vh - 156px) !important;
                overflow-y: auto;
            }
        }

        @media screen and (min-width:844px) {
            #RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_PunchListDetails_RadContentPane, #RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_PunchListDetails_treeGroupsAndItemsPane {
                height: calc(100vh - 150px) !important;
                background-color: white;
            }
        }


        @media screen and (max-width:843px) {
            .GridLayoutsLeftSplitterPane {
                position: fixed;
                width: 60vw !important;
                top: 0;
                height: calc(100vh - 123px) !important;
                z-index: 3000;
                border: 1px solid #999;
                margin-top: 87px;
                background-color: white;
            }

            .GridsLayoutSplitter {
                position: fixed;
                left: calc(60vw);
                z-index: 3000;
                height: calc(100vh - 123px) !important;
            }

            .GridLayoutsSplitterPane {
                width: calc(100vw - 6px) !important;
                height: calc(100vh - 123px) !important;
            }
        }

        .removeLeft {
            left: 0 !important;
        }

        td.rspFirstItem {
            position: relative;
        }

        .btnTreeDropItems {
            display: block !important;
        }
    </style>
</telerik:RadCodeBlock>
 <textarea type="text" id="txtClipboard" style="position: absolute;left: -9999px;" runat="server" readonly="readonly"  />
<telerik:RadContextMenu ID="cmAddFirstNode" runat="server" OnClientItemClicking="AddFirstNode">
    <Targets>
        <telerik:ContextMenuElementTarget ElementID="dvTree" />
    </Targets>
    <Items>
        <telerik:RadMenuItem Text="Add Location" meta:resourcekey="MenuItem_AddRootNode" PostBack="false" EnableImageSprite="true" CssClass="MenuAdd" Value="AddRootNode" />
        <telerik:RadMenuItem Value="DELETE" Visible="false" Text="Delete All Locations" PostBack="false" EnableImageSprite="true" CssClass="MenuDelete">
        </telerik:RadMenuItem>
    </Items>
</telerik:RadContextMenu>
<div class="PMHeader">
    <div class="row">
        <div class="col-12 ResponsiveMargin">
            <telerik:RadSplitter ID="RadSplitter1" runat="server" Width="100%" Height="100%" Skin="Default" CssClass="AssetExplorerVerticalSplitter" SplitBarsSize="" OnClientLoad="onResized">
                <telerik:RadPane ID="treeGroupsAndItemsPane" runat="server" Width="30%" Index="0" Skin="" CssClass="GridLayoutsLeftSplitterPane" EnableEmbeddedBaseStylesheet="False" OnClientCollapsed="OnClientCollapsed" OnClientExpanded="OnClientExpanded">
                    <asp:Label runat="server" ID="lblLocations" meta:resourcekey="lblLocations" Text="Locations"></asp:Label>

                    <div style="width: 100%; height: 100%" id="dvTree">
                        <telerik:RadTreeView ID="rdvLocations" runat="server" OnClientNodeEditStart="OnClientNodeEditStartHandler" EnableDragAndDrop="True" 
                            OnClientContextMenuItemClicking="onClientContextMenuItemClicking" OnNodeExpand="rdvLocations_NodeExpand"
                            MultipleSelect="true" OnClientNodeDropping="onNodeDropping" OnClientNodeDragging="onNodeDragging" OnClientContextMenuShowing="onClientContextMenuShowing" 
                            CssClass="CheckBoxesTreeview" CheckBoxes="true" OnClientNodeChecked="ShowHidebtnTreeDropItems">
                            <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                            <ExpandAnimation Duration="100"></ExpandAnimation>
                            <ContextMenus>
                                <telerik:RadTreeViewContextMenu ID="MainContextMenu" runat="server" Skin="Default" CssClass="trvContextMenu">
                                    <Items>
                                        <telerik:RadMenuItem Value="AddChild" meta:resourcekey="MenuItem_AddChild" Text="Add Sub-Location" EnableImageSprite="true" CssClass="MenuAdd">
                                        </telerik:RadMenuItem>
                                        <telerik:RadMenuItem Value="DELETE" meta:resourcekey="MenuItem_DELETE" Text="Delete" EnableImageSprite="true" CssClass="MenuDelete">
                                        </telerik:RadMenuItem>
                                        <telerik:RadMenuItem Value="Rename" meta:resourcekey="MenuItem_Rename" Text="Rename" EnableImageSprite="true" CssClass="MenuRename">
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadTreeViewContextMenu>
                            </ContextMenus>
                        </telerik:RadTreeView>
                        <asp:LinkButton runat="server" ID="btnTreeDropItems" CssClass="Hide">
                            <div class="btnTreeDropItems">&nbsp;</div>
                        </asp:LinkButton>
                    </div>
                </telerik:RadPane>
                <telerik:RadSplitBar ID="Splitter" runat="server" Index="1" Skin="Default" meta:resourcekey="Splitter" CssClass="GridsLayoutSplitter" CollapseMode="Forward" />
                <telerik:RadPane ID="RadContentPane" CssClass="GridLayoutsSplitterPane" runat="server" Width="70%" Index="2" Skin="Default" OnClientResized="ClientResized">
                    <telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
                        MaxDate="12/31/2100" runat="server" Skin="Default">
                        <ClientEvents OnDateSelected="dateSelected" />
                    </telerik:RadDatePicker>
                    <div class="PMHeader">
                        <div class="row">
                            <div class="col-12">
                                <telerik:RadGrid ID="rdgPunchListDetails" runat="server" Width="100%" ClientSettings-Scrolling-AllowScroll="true" SetWidth="true" AppendMenus="true"
                                    AutoGenerateColumns="False" ShowStatusBar="False" Font-Size="8px" PageSize="15" UseEditFormInMobile="true"
                                    AllowPaging="True" ShowGroupPanel="True" AllowMultiRowEdit="True" AllowMultiRowSelection="true" HasPasteFromExcel="true"
                                    AllowSorting="True" GridLines="None" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
                                    <PagerStyle Mode="NextPrevAndNumeric"></PagerStyle>
                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                        ClientDataKeyNames="Id" DataKeyNames="Id" CommandItemDisplay="Top" Width="100%"
                                        InsertItemDisplay="Top" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage"
                                        EditMode="InPlace" EnableHeaderContextMenu="true" TableLayout="Fixed">
                                        <Columns>
                                            <telerik:GridTemplateColumn HeaderText="Item #" HeaderStyle-Width="110px" ItemStyle-HorizontalAlign="Right"
                                                HeaderStyle-Wrap="false" Groupable="false" Reorderable="true" SortExpression="ItemNumber"
                                                UniqueName="ItemNumber" DataField="ItemNumber" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                <ItemTemplate>
                                                    <span><%#IIf(Eval("ItemNumber") Is System.DBNull.Value, "&nbsp;", Eval("ItemNumber"))%></span>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <span><%#IIf(Eval("ItemNumber") Is System.DBNull.Value, "&nbsp;", Eval("ItemNumber"))%></span>
                                                </EditItemTemplate>
                                                <HeaderStyle Wrap="False" Width="120px"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Attachments" SortExpression="AttachmentTotal"
                                                UniqueName="AttachmentTotal" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="AttachmentTotal"
                                                GroupByExpression="AttachmentTotal [GridColumn_AttachmentTotal] Group By AttachmentTotal">
                                                <ItemTemplate>
                                                    <asp:LinkButton runat="server" ID="btnAttachments"> 
                                            <span>(<%#Container.DataItem("AttachmentTotal")%>)</span>
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                                <EditItemTemplate><span><%#IIf(Eval("AttachmentTotal") Is DBNull.Value, "", "(" + Eval("AttachmentTotal").ToString() + ")")%></span></EditItemTemplate>
                                                <HeaderStyle Width="75px" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Location" HeaderStyle-Width="200px" ItemStyle-HorizontalAlign="Right"
                                                HeaderStyle-Wrap="false" Groupable="true" Reorderable="true" SortExpression="Location"
                                                GroupByExpression="Location [GridColumn_Location] Group By Location" UniqueName="Location" DataField="Location" CurrentFilterFunction="Contains"
                                                FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                <ItemTemplate>
                                                    <span><%#IIf(Container.DataItem("Location") Is DBNull.Value, "&nbsp;", Container.DataItem("Location") & "&nbsp;")%></span>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <input type="hidden" id="hdLocationId" runat="server" value='<%# Eval("LocationId") %>' />
                                                    <input type="hidden" id="hdLocationType" runat="server" value='<%# Eval("LocationType") %>' />
                                                    <asp:TextBox ID="txtLocation" runat="server" MaxLength="1000" Width="100%" Text='<%# Eval("Location") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <HeaderStyle Wrap="False" Width="200px"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Description" HeaderStyle-Width="200px" ItemStyle-HorizontalAlign="Right"
                                                HeaderStyle-Wrap="false" Groupable="true" Reorderable="true" SortExpression="Description"
                                                GroupByExpression="Description [GridColumn_Description] Group By Description" UniqueName="Description" DataField="Description" CurrentFilterFunction="Contains"
                                                FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                <ItemTemplate>
                                                    <span><%#IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description"))%></span>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtDescription" MaxLength="4000" Width="100%" runat="server" Text='<%# Eval("Description") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <HeaderStyle Wrap="False" Width="180px"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Trade" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Right"
                                                HeaderStyle-Wrap="false" Groupable="true" Reorderable="true" SortExpression="Trade"
                                                GroupByExpression="Trade [GridColumn_Trade] Group By Trade" UniqueName="Trade" DataField="Trade" CurrentFilterFunction="Contains"
                                                FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                <ItemTemplate>
                                                    <span><%#IIf(Container.DataItem("Trade") = String.Empty, "&nbsp;", Container.DataItem("Trade"))%></span>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadComboBox ID="ddlTrade" Filter="Contains" AllowCustomText="True" runat="server" Width="100%" Skin="Default" Style="font-size: 11px">
                                                    </telerik:RadComboBox>
                                                </EditItemTemplate>
                                                <HeaderStyle Wrap="False" Width="180px"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Assigned To" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Right"
                                                HeaderStyle-Wrap="false" Groupable="true" Reorderable="true" SortExpression="AssignedToName"
                                                GroupByExpression="AssignedToName [GridColumn_AssignedToName] Group By AssignedToName" UniqueName="AssignedToName" DataField="AssignedToName" CurrentFilterFunction="Contains"
                                                FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                <ItemTemplate>
                                                    <span><%#IIf(Container.DataItem("AssignedToName") = String.Empty, "&nbsp;", Container.DataItem("AssignedToName"))%></span>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <div style="width: 100%; white-space: nowrap">
                                                        <telerik:RadComboBox ID="ddlAssignedTo" runat="server" Width="85%" DropDownWidth="405px"
                                                            Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListContactEmptyMsg %>'
                                                            NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
                                                            OnClientDropDownClosed="dllcompClientClosed"
                                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                            OnItemsRequested="ddl_ItemsRequested"
                                                            Style="font-size: 11px" Height="250px">
                                                            <HeaderTemplate>
                                                                <table style="width: 385px" cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td style="width: 250px;">
                                                                            <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal></td>
                                                                        <td style="width: 135px;">
                                                                            <asp:Literal ID="Literal4" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal></td>
                                                                    </tr>
                                                                </table>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <table style="width: 385px" cellspacing="0" cellpadding="2">
                                                                    <tr>
                                                                        <td style="width: 250px;">
                                                                            <%#DataBinder.Eval(Container, "Attributes['CompanyName']")%>
                                                                        </td>
                                                                        <td style="width: 135px;">
                                                                            <%#DataBinder.Eval(Container, "Attributes['ContactName']")%>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ItemTemplate>
                                                        </telerik:RadComboBox>
                                                        <asp:LinkButton runat="server" ID="imgfilter"
                                                            OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter','HiddenField1'),this.id.replace('imgfilter','ddlAssignedTo'),'Contacts')"
                                                            CssClass="SearchButton">
                                      <span class="Icon"></span>
                                                        </asp:LinkButton>
                                                        <asp:HiddenField ID="HiddenField1" runat="server" />
                                                    </div>
                                                </EditItemTemplate>
                                                <HeaderStyle Wrap="False" Width="150px"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Issued Date" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right"
                                                HeaderStyle-Wrap="false" Groupable="true" Reorderable="true" SortExpression="IssuedDate"
                                                GroupByExpression="IssuedDate [GridColumn_IssuedDate] Group By IssuedDate" UniqueName="IssuedDate" DataField="IssuedDate" CurrentFilterFunction="EqualTo"
                                                FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                <ItemTemplate>
                                                    <span><%#FormatDate(Container.DataItem("IssuedDate"))%>&nbsp;</span>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                <EditItemTemplate>
                                                    <telerik:RadDatePicker ID="dtpIssuedDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                        SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default" Culture="English (United States)"
                                                        EnableTyping="True">
                                                        <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                                            runat="server">
                                                        </DateInput>
                                                        <Calendar ID="Calendar2" Skin="Default" runat="server">
                                                        </Calendar>
                                                    </telerik:RadDatePicker>
                                                </EditItemTemplate>
                                                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Received From" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Right"
                                                HeaderStyle-Wrap="false" Groupable="true" Reorderable="true" SortExpression="ReceivedFromName"
                                                GroupByExpression="ReceivedFromName [GridColumn_ReceivedFromName] Group By ReceivedFromName" UniqueName="ReceivedFromName" DataField="ReceivedFromName" CurrentFilterFunction="Contains"
                                                FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                <ItemTemplate>
                                                    <span><%#IIf(Container.DataItem("ReceivedFromName") = String.Empty, "&nbsp;", Container.DataItem("ReceivedFromName"))%></span>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <div style="width: 100%; white-space: nowrap">
                                                        <telerik:RadComboBox ID="ddlReceivedFrom" runat="server" Width="85%" DropDownWidth="405px"
                                                            Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListContactEmptyMsg %>'
                                                            NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged1"
                                                            OnClientDropDownClosed="dllcompClientClosed1"
                                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                            OnItemsRequested="ddl_ItemsRequested"
                                                            Style="font-size: 11px" Height="250px">
                                                            <HeaderTemplate>
                                                                <table style="width: 385px" cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td style="width: 250px;">
                                                                            <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal></td>
                                                                        <td style="width: 135px;">
                                                                            <asp:Literal ID="Literal4" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal></td>
                                                                    </tr>
                                                                </table>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <table style="width: 385px" cellspacing="0" cellpadding="2">
                                                                    <tr>
                                                                        <td style="width: 250px;">
                                                                            <%#DataBinder.Eval(Container, "Attributes['CompanyName']")%>
                                                                        </td>
                                                                        <td style="width: 135px;">
                                                                            <%#DataBinder.Eval(Container, "Attributes['ContactName']")%>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ItemTemplate>
                                                        </telerik:RadComboBox>
                                                        <asp:LinkButton runat="server" ID="imgfilter1"
                                                            OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter1','HiddenField2'),this.id.replace('imgfilter1','ddlReceivedFrom'),'Contacts')"
                                                            CssClass="SearchButton">
                                      <span class="Icon"></span>
                                                        </asp:LinkButton>
                                                        <asp:HiddenField ID="HiddenField2" runat="server" />
                                                    </div>
                                                </EditItemTemplate>
                                                <HeaderStyle Wrap="False" Width="150px"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Sent To" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Right"
                                                HeaderStyle-Wrap="false" Groupable="true" Reorderable="true" SortExpression="SentToName"
                                                GroupByExpression="SentToName [GridColumn_SentToName] Group By SentToName" UniqueName="SentToName" DataField="SentToName" CurrentFilterFunction="Contains"
                                                FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                <ItemTemplate>
                                                    <span><%#IIf(Container.DataItem("SentToName") = String.Empty, "&nbsp;", Container.DataItem("SentToName"))%></span>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <div style="width: 100%; white-space: nowrap">
                                                        <telerik:RadComboBox ID="ddlSentTo" runat="server" Width="85%" DropDownWidth="405px"
                                                            Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListContactEmptyMsg %>'
                                                            NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged2"
                                                            OnClientDropDownClosed="dllcompClientClosed2"
                                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                            OnItemsRequested="ddl_ItemsRequested"
                                                            Style="font-size: 11px" Height="250px">
                                                            <HeaderTemplate>
                                                                <table style="width: 385px" cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td style="width: 250px;">
                                                                            <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal></td>
                                                                        <td style="width: 135px;">
                                                                            <asp:Literal ID="Literal4" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal></td>
                                                                    </tr>
                                                                </table>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <table style="width: 385px" cellspacing="0" cellpadding="2">
                                                                    <tr>
                                                                        <td style="width: 250px;">
                                                                            <%#DataBinder.Eval(Container, "Attributes['CompanyName']")%>
                                                                        </td>
                                                                        <td style="width: 135px;">
                                                                            <%#DataBinder.Eval(Container, "Attributes['ContactName']")%>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ItemTemplate>
                                                        </telerik:RadComboBox>
                                                        <asp:HiddenField ID="HiddenField3" runat="server" />
                                                        <asp:LinkButton runat="server" ID="imgfilter2" OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter2','HiddenField3'),this.id.replace('imgfilter2','ddlSentTo'),'Contacts')"
                                                            CssClass="SearchButton">
                                      <span class="Icon"></span>
                                                        </asp:LinkButton>
                                                    </div>
                                                </EditItemTemplate>
                                                <HeaderStyle Wrap="False" Width="150px"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Due Date" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right"
                                                HeaderStyle-Wrap="false" Groupable="true" Reorderable="true" SortExpression="DueDate"
                                                GroupByExpression="DueDate [GridColumn_DueDate] Group By DueDate" UniqueName="DueDate" DataField="DueDate" CurrentFilterFunction="EqualTo"
                                                FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                <ItemTemplate>
                                                    <span><%#FormatDate(Container.DataItem("DueDate"))%>&nbsp;</span>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                <EditItemTemplate>
                                                    <telerik:RadDatePicker ID="dtpDueDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                        SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default" Culture="English (United States)"
                                                        EnableTyping="True">
                                                        <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                                            runat="server">
                                                        </DateInput>
                                                        <Calendar ID="Calendar2" Skin="Default" runat="server">
                                                        </Calendar>
                                                    </telerik:RadDatePicker>
                                                </EditItemTemplate>
                                                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Days Overdue" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right"
                                                HeaderStyle-Wrap="false" Groupable="false" UniqueName="DaysOverdue" Reorderable="true" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDaysOverdue" runat="server"></asp:Label>&nbsp;
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:Label ID="lblDaysOverdue" runat="server"></asp:Label>
                                                </EditItemTemplate>
                                                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Completed" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right"
                                                HeaderStyle-Wrap="false" Groupable="true" Reorderable="true" SortExpression="CompletedDate"
                                                GroupByExpression="CompletedDate [GridColumn_CompletedDate] Group By CompletedDate" UniqueName="CompletedDate" DataField="CompletedDate" CurrentFilterFunction="EqualTo"
                                                FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                <ItemTemplate>
                                                    <span><%#formatdate(Container.DataItem("CompletedDate"))%>&nbsp;</span>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                <EditItemTemplate>
                                                    <telerik:RadDatePicker ID="dtpCompleted" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                        SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default" Culture="English (United States)"
                                                        EnableTyping="True">
                                                        <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default"
                                                            runat="server">
                                                        </DateInput>
                                                        <Calendar ID="Calendar2" Skin="Default" runat="server">
                                                        </Calendar>
                                                    </telerik:RadDatePicker>
                                                </EditItemTemplate>
                                                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Days +/-" HeaderStyle-Width="75px" ItemStyle-HorizontalAlign="Right"
                                                HeaderStyle-Wrap="false" Groupable="false" UniqueName="DaysPlusMinus" Reorderable="true" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDaysPlusMin" runat="server"></asp:Label>
                                                    &nbsp;
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:Label ID="lblDaysPlusMin" runat="server"></asp:Label>
                                                </EditItemTemplate>
                                                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Cost" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right"
                                                HeaderStyle-Wrap="false" Groupable="true" Reorderable="true" SortExpression="Cost"
                                                GroupByExpression="Cost [GridColumn_Cost] Group By Cost" UniqueName="Cost" DataField="Cost" CurrentFilterFunction="EqualTo"
                                                FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCost" runat="server" Text='<%#FormatCurrency(Container.DataItem("Cost"))%>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtCost" CssClass="Currency" runat="server" Width="100%" MaxLength="15"
                                                        Text='<%# FormatCurrency(Eval("Cost")) %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Charged To" HeaderStyle-Width="150px" ItemStyle-HorizontalAlign="Right"
                                                HeaderStyle-Wrap="false" Groupable="true" Reorderable="true" SortExpression="ChargeToName"
                                                GroupByExpression="ChargeToName [GridColumn_ChargeToName] Group By ChargeToName" UniqueName="ChargeToName" DataField="ChargeToName" CurrentFilterFunction="Contains"
                                                FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                <ItemTemplate>
                                                    <span><%#IIf(Container.DataItem("ChargeToName") = String.Empty, "&nbsp;", Container.DataItem("ChargeToName"))%></span>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <div style="width: 100%; white-space: nowrap">
                                                        <telerik:RadComboBox ID="ddlChargedTo" runat="server" Width="85%" DropDownWidth="405px"
                                                            Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false" EmptyMessage='<%$Resources:PMWeb, ListContactEmptyMsg %>'
                                                            NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged3"
                                                            OnClientDropDownClosed="dllcompClientClosed3"
                                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                            OnItemsRequested="ddl_ItemsRequested"
                                                            Style="font-size: 11px" Height="250px">
                                                            <HeaderTemplate>
                                                                <table style="width: 385px" cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td style="width: 250px;">
                                                                            <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal></td>
                                                                        <td style="width: 135px;">
                                                                            <asp:Literal ID="Literal4" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal></td>
                                                                    </tr>
                                                                </table>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <table style="width: 385px" cellspacing="0" cellpadding="2">
                                                                    <tr>
                                                                        <td style="width: 250px;">
                                                                            <%#DataBinder.Eval(Container, "Attributes['CompanyName']")%>
                                                                        </td>
                                                                        <td style="width: 135px;">
                                                                            <%#DataBinder.Eval(Container, "Attributes['ContactName']")%>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ItemTemplate>
                                                        </telerik:RadComboBox>
                                                        <asp:HiddenField ID="HiddenField4" runat="server" />
                                                        <asp:LinkButton runat="server" ID="imgfilter3"
                                                            OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter3','HiddenField4'),this.id.replace('imgfilter3','ddlChargedTo'),'Contacts')"
                                                            CssClass="SearchButton">
                                      <span class="Icon"></span>
                                                        </asp:LinkButton>

                                                    </div>
                                                </EditItemTemplate>
                                                <HeaderStyle Wrap="False" Width="150px"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Closed" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Right"
                                                HeaderStyle-Wrap="false" Groupable="true" Reorderable="true" SortExpression="Closed"
                                                GroupByExpression="Closed [GridColumn_Closed] Group By Closed" UniqueName="Closed" DataField="Closed" CurrentFilterFunction="Contains"
                                                FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                <ItemTemplate>
                                                    <img src="Images/Global/<%#CStr(IIf(CBool(Eval("Closed")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:CheckBox ID="chkClosed" runat="server" />
                                                </EditItemTemplate>
                                                <HeaderStyle Wrap="False" Width="110px"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Notes" HeaderStyle-Width="200px" ItemStyle-HorizontalAlign="Right"
                                                HeaderStyle-Wrap="false" Groupable="true" Reorderable="true" SortExpression="Notes"
                                                GroupByExpression="Notes [GridColumn_Notes] Group By Notes" UniqueName="Notes" DataField="Notes" CurrentFilterFunction="Contains"
                                                FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                <ItemTemplate>
                                                    <span><%#IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes"))%></span>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtNotes" MaxLength="4000" TextMode="MultiLine" Height="14px" runat="server" Width="70%" Text='<%# Eval("Notes") %>'></asp:TextBox>
                                                    <asp:LinkButton runat="server" ID="imgNotes" OnClientClick="return OpenNoteDetailPopup(this.id.replace('imgNotes','txtNotes'))"
                                                        CssClass="SearchButton">
                                      <span class="Icon"></span>
                                                    </asp:LinkButton>
                                                </EditItemTemplate>
                                                <HeaderStyle Wrap="False" Width="120px"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Field1" GroupByExpression="Field1 [GridColumn_Field1] Group By Field1 ASC" UniqueName="Field1"
                                                Groupable="false" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields1" runat="server" />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <uc1:UserDefinedFields ID="EditUserDefinedFields1" runat="server" />
                                                </EditItemTemplate>
                                                <HeaderStyle Width="115px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Field2" GroupByExpression="Field2 [GridColumn_Field2] Group By Field2 ASC" UniqueName="Field2"
                                                Groupable="false" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields2" runat="server" />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <uc1:UserDefinedFields ID="EditUserDefinedFields2" runat="server" />
                                                </EditItemTemplate>
                                                <HeaderStyle Width="115px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Field3" GroupByExpression="Field3 [GridColumn_Field3] Group By Field3 ASC" UniqueName="Field3"
                                                Groupable="false" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields3" runat="server" />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <uc1:UserDefinedFields ID="EditUserDefinedFields3" runat="server" />
                                                </EditItemTemplate>
                                                <HeaderStyle Width="115px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Field4" GroupByExpression="Field4 [GridColumn_Field4] Group By Field4 ASC" UniqueName="Field4"
                                                Groupable="false" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields4" runat="server" />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <uc1:UserDefinedFields ID="EditUserDefinedFields4" runat="server" />
                                                </EditItemTemplate>
                                                <HeaderStyle Width="115px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Field5" GroupByExpression="Field5 [GridColumn_Field5] Group By Field5 ASC" UniqueName="Field5"
                                                Groupable="false" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields5" runat="server" />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <uc1:UserDefinedFields ID="EditUserDefinedFields5" runat="server" />
                                                </EditItemTemplate>
                                                <HeaderStyle Width="115px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Field6" GroupByExpression="Field6 [GridColumn_Field6] Group By Field6 ASC" UniqueName="Field6"
                                                Groupable="false" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields6" runat="server" />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <uc1:UserDefinedFields ID="EditUserDefinedFields6" runat="server" />
                                                </EditItemTemplate>
                                                <HeaderStyle Width="115px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Field7" GroupByExpression="Field7 [GridColumn_Field7] Group By Field7 ASC" UniqueName="Field7"
                                                Groupable="false" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields7" runat="server" />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <uc1:UserDefinedFields ID="EditUserDefinedFields7" runat="server" />
                                                </EditItemTemplate>
                                                <HeaderStyle Width="115px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Field8" GroupByExpression="Field8 [GridColumn_Field8] Group By Field8 ASC" UniqueName="Field8"
                                                Groupable="false" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields8" runat="server" />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <uc1:UserDefinedFields ID="EditUserDefinedFields8" runat="server" />
                                                </EditItemTemplate>
                                                <HeaderStyle Width="115px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Field9" GroupByExpression="Field9 [GridColumn_Field9] Group By Field9 ASC" UniqueName="Field9"
                                                Groupable="false" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields9" runat="server" />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <uc1:UserDefinedFields ID="EditUserDefinedFields9" runat="server" />
                                                </EditItemTemplate>
                                                <HeaderStyle Width="115px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn HeaderText="Field10" GroupByExpression="Field10 [GridColumn_Field10] Group By Field10 ASC" UniqueName="Field10"
                                                Groupable="false" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <uc1:UserDefinedFields ID="PreviewUserDefinedFields10" runat="server" />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <uc1:UserDefinedFields ID="EditUserDefinedFields10" runat="server" />
                                                </EditItemTemplate>
                                                <HeaderStyle Width="115px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                        <CommandItemTemplate>
                                            <div style="padding: 2px">
                                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows" CssClass="GridCmdEditRows"
                                                    SecurityButtonType="ItemMode_Edit" Visible='<%# rdgPunchListDetails.EditIndexes.Count = 0 And (Not rdgPunchListDetails.MasterTableView.IsItemInserted) %>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblEditSelectedLines" runat="server"></asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="False" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                                    SecurityButtonType="AddEditMode_Edit" Visible='<%# rdgPunchListDetails.EditIndexes.Count > 0 %>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblUpdateRecords" runat="server"></asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnSave" runat="server" CausesValidation="False" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                                    SecurityButtonType="AddEditMode_Add" Visible='<%# rdgPunchListDetails.MasterTableView.IsItemInserted %>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblSave" runat="server"></asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                                    SecurityButtonType="AddEditMode" Visible='<%# rdgPunchListDetails.EditIndexes.Count > 0 Or rdgPunchListDetails.MasterTableView.IsItemInserted %>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblCancel" runat="server"></asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewLine" CssClass="GridCmdInitNewRow"
                                                    SecurityButtonType="ItemMode_Add" Visible='<%# rdgPunchListDetails.EditIndexes.Count = 0 And (Not rdgPunchListDetails.MasterTableView.IsItemInserted)  %>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblAddLine" runat="server"></asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnCloseSelectedLines" runat="server" CausesValidation="False" CssClass="GridCmdExecuteMove"
                                                    CommandName="CloseSelectedLines" SecurityButtonType="ItemMode_Edit" Visible='<%# rdgPunchListDetails.EditIndexes.Count = 0 And (Not rdgPunchListDetails.MasterTableView.IsItemInserted) %>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblCloseSelectedLines" runat="server" meta:resourcekey="lblCloseSelectedLines" Text="Close Selected Lines"></asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="return ConfirmDelete()" CssClass="GridCmdDeleteRows"
                                                    SecurityButtonType="ItemMode_Delete" Visible='<%# rdgPunchListDetails.EditIndexes.Count = 0 And (Not rdgPunchListDetails.MasterTableView.IsItemInserted) %>'
                                                    runat="server" CommandName="DeleteRows">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="Label2" runat="server"></asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid"
                                                    SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                                                    &nbsp;&nbsp;
                                                </asp:LinkButton>

                                                <asp:LinkButton ID="btnExportExcel" runat="server"
                                                    SecurityButtonType="ItemMode" CausesValidation="False" CommandName="ExpToExcel" CssClass="GridCmdExpToExcel"
                                                    Visible='<%# rdgPunchListDetails.EditIndexes.Count = 0 And (Not rdgPunchListDetails.MasterTableView.IsItemInserted)%>'>
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="Label8" Text="Copy To Exel" runat="server"></asp:Label>
                                                    &nbsp;&nbsp
                                                </asp:LinkButton>


                                                <asp:LinkButton ID="btnPasteClipBoard" runat="server" OnClientClick="return GetClipboardData();"
                                                    SecurityButtonType="ItemMode_Add" CausesValidation="False" CssClass="GridCmdPasteClipBoard" CommandName="PasteClipBoard">
                                                    <span class="Icon"></span>
                                                    <asp:Label ID="lblPasteLines" runat="server"></asp:Label>
                                                    &nbsp;&nbsp;&nbsp;
                                                </asp:LinkButton>
                              
                                                <span>
                                                <asp:Label ID="lblTreeLevelGrouping" runat="server" meta:resourcekey="lblTreeLevelGrouping" Text="Group by Tree Level"
                                                    Visible='<%# rdgPunchListDetails.EditIndexes.Count = 0 And (Not rdgPunchListDetails.MasterTableView.IsItemInserted) %>'></asp:Label>
                                                <telerik:RadComboBox ID="ddlTreeLevel" runat="server" OnSelectedIndexChanged="ddlTreeLevel_SelectedIndexChanged"
                                                    Width="90px" AutoPostBack="true" Style="font-size: 11px; padding-left: 16px;"
                                                    Visible='<%# rdgPunchListDetails.EditIndexes.Count = 0 And (Not rdgPunchListDetails.MasterTableView.IsItemInserted) %>'>
                                                </telerik:RadComboBox>
                                                </span>
                                                <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                                    CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                                    runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                                    EnableShadows="true" CausesValidation="false"
                                                    Visible="true">
                                                </telerik:RadMenu>
                                            </div>
                                        </CommandItemTemplate>
                                    </MasterTableView>
                                    <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="true" AllowColumnsReorder="true">
                                        <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
                                            AllowColumnResize="True"></Resizing>
                                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
                                    </ClientSettings>
                                </telerik:RadGrid>
                            </div>
                        </div>
                    </div>
                </telerik:RadPane>
            </telerik:RadSplitter>
            <input type="button" id="btnClipborad" class="Hide" runat="server" />
            <input type="hidden" id="hdClipboard" runat="server" />
        </div>
    </div>
</div>

<%--</telerik:RadAjaxPanel>--%>