<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="InspectionImage.ascx.vb" Inherits="Website.InspectionImage" %>

<telerik:RadScriptBlock runat="server">
    <style>
        svg {
            position: absolute !important;
            top: 0 !important;
            left: 0 !important;
        }

    
        /*#imgCanvas {
            height:100%;
            width:100%;
           
        }*/

        

        /*#RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_InspectionImage1_LeftPane,
        #RAD_SLIDING_PANE_CONTENT_ctl00_CPH1_InspectionImage1_RadSlidingPane1,
        #ctl00_CPH1_InspectionImage1_RadSlidingPane1*/

        /*.rspSlideContent , .rspPaneTabContainer {
            width:500px !important;
        }*/

        #Canvas > div {
            position: absolute !important;
            z-index: 10;
        }
        
        .InspectionTable {
            margin-top: 20px; 
            padding-right: 24px;
            max-width: 404px;
            padding-left: 14px;
        }

        .InspectionTable .labelWidth{
            min-width: 160px;
            width: 100%;
        }

    </style>
    <script src="JS/raphael-min.js" type="text/javascript"></script>
    <script>


        var menuX; var menuY;
        var mouseX = 100; var mouseY = 100;
        var tempX1 = 0; var tempY1 = 0;
        var currColor = "#69B932";
        var textColor = "white";
        var intThickness = 1;
        var ptLocation = 0

        function DrawInspectionPoint(inspectionDetailId, lineNumber) {
            tempX1 = mouseX;
            tempY1 = mouseY;
            ptLocation = tempX1 + "$" + tempY1;
            var ellipse = paper.ellipse(tempX1, tempY1, 12, 12);
            ellipse.id = 'InspectionDetail_' + inspectionDetailId;
            ellipse.attr({
                fill: currColor
            });

            var text = paper.text(tempX1, tempY1, lineNumber).attr(
            {
                "text-anchor": "middle",
                stroke: 'none',
                fill: 'white',
                "stroke-width": intThickness,
                font: '14px "verdana,geneva,helvetica,sans-serif"',
                "font-family": "verdana,geneva,helvetica,sans-serif"
            });
            text.id = 'InspectionDetailText_' + inspectionDetailId;
            var InspectionDetailSet = paper.set()
            InspectionDetailSet.push(text);
            InspectionDetailSet.push(ellipse);
            InspectionDetailSet.ID = inspectionDetailId;
            InspectionDetailSet.mousedown(function (e) {
                if (e.button == 0) {
                    $("[id$='hdnRefreshInspectionData']")[0].value = inspectionDetailId;
                    $("[id$='btnRefreshInspectionData']")[0].click();
                } else if (e.button == 2) {
                    //var upX = e.clientX + $(window).scrollLeft() - 5;
                    //var upY = e.clientY + $(window).scrollTop() - 5;
                    //OpenMenu(this, upX, upY);

                }
            });
            //PageMethods.DeletePoint(inspectionDetailId);
            arrDrawings.push({ 'X': tempX1, 'Y': tempY1, "ID": inspectionDetailId, "LineNumber": lineNumber });
            PageMethods.SavePoint(inspectionDetailId, ptLocation)
        }

        function LoadInspectionPoint(x, y, inspectionDetailId, lineNumber) {

            var ellipse = paper.ellipse(x, y, 12, 12);
            ellipse.id = 'InspectionDetail_' + inspectionDetailId;
            ellipse.attr({
                fill: currColor
            });

            var text = paper.text(x, y, lineNumber).attr(
            {
                "text-anchor": "middle",
                stroke: 'none',
                fill: 'white',
                "stroke-width": intThickness,
                font: '14px "verdana,geneva,helvetica,sans-serif"',
                "font-family": "verdana,geneva,helvetica,sans-serif"
            });
            text.id = 'InspectionDetailText_' + inspectionDetailId;
            var InspectionDetailSet = paper.set()
            InspectionDetailSet.push(text);
            InspectionDetailSet.push(ellipse);
            InspectionDetailSet.ID = inspectionDetailId;
            InspectionDetailSet.mousedown(function (e) {
                if (e.button == 0) {
                    $("[id$='hdnRefreshInspectionData']")[0].value = inspectionDetailId;
                    $("[id$='btnRefreshInspectionData']")[0].click();
                } else if (e.button == 2) {
                    //var upX = e.clientX + $(window).scrollLeft() - 5;
                    //var upY = e.clientY + $(window).scrollTop() - 5;
                    //OpenMenu(this, upX, upY);
                }
            });
        }

        function RadContextMenu_ClientItemClicking(sender, args) {
            switch (args.get_item().get_value()) {
                case 'AddPoint':
                    AddPoint();
                    break;
                case 'MoveSelectedPoint':
                    MoveSelectedPoint();
                    break;
                case 'DeleteSelectedPoint':
                    DeleteSelectedPoint(false);
                    break;
            }
        }


        function MoveSelectedPoint() {
            tempX1 = mouseX;
            tempY1 = mouseY;
            ptLocation = tempX1 + "$" + tempY1;
            var selectedId = $("[id$='hdnRefreshInspectionData']")[0].value
            if (selectedId == null || selectedId <= 0) return false;

            for (var i = 0; i < arrDrawings.length; i++) {
                elementId = arrDrawings[i].ID;
                lineNumber = arrDrawings[i].LineNumber;
                if (elementId == selectedId) {
                    arrDrawings.splice(i, 1);
                    arrDrawings.push({ 'X': tempX1, 'Y': tempY1, "ID": selectedId, "LineNumber": lineNumber });
                    PageMethods.SavePoint(selectedId, ptLocation)
                }
            }
            LoadAllInspectionPoints();
        }

        function AddPoint() {
            var wnd = window.radopen('InspectionDetailsPopup.aspx');
            wnd.setSize(700, 700);
            //wnd.set_behaviors(Telerik.Web.UI.WindowBehaviors.Minimize + Telerik.Web.UI.WindowBehaviors.Maximize + Telerik.Web.UI.WindowBehaviors.Close);
            wnd.Center();
        }


        function SelectAsset(node) {
            var assetText = ""
            var AssetId = node.get_attributes().getAttribute("AssetId");
            switch (node.get_contentCssClass()) {
                case "trvProperty":
                    assetText = "Property"
                    break;
                case "trvBuilding":
                    assetText = "Building"
                    break;
                case "trvFloor":
                    assetText = "Floor"
                    break;
                case "trvSpace":
                    assetText = "Space"
                    break;
                case "trvEquipment":
                    assetText = "Equipment"
                    break;
            }
            //$("[id$=txtAssetType]")[0].value = assetText

            //
            $("[id$='txtAssetType']").val(assetText)
            $("[id$='hdnAssetId']")[0].value = AssetId;
            $("[id$='txtAsset']")[0].value = node.get_text();
            $("[id$='txtDescription']").val(node.get_text());
        }


        function DeleteSelectedPoint(bool) {
            var selectedId = $("[id$='hdnRefreshInspectionData']")[0].value
            var selectedLineNumber;
            if (selectedId == null || selectedId <= 0) return false;
            for (var i = 0; i < arrDrawings.length; i++) {
                elementId = arrDrawings[i].ID
                if (elementId == selectedId) {
                    selectedLineNumber = arrDrawings[i].LineNumber;
                    arrDrawings.splice(i, 1);
                    PageMethods.DeletePoint(selectedId)
                }
            }
            if (bool) {
                for (var i = 0; i < arrDrawings.length; i++) {
                    if (selectedLineNumber < arrDrawings[i].LineNumber) {
                        arrDrawings[i].LineNumber = arrDrawings[i].LineNumber - 1;
                    }
                }
            } else {
                document.getElementById("ctl00_CPH1_InspectionImage1_lblSelectionLabel").style.display = "block";
                document.getElementById("ctl00_CPH1_InspectionImage1_pnlAsset").style.display = "none";
            }
            LoadAllInspectionPoints();
        }




        var uploadsDocFileInProgress = 0;

        function onDocFileSelected(sender, args) {
            uploadsDocFileInProgress++;
        }

        function onDocFileUploaded(sender, args) {
            decrementUploadsDocFileInProgress();
            if (uploadsDocFileInProgress <= 0) {
                var btnRefreshUserImage = $("[id$=btnRefreshUserImage]");
                btnRefreshUserImage.click();
                setTimeout(function () {
                    sender.deleteAllFileInputs();
                }, 10);
            }
        }

        function onDocFileUploadFailed(sender, args) {
            decrementUploadsDocFileInProgress();
        }

        function decrementUploadsDocFileInProgress() {
            uploadsDocFileInProgress--;
        }

        function ClientDocFileValidationFailed(sender, args) {
            decrementUploadsDocFileInProgress();
            alert(WarningMsg_InvalidFile);
        }


        function OnMenuShowing() {
            //menuX = mouseX
            //menuY = mouseY
            //if (cursorType == 'Move') {
            //    cursorType = 'Default';
            //    $('#Canvas').hover(function () { $(this).css('cursor', 'default') })
            //}
        }


        function LoadAllInspectionPoints() {
            $('#Canvas')[0].innerHTML = $('#Canvas')[0].children['ctl00_CPH1_InspectionImage1_imgCanvas'].outerHTML;
            paper = new Raphael("Canvas");
            paper.clear();
            for (var i = 0; i < arrDrawings.length; i++) {
                LoadInspectionPoint(arrDrawings[i].X, arrDrawings[i].Y, arrDrawings[i].ID, arrDrawings[i].LineNumber)
            }
        }



        $(document).ready(function () {
            for (var i = 0; i < arrDrawings.length; i++) {
                LoadInspectionPoint(arrDrawings[i].X, arrDrawings[i].Y, arrDrawings[i].ID, arrDrawings[i].LineNumber)
            }
        });

        function OnInspectionClientBeforeExpand(sender, eventArgs) {
            var TabPane = document.getElementById('RAD_SLIDING_PANE_TAB_ctl00_CPH1_InspectionImage1_RadSlidingPane1');
            TabPane.style.visibility = 'hidden';
        }

        function OnInspectionClientCollapsed(sender, eventArgs) {
            var TabPane = document.getElementById('RAD_SLIDING_PANE_TAB_ctl00_CPH1_InspectionImage1_RadSlidingPane1');
            TabPane.style.visibility = 'visible';
        }



        function detailClick_handler(sender, args) {
            var value = args.get_item().get_commandName();
            if (value == "Delete") {
                DeleteSelectedPoint(true);
            }
        }

        function UpdatePanelSettings(sender) {
            $.ajax({
                type: "POST",
                url: "AjaxService.aspx/UpdateInspectionPanelSettings",
                contentType: "application/json; charset=utf-8",
                data: "{'isPinned':'" + sender.get_docked() + "' }",
                dataType: "json",
                async: true
            });
            if (!sender.get_docked()) {
                sender.set_dockOnOpen(false)
                var TabPane = document.getElementById('RAD_SLIDING_PANE_TAB_ctl00_CPH1_InspectionImage1_RadSlidingPane1');
                var TabPane1 = document.getElementById('RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_InspectionImage1_LeftPane');
                TabPane.style.visibility = 'visible';
                TabPane1.className = 'drawing-viewer-UnDockrdLeftPane';
            }
            else {
                sender.set_dockOnOpen(true)
                var TabPane = document.getElementById('RAD_SLIDING_PANE_TAB_ctl00_CPH1_InspectionImage1_RadSlidingPane1');
                var TabPane1 = document.getElementById('RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_InspectionImage1_LeftPane');
                TabPane.style.visibility = 'hidden';
                TabPane1.className = '';
            }
            return false;
        }

        function OpenAssetPopup() {
            var selectedId = $("[id$='hdnRefreshInspectionData']")[0].value
            if (selectedId == null || selectedId <= 0) return false;
            return OpenPOPUp('SelectAsset.aspx?Id=6&From=InspectionPopup', 350, 700)
        }
    </script>
