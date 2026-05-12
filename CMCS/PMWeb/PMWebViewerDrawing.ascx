<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="PMWebViewerDrawing.ascx.vb" Inherits="Website.PMWebViewerDrawing" %>
<%@ Register Src="SpaceToolTip.ascx" TagName="SpaceToolTip" TagPrefix="uc1" %>

<telerik:RadAjaxManagerProxy ID="Proxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgActions">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgActions" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<%-- <telerik:RadAjaxLoadingPanel ID="ldpPM1" runat="server" />--%>

<asp:PlaceHolder ID="pnlMessages" runat="server"></asp:PlaceHolder>
<link href="CSS/jQueryUI-v1.8.24.css" rel="stylesheet" />
<script src="JS/jQueryUI-v1.8.24.js" type="text/javascript"></script>


<telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">

    <script type="text/javascript">

        imgCanvasId = "ctl00_CPH1_PMWebViewerDrawing1_imgCanvas";

        txtDisMapId = 'ctl00_CPH1_PMWebViewerDrawing1_txtDisMap';
        txtDisGridId = 'ctl00_CPH1_PMWebViewerDrawing1_txtDisGrd';

        undoIndex = 0;
        redoIndex = 1;
        //var tooltipelement;

        //function manualclosehideToolTip(sender, args) {
        //    if (tooltipelement) {
        //        $('#Canvas')[0].removeChild(tooltipelement);
        //        hideToolTip(tooltipelement);
        //        tooltipelement = '';
        //    }
        //}
        function DeleteFromGrid() {
            var grid = $find("<%= rdgActions.ClientID %>");
            if (grid.get_masterTableView().get_selectedItems().length > 0) {
                var selectedrows = grid.get_masterTableView().get_selectedItems();
                for (var i = 0; i < selectedrows.length; i++) {
                    var id = selectedrows[0].getDataKeyValue('Id')
                    var index = arrDrawings.findIndex(x=> x.ID.replace("NOTE_", "") === '11287')
                    arrDrawings.splice(index, 1);
                }
                ReDrawANN();
            }
        }
        function TransformFromGrid() {
            var grid = $find("<%= rdgActions.ClientID %>");
            if (grid.get_masterTableView().get_selectedItems().length > 0) {
                var selectedrow = grid.get_masterTableView().get_selectedItems()[0];
                var selectedId = selectedrow.getDataKeyValue('Id')
                var transformID = arrDrawings.find(x=> x.ID.replace("NOTE_", "") === selectedId).TransformID
                var selectedObj = paper.getById(transformID)
                ObjectDblClicked(selectedObj)
            }
            return false;

        }
        function OnRowSelected() {
            var grid = $find("<%= rdgActions.ClientID %>");
            var selectedCount = grid.get_masterTableView().get_selectedItems().length
            if (selectedCount != 1) {
                grid.Control.getElementsByClassName('GridCmdEditRows')[0].style.display = 'none'
                grid.Control.getElementsByClassName('GridCmdUpdateEdited')[0].style.display = 'none'
            }
            else {
                var selectedrow = grid.get_masterTableView().get_selectedItems()[0];
                var selectedId = selectedrow.getDataKeyValue('Id')
                var transformID = arrDrawings.find(x=> x.ID.replace("NOTE_", "") === selectedId).TransformID
                if (transformID == editedObject && isEdit != '') {
                    grid.Control.getElementsByClassName('GridCmdEditRows')[0].style.display = 'none'
                    grid.Control.getElementsByClassName('GridCmdUpdateEdited')[0].style.display = 'inline';
                    if ($("[id$=rdgActions]").length == 1)
                        ResetGridSettings($("[id$=rdgActions]")[0].id);
                }
                else {
                    grid.Control.getElementsByClassName('GridCmdEditRows')[0].style.display = 'inline'
                    grid.Control.getElementsByClassName('GridCmdUpdateEdited')[0].style.display = 'none'
                    if ($("[id$=rdgActions]").length == 1)
                        ResetGridSettings($("[id$=rdgActions]")[0].id);
                }
            }
            return false;
        }
        function OnRowMouseOver(sender, args) {
            var id = args.getDataKeyValue('Id')
            var transformID = arrDrawings.find(x=> x.ID.replace("NOTE_", "") === id).TransformID
            var hoveredObj = paper.getById(transformID)
            if (hoveredObj)
                hoveredObj.g = hoveredObj.glow({ color: hoveredObj.attrs.stroke })
            return false;
        }
        function OnRowMouseOut(sender, args) {
            var id = args.getDataKeyValue('Id')
            var transformID = arrDrawings.find(x=> x.ID.replace("NOTE_", "") === id).TransformID
            var hoveredObj = paper.getById(transformID)
            if (hoveredObj)
                if (hoveredObj.g != null) { hoveredObj.g.remove() }
            return false;
        }
        function showToolTip(element) {
            var tooltipManager;
            if (element.id.indexOf("SPACE_") == -1) {
                tooltipManager = $find("<%= TextNoteRadToolTipManager.ClientID %>");
            }
            else {
                tooltipManager = $find("<%= RadToolTipManager1.ClientID %>");
            }

            if (!tooltipManager) return;
            tooltip = tooltipManager.getToolTipByElement(element);
            if (!tooltip) {
                tooltip = tooltipManager.createToolTip(element);
                tooltip.set_value(element.id);

                //if (tooltipelement) {
                //    $('#Canvas')[0].removeChild(tooltipelement);
                //    hideToolTip(tooltipelement);
                //}
                var hdnNotes = $("[id$=hdnNotes]")[0];
                hdnNotes.value = element.id;
                tooltipelement = element;
                // tooltip.set_value(element.id.substring(element.id.indexOf("_") + 1, element.id.lastIndexOf("_")));
            }

            element.onclick = null;

            tooltip.show();

            //if (element.id.indexOf("SPACE_") == -1) {
            //    var RadToolTipWrapper2 = document.getElementById('RadToolTipWrapper_' + tooltip._element.id);
            //    RadToolTipWrapper2.style.overflow = "hidden";
            //RadToolTipWrapper2.style.top = element.style.top;
            //RadToolTipWrapper2.style.left = element.style.left;
            //}


        }

        function hideToolTip(element) {
            var tooltipManager;
            if (element.id.indexOf("SPACE_") == -1) {
                tooltipManager = $find("<%= TextNoteRadToolTipManager.ClientID %>");
            }
            else {
                tooltipManager = $find("<%= RadToolTipManager1.ClientID %>");
            }
            if (!tooltipManager) return;
            var tooltip = tooltipManager.getToolTipByElement(element);
            if (tooltip) {
                tooltip.hide();
            }
        }


        function EnableToolBarButton(argButtonIndx, argEnable) {
            var mainToolBar = $find("<%=mainToolBar.ClientID %>");
            var ToolBarButton;
            if (argButtonIndx == 0) {
                ToolBarButton = mainToolBar.findButtonByCommandName("Undo");
            }
            else {
                ToolBarButton = mainToolBar.findButtonByCommandName("Redo");
            }
            ToolBarButton.set_enabled(argEnable);
        }


        function RadToolbarLoad(sender, eventArgs) {
            objToolBar = sender;
            /***/
            if (drawingsCateg == 'MSR') {
                sender.get_items().getItem(4).set_enabled(false);

                if (scaleSetup == true) {
                    sender.get_items().getItem(4).set_enabled(false);
                    sender.get_items().getItem(0).set_enabled(false);
                    sender.get_items().getItem(1).set_enabled(true);
                    sender.get_items().getItem(2).set_enabled(false);
                    sender.get_items().getItem(3).set_enabled(false);
                }
            }
        }



        function StampLoad(sender, eventArgs) {
            if (drawingsCateg == 'MSR') {
                for (var i = 0; i < sender.get_allItems().length; i++) {
                    sender.get_allItems()[i].disable();
                }
            } else {
                for (var i = 0; i < sender.get_allItems().length; i++) {
                    sender.get_allItems()[i].enable();
                }
            }
        }

        function AllCheckClicked(iObj) {

            var i = 0;
            var rdgActions = $("div[id$='rdgActions']");
            var j = 0;
            var k = 0;
            rdgActions.find("input[type='checkbox']").each(function () {
                if (i > 0) {
                    if (!this.disabled && this.id.indexOf("chkVisible") > 0) {
                        if (!this.checked)
                            j = j + 1;
                        if (this.checked)
                            k = k + 1;
                        this.checked = iObj.checked;
                    }

                }
                i++;
            });

            var Value = 0
            if (iObj.checked) {
                Value = Value + j;
            }
            else {
                if ((Value - k) >= 0)
                    Value = Value - k;
            }
            rdgActions.find("input[id$='chkVisible']").each(function () {
                chkActionChange(this);
            });

            ReDrawANN();


        }


        $(document).ready(function () {

            $('.disableRT').bind('contextmenu', function (sender, e) {
                return false;
            })
            var isPinned = '<%=PM.HomeInfo.IsPMWebViewerPanelPinned%>';
            if (isPinned == 'False') {
                var TabPane1 = document.getElementById('RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_PMWebViewerDrawing1_LeftPane');
                TabPane1.className = 'drawing-viewer-UnDockrdLeftPane';
            }
            var hdnResize;
            hdnResize = $("[id$=hdnResize]");
            $("#ctl00_CPH1_PMWebViewerDrawing1_RadSplitter1").resizable({

                resize: function (event, ui) {
                    var LeftPanewidth = $("#RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_PMWebViewerDrawing1_LeftPane").width();
                    var argheight = $("#ctl00_CPH1_PMWebViewerDrawing1_RadSplitter1").height();
                    var argwidth = $("#ctl00_CPH1_PMWebViewerDrawing1_RadSplitter1").width() - LeftPanewidth;
                    hdnResize.val(parseInt(argheight) + ',' + parseInt(argwidth));

                    $("#RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_PMWebViewerDrawing1_RadPane1").width(argwidth - 2).height(argheight - 2);
                    // $("#RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_PMWebViewerDrawing1_ctl00").width(argwidth - 2).height(argheight - 2);
                    $("#divZoomer").width(argwidth - 8).height(argheight - 8);


                    var viewX = event.view.leftOffset;
                    var viewY = event.view.topOffset;
                    event.view.scrollTo(viewX + argwidth, viewY + argheight);

                }

            });


            if (hdnResize.val() != '') {
                var argsResize = hdnResize.val().split(',');
                var ResizeHeight = argsResize[0];
                var ResizeWidth = argsResize[1];
                $("#RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_PMWebViewerDrawing1_RadPane1").width(ResizeWidth - 2).height(ResizeHeight - 2);
                $("#divZoomer").width(ResizeWidth - 8).height(ResizeHeight - 8);
                $('.ui-resizable').css('width', parseInt(ResizeWidth) + 8);
                $('.ui-resizable').css('height', ResizeHeight);
            }

            gridId = '<%=rdgActions.ClientID%>';
            RecordId = '<%=PM.RedliningInfo.Id%>';
            ProjectId = '<%=PM.RedliningInfo.ProjectId%>';
            LinkNumber = $("[id$=hdnLinkNumber]").val();
            NoteNumber = $("[id$=hdnNoteNumber]").val();

            if (IsExpanded == 'True') {
                $(".rspPaneTabContainer")[0].style.top = '250px';
            }
            else {
                $(".rspPaneTabContainer")[0].style.top = '250px';
            }

            for (var i = 0; i < arrDrawings.length; i++) {
                if (arrDrawings[i].TYPE == 'NOTE' || arrDrawings[i].TYPE == 'TEXT') {
                    var arrText = arrDrawings[i].VALUE.split('@!~');
                    var ObjText = arrText[0];
                    for (var j = 1; j < arrText.length; j++) {
                        ObjText = ObjText + String.fromCharCode(10) + arrText[j];
                    }
                    for (var q = 0; q < ObjText.split('@~#').length; q++) {
                        ObjText = ObjText.replace("@~#", "'");
                    }
                    arrDrawings[i].VALUE = ObjText.replace("@~#", "'");
                }
                else {
                    if (arrDrawings[i].VALUE) {
                        if (arrDrawings[i].VALUE.indexOf("@~#") >= 0) {
                            arrDrawings[i].VALUE = arrDrawings[i].VALUE.replace("@~#", "'");
                        }
                    }
                }

            }

            //$(this).click(function (e) {
            //    var element = e.srcElement || e.target;
            //    if (element.id == 'RAD_SPLITTER_SLIDING_ZONE_RESIZE_ctl00_CPH1_PMWebViewerDrawing1_RadSlidingPane1') {
            //        $find('ctl00_CPH1_PMWebViewerDrawing1_RadSlidingPane1').get_parent().collapsePane('ctl00_CPH1_PMWebViewerDrawing1_RadSlidingPane1');
            //    }

            //}); 
            var rdgActions = $("div[id$='rdgActions']");
            var chkPArent = rdgActions.find("input[type='checkbox']")[0];
            var i = 0;
            var isChecked = true;
            rdgActions.find("input[type='checkbox']").each(function () {
                if (i > 0) {
                    if (!this.disabled && !this.checked && this.id.indexOf("chkVisible") > 0) isChecked = false
                }
                i++;
            });
            chkPArent.checked = isChecked;

        });


        $(document).keydown(function (e) {
            var kp = e.keyCode ? e.keyCode : e.which;
            if (kp == 46) {
                return DeleteSelectedRows();
            }

        });



        function HandlePageChanged(sender, eventArgs) {
            var PageNumber = sender.get_value();
            document.getElementById('ctl00_CPH1_PMWebViewerDrawing1_lblCurrPage').innerText = PageNumber;
        }

        function OnClientBeforeExpand(sender, eventArgs) {
            //var TabPane = document.getElementById('ctl00_CPH1_PMWebViewerDrawing1_LeftPane');
            //TabPane.style.visibility = 'hidden';

            var TabPane = document.getElementById('RAD_SLIDING_PANE_TAB_ctl00_CPH1_PMWebViewerDrawing1_RadSlidingPane1');
            TabPane.style.visibility = 'hidden';


            var SlidePane = document.getElementById('RAD_SPLITTER_SLIDING_ZONE_RESIZE_ctl00_CPH1_PMWebViewerDrawing1_RadSlidingPane1');
            //SlidePane.style.cursor = 'pointer';
        }

        function OnClientBeforeDock(sender, eventArgs) {
            var TabPane = document.getElementById('RAD_SLIDING_PANE_TAB_ctl00_CPH1_PMWebViewerDrawing1_RadSlidingPane1');
            TabPane.style.visibility = 'hidden';

            var TabPane1 = document.getElementById('RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_PMWebViewerDrawing1_LeftPane');
            TabPane1.className = '';

        }

        function SlidingZoneOnClientLoad(sender, args) {
            var Resize;
            Resize = $("[id$=hdnResize]");
            if (Resize.val() != '') {
                var LeftPanewidth = $("#RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_PMWebViewerDrawing1_LeftPane").width();
                var ResizeDivWidth = $('.ui-resizable').width();
                if (parseInt(LeftPanewidth) > 10)
                    $('.ui-resizable').css('width', parseInt(ResizeDivWidth) + parseInt(LeftPanewidth) - 8);

                var RadPane = document.getElementById('RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_PMWebViewerDrawing1_RadPane1');
                RadPane.style.width = String(parseInt(ResizeDivWidth) - 10) + 'px';

                $("#divZoomer").width(parseInt(ResizeDivWidth))
            }
            else {
                $("#divZoomer").width($("#ctl00_CPH1_PMWebViewerDrawing1_RadSplitter1").width() - $("#RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_PMWebViewerDrawing1_LeftPane").width())
                $('#RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_PMWebViewerDrawing1_RadPane1').width($("#ctl00_CPH1_PMWebViewerDrawing1_RadSplitter1").width() - $("#RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_PMWebViewerDrawing1_LeftPane").width())
            }
        }

        function OnClientBeforeUndock(sender, eventArgs) {
            var TabPane = document.getElementById('RAD_SLIDING_PANE_TAB_ctl00_CPH1_PMWebViewerDrawing1_RadSlidingPane1');
            TabPane.style.visibility = 'visible';

            var TabPane1 = document.getElementById('RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_PMWebViewerDrawing1_LeftPane');
            TabPane1.className = 'drawing-viewer-UnDockrdLeftPane';
        }

        function OnClientCollapsed(sender, eventArgs) {
            //var TabPane = document.getElementById('ctl00_CPH1_PMWebViewerDrawing1_LeftPane')
            //TabPane.style.visibility = 'visible';

            var TabPane = document.getElementById('RAD_SLIDING_PANE_TAB_ctl00_CPH1_PMWebViewerDrawing1_RadSlidingPane1');
            TabPane.style.visibility = 'visible';
        }

        function DeleteSelectedRows() {
            var btnDelete = document.getElementById('ctl00_CPH1_PMWebViewerDrawing1_rdgActions_ctl00_ctl02_ctl00_btnDelete');
            if (btnDelete.getAttribute('disabled') == null || btnDelete.getAttribute('disabled') == false) {
                var grid = $find("<%= rdgActions.ClientID%>");
                var RowsSelectedCount = grid.MasterTableView.get_selectedItems().length;
                if (RowsSelectedCount > 0) {
                    if (confirm(Msg_ConfirmDelete)) {
                        __doPostBack('ctl00$CPH1$PMWebViewerDrawing1$rdgActions$ctl00$ctl02$ctl00$btnDelete');
                    }
                }
            }
        }

        function rdgActions_OnClientSave() {
            var hdnActionChecked = $("[id$=hdnActionChecked]");
            hdnActionChecked.val(arrVisible.join(','));
            arrVisible = [];
        }
        function DisableUndoButtons() {
            EnableToolBarButton(redoIndex, false)
            EnableToolBarButton(undoIndex, false)
        }

    </script>
