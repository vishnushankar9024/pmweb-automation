<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="PMWebViewerMeasurements.ascx.vb" Inherits="Website.PMWebViewerMeasurements" %>

<telerik:RadAjaxManagerProxy ID="Proxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="pnlScale">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="divZoomer" />
            </UpdatedControls>
        </telerik:AjaxSetting>

    </AjaxSettings>
</telerik:RadAjaxManagerProxy>


<telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
    <script type="text/javascript">

        imgCanvasId = "ctl00_CPH1_PMWebViewerMeasurement1_imgCanvas";

        txtDisMapId = 'ctl00_CPH1_PMWebViewerMeasurement1_txtDisMap';
        txtDisGridId = 'ctl00_CPH1_PMWebViewerMeasurement1_txtDisGrd';

        undoIndex = 0;
        redoIndex = 1;


        var arrIds = [];
        var addTextToMsr = true;


        $(document).ready(function (e) {
            $('.disableRT').bind('contextmenu', function (sender, e) {
                return false;
            })

            for (var i = 0; i < arrMeasures.length; i++) {
                var arrText = arrMeasures[i].CENTROID.split('@!~');
                var ObjText = arrText[0];
                for (var j = 1; j < arrText.length; j++) {
                    ObjText = ObjText + String.fromCharCode(10) + arrText[j];
                }
                for (var q = 0; q < ObjText.split('@~#').length; q++) {
                    ObjText = ObjText.replace("@~#", "'");
                }
                arrMeasures[i].CENTROID = ObjText.replace("@~#", "'");
            }
        });

        function divClick(sender) {
            var MeasureActionId = sender.getAttribute("MeasureId");

            if (arrIds.indexOf(MeasureActionId) == -1) {
                arrIds.push(MeasureActionId);
                sender.className = "measurement-viewer-divselect"
                //sender.style.backgroundColor = "#FFCB60"; 
            }
            else {
                var index = arrIds.indexOf(MeasureActionId);
                arrIds.splice(index, 1);
                sender.className = "RL_ActionViewer";
                //sender.style.backgroundColor = "";
            }
        }

        $(document).keydown(function (e) {
            var kp = e.keyCode ? e.keyCode : e.which;
            if (kp == 46) {
                return DeleteSelectedIds();
            }

        });

        function addTextCheckedChanged(sender) {
            addTextToMsr = sender.checked;
        }
        function DeleteSelectedIds() {
            //var lbtDelete = document.getElementById('ctl00_CPH1_PMWebViewerMeasurement1_dtlMeasures_ctl01_lbtDelete');

            //if (lbtDelete.getAttribute('disabled') == null || lbtDelete.getAttribute('disabled') == false) {
            if (arrIds.length > 0) {
                if (confirm(Msg_ConfirmDelete)) {
                    var btn = $("input[id$='btnDeleteMeasures']");
                    $("[id$='hdnMeasureIds']").val(arrIds.join(','));
                    btn.click();

                }
            }
            //}
        }

        //function DeleteSelectedIds() {
        //    var arr = [];
        //    if (arrIds.length > 0) {
        //        for(i=0;i<arrIds.length;i++){
        //            var lbtDelete = document.getElementById(arrIds[i]).childNodes[1].childNodes[1].childNodes[0].childNodes[9].firstChild;

        //            if (lbtDelete && (lbtDelete.getAttribute('disabled') == null || lbtDelete.getAttribute('disabled') == false)) {
        //                arr.push(arrIds[i]);
        //            }          
        //        }
        //        if (confirm(Msg_ConfirmDelete)) {
        //            var btn = $("input[id$='btnDeleteMeasures']");
        //            $("[id$='hdnMeasureIds']").val(arr.join(','));
        //            btn.click();
        //        }
        //    }
        //}



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
            //objToolBar = sender;
            ///***/
            //if (drawingsCateg == 'MSR') {

            //    if (sender.get_items()._array.length > 4) {
            //        sender.get_items().getItem(4).set_enabled(false);
            //    }

            //    if (scaleSetup == true) {
            //        sender.get_items().getItem(4).set_enabled(false);
            //        sender.get_items().getItem(0).set_enabled(false);
            //        sender.get_items().getItem(1).set_enabled(true);
            //        sender.get_items().getItem(2).set_enabled(false);
            //        sender.get_items().getItem(3).set_enabled(false);
            //    }
            //}
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

        function HandlePageChanged(sender, eventArgs) {
            var PageNumber = sender.get_value();
            document.getElementById('ctl00_CPH1_PMWebViewerMeasurement1_lblCurrPage').innerText = PageNumber;
        }
        function DisableUndoButtons() {
            EnableToolBarButton(redoIndex, false)
            EnableToolBarButton(undoIndex, false)
        }


    </script>
