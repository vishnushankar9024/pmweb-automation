<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PropertiesMapView.aspx.vb" Inherits="Website.PropertiesMapView" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />--%>
    <style type="text/css">
        /*.body {
            background-image: none !important;
        }*/
        table {
            font-size: 12px;
            color: #666666;
        }
        .RightAlign input{
            text-align:right;
        }
        .canvas{height:calc(100vh - 26px) !important}
        .map-view-rdsplitter .rspSlideTitle {
            visibility: hidden;
        }

        .map-view-rdsplitter .rspPaneTabText {
            display: none !important;
        }

        .map-view-rdsplitter .rspPaneTabContainer {
            width: 5px !important;
            background-image: url(CSS/Images/Splitter/ExpandCollapseBarsCommands.gif) !important;
            background-repeat: no-repeat;
            background-position: 1px 0 !important;
            position: absolute;
            top: 350px;
            background-color: #EDEDED !important;
            height: 30px !important;
            border: none !important;
        }

        .map-view-rdsplitter .RadSplitter_Default .rspSlideContainerResize {
            background-color: #EDEDED;
            border-right-color: #8a8a8a;
        }

        .map-view-rdsplitter .rspSlideTitleContainer {
            background: #EDEDED !important;
        }

        div#RAD_SPLITTER_PANE_CONTENT_LeftPane {
            background-color: #EDEDED;}
        
        .map-view-rdsplitter .rspSlideHeaderIconWrapper {
            background-color: #EDEDED;
        }


        .rspPaneTabContainer {
            width: 10px !important;
            background-image: url(../CSS/Images/Splitter/ExpandCollapseBarsCommands.gif) !important;
            background-repeat: no-repeat;
            background-position: 0 0 !important;
            position: absolute;
            top: 250px;
            background-color: #EDEDED;
            height: 30px !important;
            border: none;
        }

        .map-view-UnDockrdLeftPane {
            width: 6px !important;
                max-width: 6px;
        }

        .map-view-rdsplitter .rspPaneTabContainer.rspPaneTabContainerDocked {
            visibility: hidden;
        }

        .map-view-rdsplitter .RadSplitter_Default .rspSlideHeaderDockIcon, .map-view-rdsplitter .RadSplitter_Default .rspSlideHeaderUndockIcon, .map-view-rdsplitter .RadSplitter_Default .rspSlideHeaderCollapseIcon {
            background-color: #EDEDED !important;
        }
         
        @media screen and (min-width:320px) and (max-width:843px) {
            .PMHeader {
                padding-top: 0;
                /*margin-top: 41px !important;*/
            }
            div#RAD_SPLITTER_PANE_CONTENT_LeftPane {
                background-color: #EDEDED;
                max-width: 95vw;
            }

            div#RadSlidingPane1 {
                max-width: 95vw;
                overflow: auto !important;
            }

            .map-view-rdsplitter .RadSplitter_Default .rspSlideHeaderDockIcon {
                display: none;
           }

        }

    </style>
    <script type="text/javascript" src="JS/encoder.js"></script>
    <script type="text/javascript">
        var objMap;
        var wait;
        var undocked = false;
        var arrMarkers = [];
        function LoadDoc() {
            var docked = $find('RadSlidingPane1').get_docked()
            var TabPane1 = document.getElementById('RAD_SPLITTER_PANE_CONTENT_LeftPane');
            if (!docked) {
                TabPane1.className = 'map-view-UnDockrdLeftPane';
            }
            else {
                TabPane1.className = ''
            }
        }
        function UpdateGridSettings(sender, args) {
            UpdatePanelSettings(sender)
            ResetGridSettings($("[id$=rdgLocations]")[0].id)
        }
        function initializeMap() {
            var latlng = new google.maps.LatLng(49.496675, -102.65625);
            var myOptions = {
                zoom: ZoomLevel,
                Center: latlng,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            objMap = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
            wait = false;

            var geocoder = new google.maps.Geocoder();
            geocoder.geocode({ 'address': MapCenter }, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    objMap.setCenter(results[0].geometry.location, ZoomLevel);
                }
            });
        }
        var PointsArray = [];

        function showAddresse() {
            ClearMarkers();
            wait = false;
            for (i = 0; i <= ProjectAddresses.length - 1; i++) {
                var objProjectAddress = ProjectAddresses[i];
                if (objProjectAddress.Checked == false) DisplayAddress(i);
            }
        }

        function ClearMarkers() {
            for (var i = 0; i < arrMarkers.length; i++) {
                arrMarkers[i].setMap(null);
            }
            arrMarkers = [];
        }

        function DisplayAddress(AddresseIndx) {
            var ProjIcon;
            var objProjectAddress = ProjectAddresses[i];
            ProjIcon = 'Images/Asset/Excavator_red.png';
            if (objProjectAddress.IsProjectUnderBudget == 'True') { ProjIcon = 'Images/Asset/Excavator_green.png'; }
            if ((isNaN(parseFloat(objProjectAddress.Latitude))) == false || (isNaN(parseFloat(objProjectAddress.Longitude))) == false) {
                var myLatlng = new google.maps.LatLng(objProjectAddress.Latitude, objProjectAddress.Longitude);
                var objCurrMarker = new google.maps.Marker({ position: myLatlng, map: objMap, draggable: false, icon: ProjIcon });
                arrMarkers.push(objCurrMarker);
                var infowindow = new google.maps.InfoWindow({
                    content: Encoder.htmlDecode(objProjectAddress.GoogleSummary)
                });
                google.maps.event.addListener(objCurrMarker, 'click', function () { infowindow.open(objMap, objCurrMarker); });
            }
        }

        function OnClientUndocked(sender, eventArgs) {
            undocked = true;
            var TabPane1 = document.getElementById('RAD_SPLITTER_PANE_CONTENT_RadPane1');
            TabPane1.style.width = TabPane1.style.width.replace('px', '') - 10 + 'px';
            UpdatePanelSettings(sender);
        }

        function OnClientBeforeUndock(sender, eventArgs) {
            var TabPane1 = document.getElementById('RAD_SPLITTER_PANE_CONTENT_LeftPane');
            TabPane1.className = 'map-view-UnDockrdLeftPane';
        }
        function OnClientBeforeDock(sender, eventArgs) {
            var TabPane1 = document.getElementById('RAD_SPLITTER_PANE_CONTENT_LeftPane');
            TabPane1.className = '';

        }

        function test(sender) {
            if (undocked == true) {
                var TabPane1 = document.getElementById('RAD_SPLITTER_PANE_CONTENT_RadPane1');
                TabPane1.style.width = TabPane1.style.width.replace('px', '') - 10 + 'px';
            }
            UpdatePanelSettings(sender);
        }

        function UpdatePanelSettings(sender) {
            $.ajax({
                type: "POST",
                url: "AjaxService.aspx/UpdatePropertiesMapViewPanelSettings",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ isPinned: sender.get_docked(), Width: sender.get_width() }),
                dataType: "json",
                async: true
            });
            if (!sender.get_docked()) {
                sender.set_dockOnOpen(false)
            }
            else {
                sender.set_dockOnOpen(true)
            }
            return false;
        }

    </script>

