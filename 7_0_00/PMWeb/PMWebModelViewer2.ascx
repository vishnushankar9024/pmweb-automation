<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="PMWebModelViewer2.ascx.vb" Inherits="Website.PMWebModelViewer2" %>
  <link rel="stylesheet" href="https://developer.api.autodesk.com/modelderivative/v2/viewers/2.*/style.min.css" type="text/css"/>
  <script src="https://developer.api.autodesk.com/modelderivative/v2/viewers/2.*/three.min.js"></script>
  <script src="https://developer.api.autodesk.com/viewingservice/v1/viewers/wgs.min.js"></script>
    <script src="https://developer.api.autodesk.com/modelderivative/v2/viewers/2.*/viewer3D.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/require.js/2.3.3/require.min.js"></script>
   <script src="JS/3DViewer/Autodesk.ADN.Viewing.Extension.ScreenShotManager.js"></script>
   <script src="JS/3DViewer/Autodesk.ADN.Viewing.Extension.Viewables.js"></script>

<script type="text/javascript">
    var viewer = null;
    var tmpToken = null;
    var urn = '';
    var viewerState = [];
    var objDoc = null;
    var objViewables = null;
    var objViewableIndx = null;


    function UpdateViewerState(argViewableIndx, argViewableState) {
        var blnFound = 0;
        for (var i = 0; i < viewerState.length; i++) {
            if (viewerState[i].ViewableIndx == objViewableIndx) {
                blnFound = 1;
                viewerState[i].ViewableState = JSON.stringify(viewer.getState());
            }
        }
        if (blnFound == 0) viewerState.push({'ViewableIndx': argViewableIndx, 'ViewableState': argViewableState });
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



    function GetSavedViewableState() {
        for (var i = 0; i < viewerState.length; i++) {
            if (viewerState[i].ViewableIndx == objViewableIndx) {
                return JSON.parse(viewerState[i].ViewableState);
            }
        }
        return null;
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

    function onDocFileUploaded(sender, args) {
            var btnFileUploaded = $("[id$=btnFileUploaded]");
            btnFileUploaded.click();
            setTimeout(function () {
                sender.deleteAllFileInputs();
            }, 10);
    }

    function addedDocFile(sender, args) {
        if (document.getElementById('lblUploadOption')) {
            if (Telerik.Web.UI.RadAsyncUpload.Modules.FileApi.isAvailable()) {
                $("#lblUploadOption").html(lblViewerUploadOptionChFFText);
            } else {
                var tdUploadOption = $("[id$=tdUploadOption]");
                tdUploadOption[0].style.display = 'none';
            }
            var senderelement = sender.get_element();
            var inputs = senderelement.getElementsByTagName("span");
            for (var i = 0; i < inputs.length; i++) {
                var input = inputs[i]
                if (input.className == "ruButton ruBrowse") {
                    if (Telerik.Web.UI.RadAsyncUpload.Modules.FileApi.isAvailable()) {
                        $(input).html(lblViewerBrowseIEText)
                    } else {
                        $(input).html(lblBrowseIEText)
                    }
                }
            }
        }
    }

    function ClientDocFileValidationFailed(sender, args) {
        alert(WarningMsg_InvalidFile);
    }

      
    </script>
<style type="text/css">
    .ModelViewerPopup span.rtbIcon {
        padding: 0;
        width: 16px;
        height: 16px;
    }
    .ToolbarSaveAsDefault .rtbIcon{
    background-position:-336px;
}
    .ToolbarChange3DFile .rtbIcon{background-position:-1568px 0px !important} 
    .ToolbarChange3DFile .rtbIcon{background-position:-1568px 0px !important} 
    .ToolbarChange2DImage .rtbIcon{background-position:-1120px 0px }
    .ToolbarViewer3DTakeSnapshot .rtbIcon {background-position:-1344px 0px !important}
    .ModelViewerPopup .ToolbarRefresh .rtbIcon {background-position:-640px 0px !important}
    .RadUpload .ruInputs li {margin-top:0 !important}
</style>


    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
          <script>
              function ModelViewerToolbar_click_handler(sender, args) {
                  var CurrentGUID = sender._element.getAttribute('GUID');
                  switch (args.get_item().get_commandName()) {
                      case 'ViewModel':
                          OpenModelPOPUpToRedirect('UploadAndViewAutodeskForgefilePopup.aspx?Source=ModelViewer&FileGuid=' + CurrentGUID, 300, 200);
                          break;


                      case 'OpenInPopup':
                          Open3DViewer('<%= Library.PMBIM.BIMModelManagerInfo.OBJECT_TYPE%>', '<%= PM.BIM.BIMModelManagerInfo.Id%>', CurrentGUID);
                      break;

                      case 'Viewer3DTakeSnapshot':
                          //OpenSnapshotCompleteToRefresh('<%= Library.PMBIM.BIMModelManagerInfo.OBJECT_TYPE%>', '<%= PM.BIM.BIMModelManagerInfo.Id%>');
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

              function OpenModelPOPUpToRedirect(URL) {
                  var browserWidth = $telerik.$(window).width();
                  var browserHeight = $telerik.$(window).height();
                  var wnd = window.radopen(URL);
                  wnd.add_close(function () {
                      window.location.href = '<%= Me.GetUrlByObjectType(Library.PMBIM.BIMModelManagerInfo.OBJECT_TYPE, PM.BIM.BIMModelManagerInfo.Id)%>'
                  });
                  if (isMobileScreen()) {
                      wnd.setSize(browserWidth - 10, browserHeight - 10);
                      wnd.moveTo(8, 0);
                  }
                  else {
                      wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                      wnd.Center();
                  }
                  return false;
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
                              , url: "BIMModelManager.aspx?CreateAttachment=1"
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
                          , url: "BIMModelManager.aspx?CreateScreenShot=1"
                          , contentType: false
                          , data: formData
                          , async: false
                         , processData: false
                         , cache: false
                          , success: function (response) {
                              OpenSnapshotCompleteToRefresh('<%= Library.PMBIM.BIMModelManagerInfo.OBJECT_TYPE%>', '<%= PM.BIM.BIMModelManagerInfo.Id%>');
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

              function getViewerState(){
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




    </script>
    </telerik:RadCodeBlock>
<div style="width:100%;overflow:auto;max-width:calc(100vw - 40px)" class="ResponsiveMargin">
<table style="width: 100%" cellpadding="0" cellspacing="0">
    <tr>
        <td>
            <telerik:RadToolBar id="ModelViewerToolbar" runat="server" OnClientButtonClicked="ModelViewerToolbar_click_handler" Width="100%" Height="30px" CssClass="ModelViewerPopup">
                                <Items>
                                <telerik:RadToolBarButton PostBack="false" CommandName="ViewModel" Value="ViewModel" style="margin-left:10px" CssClass="ToolbarViewModel_ON" meta:resourcekey="RadToolBarButton_ViewModel" 
                                                          CausesValidation ="false" EnableImageSprite="true"  Visible="true"/>
                                <telerik:RadToolBarButton PostBack="True" CommandName="Change3DFile" Value="Change3DFile" style="margin-left:10px" CssClass="ToolbarChange3DFile" meta:resourcekey="RadToolBarButton_Change3DFile"
                                                          CausesValidation ="false" EnableImageSprite="true"  Visible="true"/>
                                <telerik:RadToolBarButton PostBack="True" CommandName="Change2DImage" Value="Change2DImage" style="margin-left:10px" CssClass="ToolbarChange2DImage" meta:resourcekey="RadToolBarButton_Change2DImage"
                                                          CausesValidation ="false" EnableImageSprite="true"  Visible="true"/>
                                <telerik:RadToolBarButton PostBack="false" CommandName="Viewer3DTakeSnapshot" Value="Viewer3DTakeSnapshot" style="margin-left:10px" CssClass="ToolbarViewer3DTakeSnapshot" meta:resourcekey="RadToolBarButton_Viewer3DTakeSnapshot" 
                                                          CausesValidation ="false" EnableImageSprite="true"  Visible="true"/>
                                <telerik:RadToolBarButton PostBack="false" CommandName="OpenInPopup" Value="OpenInPopup" style="margin-left:10px" CssClass="ToolbarOpenInPopup" meta:resourcekey="RadToolBarButton_OpenInPopup"
                                                          CausesValidation ="false" EnableImageSprite="true"  Visible="true"/>
                                <telerik:RadToolBarButton PostBack="False" CommandName="Save" Value="Save" style="margin-left:10px" CssClass="ToolbarSaveAsDefault"  meta:resourcekey="RadToolBarButton_Save"
                                                          CausesValidation ="false" EnableImageSprite="true"  Visible="true" />
                                <telerik:RadToolBarButton PostBack="False" CommandName="LoadDefault" Value="LoadDefault" style="margin-left:10px" CssClass="ToolbarRefresh" meta:resourcekey="RadToolBarButton_LoadDefault"
                                                          CausesValidation ="false" EnableImageSprite="true"  Visible="true"/>
                                </Items>
            </telerik:RadToolBar>
        </td>
    </tr>
    <tr id="trViewer3d" runat="server" visible="false">
        <td>
                    <div id="viewer3d" style="width: 1000px; height: 700px; position: relative;">
            </div>

        </td>
    </tr>
    <tr id="tr2DImage" runat="server" visible="false">
        <td>
             <asp:Image runat="server" id="img2D">
            </asp:Image>
        </td>
    </tr>
    <tr id="trSelectFile" runat="server">
        <td>
                <table>
                    <tr  style="vertical-align: top;">
                        <td style="width:500px">
                            <div style="padding-left:20px;padding-top:20px;font-size:17px !important;">
                                 <asp:Label runat="server" id="lblSelectedFile" Text="Selected File:" ></asp:Label>
                            </div>

                            <asp:Panel ID="pnlQuickFileUpload" runat="server">                                   
                            <table border="0">
                                <tr>
                                    <td>
                                        <div id="UploadDropZone" style="padding-left:120px;padding-top:80px;">   
                                        <table border="0" cellpadding="0" cellspacing="7">                                         
                                            <tr>
                                                 <td   id="tdUploadOption" style="padding-top:10px; padding-bottom:10px;text-align:center;color:#fff;background-color:#71b641;width:190px;">                                                  
                                                                  <span id="lblUploadOption" ></span>                                                    
                                                    </td>
                                             </tr>
                                            <tr>
                                                <td>
                                                 <telerik:RadAsyncUpload runat="server"  RenderMode="Native"  CssClass="BigUpload Modelupload" ID="rauModelViewer"
                                                        OnClientAdded="addedDocFile"  HideFileInput="true" OnClientFileUploaded="onDocFileUploaded" style="text-align:center"
                                                        MultipleFileSelection="Disabled"  OnClientValidationFailed="ClientDocFileValidationFailed" DropZones="#UploadDropZone">
                                                    <Localization Select="<%$ Resources:PMWeb, btn_BrowseToUpload %>" />
                                                </telerik:RadAsyncUpload>           
                                                  <asp:Button ID="btnFileUploaded" runat="server" CssClass="Hide"/>
                                                </td>
                                            </tr>
                                             <tr>
                                                <td>
                                                  <asp:Button ID="btnCancel" runat="server" meta:resourcekey="btnCancel" CssClass="CancelUploadButton"/>
                                                </td>
                                            </tr>
                                        </table>
                                      </div>
                                    </td>    
                                </tr>

                            </table>
                                  
                        </asp:Panel>
                        </td>
                        <td style="width:392px;">
                            <img src="~/Images/Global/PMWeb3D.png" alt="PMWeb" height="316" width ="392"  runat="server"/>
                        </td>
                    </tr>
                </table>
        </td>
    </tr>
</table>
    </div>
<asp:placeholder ID="plcScript" runat="server"></asp:placeholder>