</telerik:RadScriptBlock>

<div class="PMHeader">
    <div class="row">
        <div class="col-12">
            <table id="tblInspectionImage" runat="server" style="width: 100%;" border="0" cellpadding="0" cellspacing="0" class="colTable">
                <tr>
                    <td>
                        <telerik:RadSplitter ID="RadSplitter1" runat="server" Height="523px" CssClass="drawing-viewer-rdsplitter" BackColor="White" EnableImageSprites="true" Width="99%">
                            <telerik:RadPane ID="LeftPane"  runat="server" Width="10px" Scrolling="none">
                                <telerik:RadSlidingZone ID="SlidingZone1" runat="server" ClickToOpen="true">
                                    <telerik:RadSlidingPane ID="RadSlidingPane1"  Width="310px" Style="position: relative; left: 4px; top: 37px; z-index: 1000;" Title="Pane1" runat="server" OnClientBeforeExpand="OnInspectionClientBeforeExpand" OnClientCollapsed="OnInspectionClientCollapsed"
                                        MinWidth="100" ResizeText="" EnableResize="true" RenderMode="Lightweight" EnableDock="true" OnClientDocked="UpdatePanelSettings" OnClientUndocked="UpdatePanelSettings">
                                        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" Skin="Default" />
                                        <telerik:RadAjaxPanel runat="server" LoadingPanelID="ldpPM">
                                            <div id="pnlAsset" runat="server">
                                                <table style="width: 100%;background:rgb(237, 237, 237);" cellpadding="0" cellspacing="0">
                                                    <tr valign="top">
                                                        <td style="padding-left: 23px; height: 40px; padding-top: 10px">
                                                            <telerik:RadToolBar ID="mainToolBar" runat="server" Width="100%" Height="30px" OnClientButtonClicked="detailClick_handler">
                                                                <Items>
                                                                    <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                                                                        CommandName="Save" AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)"
                                                                        Value="Save">
                                                                    </telerik:RadToolBarButton>
                                                                    <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                                                                        CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete" CausesValidation="false">
                                                                    </telerik:RadToolBarButton>
                                                                    <telerik:RadToolBarButton CausesValidation="false" CommandName="Cancel" Value="Cancel" SecurityButtonType="Read" AccessKey="c" ImageUrl="Images/ToolBar/Save.png"
                                                                        meta:resourcekey="RadToolBarButton_Cancel">
                                                                    </telerik:RadToolBarButton>
                                                                </Items>
                                                            </telerik:RadToolBar>
                                                        </td>
                                                    </tr>
                                                </table>

                                                <table class="colTable InspectionTable">
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblLineNumber" runat="server" meta:Resourcekey="lblLineNumber" Text="Line #"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <asp:TextBox ID="txtLineNumber" ReadOnly="true" Enabled="false" runat="server" ></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <div style="float: left; width: 36px;">
                                                                <asp:Label ID="lblAsset" runat="server" meta:ResourceKey="lblAsset" Text="Asset"></asp:Label>
                                                            </div>
                                                            <div style="float: right;">
                                                                <asp:LinkButton runat="server" ID="imgfilter" Style="position: relative; top: 3px; left: 2px"
                                                                    OnClientClick="return OpenAssetPopup();"
                                                                    CssClass="SearchButton">
                                                    <span class="Icon"></span>
                                                                </asp:LinkButton>
                                                            </div>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <asp:TextBox ID="txtAsset" Enabled="false" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblAssetType" runat="server" meta:Resourcekey="lblAssetType" Text="Asset Type"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <asp:TextBox ID="txtAssetType" Enabled="false" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblDescription" runat="server" meta:Resourcekey="lblDescription" Text="Description"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <asp:TextBox ID="txtDescription" MaxLength="500" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblMaterial" runat="server" meta:Resourcekey="lblMaterial" Text="Material"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <telerik:RadComboBox ID="ddlMaterial" runat="server" Width="100%" meta:resourcekey="ddlMaterial"
                                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Material..."
                                                                NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableItemCaching="False"
                                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                                                Style="font-size: 11px" Height="200px">
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblCondition" runat="server" meta:Resourcekey="lblCondition" Text="Condition"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <telerik:RadComboBox ID="ddlCondition" runat="server" Width="100%" meta:resourcekey="ddlCondition"
                                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Condition..."
                                                                NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableItemCaching="False"
                                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                                                Style="font-size: 11px" Height="200px">
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblRecommend" runat="server" meta:Resourcekey="lblRecommend" Text="Recommend"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <telerik:RadComboBox ID="ddlRecommend" runat="server" Width="100%" meta:resourcekey="ddlRecommend"
                                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Recommend..."
                                                                NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableItemCaching="False"
                                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                                                Style="font-size: 11px" Height="200px">
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblPriority" runat="server" Text="Priority" meta:Resourcekey="lblPriority"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <telerik:RadComboBox ID="ddlPriority" runat="server" Width="100%" meta:resourcekey="ddlPriority"
                                                                MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EmptyMessage="Select Priority..."
                                                                NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableItemCaching="False"
                                                                EnableVirtualScrolling="true" OnItemsRequested="ddl_ItemsRequested"
                                                                Style="font-size: 11px" Height="200px">
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr valign="top">
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblNotes" runat="server" meta:Resourcekey="lblNotes" Text="Notes"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <asp:TextBox runat="server" ID="txtNotes" Text="" TextMode="MultiLine" MaxLength="50" Height="80px"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:Label runat="server" Text="Select an inspection point in the image or right click to create one" ID="lblSelectionLabel" meta:resourcekey="lblSelectionLabel"
                                                Style="margin-left: 50px; top: 220px; color: silver; position: relative;"></asp:Label>
                                            <asp:HiddenField ID="hdnRefreshInspectionData" Value="" runat="server" />
                                            <asp:HiddenField ID="hdnAssetId" Value="" runat="server" />
                                            <asp:Button runat="server" ID="btnRefreshInspectionData" CssClass="Hide" />
                                            <asp:PlaceHolder ID="pnlDrawings" runat="server"></asp:PlaceHolder>
                                        </telerik:RadAjaxPanel>

                                    </telerik:RadSlidingPane>
                                </telerik:RadSlidingZone>
                            </telerik:RadPane>
                            <telerik:RadPane ID="RadPane1" runat="server" Scrolling="None">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="background-color: #C4DBF9; border-width: 0px;" valign="top">
                                            <div class="RL_Info">
                                                <table style="width: 100%; height: 100%; background-color: #F8F8F8" cellpadding="0" cellspacing="0" border="0">
                                                    <tr>
                                                        <td style="vertical-align: top; background-color: #EFEFEF" id="tdZoomer" class="disableSelection">
                                                            <div id="divZoomer" style="position: relative; height: 510px; width: auto; overflow: auto">
                                                                <div id="Canvas" style="cursor: default; position: absolute; top: 0px; left: 0px;">
                                                                    <%--width:100%;max-width:100%;--%>
                                                                    <img id="imgCanvas" runat="server" />
                                                                    <%--style="width:100%;height:100%;max-width:100%;"--%>
                                                                    <div id="divResize">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>

                                        </td>
                                    </tr>
                                </table>
                            </telerik:RadPane>
                        </telerik:RadSplitter>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>

