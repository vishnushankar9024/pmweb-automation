<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="WorkOrdersMapViewPopup.aspx.vb" Inherits="Website.WorkOrdersMapViewPopup" Title="Map View" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script type="text/javascript" src="JS/encoder.js"></script>
    <script type="text/javascript">
        var objMap;

        var wait;
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

<body onload="initializeMap();">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server"></telerik:RadAjaxManager>


        <div class="PMMainPage">
            <div class="row">
                <div class="col-4">
                    <table class="colTable" style="font-size: 12px;">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblFromDate" meta:resourcekey="lblFromDate" runat="server" Text="From"></asp:Label>
                            </td>
                            <td class="controlWidth" style="text-align-last: right;">
                                <telerik:RadDateInput runat="server" ID="rdiFromDate" MinDate="1900-1-1" MaxDate="2100-1-1" Width="100%"></telerik:RadDateInput>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblToDate" meta:resourcekey="lblToDate" runat="server" Text="To"></asp:Label>
                            </td>
                            <td class="controlWidth" style="text-align-last: right;">
                                <telerik:RadDateInput runat="server" ID="rdiToDate" MinDate="1900-1-1" MaxDate="2100-1-1" Width="100%"></telerik:RadDateInput>
                            </td>
                        </tr>
                        <tr>

                            <td class="labelWidth"></td>
                            <td class="controlWidth" align="right">
                                <asp:Button ID="btnRefresh" runat="server" Text="Refresh" meta:resourcekey="btnRefresh" CssClass="submit" />
                            </td>
                        </tr>

                    </table>
                </div>

            </div>
        </div>


        <div id="map_canvas" style="width: 100%; height: 400px"></div>

    </form>
</body>
</html>