</telerik:RadScriptBlock>
<telerik:RadToolBar ID="mainToolBar" Height="30px" OnClientLoad="DisableUndoButtons" Width="100%" runat="server" Skin="Default" AutoPostBack="true" CssClass="drawing-viewer-toolbar" OnClientDropDownOpened="OnClientDropDownOpened">
    <Items>
        <telerik:RadToolBarButton SecurityButtonType="Add" EnableImageSprite="true" CssClass="ToolbarUndo" CommandName="Undo" AccessKey="z" ToolTip="Undo (Alt+z)" CausesValidation="false"></telerik:RadToolBarButton>
        <telerik:RadToolBarButton SecurityButtonType="Add" EnableImageSprite="true" CssClass="ToolbarRedo" CommandName="Redo" AccessKey="y" ToolTip="Redo (Alt+y)" CausesValidation="false"></telerik:RadToolBarButton>
        <telerik:RadToolBarButton IsSeparator="true"></telerik:RadToolBarButton>
        <telerik:RadToolBarButton SecurityButtonType="Read" EnableImageSprite="true" CssClass="ToolbarPrint" Visible="false" ToolTip="Print" PostBack="false" CommandName="Print"></telerik:RadToolBarButton>
        <telerik:RadToolBarButton IsSeparator="true" Visible="false"></telerik:RadToolBarButton>

        <telerik:RadToolBarDropDown EnableImageSprite="true" CssClass="ToolbarDefault" key="Mouse" DropDownWidth="22px" Width="32px">
            <Buttons>

                <telerik:RadToolBarButton EnableImageSprite="true" PostBack="false" CssClass="ToolbarDefault" CommandName="Default" CausesValidation="false"></telerik:RadToolBarButton>
                <telerik:RadToolBarButton EnableImageSprite="true" PostBack="false" Visible="false" CssClass="ToolbarPointer" CommandName="Pointer" CausesValidation="false"></telerik:RadToolBarButton>
                <telerik:RadToolBarButton EnableImageSprite="true" PostBack="false" CssClass="ToolbarMove" CommandName="Move" CausesValidation="false"></telerik:RadToolBarButton>
            </Buttons>
        </telerik:RadToolBarDropDown>

        <telerik:RadToolBarDropDown EnableImageSprite="true" CssClass="Toolbarline" key="Lines" DropDownWidth="22px" Width="32px">
            <Buttons>

                <telerik:RadToolBarButton EnableImageSprite="true" PostBack="false" CssClass="Toolbarline" CommandName="line" CausesValidation="false"></telerik:RadToolBarButton>
                <telerik:RadToolBarButton EnableImageSprite="true" PostBack="false" CssClass="Toolbarpolyline" CommandName="polyline" CausesValidation="false"></telerik:RadToolBarButton>
                <telerik:RadToolBarButton EnableImageSprite="true" PostBack="false" Visible="false" CssClass="ToolbarCurveLine" CommandName="curvelive" CausesValidation="false"></telerik:RadToolBarButton>
            </Buttons>

        </telerik:RadToolBarDropDown>

        <telerik:RadToolBarDropDown EnableImageSprite="true" CssClass="Toolbarrectangle" key="Shapes" DropDownWidth="22px" Width="32px">
            <Buttons>
                <telerik:RadToolBarButton EnableImageSprite="true" PostBack="false" CssClass="Toolbarrectangle" CommandName="rectangle" CausesValidation="false"></telerik:RadToolBarButton>
                <telerik:RadToolBarButton EnableImageSprite="true" PostBack="false" CssClass="Toolbarellipse" CommandName="ellipse" CausesValidation="false"></telerik:RadToolBarButton>
                <telerik:RadToolBarButton EnableImageSprite="true" PostBack="false" Visible="false" CssClass="ToolbarTriangle" CommandName="triangle" CausesValidation="false"></telerik:RadToolBarButton>
            </Buttons>
        </telerik:RadToolBarDropDown>
        <telerik:RadToolBarDropDown EnableImageSprite="true" Visible="false" CssClass="ToolbarNotes" key="Docs" DropDownWidth="22px" Width="32px">
            <Buttons>

                <telerik:RadToolBarButton EnableImageSprite="true" PostBack="false" CssClass="ToolbarNotes" CommandName="notes" CausesValidation="false"></telerik:RadToolBarButton>
                <telerik:RadToolBarButton EnableImageSprite="true" PostBack="false" CssClass="Toolbartext" CommandName="text" CausesValidation="false"></telerik:RadToolBarButton>
                <telerik:RadToolBarButton EnableImageSprite="true" PostBack="false" CssClass="Toolbarstamps" CommandName="stamps" CausesValidation="false"></telerik:RadToolBarButton>
                <telerik:RadToolBarButton EnableImageSprite="true" PostBack="false" CssClass="ToolbarLinkRecords" CommandName="LinkRecords" CausesValidation="false"></telerik:RadToolBarButton>
            </Buttons>

        </telerik:RadToolBarDropDown>
        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarBubble" key="Cloud" CommandName="Bubble" Visible="false"></telerik:RadToolBarButton>
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
                    OnClientColorChange="HandleColorChanged" OnClientLoad="HandleColorChanged" KeepInScreenBounds="true"
                    PaletteModes="WebPalette" Preset="Default" EnableCustomColor="true" RenderMode="Lightweight">
                </telerik:RadColorPicker>
            </ItemTemplate>
        </telerik:RadToolBarButton>

        <telerik:RadToolBarDropDown CssClass="drawThickness" EnableImageSprite="true" PostBack="false">
            <Buttons>
                <telerik:RadToolBarButton>
                    <ItemTemplate>
                        <table style="width: 150px; background-color: white; display: block; margin: -3px;">
                            <tr>
                                <td style="height: 45px; padding-top: 10px">
                                    <telerik:RadSlider ID="sldrThickness" runat="server" Skin="Default" Width="100px"
                                        Value="1" ItemType="Tick" OnClientValueChanged="HandleThicknessChanged" OnClientLoad="HandleThicknessChanged"
                                        ShowIncreaseHandle="false" style="margin-right:20px"
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

        <telerik:RadToolBarButton PostBack="false">
            <ItemTemplate>
                <table>
                    <tr>
                        <td>
                            <label class="switch">
                                <input id="cbxText" runat="server" type="checkbox" />
                                <span class="slider round"></span>
                            </label>
                        </td>
                        <td>
                            <asp:Label ID="lblAddText" runat="server" Text="Add Text1" meta:Resourcekey="lblAddTextToMsr"> </asp:Label>
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </telerik:RadToolBarButton>

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
                                <td style="padding-bottom: 2px; padding-left: 5px;">
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
                <asp:RangeValidator ID="rgvalPages" runat="server" CssClass="validator" Type="Integer" ErrorMessage="*" ValidationGroup="Paging" MinimumValue="1" ControlToValidate="txtPage"></asp:RangeValidator>
            </ItemTemplate>
        </telerik:RadToolBarButton>

        <telerik:RadToolBarButton CommandName="Next" CssClass="ToolbarNext" EnableImageSprite="true">
        </telerik:RadToolBarButton>



    </Items>
