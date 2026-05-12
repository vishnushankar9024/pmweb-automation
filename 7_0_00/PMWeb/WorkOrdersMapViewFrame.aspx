<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="WorkOrdersMapViewFrame.aspx.vb" Inherits="Website.WorkOrdersMapViewFrame" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <%--<style type="text/css">
        .body{ background-image:none important!;} 
        .RadGrid_PM .rgPagerLabel{font-size:8pt !important;}

    </style>--%>
    <style type="text/css">
        table {
            font-size: 12px;
            color: #666666;
        }
        .RightAlign input{
            text-align:right;
        }
    </style>
    <script type="text/javascript" src="JS/encoder.js"></script>
    <script type="text/javascript">
        var objMap;

        var wait;
        function initializeMap() {
            // MENU EMPTY DIV

            var divs = document.querySelectorAll('.divBox');
            var divBox = Array.prototype.slice.call(divs);
            divBox.forEach(function (curr) {
                if (curr.innerHTML.trim() === "") {
                    curr.style.display = 'none';
                }
            })


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
            showAddresses();
        }
        var PointsArray = [];

        function showAddresses() {
            wait = false;
            for (i = 0; i <= LocationAddresses.length - 1; i++) {
                var objLocationAddress = LocationAddresses[i];
                if (objLocationAddress.Checked == false) DisplayAddress(i);
            }
        }


        function DisplayAddress(AddresseIndx) {
            var ProjIcon;
            var objLocationAddress = LocationAddresses[i];
            ProjIcon = 'Images/Asset/Excavator_red.png';
            if ((isNaN(parseFloat(objLocationAddress.Latitude))) == false || (isNaN(parseFloat(objLocationAddress.Longitude))) == false) {
                var myLatlng = new google.maps.LatLng(objLocationAddress.Latitude, objLocationAddress.Longitude);
                var objMarker = new google.maps.Marker({ position: myLatlng, map: objMap, draggable: false, icon: ProjIcon });
                var infowindow = new google.maps.InfoWindow({
                    content: objLocationAddress.GoogleSummary
                });
                google.maps.event.addListener(objMarker, 'click', function () { infowindow.open(objMap, objMarker); });
            }
        }
    </script>
</head>

<body onload="initializeMap();" style="padding: 0px; background-image: none !important">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager1" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxLoadingPanel ID="ldpWorkOrders1" runat="server" Skin="Default" />


        <div class="PMMainPage documentSinglePage">
            <div class="row row-8-4">
                <div class="col-4">
                    <div id="map_canvas" style="width: 100%; height: 450px"></div>
                </div>
                <div class="col-8">
                    <telerik:RadGrid ID="rdgWorkOrders" runat="server" Width="100%" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" AppendMenus="true"
                        HeaderStyle-Font-Size="8" AutoGenerateColumns="False" ShowStatusBar="True" AllowPaging="true" PageSize="20"
                        AllowMultiRowEdit="True" AllowMultiRowSelection="True" GridLines="None" ShowGroupPanel="true">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                        <HeaderContextMenu EnableViewState="false">
                        </HeaderContextMenu>
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Index" CommandItemDisplay="Top" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage"
                            EditMode="InPlace" TableLayout="Fixed">
                            <Columns>

                                <telerik:GridTemplateColumn HeaderText="Location" UniqueName="Location"
                                    GroupByExpression="Location [GridColumn_Location] Group By Location">
                                    <ItemTemplate>
                                        <%#IIf(Container.DataItem("Location") = String.Empty, "&nbsp;", Container.DataItem("Location"))%>
                                    </ItemTemplate>
                                    <HeaderStyle Width="200px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Work Order" UniqueName="WorkOrder"
                                    GroupByExpression="WorkOrder [GridColumn_WorkOrder] Group By WorkOrder">
                                    <ItemTemplate>
                                        <a target="_parent" href='<%#Container.DataItem("WorkOrderURL").ToString%>'><span><%#IIf(Len(Container.DataItem("WorkOrder").ToString) = 0, "&nbsp;", Container.DataItem("WorkOrder").ToString)%></span></a>
                                    </ItemTemplate>
                                    <HeaderStyle Width="200px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Date" UniqueName="Date" DataField="Date"
                                    GroupByExpression="Date [GridColumn_Date] Group By Date">
                                    <ItemTemplate>
                                        <%# FormatDate(CDate(Container.DataItem("Date")))%>
                                    </ItemTemplate>
                                    <HeaderStyle Width="200px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>


                                <telerik:GridTemplateColumn HeaderText="Resources" UniqueName="Resources"
                                    GroupByExpression="Resources [GridColumn_Resources] Group By Resources">
                                    <ItemTemplate>
                                        <%#IIf(Container.DataItem("Resources") = String.Empty, "&nbsp;", Container.DataItem("Resources"))%>
                                    </ItemTemplate>
                                    <HeaderStyle Width="198px"></HeaderStyle>
                                </telerik:GridTemplateColumn>


                            </Columns>
                            <SortExpressions>
                                <telerik:GridSortExpression FieldName="Location"></telerik:GridSortExpression>
                            </SortExpressions>
                            <CommandItemTemplate>
                                <table style="margin: 0; padding: 0;white-space:nowrap;" cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td>
                                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid">
                                                                        <span class="Icon"></span>
                                            </asp:LinkButton>
                                            <b>&nbsp;<asp:Label ID="lblLocation" meta:resourcekey="lblLocation" runat="server" Text="Location"></asp:Label></b>
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="ddlLocations" runat="server" Width="150px" AutoPostBack="false"
                                                Style="font-size: 11px" CloseDropDownOnBlur="true" EnableItemCaching="false"
                                                NoWrap="True" AllowCustomText="true" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                        <td><b>&nbsp;<asp:Label ID="lblFromDate" meta:resourcekey="lblFromDate" runat="server" Text="From"></asp:Label></b>
                                            <telerik:RadDateInput runat="server" ID="rdiFromDate" MinDate="1900-1-1" MaxDate="2100-1-1" Width="80px" style="text-align:right;"></telerik:RadDateInput>
                                        </td>
                                        <td><b>&nbsp;<asp:Label ID="lblToDate" meta:resourcekey="lblToDate" runat="server" Text="To"></asp:Label></b>
                                            <telerik:RadDateInput runat="server" ID="rdiToDate" MinDate="1900-1-1" MaxDate="2100-1-1" Width="80px" style="text-align:right;"></telerik:RadDateInput>
                                        </td>
                                        <td><b>&nbsp;<asp:Label ID="lblCenter" meta:resourcekey="lblCenter" runat="server" Text="Center"></asp:Label></b>
                                            <asp:TextBox ID="txtCenter" runat="server" Width="100px"></asp:TextBox></td>
                                        <td>&nbsp;<b><asp:Label ID="lblZoomLevel" meta:resourcekey="lblZoomLevel" runat="server" Text="Zoom"></asp:Label></b>
                                            <telerik:RadComboBox ID="ddlZoomLevel" runat="server" Width="50px" Height="200px" CssClass="RightAlign"
                                                Style="font-size: 11px;">
                                                <CollapseAnimation Duration="200" Type="OutQuint"   />
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
                        <ClientSettings AllowDragToGroup="true">
                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                AllowColumnResize="True" />
                            <Scrolling UseStaticHeaders="true" />
                        </ClientSettings>
                    </telerik:RadGrid>
                </div>
            </div>
        </div>


        <table style="padding: 0px; background-image: none !important" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 500px" valign="top"></td>
                <td valign="top"></td>
            </tr>
        </table>
    </form>
</body>
</html>
