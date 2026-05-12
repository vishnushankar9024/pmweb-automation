<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="GoogleAddressesPicker.aspx.vb"
    Inherits="Website.GoogleAddressesPicker" Title="Google Map" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
       .fullWidth .rtsLevel1.rtsLevel{width:100% !important}
    </style>
    <script src="JS/jQuery-v2.1.2.js" type="text/javascript"></script>
    <script src="JS/jQuery-migrate-1.1.1.js" type="text/javascript"></script>


</head>
<body onload="initialize();" onunload="RefreshComponentGrid();">
    <form id="form1" runat="server">
        <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <style type="text/css">
            a.rfdSkinnedButton {
                text-decoration: none !important;
            }

            .documentTabs {
                top: 50px !important;
            }

            .GooglAddressMultipage {
                margin-top: 82px;
            }

            .GoogleAddressUpdateButton .Icon {
                background-image: url('css/Images/ResponsiveIcons/24Enabled.png') !important;
                background-position: -1776px 0px !important;
                display: inline-block !important;
                width: 24px !important;
                height: 24px !important;
            }
        </style>

            <script type="text/javascript">

                var isAddressPicker = true; isPolylinePicker = true; argClose = true; DisplayPMWebFeatures = true; UpdateRecord = false; PickerSender = '';
                var imgRedMarker = 'Images/Global/GoogleMarkerR.png'; imgGrayMarker = 'Images/Global/GoogleMarkerG.png'; imgBlueMarker = 'Images/Global/GoogleMarkerB.png';
                var msgSuccessfullySaved = 'Successfully Saved1';
                var RedPolyline = '#D54732'; GrayPolyline = '#777'; PolylineWeight = 2; currComponentId = 0;
                var currentLoadingPanel = null; currentUpdatedControl = null;
                var arrData = []; arrPoints = []; arrMarkers = []; arrComponents = [];
                var strGoogleAddress = ''; dblLatitude = 38; dblLongitude = -100; dblElevation = 0; objMap = null; objPoly = null; objMarker = null;
                var objElevator = null; objGeocoder = null; arrAddresses = []; MouseX = 0; MouseY = 0; BoxX = 0; BoxY = 0; objTimer = null;
                var timer_is_on = 0; var arrPolylinePath = []; var objPolylineArea = null; var objPolylinePath = null; var LengthUOMId = 1; var AreaUOMId = 1;
                const urlparam = new URLSearchParams(window.location.search);
                var recordType = urlparam.get("RecordType");
                $(document).ready(function () {
                    $("input[id$=txtAreaPoints]").mouseenter(function () {
                        if (!objPolylineArea) {
                            objPolylineArea = new google.maps.Polygon({
                                map: objMap,
                                path: arrPolylinePath,
                                fillColor: "#FF0000",
                                fillOpacity: 0.20,
                                strokeOpacity: 0.01,
                                strokeWeight: 0.01
                            });
                        }
                    }).mouseleave(function () {
                        setTimeout(function () { if (objPolylineArea) { objPolylineArea.setMap(null); objPolylineArea = null; } }, 300);
                    });

                    $("input[id$=txtLengthPoints]").mouseenter(function () {
                        if (!objPolylinePath) {
                            objPolylinePath = new google.maps.Polyline({
                                map: objMap,
                                path: arrPolylinePath,
                                strokeColor: RedPolyline,
                                strokeOpacity: 1,
                                strokeWeight: 4
                            });
                        }
                    }).mouseleave(function () {
                        setTimeout(function () { if (objPolylinePath) { objPolylinePath.setMap(null); objPolylinePath = null; } }, 300);
                    });

                });

                $(document).keydown(function (e) {
                    if (e.keyCode == dKey) { if (document.getElementById('lstPoints')) DeleteSelectedPoint(false); }
                });

                function initialize() {
                    setTimeout(() => { 
                    debugger;
                        try { StartUp(); } catch (err) { };
                        if ((PickerSender == 'RecordAddress') || (PickerSender == 'Component')) {
                            //var myLatlng = new google.maps.LatLng(arrData[0].CenterLat, arrData[0].CenterLong);
                            var myLatlng = new google.maps.LatLng(39.305, -76.617);
                            var myOptions = {
                                zoom: 4,
                                center: myLatlng,
                                mapTypeId: google.maps.MapTypeId.ROADMAP
                            }
                            objMap = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
                            google.maps.event.addListener(objMap, 'center_changed', function () { HideHtmlDiv(); });
                            google.maps.event.addListener(objMap, 'zoom_changed', function () { HideHtmlDiv(); });
                            $("#map_canvas").mousemove(function (event) {
                                MouseX = event.pageX;
                                MouseY = event.pageY;
                            });

                            if (PickerSender == 'RecordAddress') {
                                objMarker = new google.maps.Marker({ position: new google.maps.LatLng(dblLatitude, dblLongitude), map: objMap, draggable: true });
                                google.maps.event.addListener(objMarker, 'click', function () {
                                    BoxX = MouseX;
                                    BoxY = MouseY;
                                    BuildAddressSuggestions()
                                    $('#htmlDiv').toggle(500, function () { });
                                });
                                google.maps.event.addListener(objMarker, 'dragend', function () {
                                    BoxX = MouseX;
                                    BoxY = MouseY;
                                    MarkerDragend(true, true, true);
                                });

                                $("input[id=txtGoogleAddress]").keypress(function (e) {
                                    if (e.keyCode == 13) {
                                        UpdateGoogleAddress();
                                    }
                                });

                                //$("input[id=txtlatitude]").val(window.parent.$("input[id$=txtlatitude]").val());
                                //$("input[id=txtLongitude]").val(window.parent.$("input[id$=txtLongitude]").val());
                                //$("input[id=txtElevation]").val(window.parent.$("input[id$=txtElevation]").val());
                                //$("input[id=txtGoogleAddress]").val(window.parent.$("input[id$=txtGoogleAddress]").val());
                            }

                            var polyOptions = {
                                strokeColor: GrayPolyline,
                                strokeOpacity: 1.0,
                                strokeWeight: 3.5
                            };
                            objPoly = new google.maps.Polyline(polyOptions);
                            objPoly.setMap(objMap);
                            DrawPolyline();
                        }

                        if (PickerSender == 'LinearAsset') {
                            if (document.getElementById("map_canvas1")) {
                                var polyOptions = {
                                    strokeColor: RedPolyline,
                                    strokeOpacity: 1.0,
                                    strokeWeight: 2
                                };

                                var myLatlng = new google.maps.LatLng(arrData[0].CenterLat, arrData[0].CenterLong);
                                var myOptions = {
                                    zoom: arrData[0].ZoomLevel,
                                    center: myLatlng,
                                    mapTypeId: google.maps.MapTypeId.ROADMAP
                                }
                                objMap = new google.maps.Map(document.getElementById("map_canvas1"), myOptions);
                                objMarker = new google.maps.Marker({
                                    position: myLatlng,
                                    map: objMap,
                                    draggable: true
                                });
                                objPoly = new google.maps.Polyline(polyOptions);
                                objPoly.setMap(objMap);


                                $("#map_canvas1").mousemove(function (event) {
                                    MouseX = event.pageX;
                                    MouseY = event.pageY;
                                });

                                google.maps.event.addListener(objMarker, 'dragend', function () {
                                    MarkerDragend1(this);
                                });


                                $("input[id=txtGoogleAddress1]").keypress(function (e) {
                                    if (e.keyCode == 13 && objMap !== null) {
                                        strGoogleAddress = $("input[id=txtGoogleAddress1]").val();
                                        if (strGoogleAddress.length == 0) { return; }
                                        objGeocoder = new google.maps.Geocoder();
                                        objGeocoder.geocode({ 'address': strGoogleAddress }, function (results, status) {
                                            if (status == google.maps.GeocoderStatus.OK) {
                                                objMap.setCenter(results[0].geometry.location);
                                                objMarker.position = objMap.getCenter(); //results[0].geometry.location;
                                                $("input[id$=txtlatitude1]").val(objMarker.position.lat());
                                                $("input[id$=txtLongitude1]").val(objMarker.position.lng());
                                                var locations = [];
                                                var clickedLocation = objMarker.getPosition();
                                                locations.push(clickedLocation);
                                                var positionalRequest = {
                                                    'locations': locations
                                                }
                                                objElevator = new google.maps.ElevationService();
                                                objElevator.getElevationForLocations(positionalRequest, function (results, status) {
                                                    if (status === google.maps.ElevationStatus.OK) {
                                                        $("input[id$=txtElevation1]").val(results[0].elevation);
                                                    } else {
                                                        $("input[id$=txtElevation1]").val('---');
                                                    }
                                                });
                                            } else {
                                                arrAddresses = [];
                                                alert('Invalid Address!');
                                                $("input[id$=txtlatitude1]").val('');
                                                $("input[id$=txtLongitude1]").val('');
                                                $("input[id$=txtElevation1]").val('');
                                            }
                                        }
                                       );
                                    }
                                });

                                google.maps.event.addListener(objMap, 'dblclick', function (event) {
                                    var MarkerPos = new google.maps.LatLng(event.latLng.lat(), event.latLng.lng());
                                    objMarker.setPosition(MarkerPos);
                                    $("input[id$=txtlatitude1]").val(objMarker.position.lat());
                                    $("input[id$=txtLongitude1]").val(objMarker.position.lng());
                                });

                                DrawPolyline();
                                var arrPointsLength = arrPoints.length;
                                var lstPoints = document.getElementById('lstPoints');
                                for (var i = 0; i < arrPointsLength; i++) {
                                    var newOptionList = document.createElement("option");
                                    newOptionList.text = arrPoints[i].LATITUDE + ';' + arrPoints[i].LOGITUDE;
                                    newOptionList.value = arrPoints[i].LATITUDE + ';' + arrPoints[i].LOGITUDE;
                                    lstPoints.options.add(newOptionList);
                                }
                            }
                        }
                    }, 1000);
                }
                function MarkerDragend1(argobjMarker) {
                    objMarker = argobjMarker;
                    $("input[id$=txtlatitude1]").val(objMarker.position.lat());
                    $("input[id$=txtLongitude1]").val(objMarker.position.lng());

                    var locations = [];
                    var clickedLocation = objMarker.getPosition();
                    locations.push(clickedLocation);
                    var positionalRequest = {
                        'locations': locations
                    }
                    objElevator = new google.maps.ElevationService();
                    objElevator.getElevationForLocations(positionalRequest, function (results, status) {
                        if (status === google.maps.ElevationStatus.OK) {
                            $("input[id$=txtElevation1]").val(results[0].elevation);
                        } else {
                            $("input[id$=txtElevation1]").val('---');
                        }
                    });
                    objGeocoder = new google.maps.Geocoder();
                    objGeocoder.geocode({ 'location': objMarker.getPosition() }, function (results, status) {
                        arrAddresses = [];
                        if (status == google.maps.GeocoderStatus.OK) {
                            if (results.length > 1) {
                                for (var i = 0; i < results.length; i++) {
                                    if (arrAddresses.indexOf(results[i].formatted_address) == -1) { arrAddresses.push(results[i].formatted_address); }
                                }
                                if (arrAddresses.length > 0) {
                                    $("input[id$=txtGoogleAddress1]").val(arrAddresses[0]);
                                } else {
                                    $("input[id=txtGoogleAddress1]").val('No address found');
                                }
                            }
                        } else {
                            $("input[id=txtGoogleAddress1]").val('No address found');
                        }
                    });
                
                }

                function MarkerDragend(blnBuildAddresses, blnUpdateTxtGoogleAddress, blnShowDiv) {
                    if (blnUpdateTxtGoogleAddress) {
                        $("input[id$=txtlatitude]").val(objMarker.position.lat());
                        $("input[id$=txtLongitude]").val(objMarker.position.lng());
                    }
                    var locations = [];
                    var clickedLocation = objMarker.getPosition();
                    locations.push(clickedLocation);

                    var positionalRequest = {
                        'locations': locations
                    }

                    objElevator = new google.maps.ElevationService();
                    objElevator.getElevationForLocations(positionalRequest, function (results, status) {
                        if (status === google.maps.ElevationStatus.OK) {
                            if (blnUpdateTxtGoogleAddress) { $("input[id$=txtElevation]").val(results[0].elevation); }

                        } else {
                            $("input[id$=txtElevation]").val('---');
                        }
                    });

                    objGeocoder = new google.maps.Geocoder();
                    objGeocoder.geocode({ 'location': objMarker.getPosition() }, function (results, status) {
                        arrAddresses = [];
                        if (status == google.maps.GeocoderStatus.OK) {
                            if (results.length > 1) {
                                for (var i = 0; i < results.length; i++) {
                                    if (arrAddresses.indexOf(results[i].formatted_address) == -1) { arrAddresses.push(results[i].formatted_address); }
                                }
                                if (blnBuildAddresses) { BuildAddressSuggestions(); }
                                if (arrAddresses.length > 0) {
                                    if (blnUpdateTxtGoogleAddress) { $("input[id$=txtGoogleAddress]").val(arrAddresses[0]); }
                                    if (blnShowDiv) { ShowHtmlDiv(); }
                                } else {
                                    $("input[id=txtGoogleAddress]").val('No address found');
                                    HideHtmlDiv();
                                }
                            }
                        } else {
                            $("input[id=txtGoogleAddress]").val('No address found');
                            HideHtmlDiv();
                        }

                    });
                }

                function UpdateGoogleAddress() {
                    debugger;
                    strGoogleAddress = $("input[id=txtGoogleAddress]").val();
                    if (strGoogleAddress.length == 0) { return; }
                    objGeocoder = new google.maps.Geocoder();
                    objGeocoder.geocode({ 'address': strGoogleAddress }, function (results, status) {
                        if (status == google.maps.GeocoderStatus.OK) {
                            objMap.setCenter(results[0].geometry.location);
                            objMarker.position = results[0].geometry.location;
                            objMarker.setPosition(results[0].geometry.location);
                            MarkerDragend(true, true, false);
                        } else {
                            arrAddresses = [];
                            alert('Invalid Address!');
                        }

                    }
                    );
                    return false;
                }

                function BuildAddressSuggestions() {
                    var htmlDiv = document.getElementById('htmlDiv');
                    if (!htmlDiv) {
                        document.body.appendChild(document.createElement('div')).innerHTML = "<div id='htmlDiv' style='position:absolute; z-index: 1100;left:0px; top:0px; border:0px; padding:0px; margin:0px;display:none'>Test</div>";
                        htmlDiv = document.getElementById('htmlDiv');
                    }

                    htmlDiv.innerHTML = '';
                    var strInnerHTML = '<table class=Container1 style="margin:3px;background-color:White;min-width:200px">';

                    for (var i = 0; i < arrAddresses.length; i++) {
                        strInnerHTML += '<tr><td>';
                        strInnerHTML += '<a class=Link><span onclick="AddressClicked(this);" class="nowrap">' + arrAddresses[i] + '</span></a>'
                        strInnerHTML += '</td></tr>';
                    }
                    strInnerHTML += '</table>'

                    htmlDiv.innerHTML = strInnerHTML;
                    htmlDiv.style.left = BoxX + 5 + 'px';
                    htmlDiv.style.top = BoxY + 10 + 'px';
                }

                function AddressClicked(sender) {
                    $("input[id$=txtGoogleAddress]").val(sender.innerHTML);
                    HideHtmlDiv();
                }

                function ShowHtmlDiv() {
                    $('#htmlDiv').show(500, function () { });
                }

                function HideHtmlDiv() {
                    $('#htmlDiv').hide(500, function () { });
                }

                function querySt(ji) {
                    hu = window.location.search.substring(1);
                    gy = hu.split("&");
                    for (i = 0; i < gy.length; i++) {
                        ft = gy[i].split("=");
                        if (ft[0] == ji) {
                            return ft[1];
                        }
                    }
                }

                function ToolBar_Clicking(sender, args) {
                    switch (args.get_item().get_commandName()) {
                        case "Save":
                            if (objMap !== null) {
                                if (PickerSender == 'RecordAddress') {
                                    var objMapCenter = objMap.getCenter();
                                    PageMethods.SaveRecordMapSettings(objMapCenter.lat(), objMapCenter.lng(), objMap.getZoom(), $("input[id=txtlatitude]").val(), $("input[id=txtLongitude]").val(), $("input[id=txtElevation]").val(), $("input[id=txtGoogleAddress]").val(),
                                        function (response) {
                                            console.log('hwllo');
                                            if (recordType == "FILEMANGER_LOOKUPFILES" || recordType == "ATTACHMENTS" ) {

                                                window.parent.$("input[id$=hfZoomLevel]").val(objMap.getZoom());
                                                window.parent.$("input[id$=hfCenter]").val(objMapCenter.lat() + ';' + objMapCenter.lng());
                                                window.parent.$("input[id$=txtlatitude]").val($("input[id=txtlatitude]").val());
                                                window.parent.$("input[id$=txtLongitude]").val($("input[id=txtLongitude]").val());
                                                window.parent.$("input[id$=hfElevation]").val($("input[id=txtElevation]").val());
                                                window.parent.$("input[id$=hfGoogleAddress]").val($("input[id=txtGoogleAddress]").val());
                                                window.parent.$("input[id$=hfLatitude]").val($("input[id=txtlatitude]").val());
                                                window.parent.$("input[id$=hfLongitude]").val($("input[id=txtLongitude]").val());
                                                window.parent.$("input[id$=txtElevation]").val($("input[id=txtElevation]").val());
                                                window.parent.$("input[id$=txtGoogleAddress]").val($("input[id=txtlatitude]").val() + ", " + $("input[id=txtLongitude]").val());
                                                window.parent.$("input[id$=hfIsGeoLocationUpdated]").val('1');
                                            }
                                            else {

                                                window.parent.$("input[id$=txtlatitude]").val($("input[id=txtlatitude]").val());
                                                window.parent.$("input[id$=txtLongitude]").val($("input[id=txtLongitude]").val());
                                                window.parent.$("input[id$=txtElevation]").val($("input[id=txtElevation]").val());
                                                window.parent.$("input[id$=txtGoogleAddress]").val($("input[id=txtGoogleAddress]").val());
                                            }


                                            

                                        },
                                        function (msg) { alert(msg) },
                                                    null);
                                    args.set_cancel(true);
                                }

                                if (PickerSender == 'Component') {
                                    var objMapCenter = objMap.getCenter();
                                    var arrComponentsLength = arrComponents.length;
                                    var strComponents = '';
                                    for (var i = 0; i < arrComponentsLength; i++) {
                                        //strComponents = strComponents + arrComponents[i].COMPONENTID + ';' + arrComponents[i].LATITUDE + ';' + arrComponents[i].LOGITUDE + ';' + arrComponents[i].ELEVATION + '$$$'
                                        if (arrComponents[i].COMPONENTID == currComponentId) {
                                            window.parent.$("input[id$=txtLatitude]").val(arrComponents[i].LATITUDE);
                                            window.parent.$("input[id$=txtLongitude]").val(arrComponents[i].LOGITUDE);
                                            window.parent.$("input[id$=txtElevation]").val(arrComponents[i].ELEVATION);
                                        }
                                    }
                                    PageMethods.SaveComponents(objMapCenter.lat(), objMapCenter.lng(), objMap.getZoom(), strComponents, DisplayPMWebFeatures, UpdateRecord,
                                        function (response) {
                                            if (args.get_item().get_commandName() == 'Save') {
                                                alert(msgSuccessfullySaved);
                                            }
                                        },
                                        function (msg) { alert(msg) },
                                                    null);

                                    args.set_cancel(true);
                                }

                                if (PickerSender == 'LinearAsset') {
                                    if (objMap !== null) {
                                        var objMapCenter = objMap.getCenter();
                                        arrData = [];
                                        arrData.push({
                                            CenterLat: objMapCenter.lat()
                                                       , CenterLong: objMapCenter.lng()
                                                       , ZoomLevel: objMap.getZoom()
                                        });

                                        var strPoints = '';
                                        var arrPointsLength = arrPoints.length;
                                        for (var i = 0; i < arrPointsLength; i++) {
                                            strPoints = strPoints + arrPoints[i].LATITUDE + ';' + arrPoints[i].LOGITUDE + '$$$'
                                        }

                                        //arrData.push(arrPoints);
                                        currentLoadingPanel = $find("<%= ldpMaps.ClientID %>");
                                        currentUpdatedControl = $find("<%= pvLinear.ClientID %>");

                                        PageMethods.SavePoints(objMapCenter.lat(), objMapCenter.lng(), objMap.getZoom(), LengthUOMId, AreaUOMId, strPoints, DisplayPMWebFeatures, UpdateRecord,
                                                function (response) {
                                                    if (UpdateRecord == true) {

                                                        var currddlLengthUOM = $find("<%= ddlLengthUOM.ClientID %>");
                                                        var currddlAreaUOM = $find("<%= ddlAreaUOM.ClientID %>");
                                                        var lstPoints = document.getElementById('lstPoints');
                                                        var listLength = lstPoints.options.length;
                                                        if (listLength > 0) {
                                                            if (window.parent.$("input[id$=TxtBegin]")) window.parent.$("input[id$=TxtBegin]").val(lstPoints.options[0].value);
                                                            if (window.parent.$("input[id$=TxtEnd]")) window.parent.$("input[id$=TxtEnd]").val(lstPoints.options[listLength - 1].value);
                                                        }
                                                        if (window.parent.$("input[id$=txtLength]")) window.parent.$("input[id$=txtLength]").val($("input[id=txtLengthPoints]").val());
                                                        var txtLengthId = window.parent.$("input[id$=txtLength]")[0].id;
                                                        var ddlLengthUOM = txtLengthId.substring(txtLengthId.lastIndexOf('_'), txtLengthId.lenght - 1) + '_ddlLengthUOM';
                                                        if (window.parent.$find(ddlLengthUOM)) {
                                                            window.parent.$find(ddlLengthUOM).set_value(currddlLengthUOM.get_selectedItem().get_value());
                                                            window.parent.$find(ddlLengthUOM).set_text(currddlLengthUOM.get_selectedItem().get_text());
                                                        }

                                                        if (window.parent.$("input[id$=txtLinearArea]")) window.parent.$("input[id$=txtLinearArea]").val($("input[id=txtAreaPoints]").val());
                                                        var txtLinearAreaId = window.parent.$("input[id$=txtLinearArea]")[0].id;
                                                        var ddlLinearAreaUOM = txtLinearAreaId.substring(txtLinearAreaId.lastIndexOf('_'), txtLinearAreaId.lenght - 1) + '_ddlLinearAreaUOM';
                                                        if (window.parent.$find(ddlLinearAreaUOM)) {
                                                            window.parent.$find(ddlLinearAreaUOM).set_value(currddlAreaUOM.get_selectedItem().get_value());
                                                            window.parent.$find(ddlLinearAreaUOM).set_text(currddlAreaUOM.get_selectedItem().get_text());
                                                        }

                                                    }
                                                    if (args.get_item().get_commandName() == 'Save') {
                                                        alert(msgSuccessfullySaved);
                                                    }
                                                },
                                                function (msg) {
                                                    alert(msg)
                                                },
                                                            null);

                                    }
                                }
                            }
                            break;
                        case "SaveAndExit":
                            if (objMap !== null) {
                                if (PickerSender == 'RecordAddress') {
                                    var objMapCenter = objMap.getCenter();
                                    PageMethods.SaveRecordMapSettings(objMapCenter.lat(), objMapCenter.lng(), objMap.getZoom(), $("input[id=txtlatitude]").val(), $("input[id=txtLongitude]").val(), $("input[id=txtElevation]").val(), $("input[id=txtGoogleAddress]").val(),
                                        function (response) {
                                            if (recordType == "FILEMANGER_LOOKUPFILES" || recordType == "ATTACHMENTS") {
                                                
                                                window.parent.$("input[id$=hfZoomLevel]").val(objMap.getZoom());
                                                window.parent.$("input[id$=hfCenter]").val(objMapCenter.lat() + ';' + objMapCenter.lng());
                                                window.parent.$("input[id$=txtlatitude]").val($("input[id=txtlatitude]").val());
                                                window.parent.$("input[id$=txtLongitude]").val($("input[id=txtLongitude]").val());
                                                window.parent.$("input[id$=hfElevation]").val($("input[id=txtElevation]").val());
                                                window.parent.$("input[id$=hfGoogleAddress]").val($("input[id=txtGoogleAddress]").val());
                                                window.parent.$("input[id$=hfLatitude]").val($("input[id=txtlatitude]").val());
                                                window.parent.$("input[id$=hfLongitude]").val($("input[id=txtLongitude]").val());
                                                window.parent.$("input[id$=txtElevation]").val($("input[id=txtElevation]").val());
                                                window.parent.$("input[id$=txtGoogleAddress]").val($("input[id=txtlatitude]").val() + ", " + $("input[id=txtLongitude]").val());
                                                window.parent.$("input[id$=hfIsGeoLocationUpdated]").val('1');
                                            }
                                            else {

                                                window.parent.$("input[id$=txtlatitude]").val($("input[id=txtlatitude]").val());
                                                window.parent.$("input[id$=txtLongitude]").val($("input[id=txtLongitude]").val());
                                                window.parent.$("input[id$=txtElevation]").val($("input[id=txtElevation]").val());
                                                window.parent.$("input[id$=txtGoogleAddress]").val($("input[id=txtGoogleAddress]").val());
                                            }
                                            self.close();
                                        },
                                        function (msg) { alert(msg) },
                                                    null);
                                    args.set_cancel(true);
                                }

                                if (PickerSender == 'Component') {
                                    var objMapCenter = objMap.getCenter();
                                    var arrComponentsLength = arrComponents.length;
                                    var strComponents = '';
                                    for (var i = 0; i < arrComponentsLength; i++) {
                                        //strComponents = strComponents + arrComponents[i].COMPONENTID + ';' + arrComponents[i].LATITUDE + ';' + arrComponents[i].LOGITUDE + ';' + arrComponents[i].ELEVATION + '$$$'
                                        if (arrComponents[i].COMPONENTID == currComponentId) {
                                            window.parent.$("input[id$=txtLatitude]").val(arrComponents[i].LATITUDE);
                                            window.parent.$("input[id$=txtLongitude]").val(arrComponents[i].LOGITUDE);
                                            window.parent.$("input[id$=txtElevation]").val(arrComponents[i].ELEVATION);
                                        }
                                    }
                                    PageMethods.SaveComponents(objMapCenter.lat(), objMapCenter.lng(), objMap.getZoom(), strComponents, DisplayPMWebFeatures, UpdateRecord,
                                        function (response) {
                                            if (args.get_item().get_commandName() == 'Save') {
                                                alert(msgSuccessfullySaved);
                                            } else {
                                                self.close();
                                                //RefreshComponentGrid();
                                            }
                                        },
                                        function (msg) { alert(msg) },
                                                    null);

                                    args.set_cancel(true);
                                }

                                if (PickerSender == 'LinearAsset') {
                                    if (objMap !== null) {
                                        var objMapCenter = objMap.getCenter();
                                        arrData = [];
                                        arrData.push({
                                            CenterLat: objMapCenter.lat()
                                                       , CenterLong: objMapCenter.lng()
                                                       , ZoomLevel: objMap.getZoom()
                                        });

                                        var strPoints = '';
                                        var arrPointsLength = arrPoints.length;
                                        for (var i = 0; i < arrPointsLength; i++) {
                                            strPoints = strPoints + arrPoints[i].LATITUDE + ';' + arrPoints[i].LOGITUDE + '$$$'
                                        }

                                        //arrData.push(arrPoints);
                                        currentLoadingPanel = $find("<%= ldpMaps.ClientID %>");
                                        currentUpdatedControl = $find("<%= pvLinear.ClientID %>");

                                        PageMethods.SavePoints(objMapCenter.lat(), objMapCenter.lng(), objMap.getZoom(), LengthUOMId, AreaUOMId, strPoints, DisplayPMWebFeatures, UpdateRecord,
                                                function (response) {
                                                    if (UpdateRecord == true) {
                                                        var currddlLengthUOM = $find("<%= ddlLengthUOM.ClientID %>");
                                                        var currddlAreaUOM = $find("<%= ddlAreaUOM.ClientID %>");
                                                        var lstPoints = document.getElementById('lstPoints');
                                                        var listLength = lstPoints.options.length;
                                                        if (listLength > 0) {
                                                            if (window.parent.$("input[id$=TxtBegin]")) window.parent.$("input[id$=TxtBegin]").val(lstPoints.options[0].value);
                                                            if (window.parent.$("input[id$=TxtEnd]")) window.parent.$("input[id$=TxtEnd]").val(lstPoints.options[listLength - 1].value);
                                                        }
                                                        if (window.parent.$("input[id$=txtLength]")) window.parent.$("input[id$=txtLength]").val($("input[id=txtLengthPoints]").val());
                                                        var txtLengthId = window.parent.$("input[id$=txtLength]")[0].id;
                                                        var ddlLengthUOM = txtLengthId.substring(txtLengthId.lastIndexOf('_'), txtLengthId.lenght - 1) + '_ddlLengthUOM';
                                                        if (window.parent.$find(ddlLengthUOM)) {
                                                            window.parent.$find(ddlLengthUOM).set_value(currddlLengthUOM.get_selectedItem().get_value());
                                                            window.parent.$find(ddlLengthUOM).set_text(currddlLengthUOM.get_selectedItem().get_text());
                                                        }

                                                        if (window.parent.$("input[id$=txtLinearArea]")) window.parent.$("input[id$=txtLinearArea]").val($("input[id=txtAreaPoints]").val());
                                                        var txtLinearAreaId = window.parent.$("input[id$=txtLinearArea]")[0].id;
                                                        var ddlLinearAreaUOM = txtLinearAreaId.substring(txtLinearAreaId.lastIndexOf('_'), txtLinearAreaId.lenght - 1) + '_ddlLinearAreaUOM';
                                                        if (window.parent.$find(ddlLinearAreaUOM)) {
                                                            window.parent.$find(ddlLinearAreaUOM).set_value(currddlAreaUOM.get_selectedItem().get_value());
                                                            window.parent.$find(ddlLinearAreaUOM).set_text(currddlAreaUOM.get_selectedItem().get_text());
                                                        }

                                                    }
                                                    if (args.get_item().get_commandName() == 'Save') {
                                                        alert(msgSuccessfullySaved);
                                                    } else {
                                                        self.close();
                                                    }
                                                },
                                                function (msg) {
                                                    alert(msg)
                                                },
                                                            null);

                                        args.set_cancel(true);

                                    }
                                }
                            }
                            break;

                        case 'Close':
                            args.set_cancel(true);
                            RefreshComponentGrid();
                            self.close();
                            break;

                        default:
                            break;

                        case 'LinearDefinitionActivation':
                            var a = $find("mainToolBar").findButtonByCommandName("MobileMenu").findControl("MobileRadmen");
                            var ActiveLinear = a.findItemByValue("ActiveLinear");
                            var InactiveLinear = a.findItemByValue("InactiveLinear");;
                            var Elem = $(sender.findButtonByCommandName('LinearDefinitionActivation').get_element()).find("> a");
                            if (Elem.hasClass("ToolbarInActive")) {
                                Elem.removeClass("ToolbarInActive").addClass("ToolbarActive");
                                InactiveLinear.set_cssClass('Hide');
                                ActiveLinear.set_cssClass('')
                                UpdateRecord = true;
                            }
                            else {
                                Elem.removeClass("ToolbarActive").addClass("ToolbarInActive");
                                ActiveLinear.set_cssClass('Hide')
                                InactiveLinear.set_cssClass('');
                                UpdateRecord = false;
                            }
                            return false;

                        case 'DisplayPmwebFeaturesActivation':
                            var a = $find("mainToolBar").findButtonByCommandName("MobileMenu").findControl("MobileRadmen");
                            var ActiveDisplayFeatures = a.findItemByValue("ActiveDisplayFeatures");
                            var InactiveDisplayFeatures = a.findItemByValue("InactiveDisplayFeatures");
                            var Elem = $(sender.findButtonByCommandName('DisplayPmwebFeaturesActivation').get_element()).find("> a");
                            if (Elem.hasClass("ToolbarInActive")) {
                                Elem.removeClass("ToolbarInActive").addClass("ToolbarActive");
                                InactiveDisplayFeatures.set_cssClass('Hide')
                                ActiveDisplayFeatures.set_cssClass('');
                                DisplayPMWebFeatures = true;
                            }
                            else {
                                Elem.removeClass("ToolbarActive").addClass("ToolbarInActive");
                                ActiveDisplayFeatures.set_cssClass('Hide');
                                InactiveDisplayFeatures.set_cssClass('')
                                DisplayPMWebFeatures = false;
                            }
                            DrawPolyline();
                            return false;

                    }
                }

                function SaveAddressToDetail() {
                    window.parent.$("input[id$=txtGoogleAddress]").val($("input[id=txtGoogleAddress]").val());
                }
                /*Polyline Picker*/
                function AddPoint() {
                    var newOptionList = document.createElement("option");
                    newOptionList.text = $("input[id$=txtlatitude1]").val() + ';' + $("input[id$=txtLongitude1]").val();
                    newOptionList.value = $("input[id$=txtlatitude1]").val() + ';' + $("input[id$=txtLongitude1]").val();
                    var lstPoints = document.getElementById('lstPoints');
                    var listLength = lstPoints.options.length;
                    var insertIndx = listLength;
                    for (var i = 0; i < listLength; i++) {
                        if (lstPoints.options[i].selected) {
                            insertIndx = i + 1;
                            break;
                        }
                    }

                    for (var i = 0; i < listLength; i++) {
                        lstPoints.options[i].selected = false;
                    }

                    insertOptionToSelect(lstPoints, insertIndx, newOptionList);
                    arrPoints.insert(insertIndx, {
                        LATITUDE: $("input[id$=txtlatitude1]").val()
                                       , LOGITUDE: $("input[id$=txtLongitude1]").val()
                    });
                    DrawPolyline();
                    return false;
                }

                function DeleteSelectedPoint(argDeleteAll) {
                    var lstPoints = document.getElementById('lstPoints');
                    var listLength = lstPoints.options.length;
                    var arrRemovedValue = [];
                    for (var i = 0; i < listLength; i++) {
                        if (argDeleteAll == true) {
                            arrRemovedValue.push(lstPoints.options[i].value);
                        } else {
                            if (lstPoints.options[i].selected) {
                                arrRemovedValue.push(lstPoints.options[i].value);
                            }
                        }
                    }
                    var arrRemovedValueLength = arrRemovedValue.length;
                    for (var i = 0; i < arrRemovedValueLength; i++) {
                        RemovePoint(arrRemovedValue[i]);
                    }
                    DrawPolyline();
                    return false;
                }

                function RemovePoint(PointValue) {
                    var lstPoints = document.getElementById('lstPoints');
                    var listLength = lstPoints.options.length;
                    for (var i = 0; i < listLength; i++) {
                        if (lstPoints.options[i].value == PointValue) {
                            lstPoints.options.remove(i);
                            break;
                        }
                    }
                    var arrPointsLength = arrPoints.length;
                    var pointLat = PointValue.substr(0, PointValue.lastIndexOf(";"));
                    var pointLn = PointValue.substr(PointValue.lastIndexOf(";") + 1);
                    for (var i = 0; i < arrPointsLength; i++) {
                        if ((arrPoints[i].LATITUDE == pointLat) && (arrPoints[i].LOGITUDE == pointLn)) {
                            arrPoints.splice(i, 1);
                            break;
                        }
                    }
                }

                function DrawPolyline() {
                    if (objPoly !== null) {

                        var arrPointsLength = arrPoints.length;
                        var arrMarkersLength = arrMarkers.length;
                        var arrComponentsLength = arrComponents.length;
                        var objPath = objPoly.getPath();
                        objPath.clear();
                        var objPointMarker;
                        for (var i = 0; i < arrMarkersLength; i++) {
                            arrMarkers[i].setMap(null);
                        }
                        for (var i = 0; i < arrPointsLength; i++) {
                            var newPoint = new google.maps.LatLng(arrPoints[i].LATITUDE, arrPoints[i].LOGITUDE);
                            if ((PickerSender == 'LinearAsset') || (DisplayPMWebFeatures == true)) objPath.push(newPoint);
                            if (PickerSender == 'LinearAsset') {
                                objPointMarker = new google.maps.Marker({
                                    position: newPoint,
                                    title: '#' + objPath.getLength(),
                                    map: objMap,
                                    icon: imgRedMarker,
                                    draggable: true
                                });
                                google.maps.event.addListener(objPointMarker, 'click', function () {
                                    PointClicked(this);
                                });
                                google.maps.event.addListener(objPointMarker, 'dragstart', function () {
                                    PointClicked(this);
                                });
                                google.maps.event.addListener(objPointMarker, 'dragend', function () {
                                    MarkerDragend1(this);
                                    AddPoint();
                                });
                                arrMarkers.push(objPointMarker);
                            }
                        }
                        if ((PickerSender == 'Component') || (DisplayPMWebFeatures == true)) {
                            for (var i = 0; i < arrComponentsLength; i++) {
                                var newPoint = new google.maps.LatLng(arrComponents[i].LATITUDE, arrComponents[i].LOGITUDE);
                                objPointMarker = new google.maps.Marker({
                                    COMPONENTID: arrComponents[i].COMPONENTID,
                                    position: newPoint,
                                    title: arrComponents[i].COMPONENT,
                                    map: objMap,
                                    icon: imgGrayMarker,
                                    draggable: ((PickerSender == 'Component') && (arrComponents[i].COMPONENTID == currComponentId)) ? true : false
                                });
                                if (arrComponents[i].COMPONENTID == currComponentId) {
                                    objPointMarker.setIcon(imgRedMarker);
                                    if ((arrComponents[i].LOGITUDE == 0) && (arrComponents[i].LATITUDE == 0)) {
                                        var myLatlng = new google.maps.LatLng(dblLatitude, dblLongitude);
                                        objPointMarker.setPosition(myLatlng);
                                    }
                                    objMap.panTo(new google.maps.LatLng(objPointMarker.position.lat(), objPointMarker.position.lng()))
                                }
                                if (PickerSender == 'Component') {
                                    google.maps.event.addListener(objPointMarker, 'dragend', function () {
                                        ComponentDragend(this);
                                    });
                                }
                                arrMarkers.push(objPointMarker);
                            }
                        }
                        if (isAddressPicker == false) RecalculateLengthArea();
                    }
                }

                function ComponentDragend(argMarker) {
                    var MarkerLatitude = argMarker.position.lat();
                    var MarkerLongitude = argMarker.position.lng();
                    $("input[id$=txtlatitude]").val(argMarker.position.lat());
                    $("input[id$=txtLongitude]").val(argMarker.position.lng());
                    var locations = [];
                    var clickedLocation = argMarker.getPosition();
                    locations.push(clickedLocation);
                    var positionalRequest = {
                        'locations': locations
                    }
                    objElevator = new google.maps.ElevationService();
                    objElevator.getElevationForLocations(positionalRequest, function (results, status) {
                        if (status === google.maps.ElevationStatus.OK) {
                            $("input[id$=txtElevation]").val(results[0].elevation);
                            var arrComponentsLength = arrComponents.length;
                            for (var i = 0; i < arrComponentsLength; i++) {
                                if (arrComponents[i].COMPONENTID == argMarker.COMPONENTID) {
                                    arrComponents[i].ELEVATION = $("input[id$=txtElevation]").val();
                                }
                            }
                        } else {
                            $("input[id$=txtElevation]").val('---');
                        }
                    });

                    var arrComponentsLength = arrComponents.length;
                    for (var i = 0; i < arrComponentsLength; i++) {
                        if (arrComponents[i].COMPONENTID == argMarker.COMPONENTID) {
                            arrComponents[i].LATITUDE = MarkerLatitude;
                            arrComponents[i].LOGITUDE = MarkerLongitude;
                        }
                    }
                }

                function SetSelectedMarker() {
                    var lstPoints = document.getElementById('lstPoints');
                    var listLength = lstPoints.options.length;
                    var listMarkersLength = arrMarkers.length;

                    for (var i = 0; i < listLength; i++) {
                        if (lstPoints.options[i].selected == true) {
                            var SelectedValue = lstPoints.options[i].value;
                            var SelectedLatitude = SelectedValue.substr(0, SelectedValue.lastIndexOf(';'));
                            var SelectedLongitude = SelectedValue.substr(SelectedValue.lastIndexOf(';') + 1);
                            for (var j = 0; j < listMarkersLength; j++) {
                                arrMarkers[j].setIcon(imgRedMarker);
                                if ((arrMarkers[j].position.lat() == SelectedLatitude) && (arrMarkers[j].position.lng() == SelectedLongitude)) {
                                    arrMarkers[j].setIcon(imgBlueMarker);
                                    objMap.panTo(arrMarkers[j].getPosition());
                                }
                            }
                        }
                    }
                    return false;
                }

                function PointClicked(argobjPointMarker) {
                    var listMarkersLength = arrMarkers.length;
                    for (var j = 0; j < listMarkersLength; j++) {
                        arrMarkers[j].setIcon(imgRedMarker);
                    }
                    var MarkerLatitude = argobjPointMarker.position.lat();
                    var MarkerLongitude = argobjPointMarker.position.lng();
                    var lstPoints = document.getElementById('lstPoints');
                    var listLength = lstPoints.options.length;
                    for (var i = 0; i < listLength; i++) {
                        var PointValue = MarkerLatitude + ';' + MarkerLongitude
                        if (lstPoints.options[i].value == PointValue) {
                            lstPoints.options[i].selected = true;
                            argobjPointMarker.setIcon(imgBlueMarker);
                        }
                    }
                }

              
                function LengthUOMChanged(sender, eventArgs) {
                    var item = eventArgs.get_item();
                    LengthUOMId = item.get_value();
                    RecalculateLengthArea();
                }

                function AreaUOMChanged(sender, eventArgs) {
                    var item = eventArgs.get_item();
                    AreaUOMId = item.get_value();
                    RecalculateLengthArea();
                }

                function RecalculateLengthArea() {
                    var arrPointsLength = arrPoints.length;
                    arrPolylinePath = [];
                    for (var i = 0; i < arrPointsLength; i++) {
                        arrPolylinePath.push(new google.maps.LatLng(arrPoints[i].LATITUDE, arrPoints[i].LOGITUDE))
                    }
                    var LengthUnitMultipliyer = 1; var AreaUnitMultipliyer = 1;
                    if (LengthUOMId == 1) LengthUnitMultipliyer = 1;
                    if (LengthUOMId == 2) LengthUnitMultipliyer = 3.28084;
                    if (LengthUOMId == 3) LengthUnitMultipliyer = 0.000621371;

                    if (AreaUOMId == 1) AreaUnitMultipliyer = 1;
                    if (AreaUOMId == 2) AreaUnitMultipliyer = 10.7639;
                    if (AreaUOMId == 3) AreaUnitMultipliyer = 0.0001;
                    if (AreaUOMId == 4) AreaUnitMultipliyer = 0.000247105;

                    //Calculate Length
                    $("input[id$=txtLengthPoints]").val(google.maps.geometry.spherical.computeLength(arrPolylinePath) * LengthUnitMultipliyer);
                    $("input[id$=txtAreaPoints]").val(google.maps.geometry.spherical.computeArea(arrPolylinePath) * AreaUnitMultipliyer);
                }

                function DisplayPMWebFeaturesClicked() {
                    DisplayPMWebFeatures = $("input[id$=chkDisplayPMWebFeatures]")[0].checked;
                    DrawPolyline();
                }

                function UpdateRecordClicked() {
                    UpdateRecord = $("input[id$=chkUpdateRecord1]")[0].checked;
                }

                function RefreshComponentGrid() {
                    if (PickerSender == 'Component') {
                        var btnRefreshId = window.parent.document.getElementById('ctl00_ctl00_CPH1_ACPH1_AssetComponents1_rdgEquComponents_ctl00_ctl02_ctl00_btnRefresh');
                        if (btnRefreshId) {
                            btnRefreshId.click();
                        }
                    }
                }
                var forceMoreMenuToClose = true;
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
                function MoreMenuClicked(sender, args) {
                    if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                        sender.close(true);

                        if (args.get_item().get_value() == "InactiveLinear") {
                            var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                            var button = mainToolBar.findButtonByCommandName("LinearDefinitionActivation");
                            button.click();
                        }
                        if (args.get_item().get_value() == "ActiveLinear") {
                            var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                            var button = mainToolBar.findButtonByCommandName("LinearDefinitionActivation");
                            button.click();
                        }
                        if (args.get_item().get_value() == "ActiveDisplayFeatures") {
                            var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                            var button = mainToolBar.findButtonByCommandName("DisplayPmwebFeaturesActivation");
                            button.click();
                        }
                        if (args.get_item().get_value() == "InactiveDisplayFeatures") {
                            var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                            var button = mainToolBar.findButtonByCommandName("DisplayPmwebFeaturesActivation");
                            button.click();
                        }
                        ToolBar_Clicking(args.get_item().get_value())
                    }
                }

            </script>

        </telerik:RadCodeBlock>
       
        <asp:ScriptManager ID="PMScriptManager" runat="server" EnablePageMethods="true">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager2" runat="server"
            DefaultLoadingPanelID="ldpPM">
            <AjaxSettings>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpMaps" runat="server" Skin="Default" />
        <div id="ProfileTitle" class="ProfileTitle" runat="server" visible="false">

            <asp:Label runat="server" ID="TitleUser"></asp:Label>
            <asp:LinkButton runat="server" CssClass="closepopup closesize" ID="btnCloseProfilePopup" OnClientClick="window.close()">
        <div class="CloseProfilePopup closesize">
                                                                                 &nbsp;
                                                                            </div></asp:LinkButton>
        </div>
        <table style="width: 100%" cellpadding="0" cellspacing="0" id="ToolBar" class="ToolBar" runat="server">
            <tr >
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" Width="100%" runat="server" Skin="Default" OnClientButtonClicking="ToolBar_Clicking"
                        AutoPostBack="true" CssClass="small-toolbar">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" Value="Save" AccessKey="s"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit" Value="SaveAndExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Close" EnableImageSprite="true" CssClass="ToolbarCancel"
                                Value="Close">
                            </telerik:RadToolBarButton>


                            <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                                <ItemTemplate>
                                    <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked"
                                        OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                        <Items>
                                            <telerik:RadMenuItem CssClass="menuMore">
                                                <Items>

                                                    <telerik:RadMenuItem EnableImageSprite="true" Text="ActiveLinear" Value="ActiveLinear"></telerik:RadMenuItem>
                                                    <telerik:RadMenuItem EnableImageSprite="true" Text="InactiveLinear" Value="InactiveLinear"></telerik:RadMenuItem>
                                                    <telerik:RadMenuItem EnableImageSprite="true" Text="ActiveDisplayFeatures" Value="ActiveDisplayFeatures"></telerik:RadMenuItem>
                                                    <telerik:RadMenuItem EnableImageSprite="true" Text="InactiveDisplayFeatures" Value="InactiveDisplayFeatures"></telerik:RadMenuItem>

                                                </Items>
                                            </telerik:RadMenuItem>
                                        </Items>
                                    </telerik:RadMenu>
                                </ItemTemplate>
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/Active.png" PostBack="false"
                                Value="ActivateLinear" CommandName="LinearDefinitionActivation" ToolTip="Activate" Text="Update Linear Definition" Style="text-transform: uppercase;" OuterCssClass="HideOnMobileToolbar">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/Active.png" PostBack="false" OuterCssClass="HideOnMobileToolbar"
                                Value="DisplayPmwebFeatures" CommandName="DisplayPmwebFeaturesActivation" ToolTip="Activate" CheckOnClick="true" Text="Display Pmweb Features" Style="text-transform: uppercase;">
                            </telerik:RadToolBarButton>
                        </Items>

                    </telerik:RadToolBar>
                </td>
                <%-- <td>
                    <asp:CheckBox ID="chkUpdateRecord1" runat="server" Text="UpdateRecord1" meta:resourcekey="chkUpdateRecord1" onclick="UpdateRecordClicked()" />

                </td>
     
               -- <td>
                    <asp:CheckBox ID="chkDisplayPMWebFeatures" runat="server" Text="DisplayPMWebFeatures1" meta:resourcekey="chkDisplayPMWebFeatures" onclick="DisplayPMWebFeaturesClicked()" />
                </td>--%>
            </tr>
        </table>

        <telerik:RadTabStrip ID="tbsDocument" AutoPostBack="true" CssClass="documentTabs fullWidth"
            runat="server" MultiPageID="mlpMaps" Skin="Default" Width="100%"
            CausesValidation="False">
            <Tabs>
                <telerik:RadTab Value="Address" meta:resourcekey="RdTAddress" Text="Address11" PageViewID="pvAddress"/>
                <telerik:RadTab Value="Linear" meta:resourcekey="RdTLinear" Text="Linear11" PageViewID="pvLinear"/>
            </Tabs>
        </telerik:RadTabStrip>


        <telerik:RadMultiPage ID="mlpMaps" runat="server" CssClass="GooglAddressMultipage"
            Width="100%" RenderSelectedPageOnly="True">

            <telerik:RadPageView ID="pvAddress" runat="server">
                <div class="PMMainPage PMPopupMainPage">
                    <div class="row">
                        <div class="col-12">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth" style="width:160px !important">
                                        <div style="float: left">
                                            <asp:Label ID="lblMapCenter" runat="server" Text="MapCenter11" meta:Resourcekey="lblMapCenter"></asp:Label>
                                        </div>
                                        <div style="float: right;padding-right:10px">
                                            <asp:LinkButton ID="btnGoogleAddresse" runat="server" CausesValidation="False" OnClientClick="javascript:return UpdateGoogleAddress();" CssClass="GoogleAddressUpdateButton"> 
                                                        <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtGoogleAddress" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLatitude" runat="server" Text="Latitude11" meta:Resourcekey="lblLatitude"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtlatitude" runat="server" CssClass="Longtitude"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLongitude" runat="server" Text="Longitude11" meta:Resourcekey="lblLongitude"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtLongitude" runat="server" CssClass="Longtitude"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblElevation" runat="server" Text="Elevation11" meta:Resourcekey="lblElevation"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtElevation" runat="server" CssClass="Longtitude"></asp:TextBox>
                                    </td>
                                </tr>
                                 <tr>
                                    <td colspan="2" valign="top">
                                            <div id="map_canvas" style="width: 100%; height: 475px"></div>
                                    </td>
                                </tr>
                                                    
                            </table>
                        </div>
                    </div>
                </div>
            </telerik:RadPageView>

            <telerik:RadPageView ID="pvLinear" runat="server">
                <div class="PMMainPage JustifyContent" style ="padding-top:24px;">
                    <div class="row row-8-4-fit8">
                       <div class="col-8">
                                    <table class="colTable">
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="Label1" runat="server" Text="MapCenter11" meta:Resourcekey="lblMapCenter"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <div style="display:flex">
                                                    <div style="float: left; width:100%">
                                                        <asp:TextBox ID="txtGoogleAddress1" runat="server"></asp:TextBox>
                                                    </div>
                                                    <div style="float: right; padding-left:24px">
                                                        <asp:LinkButton ID="btnGoogleLinear" runat="server" CausesValidation="False" OnClientClick="javascript:return UpdateGoogleAddress();" CssClass="GoogleAddressUpdateButton"> 
                                                                <span class="Icon"></span>
                                                        </asp:LinkButton>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                               
                                    </table>
                                    <div id="map_canvas1" style="width: 100%; height: 475px"></div>
                                </div>
                       <div class="col-4">
                                    <table class="colTable">
                                        <tr>
                                            <td width="100%">
                                                <table width="100%" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td width="33%">
                                                            <asp:Label ID="lblLatitude1" runat="server" Text="Latitude" meta:Resourcekey="Latitude11"></asp:Label>
                                                        </td>
                                                        <td width="33%">
                                                            <asp:Label ID="lblLongitude1" runat="server" Text="Longitude11" meta:Resourcekey="lblLongitude"></asp:Label>
                                                        </td>
                                                        <td width="33%">
                                                            <asp:Label ID="lblElevation1" runat="server" Text="Elevation11" meta:Resourcekey="lblElevation"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 33%; padding-right: 16px;">
                                                            <asp:TextBox ID="txtlatitude1" runat="server"></asp:TextBox>
                                                        </td>
                                                        <td style="width: 33%; padding-right: 16px;">
                                                            <asp:TextBox ID="txtLongitude1" runat="server"></asp:TextBox>
                                                        </td>
                                                        <td style="width: 33%;">
                                                            <asp:TextBox ID="txtElevation1" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <%--      <tr>
                                        <td class="labelWidth">
                                        </td>
                                        <td class="controlWidth">
                                   
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                        </td>
                                        <td class="controlWidth">
                                    
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                        </td>
                                        <td class="controlWidth">
                                   
                                        </td>
                                    </tr>--%>
                                        <tr>
                                            <td colspan="4" class="controlWidth">
                                                <asp:Button ID="btnAddPoint" runat="server" Text="SAVE THIS POINT" meta:Resourcekey="btnAddPoint" Style="width: 100%; text-decoration: none !important;" OnClientClick="return AddPoint();" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" class="controlWidth">
                                                <asp:ListBox ID="lstPoints" runat="server" CssClass="GoogleMapPointsList" Height="200px" Width="400px" onchange="return SetSelectedMarker();"></asp:ListBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="100%">
                                                <table width="100%" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td width="48%">
                                                            <asp:Button ID="btnDeleteSelected" runat="server" Text="SELECT ALL" Style="text-decoration: none !important" meta:Resourcekey="btnDeleteSelected" OnClientClick="return DeleteSelectedPoint(false);" />

                                                        </td>
                                                        <td width="48%" style="padding-left:4px;">
                                                            <asp:Button ID="btnDeleteAll" runat="server" Text="DELETE SELECTED" meta:Resourcekey="btnDeleteAll" Style="text-decoration: none !important" OnClientClick="return DeleteSelectedPoint(true);" />

                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                    <table class="colTable">
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblLengthPoints" runat="server" Text="Length1" meta:Resourcekey="lblLengthPoints"></asp:Label>
                                            </td>
                                            <td class="controlwidth">
                                                <asp:TextBox ID="txtLengthPoints" runat="server" ReadOnly="true" CssClass="Decimal" Style="background-color: #EDEDED;"></asp:TextBox>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="LabelWidth">
                                                <asp:Label ID="lblLengthUOM" runat="server" Text="Length UOM"></asp:Label>
                                            </td>
                                            <td class="controlwidth">
                                                <telerik:RadComboBox ID="ddlLengthUOM" runat="server" Width="100%" AutoPostBack="false" OnClientSelectedIndexChanged="LengthUOMChanged">
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblAreaPoints" runat="server" Text="Area1" meta:Resourcekey="lblAreaPoints"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtAreaPoints" runat="server" ReadOnly="true" CssClass="Decimal" Style="background-color: #EDEDED;"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="AreaUOM" runat="server" Text="Area UOM"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox ID="ddlAreaUOM" runat="server" AutoPostBack="false" OnClientSelectedIndexChanged="AreaUOMChanged">
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" style="display: none">
                                                <asp:Label ID="lblInstruction1" runat="server" Text="lblInstruction1" meta:resourcekey="lblInstruction1"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" style="display: none">
                                                <asp:Label ID="lblInstruction2" runat="server" Text="lblInstruction2" meta:resourcekey="lblInstruction2"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                     </div>
                </div>
            </telerik:RadPageView>

        </telerik:RadMultiPage>
        <asp:PlaceHolder ID="plcPoints" runat="server"></asp:PlaceHolder>
    </form>
</body>
</html>
