<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ProjectsMapViewFrame.aspx.vb" Inherits="Website.ProjectsMapViewFrame" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<link href="CSS/PMainCss.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .body{ background-image:none important!;}
        .RadGrid_PM .rgPagerLabel{font-size:8pt !important;}
    </style>--%>
    <link href="CSS/ControlsCSS/Combobox.css" rel="stylesheet" />
    <link href="CSS/ControlsCSS/Editor.css" rel="stylesheet" />
    <link href="CSS/ControlsCSS/Grid.css" rel="stylesheet" />
    <link href="CSS/ControlsCSS/Splitter.css" rel="stylesheet" />
    <script type="text/javascript" src="JS/encoder.js"></script>

    <style type="text/css">
        table {
            font-size: 12px;
            color: #666666;
        }

        .canvas {
            height: calc(100vh - 12px) !important;
        }

        .RedrawMap {
            background: url(CSS/Images/ResponsiveIcons/Refresh.png) left 8px top 7px no-repeat;
            width: 120px !important;
            text-align: right !important;
            padding: 5px 8px 5px 8px !important;
            text-transform: uppercase !important;
        }

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
            background-color: #EDEDED;
        }
        /*max-width:90vw;
        }

                div#RadSlidingPane1 {
    max-width: 90vw;
    overflow: auto !important;
}*/

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
    <script type="text/javascript">
        var objMap;
        var wait;
        var objMarker = null;
        var undocked = false;
        function LoadDoc() {
            var docked = $find('RadSlidingPane1').get_docked()
            var TabPane1 = document.getElementById('RAD_SPLITTER_PANE_CONTENT_LeftPane');

            if (!docked) {
                TabPane1.className = 'map-view-UnDockrdLeftPane';
            }
            else {
                TabPane1.className = '';
            }
        }

        function UpdatePanelSettings(sender) {
            $.ajax({
                type: "POST",
                url: "AjaxService.aspx/UpdateMapViewPanelSettings",
                contentType: "application/json; charset=utf-8",
                data: "{'isPinned':'" + sender.get_docked() + "', 'Width':" + sender.get_width() + " }",
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

        function UpdateGridSettings(sender, args) {
            ResetGridSettings($("[id$=rdgProjects]")[0].id)
            UpdatePanelSettings(sender)
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
            wait = false;
            for (i = 0; i <= ProjectAddresses.length - 1; i++) {
                var objProjectAddress = ProjectAddresses[i];
                if (objProjectAddress.Checked == false) DisplayAddress(i);
            }
        }


        function DisplayAddress(AddressIndx) {
            var ProjIcon;
            var objProjectAddress = ProjectAddresses[i];
            ProjIcon = 'Images/Asset/Excavator_red.png';
            if (objProjectAddress.IsProjectUnderBudget == 'True') { ProjIcon = 'Images/Asset/Excavator_green.png'; }
            if ((isNaN(parseFloat(objProjectAddress.Latitude))) == false || (isNaN(parseFloat(objProjectAddress.Longitude))) == false) {
                var myLatlng = new google.maps.LatLng(objProjectAddress.Latitude, objProjectAddress.Longitude);
                var objcurrMarker = new google.maps.Marker({
                    position: myLatlng
                     , map: objMap
                     , draggable: false
                     , icon: { url: ProjIcon }
                });
                var objinfowindow = new google.maps.InfoWindow({
                    content: Encoder.htmlDecode(objProjectAddress.GoogleSummary)
                });
                google.maps.event.addListener(objcurrMarker, 'click', function () {
                    objinfowindow.open(objMap, objcurrMarker);
                });


            }
        }


        function OnClientBeforeDock(sender, eventArgs) {
            var TabPane1 = document.getElementById('RAD_SPLITTER_PANE_CONTENT_LeftPane');
            TabPane1.className = '';

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

        function test(sender) {
            if (undocked == true) {
                var TabPane1 = document.getElementById('RAD_SPLITTER_PANE_CONTENT_RadPane1');
                TabPane1.style.width = TabPane1.style.width.replace('px', '') - 10 + 'px';
            }
            UpdatePanelSettings(sender);
        }


    </script>
</head>

<body onload="LoadDoc();initializeMap();showAddresse();" style="padding: 0px; width: 100%">

    <form id="form1" runat="server" style="width: 100%">

        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:radajaxmanager id="PMAjaxManager" runat="server">
        </telerik:radajaxmanager>
        <telerik:radajaxloadingpanel id="ldpProjects" runat="server" skin="Default" />

        <div class="PMHeader">
            <div class="row">
                <div class="col-12">
                    <telerik:radsplitter id="RadSplitter1" width="100%" runat="server" cssclass="map-view-rdsplitter canvas" height="100%" onclientresized="test">
                        <telerik:RadPane ID="LeftPane" runat="server" Width="10px" Scrolling="none">
                            <telerik:RadSlidingZone ID="SlidingZone1" runat="server" ClickToOpen="true">
                                <telerik:RadSlidingPane ID="RadSlidingPane1" Width="500px" Title="Pane1" runat="server" OnClientBeforeUndock="OnClientBeforeUndock" OnClientBeforeDock="OnClientBeforeDock" OnClientUndocked="OnClientUndocked" OnClientExpanded="UpdateGridSettings" OnClientDocked="UpdateGridSettings" OnClientResized="UpdateGridSettings"
                                    MinWidth="100" ResizeText="" EnableResize="true" RenderMode="Lightweight" EnableDock="true">
                                    <telerik:RadGrid ID="rdgProjects" runat="server" Width="100%" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" AllowFilteringByColumn="true"
                                        Skin="Default" HeaderStyle-Font-Size="8" AutoGenerateColumns="False" ShowStatusBar="True" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" AppendMenus="true"
                                        AllowMultiRowEdit="True" AllowMultiRowSelection="True" GridLines="None" AllowPaging="True">
                                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                            DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage"
                                            EditMode="InPlace" PageSize="20" TableLayout="Fixed">
                                            <Columns>
                                                <telerik:GridTemplateColumn HeaderText="Project #" UniqueName="ProjectNumber" Visible="False">
                                                    <ItemTemplate>
                                                        <%#IIf(Container.DataItem("ProjectNumber") = String.Empty, "&nbsp;", Container.DataItem("ProjectNumber"))%>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="100px"></HeaderStyle>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Program" UniqueName="Program" DataType="System.String" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                                    GroupByExpression="Program [GridColumn_Program] Group By Program" DataField="Program">
                                                    <ItemTemplate>
                                                        <%#IIf(Container.DataItem("Program") = String.Empty, "&nbsp;", Container.DataItem("Program"))%>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="100px"></HeaderStyle>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Project Name" UniqueName="ProjectName" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataType="System.String"
                                                    GroupByExpression="ProjectName [GridColumn_ProjectName] Group By ProjectName" DataField="ProjectName">
                                                    <ItemTemplate>
                                                        <%#IIf(Container.DataItem("ProjectName") = String.Empty, "&nbsp;", Container.DataItem("ProjectName"))%>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="270px"></HeaderStyle>
                                                </telerik:GridTemplateColumn>


                                                <telerik:GridTemplateColumn HeaderText="Approved Budget" UniqueName="ApprovedBudget" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataType="System.Decimal"
                                                    GroupByExpression="ApprovedBudget [GridColumn_ApprovedBudget] Group By ApprovedBudget" DataField="TotalOriginalBudgetApproved">
                                                    <ItemTemplate>
                                                        <a target="_parent" href="CostWorkSheet.aspx?ProjectId=<%#Container.DataItem("Id").ToString%>"><span><%#FormatCurrency(Container.DataItem("TotalOriginalBudgetApproved"), CurrencyId:=Container.DataItem("CurrencyId"))%></span></a>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="100px"></HeaderStyle>
                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                </telerik:GridTemplateColumn>

                                      <%--          <telerik:GridTemplateColumn HeaderText="Schedule" UniqueName="Schedule" Visible="false"
                                                    GroupByExpression="Schedule [GridColumn_Schedule] Group By Schedule">
                                                    <ItemTemplate>
                                                        <a target="_parent" class='<%# IIf(Container.DataItem("Schedule").ToString = String.Empty, "Hide", "")%>' href='<%#Container.DataItem("ScheduleUrl").ToString%>'><span><%#Container.DataItem("Schedule").ToString%>&nbsp;</span></a>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="200px"></HeaderStyle>
                                                </telerik:GridTemplateColumn>--%>

                                                <telerik:GridTemplateColumn HeaderText="Date" SortExpression="ProjectStartDate" GroupByExpression="StartDate [GridColumn_ProjectStartDate] Group By ProjectStartDate"
                                                    UniqueName="ProjectStartDate" DataField="ProjectStartDate" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataType="System.String">
                                                    <ItemTemplate>
                                                        <span><%#FormatDate(Container.DataItem("ProjectStartDate")) %> &nbsp;</span>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                    <HeaderStyle Width="200px"></HeaderStyle>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Date" SortExpression="ProjectFinishDate" GroupByExpression="FinishDate [GridColumn_ProjectFinishDate] Group By ProjectFinishDate"
                                                    UniqueName="ProjectFinishDate" DataField="ProjectFinishDate"  CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataType="System.String">
                                                    <ItemTemplate>
                                                        <span><%#FormatDate(Container.DataItem("ProjectFinishDate")) %> &nbsp;</span>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                    <HeaderStyle Width="200px"></HeaderStyle>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Project Manager" UniqueName="ProjectManager"
                                                    GroupByExpression="ProjectManager [GridColumn_ProjectManager] Group By ProjectManager"  DataField="ProjectManager"  CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataType="System.String">
                                                    <ItemTemplate>
                                                        <%#IIf(Container.DataItem("ProjectManager") = String.Empty, "&nbsp;", Container.DataItem("ProjectManager"))%>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="150px"></HeaderStyle>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Location" UniqueName="Location" DataField="Location"  CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataType="System.String" 
                                                    GroupByExpression="Location [GridColumn_Location] Group By Location">
                                                    <ItemTemplate>
                                                        <%#IIf(Container.DataItem("Location") = String.Empty, "&nbsp;", Container.DataItem("Location"))%>
                                                    </ItemTemplate>
                                                    <HeaderStyle Width="120px"></HeaderStyle>
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                            <SortExpressions>
                                                <telerik:GridSortExpression FieldName="ProjectName"></telerik:GridSortExpression>
                                            </SortExpressions>
                                            <CommandItemTemplate>
                                                <table>
                                                    <tr>
                                                
                                                        <td>
                                                            <div style="min-width: 130px;">
                                                            <asp:Button runat="server" ID="btnRefresh" Text="Redraw Map" CommandName ="RebindGrid" CausesValidation="false" meta:resourcekey="btnRedrawMap" CssClass="RedrawMap" />
                                                      </div>
                                                                  </td>
                                                                <td>
                                                                    <div  style="min-width: 260px;">
                                                                        <b><asp:Label ID="lblProgram" runat="server" meta:ResourceKey="lblProgram"></asp:Label></b>
                                                                        <telerik:RadComboBox ID="ddlPrograms" Width="205px" runat="server" Height="250px" Style="font-size: 11px"
                                                                         AllowCustomText="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                                         OnItemsRequested="ddl_ItemsRequested" MarkFirstMatch="true" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                                                         NoWrap="True">
                                                                        </telerik:RadComboBox>
                                                                    </div>
                                                    
                                                        </td>
                                                        <td>
                                                            <div  style="min-width: 260px;">
                                                                    <b><asp:Label ID="lblLocation" runat="server" meta:ResourceKey="lblLocation"></asp:Label></b>
                                                                     <telerik:RadComboBox ID="ddlPlants" Width="205px" runat="server" Height="250px" Style="font-size: 11px"
                                                                     AllowCustomText="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                                     OnItemsRequested="ddl_ItemsRequested" MarkFirstMatch="true" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                                                        NoWrap="True">
                                                                     </telerik:RadComboBox>
                                                            </div>
                                                        
                                                        </td>
                                                        <td><div style="min-width: 150px;">
                                                            <b>
                                                            
                                                            <asp:Label ID="lblCenter" meta:resourcekey="lblCenter" runat="server" Text="Center"></asp:Label></b>
                                                            <asp:TextBox ID="txtCenter" runat="server" Width="100px"></asp:TextBox></div>
                                                            </td>
                                                             
                <td><div style="min-width: 150px;"> <b>
                    
                        <asp:Label ID="lblZoomLevel" meta:resourcekey="lblZoomLevel" runat="server" Text="Zoom"></asp:Label>
                </b>
                    <telerik:radcombobox id="ddlZoomLevel" runat="server" width="60px"
                        skin="Default" style="font-size: 11px">
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
                                                            </telerik:radcombobox>
            </div>
            </td>

                                                    </tr>
                                                </table>
                                            </CommandItemTemplate>
                                        </MasterTableView>
                                        <headerstyle font-size="8pt"></headerstyle>
            <clientsettings allowdragtogroup="false">
                                            <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
                                                AllowColumnResize="True"></Resizing>
                                            <Scrolling UseStaticHeaders="true" />
                                        </clientsettings>
            </telerik:RadGrid>
                                </telerik:RadSlidingPane>
                            </telerik:RadSlidingZone>
                        </telerik:RadPane>

                        <telerik:radpane id="RadPane1" runat="server" width="100%" scrolling="None">
                            <div id="map_canvas" style="width: 100%;" class="canvas"></div>
                        </telerik:radpane>
            </telerik:RadSplitter>
        </div>
        </div>
        </div>
    </form>
</body>
</html>