</telerik:RadToolBar>


<table cellpadding="0" cellspacing="0" border="0" class="RL_AllGreyBorder" width="100%" style="border-width: 2px !important; height: 100%">

    <tr>
        <td style="width: 290px; height: 80px; background-color: #FFFFFF; border: 1px solid #999999; vertical-align: top;">
            <asp:Panel ID="pnlSavedScale" runat="server">
                <table style="width:100%;margin-left:8px;margin-right:8px;margin-top:24px;">
                    <tr>
                        <td>
                            <span>
                                <asp:Label ID="lblScale" runat="server" Text="Scale" meta:resourcekey="lblMsrScale" Style="display: inline-block;"></asp:Label>
                                &nbsp
                                <asp:Label ID="lblScaleValue" runat="server"></asp:Label>
                            </span>
                        </td>
                        <td>
                            <asp:LinkButton ID="lbtEditScale" runat="server" CssClass="EditScales" >
                                   <div class="rtbIcon"> 
                                                </div>
                            </asp:LinkButton></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="dvActionSectionViewer" style="overflow-x: scroll;margin-top:24px">
                <asp:DataList ID="dtlMeasures" RepeatDirection="Vertical" RepeatLayout="Flow" ShowHeader="true"
                    ShowFooter="true" runat="server">
                    <HeaderTemplate>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <div class="RL_ActionViewer" id="divAction" measureid='<%#Eval("Id")%>' runat="server">
                            <table width="100%">
                                <tr>
                                    <td style="vertical-align:top">
                                         <div style="width: 24px; height: 24px; background-color: <%#Eval("Color")%>"></div>
                                         <img alt="" style="width:24px;height:24px;margin-top:8px;vertical-align:top" src='<%#GetMeasureImagePath(Eval("Type"))%>' /></td>
                                    </td>
                                    <td style="vertical-align:top">
                                        <%#Eval("Name")%><br />
                                        <div style="margin-top: 5px;display: <%#IIF(Eval("Length") > 0,"block","none")%>">
                                            Length: <%#FormatNumber(Math.Round(Eval("Length"), 0), 0)%>&nbsp;&nbsp;<%#Eval("LengthUOM")%><br />
                                        </div>
                                        <div style="margin-top: 5px;display: <%#IIF(Eval("Area") > 0,"block","none")%>">
                                            Area: <%#FormatNumber(Math.Round(Eval("Area"), 0), 0)%>&nbsp;&nbsp;<%#Eval("AreaUOM")%><br />
                                        </div>

                                         <div class="NoWrap labelWidth" style="margin-top: 5px;clear: both; ">
                                            By:
                                                        <%#Eval("User")%> &nbsp <%#FormatDate(Eval("MeasureDate"))%>
                                        </div>
                                    </td>
                                    <td style="vertical-align:bottom">
                                        <asp:LinkButton ID="lbtDelete" CommandName="Delete" CommandArgument='<%#Eval("Id")%>' runat="server" CssClass="DeleteMsr" >
                                   <div class="rtbIcon">
                                                </div>
                            </asp:LinkButton></td>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </ItemTemplate>
                    <FooterTemplate>
                    </FooterTemplate>
                </asp:DataList>
                            </div>
                        </td>
                    </tr>
                </table>

            </asp:Panel>


            <div style="overflow: auto;height:400px;margin-top:24px;" runat="server" id="divScale">
                <asp:Panel ID="pnlScale" runat="server">
                    <asp:Panel ID="pnlEditScale" runat="server" Style="font-size: 10px;margin-right: 8px;margin-left: 8px;">
                        <asp:Label Style="color:#666666;font-size: 10px;margin-bottom:24px;display:block" ID="lblScaleSettings" runat="server" Text="To set the image scale, please draw a line between two points a known distance apart." meta:resourcekey="lblScaleSettings"></asp:Label>
                        <table border="0" width="100%" class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblDisMap" runat="server" Text="Distance on the map(*)" meta:resourcekey="lblDistanceMap" ></asp:Label></td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtDisMap" runat="server" CssClass="Double"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvDisMap" runat="server" ControlToValidate="txtDisMap" ValidationGroup="Scale"
                                        CssClass="Validator" Display="Dynamic" ForeColor="" meta:resourcekey="rfvDisMap" ErrorMessage="*"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblDisGrd" runat="server" Text="Distance on the ground(*)" meta:resourcekey="lblDistanceGrd"></asp:Label></td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtDisGrd" runat="server" CssClass="PositiveDouble" ReadOnly="false" ></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvDisGrd" runat="server" ControlToValidate="txtDisGrd" ValidationGroup="Scale"
                                        CssClass="Validator" Display="Dynamic" ForeColor="" meta:resourcekey="rfvDisGrd" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    <asp:RangeValidator Type="Double" MaximumValue="9999999" ID="rnvDisGrd" runat="server" ControlToValidate="txtDisGrd" ValidationGroup="Scale"
                                        CssClass="Validator" Display="Dynamic" ForeColor="" meta:resourcekey="rnvDisGrd" ErrorMessage="*"></asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblLengthUOM" runat="server" Text="Length UOM" meta:resourcekey="lblLengthUOM"></asp:Label></td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlLengthUOM1" runat="server"  Height="150px" Skin="Default" Filter="Contains" MarkFirstMatch="true" DropDownWidth="120px" AllowCustomText="True"
                                        LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblAreaUOM" runat="server" Text="Area UOM" meta:resourcekey="lblAreaUOM" ></asp:Label></td>
                                <td class="controlWidth">
                                    <telerik:RadComboBox ID="ddlAreaUOM1" runat="server"  Height="150px" Skin="Default" DropDownWidth="120px" AllowCustomText="True" Filter="Contains" MarkFirstMatch="true"
                                        LoadingMessage="<%$ Resources:PMWeb, Loading %>" >
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" align="right" style="padding-top:24px">
                                    <asp:Button ID="lbtSaveScale" OnClientClick="RecalculateSavedMsr()" runat="server" meta:resourcekey="lbtOkScale" Text="Save"  ValidationGroup="Scale" CausesValidation="true" Width="50px" />&nbsp;&nbsp;
                                    <asp:Button ID="lbtCancelSaveScale" runat="server" meta:resourcekey="lbtCancelSaveScale" Text="Cancel"  CausesValidation="false" Width="50px" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>

                </asp:Panel>
            </div>
        </td>
        <td style="background-color: #666;" valign="top">
            <table style="width: 100%; height: 100%; background-color: #F8F8F8" cellpadding="0"
                cellspacing="0" border="0">
                <tr>
                    <td style="vertical-align: top; background-color: #EFEFEF" id="tdZoomer" class="disableSelection">
                        <div id="divZoomer" style="position: relative; height: 510px; width: auto; overflow: auto">
                            <div id="Canvas" class="disableRT" style="cursor: default; position: absolute; top: 0px; left: 0px;">
                                <asp:Image ID="imgCanvas" ondragstart="return false;" runat="server" />
                                <div id="divResize">
                                </div>
                            </div>
                        </div>
                    </td> 
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td style="background-color: #666; vertical-align: top;"
            class="RL_AllGreyBorder ">&nbsp;</td>
        <td style="background-color: #666; vertical-align: top; font-size: 9px; border: 0px"
            class="RL_AllGreyBorder ">
            <div id="Inst" style="float: left; margin-left: 5px"></div>
            <div style="float: right; margin-right: 5px">X:&nbsp;<span id="MouseXSpan"></span>&nbsp;&nbsp;&nbsp;Y:&nbsp;<span id="MouseYSpan"></span></div>
            <asp:HiddenField ID="hnDrawings" runat="server" />
        </td>
    </tr>