</telerik:RadScriptBlock>
<div class="ResponsiveMargin" style="padding-left: 0 !important; padding-right: 0 !important;">
    <telerik:RadToolBar ID="mainToolBar" OnClientLoad="DisableUndoButtons" Width="100%" runat="server" Skin="Default" AutoPostBack="true" Height="30px" CssClass="drawing-viewer-toolbar" OnClientDropDownOpened="OnClientDropDownOpened">
        <Items>
            <telerik:RadToolBarButton SecurityButtonType="Add" EnableImageSprite="true" CssClass="ToolbarUndo" CommandName="Undo" AccessKey="z" ToolTip="Undo (Alt+z)" CausesValidation="false"></telerik:RadToolBarButton>
            <telerik:RadToolBarButton SecurityButtonType="Add" EnableImageSprite="true" CssClass="ToolbarRedo" CommandName="Redo" AccessKey="y" ToolTip="Redo (Alt+y)" CausesValidation="false"></telerik:RadToolBarButton>
            <telerik:RadToolBarButton IsSeparator="true"></telerik:RadToolBarButton>
            <telerik:RadToolBarButton PostBack="false" Visible="false">
                <ItemTemplate>
                    <asp:CheckBox ID="cbxAllPages" runat="server" AutoPostBack="false" />
                    <asp:Label ID="lblAllPages" runat="server" Text="AllPages" meta:Resourcekey="lblAllPages"> </asp:Label>
                </ItemTemplate>
            </telerik:RadToolBarButton>
            <telerik:RadToolBarButton IsSeparator="true" Visible="false"></telerik:RadToolBarButton>

            <telerik:RadToolBarDropDown EnableImageSprite="true" CssClass="ToolbarDefault" key="Mouse" DropDownWidth="22px" Width="32px">
                <Buttons>

                    <telerik:RadToolBarButton EnableImageSprite="true" PostBack="false" CssClass="ToolbarDefault" CommandName="Default" CausesValidation="false"></telerik:RadToolBarButton>
                    <telerik:RadToolBarButton EnableImageSprite="true" Visible="false" PostBack="false" CssClass="ToolbarPointer" CommandName="Pointer" CausesValidation="false"></telerik:RadToolBarButton>
                    <telerik:RadToolBarButton EnableImageSprite="true" PostBack="false" CssClass="ToolbarMove" CommandName="Move" CausesValidation="false"></telerik:RadToolBarButton>
                </Buttons>
            </telerik:RadToolBarDropDown>

            <telerik:RadToolBarDropDown EnableImageSprite="true" CssClass="Toolbarline" key="Lines" DropDownWidth="22px" Width="32px">
                <Buttons>

                    <telerik:RadToolBarButton EnableImageSprite="true" PostBack="false" CssClass="Toolbarline" CommandName="line" CausesValidation="false"></telerik:RadToolBarButton>
                    <telerik:RadToolBarButton EnableImageSprite="true" PostBack="false" CssClass="Toolbarpolyline" CommandName="polyline" CausesValidation="false"></telerik:RadToolBarButton>
                    <telerik:RadToolBarButton EnableImageSprite="true" PostBack="false" CssClass="ToolbarCurveLine" CommandName="curvelive" CausesValidation="false" Visible="false"></telerik:RadToolBarButton>
                </Buttons>

            </telerik:RadToolBarDropDown>

            <telerik:RadToolBarDropDown EnableImageSprite="true" CssClass="Toolbarrectangle" key="Shapes" DropDownWidth="22px" Width="32px">
                <Buttons>
                    <telerik:RadToolBarButton EnableImageSprite="true" PostBack="false" CssClass="Toolbarrectangle" CommandName="rectangle" CausesValidation="false"></telerik:RadToolBarButton>
                    <telerik:RadToolBarButton EnableImageSprite="true" PostBack="false" CssClass="Toolbarellipse" CommandName="ellipse" CausesValidation="false"></telerik:RadToolBarButton>
                    <telerik:RadToolBarButton EnableImageSprite="true" PostBack="false" CssClass="ToolbarBubble" CommandName="bubble" CausesValidation="false"></telerik:RadToolBarButton>
                    <telerik:RadToolBarButton EnableImageSprite="true" PostBack="false" CssClass="ToolbarTriangle" CommandName="triangle" CausesValidation="false" Visible="false"></telerik:RadToolBarButton>
                </Buttons>
            </telerik:RadToolBarDropDown>
            <telerik:RadToolBarDropDown EnableImageSprite="true" CssClass="ToolbarNotes" key="Docs" Width="32px" DropDownWidth="100px">
                <Buttons>

                    <telerik:RadToolBarButton PostBack="false" CommandName="note" Value="notes" CausesValidation="false"></telerik:RadToolBarButton>
                    <telerik:RadToolBarButton PostBack="false" CommandName="text" Value="text" CausesValidation="false" Text="Text"></telerik:RadToolBarButton>
                    <telerik:RadToolBarButton PostBack="false" CommandName="stamps" Value="stamps" CausesValidation="false"></telerik:RadToolBarButton>
                    <telerik:RadToolBarButton PostBack="false" CommandName="LinkRecords" Value="LinkRecords" meta:resourcekey="RadToolBarButton_LinkRecords" CausesValidation="false"></telerik:RadToolBarButton>
                </Buttons>

            </telerik:RadToolBarDropDown>
            <telerik:RadToolBarButton EnableImageSprite="true" PostBack="false" key="Cloud" CssClass="ToolbarBubble" CommandName="bubble" Visible="false" CausesValidation="false"></telerik:RadToolBarButton>
            <%--<telerik:RadToolBarButton>
                <ItemTemplate>
                       <telerik:RadMenu runat="server" ID="RadMenu1" Width="45px" Height="0px" OnClientLoad="StampLoad">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Stamps" PostBack="false">
                                                            <Items>
                                                                <telerik:RadMenuItem CssClass="" Width="260px">
                                                                    <ItemTemplate>
                                                                        <div style="" class="stampItems" id="divStamps" runat="server">
                                                                        </div>
                                                                    </ItemTemplate>
                                                                </telerik:RadMenuItem>
                                                            </Items>
                                                        </telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenu>
                </ItemTemplate>
            </telerik:RadToolBarButton>--%>
            <telerik:RadToolBarButton>
                <ItemTemplate>
                    <telerik:RadColorPicker runat="server" ID="RadColorPicker1" ShowIcon="true" CssClass="NewColorPicker"
                        OnClientColorChange="HandleColorChanged" OnClientLoad="LoadColor" KeepInScreenBounds="true"
                        PaletteModes="WebPalette" Preset="Default" EnableCustomColor="true" RenderMode="Lightweight">
                    </telerik:RadColorPicker>
                </ItemTemplate>
            </telerik:RadToolBarButton>

            <telerik:RadToolBarDropDown CssClass="drawThickness" EnableImageSprite="true" PostBack="false">
                <Buttons>
                    <telerik:RadToolBarButton>
                        <ItemTemplate>
                            <table style="width: 100%; background-color: white; display: block; margin: -3px;">
                                <tr style="width: 100%;">
                                    <td style="height: 45px; padding-top: 10px">
                                        <telerik:RadSlider ID="sldrThickness" runat="server" Skin="Default" Width="100px"
                                            Value="1" ItemType="Tick" OnClientValueChanged="HandleThicknessChanged" OnClientLoad="LoadThickness"
                                            ShowIncreaseHandle="false" Style="margin-right: 20px"
                                            ShowDecreaseHandle="false"
                                            Orientation="Horizontal"
                                            MinimumValue="1" MaximumValue="20" ToolTip="" />
                                    </td>

                                    <td style="height: 35px; padding-top: 10px;" align="center">
                                        <img alt="" id="imgThickness" src="Images/Redlining/BlackCircle.png" width="1px" height="1px" />
                                        <span id="lblThickness" style="font-size: 10px; color: #3E6AAA; display: block;">1px</span>
                                    </td>
                                </tr>
                            </table>



                        </ItemTemplate>
                    </telerik:RadToolBarButton>
                </Buttons>
            </telerik:RadToolBarDropDown>

            <telerik:RadToolBarButton IsSeparator="true"></telerik:RadToolBarButton>
            <telerik:RadToolBarButton PostBack="false">
                <ItemTemplate>
                    <table>
                        <tr>
                            <td>
                                <label class="switch">
                                    <input id="cbxAutoSave" runat="server" type="checkbox" />
                                    <span class="slider round"></span>
                                </label>
                            </td>
                            <td>
                                <asp:Label ID="lblAutoSave" runat="server" Text="Autosave1" meta:Resourcekey="lblAutoSave"> </asp:Label>
                            </td>
                        </tr>
                    </table>

                </ItemTemplate>
            </telerik:RadToolBarButton>
            <telerik:RadToolBarButton IsSeparator="true"></telerik:RadToolBarButton>

            <telerik:RadToolBarDropDown PostBack="false" Text="100%">
                <Buttons>
                    <telerik:RadToolBarButton>
                        <ItemTemplate>
                            <table style="width: 160px; height: 49px; background-color: white; margin: -3px;">
                                <tr>
                                    <td style="height: 20px; padding-top: 0px;">
                                        <telerik:RadSlider ID="sldrZoom" runat="server" Skin="Windows7" Width="100px"
                                            Value="100" OnClientValueChange="HandleZoomChanged" OnClientLoad="HandleZoomChanged"
                                            ShowIncreaseHandle="true"
                                            ShowDecreaseHandle="true"
                                            Orientation="Horizontal"
                                            MinimumValue="0" MaximumValue="800" ToolTip="" SmallChange="1" />
                                    </td>
                                    <td style="padding-left: 2px;">
                                        <asp:TextBox runat="server" ID="txtZoomValue" CssClass="PositiveInteger" Width="30px" AutoPostBack="false" onchange="javascript: handleZoomChangeFromTxt(this);"></asp:TextBox>
                                        <asp:Label runat="server" ID="lblZoom" Text="%"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="padding-left: 5px;">
                                        <asp:Button runat="server" ID="btnResetZoom" Text="Reset" meta:Resourcekey="btnResetZoom" Width="50px" OnClientClick="resetZoom();return false;" />

                                    </td>
                                </tr>
                            </table>



                        </ItemTemplate>
                    </telerik:RadToolBarButton>
                </Buttons>
            </telerik:RadToolBarDropDown>
            <telerik:RadToolBarButton CommandName="Previous" CssClass="ToolbarPrevious" EnableImageSprite="true">
            </telerik:RadToolBarButton>

            <telerik:RadToolBarButton PostBack="false">
                <ItemTemplate>
                    <asp:TextBox runat="server" ID="txtPage" Width="35px" ValidationGroup="Paging" CausesValidation="true" CssClass="PositiveInteger" OnTextChanged="LoadPDFPage" AutoPostBack="true" Text="1">

                    </asp:TextBox>
                    <asp:RangeValidator ID="rgvalPages" runat="server" CssClass="validator" ErrorMessage="*" Type="Integer" ValidationGroup="Paging" MinimumValue="1" ControlToValidate="txtPage"></asp:RangeValidator>
                    <%--<asp:Label ID="Label1" runat="server" Text="of" meta:Resourcekey="lblOff"> </asp:Label>--%><%--<asp:Label runat="server" ID="lblPage" Style="margin-left: 5px;"></asp:Label>--%>
                </ItemTemplate>
            </telerik:RadToolBarButton>
            <telerik:RadToolBarButton CommandName="Next" CssClass="ToolbarNext" EnableImageSprite="true">
            </telerik:RadToolBarButton>

        </Items>
    </telerik:RadToolBar>