<div style="margin-top:10px;">

</div>
<div id="divUpload" runat="server" style="width: 70%; margin: 5%; padding: 10%; border: 5px solid silver; border-style: dashed;">
    <telerik:RadAsyncUpload runat="server" ID="rauInspectionImage" Skin="Default" OnClientFileUploadFailed="onDocFileUploadFailed" Width="100px" Style="margin-left: 30%; display: inline-block"
        ToolTip="Click button to select file to upload or drop one in this box"
        OnClientFileSelected="onDocFileSelected" OnClientFileUploaded="onDocFileUploaded"
        MultipleFileSelection="Automatic" OnClientValidationFailed="ClientDocFileValidationFailed" HideFileInput="true">
        <Localization Select="Select" />
    </telerik:RadAsyncUpload>
    <div style="display: inline-block; text-align: center;">
        <label id="lblUpload" meta:resourcekey="lblUpload" runat="server" style="position: relative; top: 4px;">Click button to select file to upload or drop one in this box </label>
    </div>

</div>

<asp:Button ID="btnRefreshUserImage" runat="server" CssClass="Hide" />

<telerik:RadContextMenu ID="rcmInspection" EnableImageSprites="true" runat="server" OnClientItemClicking="RadContextMenu_ClientItemClicking" OnClientShowing="OnMenuShowing">
    <Targets>
        <telerik:ContextMenuElementTarget ElementID="Canvas" />
    </Targets>
    <Items>
        <telerik:RadMenuItem Value="AddPoint" Text="Add a Point"></telerik:RadMenuItem>
        <telerik:RadMenuItem Value="MoveSelectedPoint" Text="Move Selected Point"></telerik:RadMenuItem>
        <telerik:RadMenuItem Value="DeleteSelectedPoint" Text="Delete Selected Point"></telerik:RadMenuItem>
    </Items>
</telerik:RadContextMenu>