</table>

<asp:Button ID="btnDeleteMeasures" runat="server" CssClass="Hide" />
<asp:HiddenField runat="server" ID="hdnMeasureIds" />

<asp:HiddenField runat="server" ID="hdnSkin" />
<asp:PlaceHolder ID="pnlDrawings" runat="server"></asp:PlaceHolder>


<telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">

    <script type="text/javascript">

        $('#Canvas').mouseover(function (e) {
            leftOffset = $('#Canvas').offset().left;
            topOffset = $('#Canvas').offset().top;
        });

        //$('#Canvas').mousemove(function (e) {
        //    mouseX = e.pageX;
        //    mouseY = e.pageY;
        //    if (IE) {
        //        if (mouseX < 0) { mouseX = 0 } else { mouseX -= (leftOffset); }
        //        if (mouseY < 0) { mouseY = 0 } else { mouseY -= (topOffset); }
        //    } else {
        //        if (mouseX < 0) { mouseX = 0 } else { mouseX -= (leftOffset); }
        //        if (mouseY < 0) { mouseY = 0 } else { mouseY -= (topOffset); }
        //    }
        //    document.getElementById('MouseXSpan').innerHTML = mouseX;
        //    document.getElementById('MouseYSpan').innerHTML = mouseY;
        //});

        $('#Canvas').dblclick(function () {
            CanvasDblClicked();
        });

    </script>
