<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="AssetsSearch.aspx.vb" Inherits="Website.AssetsSearch" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpAssets" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rdbAssetList">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdbAssetList" />
                    <telerik:AjaxUpdatedControl ControlID="pnlAdvancedSearch" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="pnlresults" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="txtName" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnSearch" />
                    <telerik:AjaxUpdatedControl ControlID="rdgEquipments" LoadingPanelID="ldpPM" />

                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgSpaces">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgSpaces" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgBuildings">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgBuildings" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgFloors">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgFloors" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgOccupants">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgOccupants" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgEquipments">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgEquipments" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

    </telerik:RadAjaxManagerProxy>

    <style type="text/css">
        .RadGrid_PM TABLE .rgCommandRow TD TD {
            BORDER-TOP-WIDTH: 0px;
            PADDING-RIGHT: 0px;
            PADDING-LEFT: 0px;
            BORDER-LEFT-WIDTH: 0px;
            BORDER-BOTTOM-WIDTH: 0px;
            PADDING-BOTTOM: 0px;
            PADDING-TOP: 0px;
            BORDER-RIGHT-WIDTH: 0px;
        }
       /* .divContentHolder{
            padding-top:115px !important;
        }*/

        .RadGrid_PM THEAD .rgCommandRow TD {
            BORDER-BOTTOM: #688caf 1px solid;
        }

        .RadGrid_PM .rgCommandRow TD {
            BORDER-TOP-WIDTH: 0px;
            PADDING-RIGHT: 0px;
            PADDING-LEFT: 0px;
            BORDER-LEFT-WIDTH: 0px;
            BORDER-BOTTOM-WIDTH: 0px;
            PADDING-BOTTOM: 0px;
            PADDING-TOP: 0px;
            BORDER-RIGHT-WIDTH: 0px;
        }

        .RadGrid_PM .rgPagerLabel {
            font-size: 8pt !important;
        }

        #ctl00_ctl00_CPH1_rdbAssetListPanel {
            display: inline-block !important;
        }
        @media screen and (min-width:468px) and (max-width:843px) {
            .RadTabStrip .rtsLevel1 {
                padding-top: 60px;
            }
        }
   
    </style>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script language="javascript" type="text/javascript">
            function fun1(e, button2) {
                var evt = e ? e : window.event;
                var bt = document.getElementById(button2);
                if (bt) {
                    if (evt.keyCode == 13) {
                        bt.click();
                        return false;
                    }
                }
            }

            function OpenPlanView(FileGUID) {
                document.location.href = 'PMWebViewer.aspx?FileGUID=' + FileGUID + '&Source=FLOOR';
                return false;
            }

            function resizeIframe(obj) {
                obj.style.height = 0;
                obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
            }
            function ButtonMove() {
                var Tab = $find("ctl00_CPH1_tbsDocument");
                var value = Tab.get_selectedTab().get_value();
                var button = document.querySelector("#ctl00_CPH1_btnSearch");
                var left = document.querySelector('.col-4-left');
                var MainPage = document.querySelector('.PMMainPage.Margin-Top');
                if (value === "Equipments") {
                    var row = document.querySelector('.row');
                    if (row.clientWidth <= 1216 && row.clientWidth > 850) {
                        MainPage.style.position = "relative";
                        button.style.position = "absolute";
                        var top = left.clientHeight + 24;
                        button.style.top = top + "px";
                    }
                    else {
                        button.style.position = "static";
                        button.style.top = "";
                    }
                    
                }
            }
            window.onresize = function () {
                ButtonMove();
            }
        </script>
    </telerik:RadCodeBlock>

    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" class="documentMultiPages"
        runat="server" MultiPageID="mlpAssets" ScrollChildren="true" ScrollButtonsPosition="Left"
        OnTabClick="tbsDocument_TabClick" Width="100%" EnableViewState="True">
        <Tabs>
            <telerik:RadTab Text="Locations" Value="Locations" meta:resourcekey="rdbProperties" Selected="true" />
            <telerik:RadTab Text="Buildings" Value="Buildings" meta:resourcekey="rdbBuildings"></telerik:RadTab>
            <telerik:RadTab Text="Floors" Value="Floors" meta:resourcekey="rdbFloors" />
            <telerik:RadTab Text="Spaces" Value="Spaces" meta:resourcekey="rdbSpaces" />
            <telerik:RadTab Text="Occupants" Value="Occupants" meta:resourcekey="rdbOccupants"></telerik:RadTab>
            <telerik:RadTab Text="Equipments" Value="Equipments" meta:resourcekey="rdbEquipments"></telerik:RadTab>
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpAssets" runat="server" SelectedIndex="0" CssClass="documentSinglePageWithoutToolbar"
        Width="100%" RenderSelectedPageOnly="true">
        <telerik:RadPageView ID="pvLocations" runat="server" Selected="True">
            <iframe src="PropertiesMapView.aspx"  id="LocationFrame" width="100%" frameborder="0" style="background-image: none !important; border: 0;height:calc(100vh - 100px)"></iframe>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvBuildings" runat="server">
            <div class="PMMainPage">
                <div class="row">
                    <div class="col-12">
                        <telerik:RadGrid ID="rdgBuildings" AllowFilteringByColumn="true" runat="server" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                SetWidth="true" AppendMenus="true" PageSize="250" AllowPaging="true" ShowGroupPanel="true" AllowSorting="true" AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" GridLines="None">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                <ClientSettings EnableRowHoverStyle="True">
                    <Selecting EnableDragToSelectRows="False" />
                </ClientSettings>
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    CommandItemDisplay="None" DataKeyNames="Id" EditMode="InPlace" InsertItemPageIndexAction="ShowItemOnFirstPage">
                    <Columns>
                        <telerik:GridTemplateColumn SortExpression="Building" HeaderText="Building" GroupByExpression="Building [GridColumn_Building] Group By Building"
                            UniqueName="Building" CurrentFilterFunction="Contains" DataField="Building" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:HyperLink ID="hliBuilding" runat="server" CssClass="NoWrap Link"
                                    Text='<%#IIf(Container.DataItem("Building") = String.Empty, "&nbsp;", Container.DataItem("Building"))%>'
                                    NavigateUrl='<%# CStr(Container.DataItem("BuildingUrl"))%>'></asp:HyperLink>&nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="219px" />
                            <ItemStyle Wrap="false " />

                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn SortExpression="Location" HeaderText="Location" GroupByExpression="Location [GridColumn_Location] Group By Location"
                            UniqueName="Location" CurrentFilterFunction="Contains" DataField="Location" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:HyperLink ID="hliLocation" runat="server" CssClass="NoWrap Link"
                                    Text='<%#IIf(Container.DataItem("Location") = String.Empty, "&nbsp;", Container.DataItem("Location"))%>'
                                    NavigateUrl='<%# CStr(Container.DataItem("LocationUrl"))%>'></asp:HyperLink>&nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="219px" />
                            <ItemStyle Wrap="false " />

                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn SortExpression="LocationType" GroupByExpression="LocationType [GridColumn_LocationType] Group By LocationType" HeaderText="Location Type"
                            UniqueName="LocationType" CurrentFilterFunction="Contains" DataField="LocationType" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%#Container.DataItem("LocationType")%>' CssClass="NoWrap" ID="lblLocationType"></asp:Label>&nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="219px" />
                            <ItemStyle Wrap="false " />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn SortExpression="Country" GroupByExpression="Country [GridColumn_Country] Group By Country" HeaderText="Country"
                            UniqueName="Country" CurrentFilterFunction="Contains" DataField="Country" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Country") = String.Empty, "&nbsp;", Container.DataItem("Country"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="219px" />
                            <ItemStyle Wrap="false " />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn SortExpression="State" GroupByExpression="State [GridColumn_State] Group By State" HeaderText="State"
                            UniqueName="State" CurrentFilterFunction="Contains" DataField="State" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("State") = String.Empty, "&nbsp;", Container.DataItem("State"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="219px" />
                            <ItemStyle Wrap="false " />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn SortExpression="City" GroupByExpression="City [GridColumn_City] Group By City" HeaderText="City"
                            UniqueName="City" CurrentFilterFunction="Contains" DataField="City" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("City") = String.Empty, "&nbsp;", Container.DataItem("City"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="219px" />
                            <ItemStyle Wrap="false " />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn SortExpression="Address" GroupByExpression="Address [GridColumn_Address] Group By Address" HeaderText="Address"
                            UniqueName="Address" CurrentFilterFunction="Contains" DataField="Address" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Address") = String.Empty, "&nbsp;", Container.DataItem("Address"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="219px" />
                            <ItemStyle Wrap="false " />
                        </telerik:GridTemplateColumn>

                    </Columns>
                    <EditFormSettings>
                        <EditColumn CancelImageUrl="Cancel.gif" EditImageUrl="Edit.gif" InsertImageUrl="Update.gif"
                            UpdateImageUrl="Update.gif">
                        </EditColumn>
                    </EditFormSettings>
                    <CommandItemTemplate>
                    </CommandItemTemplate>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ValidationSettings ValidationGroup="ObjectImport" EnableValidation="true" CommandsToValidate="SaveChanges" />
                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="false" AllowDragToGroup="true">
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />

                </ClientSettings>
            </telerik:RadGrid>
                    </div>
                </div>
            </div>
            
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvFloors" runat="server">
               <div class="PMMainPage">
                <div class="row">
                    <div class="col-12">
                       <telerik:RadGrid ID="rdgFloors" AllowFilteringByColumn="true" runat="server" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                SetWidth="true" AppendMenus="true" PageSize="250" AllowPaging="true" ShowGroupPanel="true" AllowSorting="true" AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" GridLines="None">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                <ClientSettings EnableRowHoverStyle="True">
                    <Selecting EnableDragToSelectRows="False" />
                </ClientSettings>
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    CommandItemDisplay="None" DataKeyNames="Id" EditMode="InPlace" InsertItemPageIndexAction="ShowItemOnFirstPage">
                    <Columns>
                        <telerik:GridTemplateColumn SortExpression="Floors" HeaderText="Floor" GroupByExpression="Floors [GridColumn_Floors] Group By Floors"
                            UniqueName="Floors" CurrentFilterFunction="Contains" DataField="Floors" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>

                                <asp:HyperLink ID="hliFloors" runat="server" CssClass="NoWrap Link"
                                    Text='<%#IIf(Container.DataItem("Floors") = String.Empty, "&nbsp;", Container.DataItem("Floors"))%>'
                                    NavigateUrl='<%# CStr(Container.DataItem("FloorUrl"))%>'></asp:HyperLink>&nbsp;
      
                            </ItemTemplate>
                            <HeaderStyle Width="300px" />
                            <ItemStyle Wrap="false " />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn SortExpression="TotalSpaces" GroupByExpression="TotalSpaces [GridColumn_TotalSpaces] Group By TotalSpaces" HeaderText="Total Spaces"
                            UniqueName="TotalSpaces" CurrentFilterFunction="EqualTo" DataField="TotalSpaces" DataType="System.Int32" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <%#Container.DataItem("TotalSpaces")%>
                            </ItemTemplate>
                            <HeaderStyle Width="300px" />
                            <ItemStyle Wrap="false " HorizontalAlign="right" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn SortExpression="Building" HeaderText="Building" GroupByExpression="Building [GridColumn_Building] Group By Building"
                            UniqueName="Building" CurrentFilterFunction="Contains" DataField="Building" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:HyperLink ID="hliBuilding" runat="server" CssClass="NoWrap Link"
                                    Text='<%#IIf(Container.DataItem("Building") = String.Empty, "&nbsp;", Container.DataItem("Building"))%>'
                                    NavigateUrl='<%# CStr(Container.DataItem("BuildingUrl"))%>'></asp:HyperLink>&nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="300px" />
                            <ItemStyle Wrap="false " />

                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn SortExpression="Location" HeaderText="Location" GroupByExpression="Location [GridColumn_Location] Group By Location"
                            UniqueName="Location" CurrentFilterFunction="Contains" DataField="Location" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:HyperLink ID="hliLocation" runat="server" CssClass="NoWrap Link"
                                    Text='<%#IIf(Container.DataItem("Location") = String.Empty, "&nbsp;", Container.DataItem("Location"))%>'
                                    NavigateUrl='<%# CStr(Container.DataItem("LocationUrl"))%>'></asp:HyperLink>&nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="300px" />
                            <ItemStyle Wrap="false " />

                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn SortExpression="LocationType" GroupByExpression="LocationType [GridColumn_LocationType] Group By LocationType" HeaderText="Location Type"
                            UniqueName="LocationType" CurrentFilterFunction="Contains" DataField="LocationType" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%#Container.DataItem("LocationType")%>' CssClass="NoWrap" ID="lblLocationType"></asp:Label>&nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="300px" />
                            <ItemStyle Wrap="false " />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText=""
                            UniqueName="HasPlanView" AllowFiltering="false" Groupable="false">
                            <ItemTemplate>
                                <asp:LinkButton ID="imgPlanView" meta:resourcekey="imgPlanView" ToolTip="Plan View" runat="server" CssClass="PMwebViewerButton"
                                    Visible='<%# Cbool(IIF(Eval("HasPlanView") is system.DBNULL.value, 0,Eval("HasPlanView")))%>'>
                                                        <span class="Icon"></span>
                                </asp:LinkButton>&nbsp; &nbsp;
    
                            </ItemTemplate>
                            <HeaderStyle Width="28px" />
                            <ItemStyle Wrap="false" HorizontalAlign="Center" />

                        </telerik:GridTemplateColumn>

                    </Columns>
                    <EditFormSettings>
                        <EditColumn CancelImageUrl="Cancel.gif" EditImageUrl="Edit.gif" InsertImageUrl="Update.gif"
                            UpdateImageUrl="Update.gif">
                        </EditColumn>
                    </EditFormSettings>
                    <CommandItemTemplate>
                    </CommandItemTemplate>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ValidationSettings ValidationGroup="ObjectImport" EnableValidation="true" CommandsToValidate="SaveChanges" />
                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="false" AllowDragToGroup="true">
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />

                </ClientSettings>
            </telerik:RadGrid> 
                    </div>
                </div>
            </div>
            
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvSpaces" runat="server">
               <div class="PMMainPage">
                <div class="row">
                    <div class="col-12">
                        <telerik:RadGrid ID="rdgSpaces" runat="server" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                SetWidth="true" AppendMenus="true" PageSize="250" AllowPaging="true" AllowFilteringByColumn="true" ShowGroupPanel="true" AllowSorting="true" AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" GridLines="None">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                <ClientSettings>
                    <Selecting EnableDragToSelectRows="False" />
                </ClientSettings>
                <MasterTableView ShowFooter="true" ShowGroupFooter="true" NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    CommandItemDisplay="Top" DataKeyNames="Id" EditMode="InPlace" EnableHeaderContextMenu="true" InsertItemPageIndexAction="ShowItemOnFirstPage">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText=""
                            UniqueName="PlanView" AllowFiltering="false" Groupable="false">
                            <ItemTemplate>
                                <asp:LinkButton ID="imgPlanView" meta:resourcekey="imgPlanView" ToolTip="Plan View" runat="server" CssClass="PMwebViewerButton"
                                    Visible='<%# Cbool(IIF(Eval("HasPlanView") is system.DBNULL.value, 0,Eval("HasPlanView")))%>'>
                                                        <span class="Icon"></span>
                                </asp:LinkButton>&nbsp; &nbsp;
    
                            </ItemTemplate>
                            <HeaderStyle Width="30px" />
                            <ItemStyle Wrap="false" HorizontalAlign="Center" BackColor="White" />

                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn SortExpression="Location" HeaderText="Location" GroupByExpression="Location [GridColumn_Location] Group By Location"
                            UniqueName="Location" CurrentFilterFunction="Contains" DataField="Location" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:HyperLink ID="hliLocation" runat="server" CssClass="NoWrap Link"
                                    Text='<%#IIf(Container.DataItem("Location") = String.Empty, "&nbsp;", Container.DataItem("Location"))%>'
                                    NavigateUrl='<%# CStr(Container.DataItem("LocationUrl"))%>'></asp:HyperLink>
                                &nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="160px" />
                            <ItemStyle Wrap="false" BackColor="White" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn SortExpression="LocationType" GroupByExpression="LocationType [GridColumn_LocationType] Group By LocationType" HeaderText="Location Type"
                            UniqueName="LocationType" CurrentFilterFunction="Contains" DataField="LocationType" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%#Container.DataItem("LocationType")%>' CssClass="NoWrap" ID="lblLocationType"></asp:Label>&nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="80px" />
                            <ItemStyle Wrap="false" BackColor="White" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn SortExpression="Country" GroupByExpression="Country [GridColumn_Country] Group By Country" HeaderText="Country"
                            UniqueName="Country" CurrentFilterFunction="Contains" DataField="Country" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Country") = String.Empty, "&nbsp;", Container.DataItem("Country"))%></span>
                                &nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="80px" />
                            <ItemStyle Wrap="false" BackColor="White" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn SortExpression="State" GroupByExpression="State [GridColumn_State] Group By State" HeaderText="State"
                            UniqueName="State" CurrentFilterFunction="Contains" DataField="State" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("State") = String.Empty, "&nbsp;", Container.DataItem("State"))%></span> &nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="40px" />
                            <ItemStyle Wrap="false " BackColor="White" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn SortExpression="City" GroupByExpression="City [GridColumn_City] Group By City" HeaderText="City"
                            UniqueName="City" CurrentFilterFunction="Contains" DataField="City" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("City") = String.Empty, "&nbsp;", Container.DataItem("City"))%></span>
                                &nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="80px" />
                            <ItemStyle Wrap="false " BackColor="White" />
                        </telerik:GridTemplateColumn>
                        <telerik:GridTemplateColumn SortExpression="PropertyManager" GroupByExpression="PropertyManager [GridColumn_PropertyManager] Group By PropertyManager" HeaderText="Manager"
                            UniqueName="PropertyManager" CurrentFilterFunction="Contains" DataField="PropertyManager" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("PropertyManager") = String.Empty, "&nbsp;", Container.DataItem("PropertyManager"))%></span>
                                &nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="80px" />
                            <ItemStyle Wrap="false " BackColor="White" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn SortExpression="OwnerContact" GroupByExpression="OwnerContact [GridColumn_OwnerContact] Group By OwnerContact" HeaderText="Owner"
                            UniqueName="OwnerContact" CurrentFilterFunction="Contains" DataField="OwnerContact" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("OwnerContact") = String.Empty, "&nbsp;", Container.DataItem("OwnerContact"))%></span>
                                &nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="80px" />
                            <ItemStyle Wrap="false " BackColor="White" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn SortExpression="Building" HeaderText="Building" GroupByExpression="Building [GridColumn_Building] Group By Building"
                            UniqueName="Building" CurrentFilterFunction="Contains" DataField="Building" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:HyperLink ID="hliBuilding" runat="server" CssClass="NoWrap Link"
                                    Text='<%#IIf(Container.DataItem("Building") = String.Empty, "&nbsp;", Container.DataItem("Building"))%>'
                                    NavigateUrl='<%# CStr(Container.DataItem("BuildingUrl"))%>'></asp:HyperLink>
                                &nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="160px" />
                            <ItemStyle Wrap="false " BackColor="#edf8fe" BorderColor="#9ab5d0" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn SortExpression="BuildingType" GroupByExpression="BuildingType [GridColumn_BuildingType] Group By BuildingType" HeaderText="Building Type"
                            UniqueName="BuildingType" CurrentFilterFunction="Contains" DataField="BuildingType" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%#Container.DataItem("BuildingType")%>' CssClass="NoWrap" ID="lblBuildingType"></asp:Label>
                                &nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="80px" />
                            <ItemStyle Wrap="false " BackColor="#edf8fe" BorderColor="#9ab5d0" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn SortExpression="Floors" HeaderText="Floor" GroupByExpression="Floors [GridColumn_Floors] Group By Floors"
                            UniqueName="Floors" CurrentFilterFunction="Contains" DataField="Floors" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:HyperLink ID="hliFloors" runat="server" CssClass="NoWrap Link"
                                    Text='<%#IIf(Container.DataItem("Floors") = String.Empty, "&nbsp;", Container.DataItem("Floors"))%>'
                                    NavigateUrl='<%# CStr(Container.DataItem("FloorUrl"))%>'></asp:HyperLink>
                                &nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="160px" />
                            <ItemStyle Wrap="false " BackColor="#edf8fe" BorderColor="#9ab5d0" />
                        </telerik:GridTemplateColumn>



                        <telerik:GridTemplateColumn SortExpression="Space" HeaderText="Space" GroupByExpression="Space [GridColumn_Space] Group By Space"
                            UniqueName="Space" CurrentFilterFunction="Contains" DataField="Space" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>

                                <asp:HyperLink ID="hliSpace" runat="server" CssClass="NoWrap Link"
                                    Text='<%#IIf(Container.DataItem("Space") = String.Empty, "&nbsp;", Container.DataItem("Space"))%>'
                                    NavigateUrl='<%# CStr(Container.DataItem("SpaceUrl"))%>'></asp:HyperLink>
                                &nbsp;
      
                            </ItemTemplate>
                            <HeaderStyle Width="160px" />
                            <ItemStyle Wrap="false " BackColor="#fefc75" BorderColor="#eec126" />

                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn SortExpression="Category" GroupByExpression="Category [GridColumn_SpaceType] Group By Category" HeaderText="Category"
                            UniqueName="Category" CurrentFilterFunction="Contains" DataField="Category" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%#Container.DataItem("Category")%>' CssClass="NoWrap" ID="lblCategory"></asp:Label>
                                &nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="80px" />
                            <ItemStyle Wrap="false " BackColor="#fefc75" BorderColor="#eec126" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn SortExpression="SpaceType" GroupByExpression="SpaceType [GridColumn_SpaceType] Group By SpaceType" HeaderText="Space Type"
                            UniqueName="SpaceType" CurrentFilterFunction="Contains" DataField="SpaceType" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%#Container.DataItem("SpaceType")%>' CssClass="NoWrap" ID="lblSpaceType"></asp:Label>
                                &nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="80px" />
                            <ItemStyle Wrap="false " BackColor="#fefc75" BorderColor="#eec126" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn SortExpression="SubType" GroupByExpression="SubType [GridColumn_SubType] Group By SubType"
                            HeaderText="Sub Type" UniqueName="SubType" CurrentFilterFunction="Contains" DataField="SubType" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <%#Container.DataItem("SubType")%> &nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="80px" />
                            <ItemStyle Wrap="false " BackColor="#fefc75" BorderColor="#eec126" />
                        </telerik:GridTemplateColumn>



                        <telerik:GridTemplateColumn SortExpression="Capacity" Aggregate="Sum" GroupByExpression="Capacity [GridColumn_Capacity] Group By Capacity"
                            HeaderText="Capacity" UniqueName="Capacity" FooterAggregateFormatString="{0}" CurrentFilterFunction="EqualTo" DataField="Capacity" DataType="System.Int64" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <%#Container.DataItem("Capacity")%>
                            </ItemTemplate>
                            <HeaderStyle Width="80px" />
                            <ItemStyle Wrap="false " BackColor="#fefc75" HorizontalAlign="Right" BorderColor="#eec126" />
                            <FooterStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>



                        <telerik:GridTemplateColumn SortExpression="Occupancy" Aggregate="Sum" GroupByExpression="Occupancy [GridColumn_Occupancy] Group By Occupancy"
                            HeaderText="Occupancy" UniqueName="Occupancy" FooterAggregateFormatString="{0}" CurrentFilterFunction="EqualTo" DataField="Occupancy" DataType="System.Int64" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <%#Container.DataItem("Occupancy")%>
                            </ItemTemplate>
                            <HeaderStyle Width="80px" />
                            <ItemStyle Wrap="false " BackColor="#fefc75" HorizontalAlign="Right" BorderColor="#eec126" />
                            <FooterStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn SortExpression="Utilization" Aggregate="Custom" GroupByExpression="Utilisation [GridColumn_Utilisation] Group By Utilisation"
                            HeaderText="Utilisation" UniqueName="Utilisation" FooterAggregateFormatString="{0}" CurrentFilterFunction="EqualTo" DataField="Utilisation" DataType="System.Decimal" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <%#FormatPercent(Container.DataItem("Utilisation"))%>
                            </ItemTemplate>
                            <HeaderStyle Width="80px" />
                            <ItemStyle Wrap="false " BackColor="#fefc75" HorizontalAlign="Right" BorderColor="#eec126" />
                            <FooterStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn SortExpression="Available" Aggregate="Sum" GroupByExpression="Available [GridColumn_Available] Group By Available"
                            HeaderText="Available" UniqueName="Available" FooterAggregateFormatString="{0}" CurrentFilterFunction="EqualTo" DataField="Available" DataType="System.Int64" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <%#Container.DataItem("Available")%>
                            </ItemTemplate>
                            <HeaderStyle Width="80px" />
                            <ItemStyle Wrap="false " BackColor="#fefc75" HorizontalAlign="Right" BorderColor="#eec126" />
                            <FooterStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Over Occupied" HeaderStyle-Width="55px" ItemStyle-Wrap="false"
                            SortExpression="IsOverOccupied" FooterAggregateFormatString="{0}" Aggregate="Sum" GroupByExpression="IsOverOccupied [GridColumn_IsOverOccupied] Group By IsOverOccupied" UniqueName="IsOverOccupied" CurrentFilterFunction="EqualTo" DataField="IsOverOccupied" DataType="System.Int64" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <%#Container.DataItem("IsOverOccupied")%>
                            </ItemTemplate>
                            <HeaderStyle Width="120px" />
                            <ItemStyle Wrap="false " BackColor="#fefc75" HorizontalAlign="Right" BorderColor="#eec126" />
                            <FooterStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Vacant" Aggregate="Sum" HeaderStyle-Width="55px" ItemStyle-Wrap="false"
                            SortExpression="Vacant" GroupByExpression="Vacant [GridColumn_Vacant] Group By Vacant"
                            UniqueName="Vacant" CurrentFilterFunction="EqualTo" DataField="Vacant"
                            DataType="System.Int32" FooterAggregateFormatString="{0}" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("Vacant"))=Cbool(1),"checked.png" , "unchecked.png"))%>"
                                    alt="" />

                            </ItemTemplate>
                            <HeaderStyle Width="120px" />
                            <ItemStyle Wrap="false " BackColor="#fefc75" HorizontalAlign="Right" BorderColor="#eec126" />
                            <FooterStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Leased" Aggregate="Sum" HeaderStyle-Width="55px" ItemStyle-Wrap="false"
                            SortExpression="IsLeased" GroupByExpression="IsLeased [GridColumn_IsLeased] Group By IsLeased"
                            UniqueName="IsLeased" CurrentFilterFunction="EqualTo" DataField="IsLeased"
                            DataType="System.Int32" FooterAggregateFormatString="{0}" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("IsLeased"))=Cbool(1),"checked.png" , "unchecked.png"))%>"
                                    alt="" />

                            </ItemTemplate>
                            <HeaderStyle Width="120px" />
                            <ItemStyle Wrap="false " BackColor="#fefc75" HorizontalAlign="Right" BorderColor="#eec126" />
                            <FooterStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn SortExpression="Equipments" GroupByExpression="Equipments [GridColumn_Equipments] Group By Equipments"
                            HeaderText="Equipment" Aggregate="Sum" FooterAggregateFormatString="{0}" UniqueName="Equipments" CurrentFilterFunction="EqualTo" DataField="Equipments" DataType="System.Int64" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <%#Container.DataItem("Equipments")%>
                            </ItemTemplate>
                            <HeaderStyle Width="80px" />
                            <ItemStyle Wrap="false " BackColor="#fefc75" HorizontalAlign="Right" BorderColor="#eec126" />
                            <FooterStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn SortExpression="Area" GroupByExpression="Area [GridColumn_Area] Group By Area"
                            HeaderText="Area" Aggregate="Sum" FooterAggregateFormatString="{0:N}" UniqueName="Area" CurrentFilterFunction="EqualTo" DataField="Area" DataType="System.Decimal" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <%#formatNumber(Container.DataItem("Area"))%> &nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="80px" />
                            <ItemStyle Wrap="false " BackColor="#fefc75" HorizontalAlign="Right" BorderColor="#eec126" />
                            <FooterStyle HorizontalAlign="Right" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridBoundColumn Aggregate="SUM" DataField="Area" Visible="False" />
                    </Columns>
                    <FooterStyle CssClass="GridFooter" />

                    <EditFormSettings>
                        <EditColumn CancelImageUrl="Cancel.gif" EditImageUrl="Edit.gif" InsertImageUrl="Update.gif"
                            UpdateImageUrl="Update.gif">
                        </EditColumn>
                    </EditFormSettings>
                    <CommandItemTemplate>

                        <table>
                            <tr>
                                <td>
                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                        SecurityButtonType="ItemMode">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton></td>

                                <td>
                                    <asp:LinkButton ID="btnSaveState" runat="server" SecurityButtonType="ItemMode" CausesValidation="False"
                                        CommandName="SaveState">
                                        <asp:Label ID="Label1" runat="server"></asp:Label>
                                    </asp:LinkButton></td>
                                <td>
                                    <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode"
                                        CausesValidation="False" CommandName="LoadDefaultState">
                                        &nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label ID="Label2" runat="server"></asp:Label>
                                    </asp:LinkButton></td>
                            </tr>
                        </table>
                    </CommandItemTemplate>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ValidationSettings ValidationGroup="ObjectImport" EnableValidation="true" CommandsToValidate="SaveChanges" />
                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" AllowDragToGroup="true">
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />

                </ClientSettings>
            </telerik:RadGrid>
                    </div>
                </div>
            </div>
            
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvOccupants" runat="server">
               <div class="PMMainPage">
                <div class="row">
                    <div class="col-12">
                        <telerik:RadGrid ID="rdgOccupants" AllowFilteringByColumn="true" runat="server" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                SetWidth="true" AppendMenus="true" PageSize="250" AllowPaging="true" ShowGroupPanel="true" AllowSorting="true" AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" GridLines="None">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                <ClientSettings EnableRowHoverStyle="True">
                    <Selecting EnableDragToSelectRows="False" />
                </ClientSettings>
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    CommandItemDisplay="Top" EnableHeaderContextMenu="true" DataKeyNames="Id" EditMode="InPlace" InsertItemPageIndexAction="ShowItemOnFirstPage">
                    <Columns>
                        <telerik:GridTemplateColumn SortExpression="OccupantName" HeaderText="Occupant" GroupByExpression="OccupantName [GridColumn_OccupantName] Group By OccupantName"
                            UniqueName="OccupantName" CurrentFilterFunction="Contains" DataField="OccupantName" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>

                                <asp:HyperLink ID="hliOccupant" runat="server" CssClass="NoWrap Link"
                                    Text='<%#IIf(Container.DataItem("OccupantName") = String.Empty, "&nbsp;", Container.DataItem("OccupantName"))%>'
                                    NavigateUrl='<%# CStr(Container.DataItem("OccupantUrl"))%>'></asp:HyperLink>&nbsp;
      
                            </ItemTemplate>
                            <HeaderStyle Width="160px" />
                            <ItemStyle Wrap="false " />

                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn SortExpression="OccupentType" GroupByExpression="OccupentType [GridColumn_OccupentType] Group By OccupentType" HeaderText="Occupant Type"
                            UniqueName="OccupentType" CurrentFilterFunction="Contains" DataField="OccupentType" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%#Container.DataItem("OccupentType")%>' CssClass="NoWrap" ID="lblOccupentType"></asp:Label>&nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="115px" />
                            <ItemStyle Wrap="false " />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Move In" CurrentFilterFunction="EqualTo" DataField="ActualMoveIn" DataType="System.DateTime" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" SortExpression="ActualMoveIn" UniqueName="ActualMoveIn" GroupByExpression="ActualMoveIn [GridColumn_ActualMoveIn] Group By ActualMoveIn">
                            <ItemTemplate>
                                <span>
                                    <%#FormatDate(Container.DataItem("ActualMoveIn"))%>&nbsp;</span>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                            <HeaderStyle Width="115px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <%--<telerik:GridTemplateColumn HeaderText="Move Out" SortExpression="ActualMoveOut" UniqueName="ActualMoveOut" GroupByExpression="ActualMoveOut [GridColumn_ActualMoveOut] Group By ActualMoveOut">
                                                <ItemTemplate>
                                                    <span>
                                                        <%#FormatDate(Container.DataItem("ActualMoveOut"))%>&nbsp;</span>
                                                </ItemTemplate>
                  
                                                <HeaderStyle Width="70px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>--%>

                        <telerik:GridTemplateColumn SortExpression="Title" GroupByExpression="Title [GridColumn_Title] Group By Title" HeaderText="Title"
                            UniqueName="Title" CurrentFilterFunction="Contains" DataField="Title" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%#Container.DataItem("Title")%>' CssClass="NoWrap" ID="lblTitle"></asp:Label>
                                &nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="115px" />
                            <ItemStyle Wrap="false " />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn SortExpression="Department" GroupByExpression="Department [GridColumn_Department] Group By Department" HeaderText="Department"
                            UniqueName="Department" CurrentFilterFunction="Contains" DataField="Department" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%#Container.DataItem("Department")%>' CssClass="NoWrap" ID="lblDepartment"></asp:Label>
                                &nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="115px" />
                            <ItemStyle Wrap="false " />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn SortExpression="Phone" GroupByExpression="Phone [GridColumn_Phone] Group By Phone" HeaderText="Phone"
                            UniqueName="Phone" CurrentFilterFunction="Contains" DataField="Phone" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%#Container.DataItem("Phone")%>' CssClass="NoWrap" ID="lblPhone"></asp:Label>
                                &nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="115px" />
                            <ItemStyle Wrap="false " />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn SortExpression="Email" GroupByExpression="Email [GridColumn_Email] Group By Email" HeaderText="Email"
                            UniqueName="Email" CurrentFilterFunction="Contains" DataField="Email" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%#Container.DataItem("Email")%>' CssClass="NoWrap" ID="lblEmail"></asp:Label>
                                &nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="115px" />
                            <ItemStyle Wrap="false " />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn SortExpression="Space" HeaderText="Space" GroupByExpression="Space [GridColumn_Space] Group By Space"
                            UniqueName="Space" CurrentFilterFunction="Contains" DataField="Space" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>

                                <asp:HyperLink ID="hliSpace" runat="server" CssClass="NoWrap Link"
                                    Text='<%#IIf(Container.DataItem("Space") = String.Empty, "&nbsp;", Container.DataItem("Space"))%>'
                                    NavigateUrl='<%# CStr(Container.DataItem("SpaceUrl"))%>'></asp:HyperLink>&nbsp;
      
                            </ItemTemplate>
                            <HeaderStyle Width="160px" />
                            <ItemStyle Wrap="false " />

                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn SortExpression="SpaceType" GroupByExpression="SpaceType [GridColumn_SpaceType] Group By SpaceType" HeaderText="Space Type"
                            UniqueName="SpaceType" CurrentFilterFunction="Contains" DataField="SpaceType" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%#Container.DataItem("SpaceType")%>' CssClass="NoWrap" ID="lblSpaceType"></asp:Label>&nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="115px" />
                            <ItemStyle Wrap="false " />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn SortExpression="Floors" HeaderText="Floor" GroupByExpression="Floors [GridColumn_Floors] Group By Floors"
                            UniqueName="Floors" CurrentFilterFunction="Contains" DataField="Floors" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>

                                <asp:HyperLink ID="hliFloors" runat="server" CssClass="NoWrap Link"
                                    Text='<%#IIf(Container.DataItem("Floors") = String.Empty, "&nbsp;", Container.DataItem("Floors"))%>'
                                    NavigateUrl='<%# CStr(Container.DataItem("FloorUrl"))%>'></asp:HyperLink>&nbsp;
      
                            </ItemTemplate>
                            <HeaderStyle Width="160px" />
                            <ItemStyle Wrap="false " />

                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn SortExpression="Building" HeaderText="Building" GroupByExpression="Building [GridColumn_Building] Group By Building"
                            UniqueName="Building" CurrentFilterFunction="Contains" DataField="Building" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:HyperLink ID="hliBuilding" runat="server" CssClass="NoWrap Link"
                                    Text='<%#IIf(Container.DataItem("Building") = String.Empty, "&nbsp;", Container.DataItem("Building"))%>'
                                    NavigateUrl='<%# CStr(Container.DataItem("BuildingUrl"))%>'></asp:HyperLink>&nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="160px" />
                            <ItemStyle Wrap="false " />

                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn SortExpression="Location" HeaderText="Location" GroupByExpression="Location [GridColumn_Location] Group By Location"
                            UniqueName="Location" CurrentFilterFunction="Contains" DataField="Location" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:HyperLink ID="hliLocation" runat="server" CssClass="NoWrap Link"
                                    Text='<%#IIf(Container.DataItem("Location") = String.Empty, "&nbsp;", Container.DataItem("Location"))%>'
                                    NavigateUrl='<%# CStr(Container.DataItem("LocationUrl"))%>'></asp:HyperLink>&nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="160px" />
                            <ItemStyle Wrap="false " />

                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn SortExpression="LocationType" GroupByExpression="LocationType [GridColumn_LocationType] Group By LocationType" HeaderText="Location Type"
                            UniqueName="LocationType" CurrentFilterFunction="Contains" DataField="LocationType" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <asp:Label runat="server" Text='<%#Container.DataItem("LocationType")%>' CssClass="NoWrap" ID="lblLocationType"></asp:Label>
                                &nbsp;
                            </ItemTemplate>
                            <HeaderStyle Width="115px" />
                            <ItemStyle Wrap="false " />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn SortExpression="Country" GroupByExpression="Country [GridColumn_Country] Group By Country" HeaderText="Country"
                            UniqueName="Country" CurrentFilterFunction="Contains" DataField="Country" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Country") = String.Empty, "&nbsp;", Container.DataItem("Country"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="115px" />
                            <ItemStyle Wrap="false" BackColor="White" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn SortExpression="State" GroupByExpression="State [GridColumn_State] Group By State" HeaderText="State"
                            UniqueName="State" CurrentFilterFunction="Contains" DataField="State" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("State") = String.Empty, "&nbsp;", Container.DataItem("State"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="110px" />
                            <ItemStyle Wrap="false " BackColor="White" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn SortExpression="City" GroupByExpression="City [GridColumn_City] Group By City" HeaderText="City"
                            UniqueName="City" CurrentFilterFunction="Contains" DataField="City" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("City") = String.Empty, "&nbsp;", Container.DataItem("City"))%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="110px" />
                            <ItemStyle Wrap="false " BackColor="White" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText=""
                            UniqueName="PlanView" Groupable="false" AllowFiltering="false" HeaderStyle-Width="30px">
                            <ItemTemplate>
                                <asp:LinkButton ID="imgPlanView" meta:resourcekey="imgPlanView" ToolTip="Plan View" runat="server" CssClass="PMwebViewerButton"
                                    Visible='<%# CBool(IIf(Eval("HasPlanView") Is System.DBNull.Value, 0, Eval("HasPlanView")))%>'>
                                                        <span class="Icon"></span>
                                </asp:LinkButton>&nbsp;
    
                            </ItemTemplate>
                            <HeaderStyle Width="30px" />
                            <ItemStyle Wrap="false" HorizontalAlign="Center" BackColor="White" />

                        </telerik:GridTemplateColumn>



                    </Columns>
                    <EditFormSettings>
                        <EditColumn CancelImageUrl="Cancel.gif" EditImageUrl="Edit.gif" InsertImageUrl="Update.gif"
                            UpdateImageUrl="Update.gif">
                        </EditColumn>
                    </EditFormSettings>
                    <CommandItemTemplate>
                        <div style="padding: 2px; height: 20px;">
                            <table>
                                <tr>
                                    <td>
                                        <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                            SecurityButtonType="ItemMode">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton></td>

                                    <td>
                                        <asp:LinkButton ID="btnSaveState" runat="server" SecurityButtonType="ItemMode" CausesValidation="False"
                                            CommandName="SaveState">
                                            <asp:Label ID="Label1" runat="server"></asp:Label>
                                        </asp:LinkButton></td>
                                    <td>
                                        <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode"
                                            CausesValidation="False" CommandName="LoadDefaultState">
                                            &nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label ID="Label2" runat="server"></asp:Label>
                                        </asp:LinkButton></td>
                                </tr>
                            </table>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                <ValidationSettings ValidationGroup="ObjectImport" EnableValidation="true" CommandsToValidate="SaveChanges" />
                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" AllowDragToGroup="true">
                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                        AllowColumnResize="True" />

                </ClientSettings>
            </telerik:RadGrid>
                    </div>
                </div>
            </div>
            
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvEquipments" runat="server">
        <asp:Panel ID="pnlAdvancedSearch" runat="server">
            <div class="PMMainPage JustifyContent Margin-Top">
                    <div class="row" style="padding-top:24px;">
                        <div class="col-4 col-4-left">
                            <asp:Panel runat="server" ID="pnlLocation" Visible="true">
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblLocationType" runat="server" Text="Location Types" meta:resourcekey="lblLocationType"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlPropertyType" runat="server" Filter="Contains"
                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                                meta:resourcekey="ddlPropertyType" NoWrap="true"
                                                CausesValidation="False" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblLocation" runat="server" Visible="true" Text="Locations" meta:resourcekey="lblLocation"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlLocations" Visible="true" runat="server" AutoPostBack="False"
                                                Skin="Default" NoWrap="true" Height="300px"
                                                EnableLoadOnDemand="true" ShowMoreResultsBox="True" OnItemsRequested="ddl_ItemsRequested"
                                                EnableVirtualScrolling="True">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <asp:Panel runat="server" ID="pnlBuildings" Visible="true">
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblBuilding" runat="server" Text="Buildings" meta:resourcekey="lblBuilding"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlBuildings" runat="server" AutoPostBack="False"
                                                Skin="Default" NoWrap="true" Height="300px"
                                                EnableLoadOnDemand="true" ShowMoreResultsBox="True" OnItemsRequested="ddl_ItemsRequested"
                                                EnableVirtualScrolling="True">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>
                        <div class="col-4 col-4-middle">
                            <asp:Panel runat="server" ID="pnlFloors" Visible="true">
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblFloors" runat="server" Text="Floors" meta:resourcekey="lblFloors"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlFloors" runat="server" AutoPostBack="False"
                                                Skin="Default"
                                                NoWrap="true" Height="300px"
                                                EnableLoadOnDemand="true" ShowMoreResultsBox="True" OnItemsRequested="ddl_ItemsRequested"
                                                EnableVirtualScrolling="True">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <asp:Panel runat="server" ID="pnlSpaces" Visible="true">
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblSpaceTypes" runat="server" Text="Space Types" meta:resourcekey="lblSpaceTypes"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlSpaceTypes" runat="server" Filter="Contains"
                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                                meta:resourcekey="ddlPropertyType" NoWrap="true"
                                                CausesValidation="False" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblSpaces" runat="server" Visible="true" Text="Spaces" meta:resourcekey="lblSpaces"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlSpaces" Visible="true" runat="server" AutoPostBack="False"
                                                Skin="Default"
                                                NoWrap="true" Height="300px"
                                                EnableLoadOnDemand="true" ShowMoreResultsBox="True" OnItemsRequested="ddl_ItemsRequested"
                                                EnableVirtualScrolling="True">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr id="trSpace1" runat="server" visible="false">
                                        <td>
                                            <asp:Label ID="lblSubTypes" runat="server" meta:resourcekey="lblSubTypes" Text="Sub Type"></asp:Label>
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="ddlSubTypes" runat="server" CausesValidation="False"
                                                CloseDropDownOnBlur="true" Filter="Contains"
                                                LoadingMessage="<%$ Resources:PMWeb, Loading %>" MarkFirstMatch="true"
                                                meta:resourcekey="ddlSubTypes" NoWrap="true" Skin="Default">
                                                <CollapseAnimation Duration="150" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                        <td style="padding-left: 10px">
                                            <asp:Label ID="lblVacant" runat="server" meta:resourcekey="lblVacant"
                                                Text="Vacant"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="chkVacant" runat="server" Checked="true" />
                                        </td>
                                    </tr>
                                    <tr id="trSpace2" runat="server" visible="false">
                                        <td>
                                            <asp:Label ID="lblAvailable" runat="server" meta:resourcekey="lblAvailable"
                                                Text="Available"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlOperationAvailable" runat="server">
                                                <asp:ListItem Text="Greater than or equal" Value="GreaterThanOrEqual"></asp:ListItem>
                                                <asp:ListItem Text="Less than or equal" Value="LessThanOrEqual"></asp:ListItem>
                                                <asp:ListItem Text="Equal" Value="Equal"></asp:ListItem>
                                            </asp:DropDownList>&nbsp;&nbsp;<asp:TextBox ID="txtAvailable" runat="server" CssClass="PositiveInteger" Width="55px"></asp:TextBox>
                                        </td>
                                        <td style="padding-left: 10px">
                                            <asp:Label ID="lblCapacity" runat="server" meta:resourcekey="lblCapacity"
                                                Text="Capacity"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlOperationCapacity" runat="server">
                                                <asp:ListItem Text="Greater than or equal" Value="GreaterThanOrEqual"></asp:ListItem>
                                                <asp:ListItem Text="Less than or equal" Value="LessThanOrEqual"></asp:ListItem>
                                                <asp:ListItem Text="Equal" Value="Equal"></asp:ListItem>
                                            </asp:DropDownList>&nbsp;&nbsp;<asp:TextBox ID="txtCapacity" runat="server" CssClass="PositiveInteger" Width="55px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr id="trSpace3" runat="server" visible="false">
                                        <td>
                                            <asp:Label ID="lblArea" runat="server" meta:resourcekey="lblArea"
                                                Text="Area"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlOperationArea" runat="server">
                                                <asp:ListItem Text="Greater than or equal" Value="GreaterThanOrEqual"></asp:ListItem>
                                                <asp:ListItem Text="Less than or equal" Value="LessThanOrEqual"></asp:ListItem>
                                                <asp:ListItem Text="Equal" Value="Equal"></asp:ListItem>
                                            </asp:DropDownList>&nbsp;&nbsp;<asp:TextBox ID="txtArea" runat="server" CssClass="PositiveDouble" Width="55px"></asp:TextBox>
                                        </td>
                                        <td style="padding-left: 10px">&nbsp;</td>
                                        <td></td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>
                        <div class="col-4 col-4-right">
                            <asp:Panel runat="server" ID="pnlEquipments" Visible="true">
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblEquipmentTypes" runat="server" Text="Equipment Types" meta:resourcekey="lblEquipmentTypes"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlEquipmentTypes" runat="server" Filter="Contains"
                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                                meta:resourcekey="ddlPropertyType" NoWrap="true"
                                                CausesValidation="False" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <asp:Panel runat="server" ID="pnlOccupants" Visible="false">
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblOccupantTypes" runat="server" Text="Occupant Types" meta:resourcekey="lblOccupantTypes"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlOccupantTypes" runat="server" Filter="Contains"
                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true"
                                                meta:resourcekey="ddlPropertyType" NoWrap="true"
                                                CausesValidation="False" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <asp:Panel runat="server" ID="Panel1">
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblName" meta:resourcekey="lblName" runat="server" Text="Equipment"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtName" MaxLength="50" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </div>
                    </div>                  
                             <asp:Button runat="server" CssClass="lnkButton" Style="height: 32px; width: 169px;" ID="btnSearch" Text="Search" meta:resourcekey="btnSearch" />                   
            </div>
        </asp:Panel>
            <div class="PMMainPage JustifyContent">
                <div class="PMHeader">
                    <div class="row">
                        <div class="col-12">
                                <telerik:RadGrid ID="rdgEquipments" AllowFilteringByColumn="true" runat="server" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" ClientSettings-Scrolling-AllowScroll="true"
                                            SetWidth="true" Width="100%" AppendMenus="true" PageSize="250" AllowPaging="true" ShowGroupPanel="true" AllowSorting="true" AutoGenerateColumns="False" ShowStatusBar="True" GridLines="None">
                                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                            <ClientSettings EnableRowHoverStyle="True">
                                                <Selecting EnableDragToSelectRows="False" />
                                            </ClientSettings>
                                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                CommandItemDisplay="None" DataKeyNames="Id" EditMode="InPlace" InsertItemPageIndexAction="ShowItemOnFirstPage">
                                                <Columns>
                                                    <telerik:GridTemplateColumn SortExpression="Equipment" HeaderText="Equipment" GroupByExpression="Equipment [GridColumn_Equipment] Group By Equipment"
                                                        UniqueName="Equipment" CurrentFilterFunction="Contains" DataField="Equipment" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                        <ItemTemplate>

                                                            <asp:HyperLink ID="hliEquipment" runat="server" CssClass="NoWrap Link"
                                                                Text='<%#IIf(Container.DataItem("Equipment") = String.Empty, "&nbsp;", Container.DataItem("Equipment"))%>'
                                                                NavigateUrl='<%# CStr(Container.DataItem("EquipmentUrl"))%>'></asp:HyperLink>&nbsp;
      
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="210px" />
                                                        <ItemStyle Wrap="false " />

                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn SortExpression="EquipmentType" GroupByExpression="EquipmentType [GridColumn_EquipmentType] Group By EquipmentType" HeaderText="Equipment Type"
                                                        UniqueName="EquipmentType" CurrentFilterFunction="Contains" DataField="EquipmentType" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" Text='<%#Container.DataItem("EquipmentType")%>' CssClass="NoWrap" ID="lblEquipmentType"></asp:Label>&nbsp;
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="160px" />
                                                        <ItemStyle Wrap="false " />
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn SortExpression="Location" HeaderText="Location" GroupByExpression="Location [GridColumn_Location] Group By Location"
                                                        UniqueName="Location" CurrentFilterFunction="Contains" DataField="Location" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                        <ItemTemplate>
                                                            <asp:HyperLink ID="hliLocation" runat="server" CssClass="NoWrap Link"
                                                                Text='<%#IIf(Container.DataItem("Location") = String.Empty, "&nbsp;", Container.DataItem("Location"))%>'
                                                                NavigateUrl='<%# CStr(Container.DataItem("LocationUrl"))%>'></asp:HyperLink>&nbsp;
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="210px" />
                                                        <ItemStyle Wrap="false " />

                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn SortExpression="LocationType" GroupByExpression="LocationType [GridColumn_LocationType] Group By LocationType" HeaderText="Location Type"
                                                        UniqueName="LocationType" CurrentFilterFunction="Contains" DataField="LocationType" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" Text='<%#Container.DataItem("LocationType")%>' CssClass="NoWrap" ID="lblLocationType"></asp:Label>&nbsp;
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="160px" />
                                                        <ItemStyle Wrap="false " />
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn SortExpression="Building" HeaderText="Building" GroupByExpression="Building [GridColumn_Building] Group By Building"
                                                        UniqueName="Building" CurrentFilterFunction="Contains" DataField="Building" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                        <ItemTemplate>
                                                            <asp:HyperLink ID="hliBuilding" runat="server" CssClass="NoWrap Link"
                                                                Text='<%#IIf(Container.DataItem("Building") = String.Empty, "&nbsp;", Container.DataItem("Building"))%>'
                                                                NavigateUrl='<%# CStr(Container.DataItem("BuildingUrl"))%>'></asp:HyperLink>&nbsp;
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="210px" />
                                                        <ItemStyle Wrap="false " />

                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn SortExpression="Floors" HeaderText="Floor" GroupByExpression="Floors [GridColumn_Floors] Group By Floors"
                                                        UniqueName="Floors" CurrentFilterFunction="Contains" DataField="Floors" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                        <ItemTemplate>

                                                            <asp:HyperLink ID="hliFloors" runat="server" CssClass="NoWrap Link"
                                                                Text='<%#IIf(Container.DataItem("Floors") = String.Empty, "&nbsp;", Container.DataItem("Floors"))%>'
                                                                NavigateUrl='<%# CStr(Container.DataItem("FloorUrl"))%>'></asp:HyperLink>&nbsp;
      
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="210px" />
                                                        <ItemStyle Wrap="false " />

                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn SortExpression="Space" HeaderText="Space" GroupByExpression="Space [GridColumn_Space] Group By Space"
                                                        UniqueName="Space" CurrentFilterFunction="Contains" DataField="Space" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                        <ItemTemplate>

                                                            <asp:HyperLink ID="hliSpace" runat="server" CssClass="NoWrap Link"
                                                                Text='<%#IIf(Container.DataItem("Space") = String.Empty, "&nbsp;", Container.DataItem("Space"))%>'
                                                                NavigateUrl='<%# CStr(Container.DataItem("SpaceUrl"))%>'></asp:HyperLink>&nbsp;
      
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="210px" />
                                                        <ItemStyle Wrap="false " />

                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn SortExpression="SpaceType" GroupByExpression="SpaceType [GridColumn_SpaceType] Group By SpaceType" HeaderText="Space Type"
                                                        UniqueName="SpaceType" CurrentFilterFunction="Contains" DataField="SpaceType" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" Text='<%#Container.DataItem("SpaceType")%>' CssClass="NoWrap" ID="lblSpaceType"></asp:Label>&nbsp;
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="160px" />
                                                        <ItemStyle Wrap="false " />
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn HeaderText=""
                                                        UniqueName="HasPlanView" AllowFiltering="false" Groupable="false">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="imgPlanView" meta:resourcekey="imgPlanView" ToolTip="Plan View" runat="server" CssClass="PMwebViewerButton"
                                                                Visible='<%# Cbool(IIF(Eval("HasPlanView") is system.DBNULL.value, 0,Eval("HasPlanView")))%>'>
                                                                                <span class="Icon"></span>
                                                            </asp:LinkButton>&nbsp; 
    
                                                        </ItemTemplate>
                                                        <HeaderStyle Width="30px" />
                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                    </telerik:GridTemplateColumn>
                                                </Columns>
                                                <EditFormSettings>
                                                    <EditColumn CancelImageUrl="Cancel.gif" EditImageUrl="Edit.gif" InsertImageUrl="Update.gif"
                                                        UpdateImageUrl="Update.gif">
                                                    </EditColumn>
                                                </EditFormSettings>
                                                <CommandItemTemplate>
                                                </CommandItemTemplate>
                                            </MasterTableView>
                                            <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                            <ValidationSettings ValidationGroup="ObjectImport" EnableValidation="true" CommandsToValidate="SaveChanges" />
                                            <ClientSettings AllowColumnHide="true" AllowColumnsReorder="false" AllowDragToGroup="true">
                                                <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                                    AllowColumnResize="True" />
                                            </ClientSettings>
                                        </telerik:RadGrid>
                        </div>
                    </div>
                </div>
            </div>
        </telerik:RadPageView>
    </telerik:RadMultiPage>
</asp:Content>
