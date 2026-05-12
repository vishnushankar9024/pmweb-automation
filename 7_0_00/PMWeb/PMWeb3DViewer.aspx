<%@ Page Language="vb" AutoEventWireup="false" meta:resourcekey="Page" CodeBehind="PMWeb3DViewer.aspx.vb" Inherits="Website.PMWeb3DViewer" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://developer.api.autodesk.com/modelderivative/v2/viewers/2.*/style.min.css" type="text/css" />
    <script src="https://developer.api.autodesk.com/modelderivative/v2/viewers/2.*/three.min.js"></script>
    <script src="https://developer.api.autodesk.com/viewingservice/v1/viewers/wgs.min.js"></script>
    <script src="https://developer.api.autodesk.com/modelderivative/v2/viewers/2.*/viewer3D.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/require.js/2.3.3/require.min.js"></script>
    <script src="JS/3DViewer/Autodesk.ADN.Viewing.Extension.ScreenShotManager.js"></script>
    <script src="JS/3DViewer/Autodesk.ADN.Viewing.Extension.Viewables.js"></script>
    <style type="text/css">
        .popup-toolbar .ToolbarRefreshBtn .rtbIcon {
            background-position: -960px 0px !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">



        <script type="text/javascript">
            var viewer = null;
            var tmpToken = null;
            var urn = '';
            var viewerState = [];
            var objDoc = null;
            var objViewables = null;
            var objViewableIndx = null;



            if (urn.indexOf('urn:') !== 0)
                urn = 'urn:' + urn;

            function initialize() {
                if (urn == '') { return false; }

                if (urn.indexOf('urn:') !== 0)
                    urn = 'urn:' + urn;

                var options = {
                    env: "AutodeskProduction",
                    accessToken: tmpToken
                }
                Autodesk.Viewing.Initializer(options, function () {
                    Autodesk.Viewing.Document.load(urn, onDocumentLoadSuccess, onDocumentLoadFailure);
                });
            }

            function onDocumentLoadSuccess(doc) {
                // A document contains references to 3D and 2D viewables.
                var viewables = Autodesk.Viewing.Document.getSubItemsWithProperties(doc.getRootItem(), {
                    'type': 'geometry'
                }, true);
                if (viewables.length === 0) {
                    console.error('Document contains no viewables.');
                    return;
                }
                objViewables = viewables;
                objDoc = doc;
                loadView(0)
            }

            function loadView(argIndx) {
                objViewableIndx = argIndx;
                var initialViewable = objViewables[objViewableIndx];
                var svfUrl = objDoc.getViewablePath(initialViewable);
                var modelOptions = {
                    sharedPropertyDbPath: objDoc.getPropertyDbPath()
                };
                var viewerDiv = document.getElementById('viewer3d');
                viewer = new Autodesk.Viewing.Private.GuiViewer3D(viewerDiv);
                viewer.start(svfUrl, modelOptions, onLoadModelSuccess, onLoadModelError);
                viewer.impl.setLightPreset(8);
                viewer.setOptimizeNavigation(true);
                viewer.createViewCube();
                viewer.displayViewCube(true);
                viewer.navigation.setZoomTowardsPivot(true);
                viewer.navigation.setReverseZoomDirection(true);
                viewer.addEventListener(Autodesk.Viewing.GEOMETRY_LOADED_EVENT,
                                                      function (event) {
                                                          loadExtensions(viewer);
                                                      });
            }


            function onDocumentLoadFailure(viewerErrorCode) {
                console.error('onDocumentLoadFailure() - errorCode:' + viewerErrorCode);
            }


            function onLoadModelSuccess(model) {
                console.log('onLoadModelSuccess()!');
                console.log('Validate model loaded: ' + (viewer.model === model));
                console.log(model);
            }

            function onLoadModelError(viewerErrorCode) {
                console.error('onLoadModelError() - errorCode:' + viewerErrorCode);
            }

            function GetSavedViewableState() {
                for (var i = 0; i < viewerState.length; i++) {
                    if (viewerState[i].ViewableIndx == objViewableIndx) {
                        return JSON.parse(viewerState[i].ViewableState);
                    }
                }
                return null;
            }

            function UpdateViewerState(argViewableIndx, argViewableState) {
                var blnFound = 0;
                for (var i = 0; i < viewerState.length; i++) {
                    if (viewerState[i].ViewableIndx == objViewableIndx) {
                        blnFound = 1;
                        viewerState[i].ViewableState = JSON.stringify(viewer.getState());
                    }
                }
                if (blnFound == 0) viewerState.push({ 'ViewableIndx': argViewableIndx, 'ViewableState': argViewableState });
            }

            function LoadDefaultViewerState(argViewableIndx, argViewableState) {
                var blnFound = 0;
                for (var i = 0; i < viewerState.length; i++) {
                    if (viewerState[i].ViewableIndx == objViewableIndx) {
                        blnFound = 1;
                        viewerState[i].ViewableState = argViewableState;
                    }
                }
                if (blnFound == 0) viewerState.push({ 'ViewableIndx': argViewableIndx, 'ViewableState': argViewableState });
            }

            function loadExtensions(viewer) {
                viewer.loadExtension('Autodesk.ADN.Viewing.Extension.ScreenShotManager', {
                    createControls: true
                });
                viewer.loadExtension('Autodesk.ADN.Viewing.Extension.Viewables', {
                    createControls: true
                });

                if (GetSavedViewableState() != null) {
                    viewer.restoreState(GetSavedViewableState(), null, true);
                } else {
                    viewer.fitToView();
                    var dimensions = viewer.getDimensions(); //added 1px to width and height in order to force 3D Viewer to refresh. 
                    viewer.impl.resize(dimensions.width + 1, dimensions.height + 1);
                }
            }




        </script>


        <telerik:radcodeblock id="CodeBlock" runat="server">
            <script type="text/javascript">
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

                function click_handler(sender, args) {
                    switch (args.get_item().get_commandName()) {
                        case 'TakeSnapshot':
                            //OpenSnapshotComplete(querySt('ObjectType'), querySt('ObjectId'));
                            viewer.getScreenShot(
                                                 0,
                                                 0,
                                                 function (newBlobURL) {
                                                     ModelViewerAddShotItem(newBlobURL);
                                                 });
                            break;
                        case 'Save':
                            SaveViewerState();
                            break;
                        case 'LoadDefault':
                            getViewerState();
                            break;
                        default:
                            break;
                    }
                }

                function CreateAttachment(blobimgUrl, AttachBtnId) {
                    $('#' + AttachBtnId).attr("disabled", true);
                    var oReq = new XMLHttpRequest();
                    oReq.open("GET", blobimgUrl, true);
                    oReq.responseType = "blob";
                    oReq.onload = function (oEvent) {
                        var arrayBuffer = oReq.response; // Note: not oReq.responseText
                        if (arrayBuffer) {
                            var formData = new FormData();
                            formData.append('fileid', blobimgUrl);
                            formData.append('data', arrayBuffer);
                            $.ajax({
                                type: "POST"
                                , url: "PMWeb3DViewer.aspx?CreateAttachment=1"
                                , contentType: false
                                //, contentType: 'x-wwww-form-urlencoded'
                                // , data: "{'blobObject':" + formData + ",'fileid': '" + blobimgUrl + "'}"
                                , data: formData
                                //, dataType: "json"
                              , async: false
                               , processData: false
                               , cache: false
                                , success: function (response) {
                                    $('#' + AttachBtnId).removeAttr("disabled");
                                    alert('Successfully Attached!');
                                }
                                , error: function (response) {
                                    $('#' + AttachBtnId).removeAttr("disabled");
                                }
                            });
                        }
                    };
                    oReq.send(null);
                }



                function ModelViewerAddShotItem(blobimgUrl) {
                    var oReq = new XMLHttpRequest();
                    oReq.open("GET", blobimgUrl, true);
                    oReq.responseType = "blob";
                    oReq.onload = function (oEvent) {
                        var arrayBuffer = oReq.response; // Note: not oReq.responseText
                        if (arrayBuffer) {
                            var formData = new FormData();
                            formData.append('fileid', blobimgUrl);
                            formData.append('data', arrayBuffer);
                            $.ajax({
                                type: "POST"
                                , url: "PMWeb3DViewer.aspx?CreateScreenShot=1"
                                , contentType: false
                                , data: formData
                                , async: false
                               , processData: false
                               , cache: false
                                , success: function (response) {
                                    OpenSnapshotComplete(querySt('ObjectType'), querySt('ObjectId'));
                                }
                            , error: function (response) {
                                alert('Fail!');
                            }
                            });
                        }
                    };
                    oReq.send(null);
                }


                function SaveViewerState() {
                    var objViewerState = JSON.stringify(viewer.getState());
                    UpdateViewerState(objViewableIndx, objViewerState);
                    $.ajax({
                        type: "POST",
                        url: "AjaxService.aspx/SaveViewerState",
                        contentType: "application/json; charset=utf-8",
                        data: "{'ViewableIdx':" + objViewableIndx + ", 'ViewableState':'" + objViewerState + "'}",
                        dataType: "json",
                        success: function (response) {
                        }
                       , error: function (response) {
                       }
                    });
                }

                function getViewerState() {
                    $.ajax({
                        type: "POST",
                        url: "AjaxService.aspx/GetViewablesState",
                        contentType: "application/json; charset=utf-8",
                        data: "{'ViewableIdx':" + objViewableIndx + "}",
                        dataType: "json",
                        success: function (response) {
                            if ((response.d.length) > 0) {
                                LoadDefaultViewerState(objViewableIndx, response.d);
                                initialize();
                            }
                        }
                       , error: function (response) {
                       }
                    });
                }

                function MoreMenuClicked(sender, args) {
                    if (args.get_item().get_value() == "LoadDefault") {
                        var mainToolBar = $find("mainToolBar");
                        var button = mainToolBar.findItemByValue("LoadDefault");
                        button.click();
                    }
                }

            </script>
        </telerik:radcodeblock>

                 <div class="ProfileTitle">
            <asp:Label runat="server" ID="TitleUser" Text=""></asp:Label>
            <asp:LinkButton runat="server" CssClass="closepopup" ID="btnCloseProfilePopup" OnClientClick="window.close();return false;">
        <div class="CloseProfilePopup">
                                                                                 &nbsp;
                                                                            </div></asp:LinkButton>
        </div>

        <table class="ToolBar  NewStylePopupToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:radtoolbar id="mainToolBar" runat="server" autopostback="false" width="100%" cssclass="popup-toolbar">
                                    <Items>
                                        <telerik:RadToolBarButton CommandName="TakeSnapshot" EnableImageSprite="true" CssClass="ToolbarViewer3DTakeSnapshot"
                                            PostBack="false">
                                        </telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton PostBack="False" CommandName="Save" Value="Save" Style="margin-left: 10px" CssClass="ToolbarSave"
                                            EnableImageSprite="true" Visible="true" />
                                        <telerik:RadToolBarButton PostBack="False" CommandName="LoadDefault" OuterCssClass="HideOnMobileToolbar" Value="LoadDefault" Style="margin-left: 10px" CssClass="ToolbarRefreshBtn"
                                            EnableImageSprite="true" Visible="true" />
                                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                                            <ItemTemplate>
                                                <telerik:RadMenu runat="server" CssClass="MoreMenu" ID="MobileRadmen" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked">
                                                    <Items>
                                                        <telerik:RadMenuItem CssClass="menuMore">
                                                            <Items>
                                                                <telerik:RadMenuItem Text="LoadDefault" Value="LoadDefault"></telerik:RadMenuItem>
                                                            </Items>
                                                        </telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenu>
                                            </ItemTemplate>
                                        </telerik:RadToolBarButton>
                                    </Items>
                                </telerik:radtoolbar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>
                    <div class="PMHeader">
                        <div class="row documentSinglePage">
                            <div class="col-12">
                                <table class="colTable" border="0">
                                    <tr>
                                        <td>
                                            <div id="viewer3d" style="height: 600px; position: relative"></div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </table>

        <asp:PlaceHolder ID="plcScript" runat="server"></asp:PlaceHolder>
        <telerik:radwindowmanager id="PMWindowManager" runat="server" skin="Default" visiblestatusbar="False"
            reloadonshow="True" modal="True" keepinscreenbounds="True" behavior="Default"
            iconurl="Images/Global/favicon.ico" initialbehavior="None" left="" style="display: none;"
            top="">
        </telerik:radwindowmanager>
    </form>
</body>
</html>