</telerik:RadScriptBlock>

<telerik:RadContextMenu ID="cmEdit" OnClientItemClicked="menuItemClicked" EnableImageSprites="true" CssClass="trvContextMenu" runat="server" Width="150px" Style="z-index: 9000 !important; width: 150px;">
    <Items>
        <telerik:RadMenuItem Text="Edit Text.." runat="server" Value="EditText" CssClass="MenuEdit" meta:resourcekey="MenuItem_EditText"></telerik:RadMenuItem>
        <telerik:RadMenuItem Text="Edit.." runat="server" Value="Edit" CssClass="MenuEdit" meta:resourcekey="MenuItem_Edit"></telerik:RadMenuItem>
        <telerik:RadMenuItem Text="End Edit.." runat="server" Value="EndEdit" CssClass="MenuSave" meta:resourcekey="MenuItem_EndEdit"></telerik:RadMenuItem>
        <telerik:RadMenuItem Text="Delete.." runat="server" Value="Delete" CssClass="MenuDelete" meta:resourcekey="MenuItem_Delete"></telerik:RadMenuItem>
    </Items>

</telerik:RadContextMenu>
<telerik:RadContextMenu ID="cmDrawing" runat="server" OnClientShowing="OnMenuShowing" Style="z-index: 9000 !important;">
    <Targets>
        <telerik:ContextMenuElementTarget ElementID="Canvas" />
    </Targets>
    <Items>
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

                            </Items>
                        </telerik:RadToolBar>
                    </ItemTemplate>
                </telerik:RadMenuItem>
            </Items>

        </telerik:RadMenuItem>
    </Items>
</telerik:RadContextMenu>
<asp:HiddenField ID="hdnZoomMsr" runat="server" Value="100" />
