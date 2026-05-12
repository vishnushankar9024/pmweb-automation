///////////////////////////////////////////////////////////////////////////////
// Autodesk.ADN.Viewing.Extension.Viewables
// by Nem, May 2015
//
///////////////////////////////////////////////////////////////////////////////
AutodeskNamespace("Autodesk.ADN.Viewing.Extension");

Autodesk.ADN.Viewing.Extension.Viewables = function (viewer, options) {

  Autodesk.Viewing.Extension.call(this, viewer, options);

  var _panelBaseId = newGUID();

  var _viewer = viewer;

  var _panel = null;

  var _this = this;

  ///////////////////////////////////////////////////////// 
  // load callback
  //
  //////////////////////////////////////////////////////////
  _this.load = function () {

      var viewableItems = Autodesk.Viewing.Document.getSubItemsWithProperties(objDoc.getRootItem(), {
          'type': 'geometry'
      }, true);

      if (viewableItems.length <= 1)
          return true;

    _panel = new Autodesk.ADN.Viewing.Extension.Viewables.Panel(
      _viewer.container,
      _panelBaseId);

    // creates controls if specified in
    // options: {createControls: true}
    if(options && options.createControls) {

      var ctrlGroup = getControlGroup();

      createControls(ctrlGroup);
    }
    else {

      _panel.setVisible(true);
    }

    console.log('Autodesk.ADN.Viewing.Extension.Viewables loaded');

    return true;
  };

  /////////////////////////////////////////////////////////
  // unload callback
  //
  /////////////////////////////////////////////////////////
  _this.unload = function () {

    if (_panel == undefined)
          return true;

    _panel.setVisible(false);

    // remove controls if created
    if(options && options.createControls) {

      try {

        var toolbar = viewer.getToolbar(true);

        toolbar.removeControl(
          'Autodesk.ADN.Viewables.ControlGroup');
      }
      catch (ex) {

        $('#divViewablesToolbar').remove();
      }
    }

    console.log('Autodesk.ADN.Viewing.Extension.Viewables unloaded');

    return true;
  };

  /////////////////////////////////////////////////////////
  // return control group or create if doesn't exist
  //
  /////////////////////////////////////////////////////////
  function getControlGroup() {

    var toolbar = null;

    try {
      toolbar = viewer.getToolbar(true);

      if(!toolbar) {
        toolbar = createDivToolbar();
      }
    }
    catch (ex) {
      toolbar = createDivToolbar();
    }

    var control = toolbar.getControl(
      'Autodesk.ADN.Viewables.ControlGroup');

    if(!control) {

      control = new Autodesk.Viewing.UI.ControlGroup(
        'Autodesk.ADN.Viewables.ControlGroup');

      toolbar.addControl(control);
    }

    return control;
  }

  /////////////////////////////////////////////////////////
  // create a div toolbar when Viewer3D used
  //
  /////////////////////////////////////////////////////////
  function createDivToolbar() {

    var toolbarDivHtml =
      '<div id="divViewablesToolbar"> </div>';

    $(viewer.container).append(toolbarDivHtml);

    $('#divViewablesToolbar').css({
      'bottom': '0%',
      'left': '50%',
      'z-index': '100',
      'position': 'absolute'
    });

    var toolbar = new Autodesk.Viewing.UI.ToolBar(true);

    $('#divViewablesToolbar')[0].appendChild(
      toolbar.container);

    return toolbar;
  }

  /////////////////////////////////////////////////////////
  // creates controls for the extension
  //
  /////////////////////////////////////////////////////////
  function createControls(parentGroup) {

    var btn = createButton(
      'Autodesk.ADN.Viewables.Button',
      'EyeButton',
      'Viewables',
      onShowPanelClicked);

    parentGroup.addControl(btn);
  }

  /////////////////////////////////////////////////////////
  // show panel handler
  //
  /////////////////////////////////////////////////////////
  function onShowPanelClicked() {

    _panel.setVisible(true);
  }

  /////////////////////////////////////////////////////////
  // create button util
  //
  /////////////////////////////////////////////////////////
  function createButton(id, className, tooltip, handler) {

      var button = new Autodesk.Viewing.UI.Button(id);
      //button.addClass(className);
      button.icon.className = className;
      button.icon.style.fontSize = "24px";
      button.setToolTip(tooltip);

      button.onClick = handler;

    return button;
  }

  /////////////////////////////////////////////////////////
  // new GUID util
  //
  /////////////////////////////////////////////////////////
  function newGUID() {

    var d = new Date().getTime();

    var guid = 'xxxx-xxxx-xxxx-xxxx-xxxx'.replace(
      /[xy]/g,
      function (c) {
        var r = (d + Math.random() * 16) % 16 | 0;
        d = Math.floor(d / 16);
        return (c == 'x' ? r : (r & 0x7 | 0x8)).toString(16);
      });

    return guid;
  };

  /////////////////////////////////////////////////////////
  // Panel implementation
  //
  /////////////////////////////////////////////////////////
  Autodesk.ADN.Viewing.Extension.Viewables.Panel = function(
    parentContainer,
    baseId)
  {
    this.content = document.createElement('div');

    this.content.id = baseId + 'PanelContentId';
    this.content.className = 'viewables-panel-content';

    Autodesk.Viewing.UI.DockingPanel.call(
      this,
      parentContainer,
      baseId,
      "Viewables",
      {shadow:true});

    this.container.style.right = "0px";
    this.container.style.top = "0px";

    this.container.style.width = "170px";
    this.container.style.height = "500px";

    this.container.style.resize = "auto";
  
    var html = [
      '<div class="viewables-panel-container">',
        '<div id="' + baseId + 'PanelContainerId" class="list-group viewables-panel-list-container">',
        '</div>',
      '</div>'
    ].join('\n');

    $('#' + baseId + 'PanelContentId').html(html);

    var viewables2 = Autodesk.Viewing.Document.getSubItemsWithProperties(objDoc.getRootItem(), {
        'type': 'geometry'
    }, true);

    for (var i = 0; i < viewables2.length; i++) {
        addView(viewables2[i], i);
    }
    ///////////////////////////////////////////////////////
    // Adds a new Viewable item
    //
    ///////////////////////////////////////////////////////
    function addView(objView,indx) {

      var item = {
          id: newGUID(),
          AttachBtnId: newGUID(),
          View: objView,
          itemIndx: indx
      }

      var html = [

        '<div class="list-group-item viewables-panel-item" id="' + item.id + '">',
             '<button class="btn btn-success" id="' + item.AttachBtnId + '" style="font-size:11px; width:85px">',
              '' + objView.name + '',
            '</button>',
        '</div>'

      ].join('\n');

      $('#' + baseId + 'PanelContainerId').append(html);

      $('#' + item.AttachBtnId).click(function () {
          UpdateViewerState(objViewableIndx, JSON.stringify(viewer.getState()));
          loadView(item.itemIndx);
          return false;


          //CreateAttachment(blobUrl, item.AttachBtnId);
          //return false;
          // The URL.revokeObjectURL() static method releases
          // an existing object URL which was previously
          // created by calling window.URL.createObjectURL().
          // Call this method when you've finished using
          // a object URL, in order to let the browser know
          // it doesn't need to keep the reference to the file any longer.
          // window.URL.revokeObjectURL(blobUrl);
      });

    }

  };



  Autodesk.ADN.Viewing.Extension.Viewables.Panel.prototype = Object.create(
    Autodesk.Viewing.UI.DockingPanel.prototype);

  Autodesk.ADN.Viewing.Extension.Viewables.Panel.prototype.constructor =
    Autodesk.ADN.Viewing.Extension.Viewables.Panel;

  Autodesk.ADN.Viewing.Extension.Viewables.Panel.prototype.initialize = function()
  {
    // Override DockingPanel initialize() to:
    // - create a standard title bar
    // - click anywhere on the panel to move

    this.title = this.createTitleBar(
      this.titleLabel ||
      this.container.id);

    this.closer = this.createCloseButton();

    this.container.appendChild(this.title);
    this.title.appendChild(this.closer);
    this.container.appendChild(this.content);

    this.initializeMoveHandlers(this.title);
    this.initializeCloseHandler(this.closer);
  };

  var css = [
  
    'div.viewables-panel-content {',
      'height: calc(100% - 40px);',
    '}',
  
    'div.viewables-panel-container {',
      'height: calc(100% - 40px);',
      'margin: 10px;',
    '}',
  
    'div.viewables-panel-controls-container {',
      'margin-bottom: 10px;',
    '}',
  
    'div.viewables-panel-list-container {',
      'height: calc(100% - 40px);',
      'overflow-y: auto;',
    '}',
  
    'div.viewables-panel-item {',
      'margin-left: 0;',
      'margin-right: 0;',
      'color: #FFFFFF;',
      'background-color: #3F4244;',
      'margin-bottom: 5px;',
      'border-radius: 4px;',
    '}',
  
    'div.viewables-panel-item:hover {',
      //'background-color: #5BC0DE;',
    '}',
  
    'label.viewables-panel-label {',
      'color: #FFFFFF;',
    '}',
  
    'input.viewables-panel-input {',
      'height: 30px;',
      'width: 75px;',
      'border-radius: 5px;',
    '}'

  ].join('\n');

  ///////////////////////////////////////////////////////
  // Checks if css is loaded
  //
  ///////////////////////////////////////////////////////
  function isCssLoaded(name) {

    for(var i=0; i < document.styleSheets.length; ++i){

      var styleSheet = document.styleSheets[i];

      if(styleSheet.href && styleSheet.href.indexOf(name) > -1)
        return true;
    };

    return false;
  }

  // loads bootstrap css if needed
  if (!isCssLoaded("3DViewer.css") && !isCssLoaded("3DViewer.min.css")) {
      $('<link rel="stylesheet" type="text/css" href="Css/3DViewer.css"/>').appendTo('head');
      //if (location.protocol == 'http:')

      //else
      //    $('<link rel="stylesheet" type="text/css" href="https://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.css"/>').appendTo('head');
  }


  $('<style type="text/css">' + css + '</style>').appendTo('head');
};

Autodesk.ADN.Viewing.Extension.Viewables.prototype =
  Object.create(Autodesk.Viewing.Extension.prototype);

Autodesk.ADN.Viewing.Extension.Viewables.prototype.constructor =
  Autodesk.ADN.Viewing.Extension.Viewables;

Autodesk.Viewing.theExtensionManager.registerExtension(
  'Autodesk.ADN.Viewing.Extension.Viewables',
  Autodesk.ADN.Viewing.Extension.Viewables);