</head>
<body onload="LoadDoc();initializeMap();showAddresse();" style="padding: 0px; background-image: none !important">

    <form id="form1" runat="server">

        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpProjects" runat="server" Skin="Default" />
                <div class="PMHeader">
            <div class="row">
                <div class="col-12">
                    <telerik:RadSplitter ID="RadSplitter1" Width="100%" runat="server" CssClass="map-view-rdsplitter canvas" Height="100%" OnClientResized="test">
                        <telerik:RadPane ID="LeftPane" runat="server" Width="10px" Scrolling="none">
                            <telerik:RadSlidingZone ID="SlidingZone1" runat="server" ClickToOpen="true">
                                <telerik:RadSlidingPane ID="RadSlidingPane1" Width="500px" Title="Pane1" runat="server" OnClientBeforeUndock="OnClientBeforeUndock" OnClientBeforeDock="OnClientBeforeDock" OnClientUndocked="OnClientUndocked" OnClientExpanded="UpdateGridSettings" OnClientDocked="UpdateGridSettings" OnClientResized="UpdateGridSettings"
                                    MinWidth="100" ResizeText="" EnableResize="true" RenderMode="Lightweight" EnableDock="true">
                                   <telerik:RadGrid ID="rdgLocations" CssClass="rdgpropMapView" Visible="true" runat="server" Width="100%" ShowStatusBar="False" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                                                SetWidth="true" AppendMenus="true" PageSize="250" AllowFilteringByColumn="true" AllowPaging="true" ShowGroupPanel="true" AllowSorting="true" AutoGenerateColumns="False" Font-Size="8px">
                                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="false"></PagerStyle>
                                                <ClientSettings EnableRowHoverStyle="True">
                                                    <Selecting EnableDragToSelectRows="False" />
                                                </ClientSettings>
                                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" Width="100%"
                                                    CommandItemDisplay="Top" DataKeyNames="Id" EditMode="InPlace" InsertItemPageIndexAction="ShowItemOnFirstPage">
                                                    <Columns>


                                                        <telerik:GridTemplateColumn SortExpression="Name" HeaderText="Location" GroupByExpression="Name [GridColumn_Location] Group By Name"
                                                            UniqueName="Name" CurrentFilterFunction="Contains" DataField="Name" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                            <ItemTemplate>

                                                                <asp:HyperLink ID="hliLocation" Target="_parent" runat="server" CssClass="NoWrap Link"
                                                                    Text='<%#IIf(Container.DataItem("Name") = String.Empty, "&nbsp;", Container.DataItem("Name"))%>'
                                                                    NavigateUrl='<%# CStr(Container.DataItem("LocationUrl"))%>'></asp:HyperLink>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="180px" />
                                                            <ItemStyle Wrap="false" />
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn SortExpression="LocationType" GroupByExpression="LocationType [GridColumn_LocationType] Group By LocationType" HeaderText="Location Type"
                                                            UniqueName="LocationType" CurrentFilterFunction="Contains" DataField="LocationType" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                            <ItemTemplate>
                                                                <asp:Label runat="server" Text='<%#IIf(Container.DataItem("LocationType") = String.Empty, "&nbsp;", Container.DataItem("LocationType"))%>' CssClass="NoWrap" ID="lblLocationType"></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="128px" />
                                                            <ItemStyle Wrap="false" />
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn SortExpression="Country" GroupByExpression="Country [GridColumn_Country] Group By Country" HeaderText="Country"
                                                            UniqueName="Country" CurrentFilterFunction="Contains" DataField="Country" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("Country") = String.Empty, "&nbsp;", Container.DataItem("Country"))%></span>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="128px" />
                                                            <ItemStyle Wrap="false" />
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn SortExpression="State" GroupByExpression="State [GridColumn_State] Group By State" HeaderText="State"
                                                            UniqueName="State" CurrentFilterFunction="Contains" DataField="State" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("State") = String.Empty, "&nbsp;", Container.DataItem("State"))%></span>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="128px" />
                                                            <ItemStyle Wrap="false" />
                                                        </telerik:GridTemplateColumn>


                                                        <telerik:GridTemplateColumn SortExpression="City" GroupByExpression="City [GridColumn_City] Group By City" HeaderText="City"
                                                            UniqueName="City" CurrentFilterFunction="Contains" DataField="City" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("City") = String.Empty, "&nbsp;", Container.DataItem("City"))%></span>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="128px" />
                                                            <ItemStyle Wrap="false" />
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn SortExpression="PropertyManager" GroupByExpression="PropertyManager [GridColumn_PropertyManager] Group By PropertyManager" HeaderText="Manager"
                                                            UniqueName="PropertyManager" CurrentFilterFunction="Contains" DataField="PropertyManager" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("PropertyManager") = String.Empty, "&nbsp;", Container.DataItem("PropertyManager"))%></span>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="128px" />
                                                            <ItemStyle Wrap="false" />
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn SortExpression="OwnerContact" GroupByExpression="OwnerContact [GridColumn_OwnerContact] Group By OwnerContact" HeaderText="Owner"
                                                            UniqueName="OwnerContact" CurrentFilterFunction="Contains" DataField="OwnerContact" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("OwnerContact") = String.Empty, "&nbsp;", Container.DataItem("OwnerContact"))%></span>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="128px" />
                                                            <ItemStyle Wrap="false" />
                                                        </telerik:GridTemplateColumn>



                                                        <telerik:GridTemplateColumn SortExpression="Address1" GroupByExpression="Address1 [GridColumn_Address] Group By Address1" HeaderText="Address"
                                                            UniqueName="Address1" CurrentFilterFunction="Contains" DataField="Address1" DataType="System.String" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                            <ItemTemplate>
                                                                <span><%#IIf(Container.DataItem("Address1") = String.Empty, "&nbsp;", Container.DataItem("Address1"))%></span>
                                                            </ItemTemplate>
                                                            <HeaderStyle Width="128px" />
                                                            <ItemStyle Wrap="false" />
                                                        </telerik:GridTemplateColumn>

                                                    </Columns>
                                                    <CommandItemTemplate>
                                                        <table style="padding: 0px;" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td>
                                                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid">
                                                                         <span class="Icon"></span>
                                                                    </asp:LinkButton>
                                                                </td>

                                                                <td><b>&nbsp;&nbsp;<asp:Label ID="lblCenter" meta:resourcekey="lblCenter" runat="server" Text="Center"></asp:Label></b>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCenter" runat="server"></asp:TextBox></td>
                                                                <td>&nbsp;&nbsp;<b><asp:Label ID="lblZoomLevel" meta:resourcekey="lblZoomLevel" runat="server" Text="Zoom"></asp:Label></b>
                                                                </td>
                                                                <td>
                                                                    <telerik:RadComboBox ID="ddlZoomLevel" runat="server" Width="40px"
                                                                        Style="font-size: 11px" CssClass="RightAlign">
                                                                        <CollapseAnimation Duration="200" Type="OutQuint" />
                                                                        <Items>
                                                                            <telerik:RadComboBoxItem Text="1" Value="1" />
                                                                            <telerik:RadComboBoxItem Text="2" Value="2" />
                                                                            <telerik:RadComboBoxItem Text="3" Value="3" />
                                                                            <telerik:RadComboBoxItem Text="4" Value="4" />
                                                                            <telerik:RadComboBoxItem Text="5" Value="5" />
                                                                            <telerik:RadComboBoxItem Text="6" Value="6" />
                                                                            <telerik:RadComboBoxItem Text="7" Value="7" />
                                                                            <telerik:RadComboBoxItem Text="8" Value="8" />
                                                                            <telerik:RadComboBoxItem Text="9" Value="9" />
                                                                            <telerik:RadComboBoxItem Text="10" Value="10" />
                                                                            <telerik:RadComboBoxItem Text="11" Value="11" />
                                                                            <telerik:RadComboBoxItem Text="12" Value="12" />
                                                                            <telerik:RadComboBoxItem Text="13" Value="13" />
                                                                            <telerik:RadComboBoxItem Text="14" Value="14" />
                                                                            <telerik:RadComboBoxItem Text="15" Value="15" />
                                                                            <telerik:RadComboBoxItem Text="16" Value="16" />
                                                                            <telerik:RadComboBoxItem Text="17" Value="17" />
                                                                            <telerik:RadComboBoxItem Text="18" Value="18" />
                                                                            <telerik:RadComboBoxItem Text="19" Value="19" />
                                                                            <telerik:RadComboBoxItem Text="20" Value="20" />
                                                                        </Items>
                                                                    </telerik:RadComboBox>
                                                                </td>

                                                            </tr>
                                                        </table>
                                                    </CommandItemTemplate>
                                                </MasterTableView>
                                                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                                <ClientSettings AllowColumnHide="true" AllowColumnsReorder="false" AllowDragToGroup="true" ColumnsReorderMethod="Reorder">
                                                    <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                                        AllowColumnResize="True" />
                                                </ClientSettings>
                                            </telerik:RadGrid>
                                </telerik:RadSlidingPane>
                            </telerik:RadSlidingZone>
                        </telerik:RadPane>

                        <telerik:RadPane ID="RadPane1" runat="server" Width="100%" Scrolling="None">
                            <div id="map_canvas" style="width: 100%;height:400px;"></div>
                            </telerik:RadPane>
                    </telerik:RadSplitter>
                </div>
            </div>
        </div>`
    </form>
</body>
</html>