</div>


<table cellpadding="0" cellspacing="0" border="0" class="RL_AllGreyBorder " width="100%" style="border-width: 2px !important; height: 100%">

    <asp:HiddenField ID="hdnStamp" runat="server" Value="1" />
    <asp:HiddenField ID="hdnLinkNumber" runat="server" Value="1" />
    <asp:HiddenField ID="hdnNoteNumber" runat="server" Value="1" />
    <asp:HiddenField runat="server" ID="hdnSkin" />
    <asp:HiddenField ID="hdnActionChecked" runat="server" />
    <asp:HiddenField ID="hdnZoom" Value="100%" runat="server" />
    <asp:HiddenField ID="hdnResize" runat="server" />
    <tr>
        <td>
            <div class="PMHeader" style="padding-top: 0">
                <div class="row">
                    <div class="col-12">
                        <table cellpadding="0" cellspacing="0" border="0" class="colTable" style="width: 100%; border-width: 2px !important; padding-left: 0;">
                            <tr>
                                <td colspan="2" valign="Top" style="height: 510px; background-color: #666;">
                                    <telerik:RadSplitter ID="RadSplitter1" Width="100%" runat="server" Height="523px" CssClass="drawing-viewer-rdsplitter" BackColor="White" EnableImageSprites="true">
                                        <telerik:RadPane ID="LeftPane" runat="server" Width="200px">
                                            <telerik:RadSlidingZone ID="SlidingZone1" runat="server" ClickToOpen="true" OnClientLoad="SlidingZoneOnClientLoad">
                                                <telerik:RadSlidingPane ID="RadSlidingPane1" Width="500px" Title="Pane1" runat="server" OnClientBeforeExpand="OnClientBeforeExpand" OnClientCollapsed="OnClientCollapsed" OnClientBeforeUndock="OnClientBeforeUndock" OnClientExpanded="OnclientExpanded"
                                                    MinWidth="100" ResizeText="" EnableResize="true" RenderMode="Lightweight" EnableDock="true" OnClientBeforeDock="OnClientBeforeDock" OnClientDocked="UpdatePanelSettings" OnClientResized="UpdatePanelSettings" OnClientUndocked="UpdatePanelSettings">
                                                    <telerik:RadGrid ID="rdgActions" runat="server" AllowMultiRowSelection="True" AutoGenerateColumns="False" CssClass="rdgActions"
                                                        GridLines="None" HeaderStyle-Font-Size="8" ShowStatusBar="false" PsageSize="10" ShowGroupPanel="True" Height="500px"
                                                        AllowSorting="true" ShowFooter="false" Width="100%" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
                                                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                                        <HeaderStyle Font-Size="8pt" />

                                                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" UseAllDataFields="true"
                                                            CommandItemDisplay="Top" DataKeyNames="Id" ClientDataKeyNames="Id" Width="100%">
                                                            <CommandItemTemplate>
                                                                <div style="padding: 2px;">
                                                                    <asp:LinkButton ID="btnSave" runat="server" CausesValidation="false"
                                                                        SecurityButtonType="ItemMode_Edit" OnClientClick="return rdgActions_OnClientSave();"
                                                                        CommandName="Save" CssClass="GridCmdPerformInsert" Visible="true">
                                                                        <span class="Icon"></span>
                                                                        <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                                                    </asp:LinkButton>
                                                                    <asp:LinkButton ID="btnDelete" CausesValidation="false"
                                                                        Visible="true"
                                                                        SecurityButtonType="ItemMode_Delete" runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" OnClientClick="javascript:DeleteFromGrid()">
                                                                        <span class="Icon"></span>
                                                                        <asp:Label ID="Label8" runat="server" Text="Label"></asp:Label>&nbsp;&nbsp;
                                                                    </asp:LinkButton>
                                                                    <asp:LinkButton ID="btnMoveResize" CausesValidation="false" Visible="true" OnClientClick="javascript:return TransformFromGrid(this)" Style="display: none"
                                                                        SecurityButtonType="ItemMode_Delete" runat="server" CssClass="GridCmdEditRows">
                                                                        <span class="Icon"></span>
                                                                        <asp:Label ID="Label3" runat="server" Text="Move & Resize"></asp:Label>&nbsp;&nbsp;
                                                                    </asp:LinkButton>
                                                                    <asp:LinkButton ID="EndEdit" CausesValidation="false" Visible="true" OnClientClick="javascript:return TransformFromGrid(this)" Style="display: none"
                                                                        SecurityButtonType="ItemMode_Delete" runat="server" CssClass="GridCmdUpdateEdited">
                                                                        <span class="Icon"></span>
                                                                        <asp:Label ID="Label4" runat="server" Text="End Edit"></asp:Label>&nbsp;&nbsp;
                                                                    </asp:LinkButton>
                                                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false"
                                                                        SecurityButtonType="ItemMode" CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible="true">
                                                                        <span class="Icon"></span>
                                                                        <asp:Label ID="Label9" runat="server" Text="Refresh"></asp:Label>&nbsp;&nbsp;
                                                                    </asp:LinkButton>
                                                                    <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                                                        CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                                                        runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                                                        EnableShadows="true" CausesValidation="false"
                                                                        Visible="true">
                                                                    </telerik:RadMenu>
                                                                </div>
                                                            </CommandItemTemplate>
                                                            <Columns>
                                                                <telerik:GridTemplateColumn AutoPostBackOnFilter="true" HeaderText="" Groupable="true" UniqueName="IsVisible" CurrentFilterFunction="EqualTo" Reorderable="true"
                                                                    AllowFiltering="true" GroupByExpression="IsVisible [GridColumn_IsVisible] Group By IsVisible ASC" DataType="System.Boolean" DataField="IsVisible">
                                                                    <HeaderTemplate>
                                                                        <asp:CheckBox ID="chkAll" onClick="AllCheckClicked(this)" Checked="true" runat="server" />
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox ID="chkVisible" runat="server" Checked='<%# CBool(Eval("IsVisible"))%>' />
                                                                    </ItemTemplate>
                                                                    <ItemStyle Wrap="False" />
                                                                    <HeaderStyle Width="100px"></HeaderStyle>
                                                                </telerik:GridTemplateColumn>

                                                                <telerik:GridTemplateColumn AutoPostBackOnFilter="true" HeaderText="ActionType" Groupable="true" UniqueName="ActionType" Reorderable="true"
                                                                    AllowFiltering="true" CurrentFilterFunction="Contains" GroupByExpression="ActionType [GridColumn_ActionType] Group By ActionType ASC" DataType="System.String" DataField="ActionType">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblActionType" runat="server" Text='<%#If(Eval("ActionType") = String.Empty, "&nbsp;", Eval("ActionType"))%>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Wrap="False" Width="140px" />
                                                                    <HeaderStyle Width="140px"></HeaderStyle>
                                                                </telerik:GridTemplateColumn>

                                                                <telerik:GridTemplateColumn HeaderText="DrawingCount" Groupable="true" UniqueName="DrawingCount" Reorderable="true"
                                                                    AllowFiltering="true" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" GroupByExpression="DrawingCount [GridColumn_DrawingCount] Group By DrawingCount ASC" DataType="System.Int32" DataField="DrawingCount">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblDrawingCount" runat="server" Text='<%#If(Eval("DrawingCount") = 0, "&nbsp;", Eval("DrawingCount"))%>'></asp:Label>

                                                                        <telerik:RadDiagram ID="thediagram" runat="server" CssClass="diagram" Width="20px" Height="20px " Editable="false" ZoomMax="1" ZoomMin="1">
                                                                            <ShapesCollection>
                                                                                <telerik:DiagramShape Id="start" Width="20" Height="20" Type="rectangle" Editable="false" Selectable="false">
                                                                                    <FillSettings Color="#cf3737" />
                                                                                    <ContentSettings Text="2" />
                                                                                </telerik:DiagramShape>
                                                                            </ShapesCollection>
                                                                        </telerik:RadDiagram>

                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="140px" />
                                                                    <HeaderStyle Width="140px" />
                                                                </telerik:GridTemplateColumn>

                                                                <telerik:GridTemplateColumn AutoPostBackOnFilter="true" HeaderText="Description" Groupable="true" UniqueName="Description" Reorderable="true"
                                                                    AllowFiltering="true" CurrentFilterFunction="Contains" GroupByExpression="Description [GridColumn_Description] Group By Description ASC" DataType="System.String" DataField="Description">
                                                                    <ItemTemplate>

                                                                        <asp:Label ID="lblDescription" runat="server" Text='<%#If(Eval("Description") = String.Empty, "&nbsp;", Eval("Description"))%>'></asp:Label>
                                                                        <%--                                                            <span><%#IIf(Eval("Description") = String.Empty, "&nbsp;", Eval("Description"))%></span>--%>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Wrap="False" Width="140px" />
                                                                    <HeaderStyle Width="140px"></HeaderStyle>
                                                                </telerik:GridTemplateColumn>

                                                                <telerik:GridTemplateColumn AutoPostBackOnFilter="true" HeaderText="User" Groupable="true" UniqueName="User" Reorderable="true"
                                                                    AllowFiltering="true" CurrentFilterFunction="Contains" GroupByExpression="User [GridColumn_User] Group By User ASC" DataType="System.String" DataField="User">
                                                                    <ItemTemplate>

                                                                        <span><%#IIf(Eval("User") = String.Empty, "&nbsp;", Eval("User"))%></span>

                                                                    </ItemTemplate>
                                                                    <ItemStyle Wrap="False" Width="140px" />
                                                                    <HeaderStyle Width="140px"></HeaderStyle>
                                                                </telerik:GridTemplateColumn>

                                                                <telerik:GridTemplateColumn AutoPostBackOnFilter="true" HeaderText="Date" Groupable="true" UniqueName="ActionDate" Reorderable="true"
                                                                    AllowFiltering="true" CurrentFilterFunction="GreaterThanOrEqualTo" GroupByExpression="ActionDate [GridColumn_ActionDate] Group By ActionDate ASC" DataType="System.DateTime" DataField="ActionDate">
                                                                    <ItemTemplate>

                                                                        <span><%#IIf(Eval("ActionDate") Is System.DBNull.Value, "&nbsp;", FormatDate(Eval("ActionDate")) + " " + FormatTime(Eval("ActionDate")))%></span>

                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                    <ItemStyle Wrap="False" Width="140px" />
                                                                    <HeaderStyle Width="140px"></HeaderStyle>
                                                                </telerik:GridTemplateColumn>

                                                                <telerik:GridTemplateColumn AutoPostBackOnFilter="true" HeaderText="Company" Groupable="true" UniqueName="Company" Reorderable="true"
                                                                    AllowFiltering="true" CurrentFilterFunction="Contains" GroupByExpression="Company [GridColumn_Company] Group By Company ASC" DataType="System.String" DataField="Company">
                                                                    <ItemTemplate>

                                                                        <span><%#IIf(Eval("Company") = String.Empty, "&nbsp;", Eval("Company"))%></span>

                                                                    </ItemTemplate>
                                                                    <ItemStyle Wrap="False" Width="140px" />
                                                                    <HeaderStyle Width="140px"></HeaderStyle>
                                                                </telerik:GridTemplateColumn>

                                                                <telerik:GridTemplateColumn AutoPostBackOnFilter="true" HeaderText="LinkType" Groupable="true" UniqueName="LinkType" Reorderable="true"
                                                                    AllowFiltering="true" CurrentFilterFunction="Contains" GroupByExpression="LinkType [GridColumn_LinkType] Group By LinkType ASC" DataType="System.String" DataField="LinkType">
                                                                    <ItemTemplate>

                                                                        <span><%#IIf(Eval("LinkType") = String.Empty, "&nbsp;", Eval("LinkType"))%></span>

                                                                    </ItemTemplate>
                                                                    <ItemStyle Wrap="False" Width="140px" />
                                                                    <HeaderStyle Width="140px"></HeaderStyle>
                                                                </telerik:GridTemplateColumn>

                                                                <telerik:GridTemplateColumn AutoPostBackOnFilter="true" HeaderText="HyperLink" Groupable="true" UniqueName="HyperLink" Reorderable="true"
                                                                    AllowFiltering="true" CurrentFilterFunction="Contains" GroupByExpression="HyperLink [GridColumn_HyperLink] Group By HyperLink ASC" DataType="System.String" DataField="HyperLink">
                                                                    <ItemTemplate>

                                                                        <asp:LinkButton runat="server" ID="btnHyperLink" PostBackUrl='<%# Eval("MainPage") %>'> 
                                                                <span style="color :blue"><%#IIf(Eval("HyperLink") = String.Empty, " ", Eval("HyperLink"))%></span>
                                                                        </asp:LinkButton>

                                                                    </ItemTemplate>
                                                                    <ItemStyle Wrap="False" Width="140px" />
                                                                    <HeaderStyle Width="140px"></HeaderStyle>
                                                                </telerik:GridTemplateColumn>

                                                                <telerik:GridTemplateColumn AutoPostBackOnFilter="true" HeaderText="Page1" Groupable="true" UniqueName="PageNumber" ItemStyle-HorizontalAlign="Right" Reorderable="true"
                                                                    AllowFiltering="true" CurrentFilterFunction="EqualTo" GroupByExpression="PageNumber [GridColumn_PageNumber] Group By PageNumber ASC" DataType="System.Int32" DataField="PageNumber">
                                                                    <ItemTemplate>
                                                                        <span><%# Eval("PageNumber")%></span>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Wrap="False" Width="140px" />
                                                                    <HeaderStyle Width="140px"></HeaderStyle>
                                                                </telerik:GridTemplateColumn>



                                                            </Columns>
                                                            <NoRecordsTemplate>
                                                                <table style="height: 200px; width: 100%">
                                                                    <tr>
                                                                        <td class="Top Center">
                                                                            <asp:Label ID="lblNoFileToDisplay" runat="server" meta:ResourceKey="lblNoFileToDisplay"
                                                                                Text="No Files to display."></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </NoRecordsTemplate>
                                                        </MasterTableView>
                                                        <ClientSettings AllowDragToGroup="true" AllowColumnsReorder="true">
                                                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true" AllowColumnResize="True" />
                                                            <Selecting EnableDragToSelectRows="true" AllowRowSelect="true" />
                                                            <ClientEvents OnRowMouseOver="OnRowMouseOver" OnRowMouseOut="OnRowMouseOut" OnRowSelected="OnRowSelected" OnRowDeselected="OnRowSelected" />
                                                        </ClientSettings>
                                                    </telerik:RadGrid>
                                                </telerik:RadSlidingPane>
                                            </telerik:RadSlidingZone>
                                        </telerik:RadPane>
                                        <telerik:RadPane ID="RadPane1" runat="server" Width="100%" Scrolling="None">
                                            <table style="width: 100%">
                                                <tr>
                                                    <td class="RL_AllGreyBorder " style="background-color: #666; border-width: 0px;" valign="top">
                                                        <div class="RL_Info">
                                                            <table style="width: 100%; height: 100%; background-color: #F8F8F8" cellpadding="0"
                                                                cellspacing="0" border="0">
                                                                <tr>
                                                                    <td style="vertical-align: top; background-color: #EFEFEF" id="tdZoomer" class="disableSelection">
                                                                        <div id="divZoomer" style="position: relative; height: 510px; width: auto; overflow: auto">
                                                                            <div id="Canvas" class="disableRT ViewerCanvas" style="cursor: default; position: absolute; top: 0px; left: 0px;">
                                                                                <asp:Image ID="imgCanvas" ondragstart="return false;" runat="server" />
                                                                                <div id="divResize">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                        <asp:PlaceHolder ID="pnlDrawings" runat="server"></asp:PlaceHolder>

                                                    </td>
                                                </tr>
                                            </table>

                                        </telerik:RadPane>
                                    </telerik:RadSplitter>
                                </td>

                            </tr>
                            <tr>
                                <td style="background-color: #666; vertical-align: top;">&nbsp;</td>
                                <td style="background-color: #666; vertical-align: top; font-size: 9px; border: 0px">
                                    <div id="Inst" style="float: left; margin-left: 5px"></div>
                                    <div style="float: right; margin-right: 5px">X:&nbsp;<span id="MouseXSpan"></span>&nbsp;&nbsp;&nbsp;Y:&nbsp;<span id="MouseYSpan"></span></div>
                                    <asp:HiddenField ID="hnDrawings" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>



            <telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">

                <script type="text/javascript">

                    $('#Canvas').mouseover(function (e) {
                        leftOffset = $('#Canvas').offset().left;
                        topOffset = $('#Canvas').offset().top;
                    });

                    //$('#Canvas').dblclick(function () {
                    //    CanvasdblClicked();
                    //});

                </script>
            </telerik:RadScriptBlock>
            <telerik:RadToolTipManager runat="server" ID="RadToolTipManager1" Position="TopCenter"
                RelativeTo="Mouse" Width="395px" Height="185px" Animation="Resize" HideEvent="ManualClose"
                Skin="Default" OnAjaxUpdate="OnAjaxUpdate" EnableShadow="true" RenderInPageRoot="true" AnimationDuration="200">
            </telerik:RadToolTipManager>
            <telerik:RadToolTipManager runat="server" ID="TextNoteRadToolTipManager" CssClass="TooltipManagerTextNote" Position="TopRight" RelativeTo="Mouse"
                Width="395px" Height="60px" Animation="Resize" HideEvent="ManualClose"
                Skin="Default" OnAjaxUpdate="OnAjaxUpdate" EnableShadow="false" RenderInPageRoot="true" AnimationDuration="200">
            </telerik:RadToolTipManager>
            <telerik:RadContextMenu ID="cmEdit" OnClientItemClicked="menuItemClicked" EnableImageSprites="true" CssClass="trvContextMenu" runat="server" Width="150px" Style="z-index: 9000 !important; width: 150px;">
                <Items>
                    <telerik:RadMenuItem Text="Edit Text.." runat="server" Value="EditText" CssClass="MenuEdit" meta:resourcekey="MenuItem_EditText"></telerik:RadMenuItem>
                    <telerik:RadMenuItem Text="Edit Note.." runat="server" Value="EditNote" CssClass="MenuEdit" meta:resourcekey="MenuItem_EditNote"></telerik:RadMenuItem>
                    <telerik:RadMenuItem Text="Edit.." runat="server" Value="Edit" CssClass="MenuEdit" meta:resourcekey="MenuItem_Edit"></telerik:RadMenuItem>
                    <telerik:RadMenuItem Text="End Edit.." runat="server" Value="EndEdit" CssClass="MenuSave" meta:resourcekey="MenuItem_EndEdit"></telerik:RadMenuItem>
                    <telerik:RadMenuItem Text="Delete.." runat="server" Value="Delete" CssClass="MenuDelete" meta:resourcekey="MenuItem_Delete"></telerik:RadMenuItem>
                </Items>
            </telerik:RadContextMenu>
            <telerik:RadContextMenu ID="cmDrawing" runat="server" Style="z-index: 9000 !important;" OnClientItemClicked="cmDrawingClicked" OnClientShowing="OnMenuShowing">
                <Targets>
                    <telerik:ContextMenuElementTarget ElementID="Canvas" />
                </Targets>
                <Items>
                    <telerik:RadMenuItem meta:resourcekey="MenuItem_AddText"
                        PostBack="false" Value="AddText" Text="Add" />
                    <telerik:RadMenuItem meta:resourcekey="MenuItem_AddDrawing"
                        PostBack="false" Value="Draw" Text="Add">
                        <Items>
                            <telerik:RadMenuItem meta:resourcekey="MenuItem_AddDrawing" CssClass="DrawMenu"
                                PostBack="false" Value="Draw" Text="Add">
                                <ItemTemplate>

                                    <telerik:RadToolBar ID="RadToolbar1" Height="24px" BackColor="White" runat="server" Skin="Default" OnClientLoad="RadToolbarLoad" OnClientButtonClicked="RedliningOnClientButtonClicking" CssClass="drawing-viewer-toolbar">
                                        <Items>
                                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="Toolbarellipse" CommandName="ellipse" CheckOnClick="true" Group="Format" />
                                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="Toolbarline" CommandName="line" CheckOnClick="true" Group="Format" />
                                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="Toolbarpolyline" CommandName="polyline" CheckOnClick="true" Group="Format" />
                                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="Toolbarrectangle" CommandName="rectangle" CheckOnClick="true" Group="Format" />
                                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarBubble" CommandName="bubble" CausesValidation="false"></telerik:RadToolBarButton>
                                        </Items>
                                    </telerik:RadToolBar>
                                </ItemTemplate>
                            </telerik:RadMenuItem>
                        </Items>

                    </telerik:RadMenuItem>
                    <telerik:RadMenuItem meta:resourcekey="MenuItem_AddStamps" PostBack="false" Value="AddStamp" Text="Add">
                        <Items>
                            <telerik:RadMenuItem PostBack="false" Value="Draw" Text="Add" meta:resourcekey="MenuItem_AddStamps">
                                <ItemTemplate>
                                    <div style="" class="stampItems" id="divStamps" runat="server" />
                                </ItemTemplate>
                            </telerik:RadMenuItem>
                        </Items>
                    </telerik:RadMenuItem>
                    <telerik:RadMenuItem meta:resourcekey="MenuItem_AddImgStamps"
                        PostBack="false" Value="AddImgStamp" Text="Add" />
                    <telerik:RadMenuItem meta:resourcekey="MenuItem_AddNote"
                        PostBack="false" Value="AddNote" Text="Add" />
                    <telerik:RadMenuItem meta:resourcekey="MenuItem_AddLinkedRecords"
                        PostBack="false" Value="AddLinkedRecord" Text="Add" />
                </Items>
            </telerik:RadContextMenu>

        </td>
    </tr>
</table>
<asp:HiddenField runat="server" ID="hdnNotes" />
