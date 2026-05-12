<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="InspectionImage.ascx.vb" Inherits="Website.InspectionImage" %>
<%@ Register Src="InspectionDynamicFields.ascx" TagName="InspectionDynamicFields" TagPrefix="uc1" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc2" %>

<div class="PMHeader">
    <div class="row">
        <div class="col-12">
            <table id="tblInspectionImage" runat="server" style="width: 100%;" border="0" cellpadding="0" cellspacing="0" class="colTable">
                <tr>
                    <td>
                        <telerik:radsplitter id="RadSplitter1" runat="server" height="523px" cssclass="drawing-viewer-rdsplitter" backcolor="White" enableimagesprites="true" width="100%">
                            <telerik:RadPane ID="LeftPane" runat="server" Width="10px" Scrolling="none" CssClass="ImageLeftPane">
                                <telerik:RadSlidingZone ID="SlidingZone1" runat="server" ClickToOpen="true">
                                    <telerik:RadSlidingPane ID="RadSlidingPane1" Width="448px" Style="position: relative; left: 4px; top: 37px; z-index: 1000;" Title="Pane1" runat="server" OnClientBeforeExpand="OnInspectionClientBeforeExpand" OnClientCollapsed="OnInspectionClientCollapsed"
                                        MinWidth="100" ResizeText="" EnableResize="true" RenderMode="Lightweight" EnableDock="true" OnClientDocked="UpdatePanelSettings" OnClientResized="UpdatePanelSettings" OnClientUndocked="UpdatePanelSettings">
                                        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" Skin="Default" />


                                        <telerik:RadAjaxPanel id="ajaxtest" runat="server" LoadingPanelID="ldpPM" ClientEvents-OnResponseEnd="InspectionResponseEnd"  >
                                            <table style="width: 100%; background: rgb(237, 237, 237); display: flex !important;" cellpadding="0" cellspacing="0">
                                                <tr valign="top">
                                                    <td style="padding-left: 23px; height: 40px; padding-bottom: 10px">
                                                        <telerik:RadToolBar ID="mainToolBar" runat="server" Width="100%" Height="30px" OnClientButtonClicked="detailClick_handler">
                                                            <Items>
                                                                  <telerik:RadToolBarButton CausesValidation="false" CommandName="FirstArrow" Value="FirstArrow" SecurityButtonType="Read" AccessKey="c" Enabled="false" CssClass="FirstArrow"
                                                                    meta:resourcekey="RadToolBarButton_FirstArrow" Onclick="return LoadFirst()" PostBack="false">
                                                                </telerik:RadToolBarButton>
                                                                <telerik:RadToolBarButton CausesValidation="false" CommandName="BackArrow" Value="BackArrow" SecurityButtonType="Read" AccessKey="c" Enabled="false" CssClass="BackArrow"
                                                                    meta:resourcekey="RadToolBarButton_BackArrow" Onclick="return LoadPrevious()" PostBack="false">
                                                                </telerik:RadToolBarButton>

                                                                <telerik:RadToolBarButton CausesValidation="false" CommandName="ForWardArrow" Value="ForWardArrow" SecurityButtonType="Read" AccessKey="c" Enabled="false" CssClass="ForWardArrow"
                                                                    meta:resourcekey="RadToolBarButton_ForWardArrow" Onclick="return LoadNext()" PostBack="false">
                                                                </telerik:RadToolBarButton>
                                                                 <telerik:RadToolBarButton CausesValidation="false" CommandName="LastArrow" Value="LastArrow" SecurityButtonType="Read" AccessKey="c" Enabled="false" CssClass="LastArrow"
                                                                    meta:resourcekey="RadToolBarButton_LastArrow" Onclick="return LoadLast()" PostBack="false">
                                                                </telerik:RadToolBarButton>
                                                                <telerik:RadToolBarButton IsSeparator="true"></telerik:RadToolBarButton>
                                                                <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                                                                    CommandName="Save" AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)"
                                                                    Value="Save" >
                                                                </telerik:RadToolBarButton>
                                                                <telerik:RadToolBarButton PostBack="true" ImageUrl="Images/Global/AddLine.png" Value="New"
                                                                    CommandName="New">
                                                                </telerik:RadToolBarButton>
                                                                <telerik:RadToolBarButton PostBack="true"  ImageUrl="Images/Global/AddLine.png" Value="ContextMenuNewEntry" CssClass="NewEntry Hide"
                                                                    CommandName="ContextMenuNewEntry">
                                                                </telerik:RadToolBarButton>
                                                                <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" 
                                                                    CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete" CausesValidation="false" CssClass="Deletebtn">
                                                                </telerik:RadToolBarButton>
                                                                <%--    <telerik:RadToolBarButton CausesValidation="false" CommandName="Cancel" Value="Cancel" SecurityButtonType="Read" AccessKey="c" ImageUrl="Images/ToolBar/Save.png"
                                                                        meta:resourcekey="RadToolBarButton_Cancel">
                                                                    </telerik:RadToolBarButton>--%>
                                                            </Items>
                                                        </telerik:RadToolBar>
                                                    </td>
                                                    <td style="padding-top: 2px; padding-left: 10px; height: 40px; vertical-align: middle">
                                                        <telerik:RadDiagram ID="thediagram" runat="server" Selectable="false" Width="25px" Height="25px " Editable="false" ZoomMax="1" ZoomMin="1">
                                                            <ShapesCollection>
                                                                <telerik:DiagramShape Id="start" Width="22" Height="22" Type="Circle" X="1" Y="1" Fill="transparent" Editable="false" Selectable="false">
                                                                </telerik:DiagramShape>
                                                            </ShapesCollection>
                                                            <ClientEvents OnClick="OpenConfirmPopup" />
                                                        </telerik:RadDiagram>
                                                    </td>
                                                </tr>
                                            </table>
                                            <div id="pnlAsset" runat="server">
                                                <div class="PMMainPage JustifyContent">
                                                    <div class="row">
                                                        <div class="col-4 col-4-left">
                                                            <table class="colTable dynamicFields">
                                                                <tr runat="server" id="trLineNumber">
                                                                    <td class="labelWidth">
                                                                        <asp:Label ID="lblLineNumber" runat="server"  meta:Resourcekey="lblLineNumber" Text="Line #" ></asp:Label>
                                                                    </td>
                                                                    <td class="controlWidth">
                                                                        <asp:TextBox ID="txtLineNumber" ReadOnly="false" Enabled="false" runat="server"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr  runat="server"  id="trAttachment">
                                                                    <td class="labelWidth">
                                                                        <div style="float: left; width: 36px;">
                                                                            <asp:Label ID="lblAttachment" runat="server" meta:Resourcekey="lblAttachment" Text="Attachment"></asp:Label>
                                                                        </div>
                                                                        <div style="float: right;">
                                                                            <asp:LinkButton runat="server" ID="btnAttachment" Style="position: relative; left: 2px" CssClass="SearchButton">
                                                    <span class="Icon"></span>
                                                                            </asp:LinkButton>
                                                                        </div>
                                                                    </td>
                                                                    <td style="width:100%">
                                                                        <asp:TextBox ID="txtAttachment" ReadOnly="false" Enabled="false" runat="server"></asp:TextBox>

                                                                    </td>
                                                                </tr>
                                                                <tr runat="server"  id="trAsset">
                                                                    <td class="labelWidth">
                                                                        <div style="float: left; width: 36px;">
                                                                             <asp:Label ID="lblAsset" runat="server" meta:ResourceKey="lblAsset" Text="Asset" ></asp:Label>
                                                                        </div>
                                                                        <div style="float: right;">
                                                                            <asp:LinkButton runat="server" ID="btnAsset" Style="position: relative; left: 2px" CssClass="SearchButton" CommandName="InspectionlinkAsset" OnClientClick="return OpenSelectAssetPopup();"> 
                                                                                                                                                                                                                                                           
                                                    <span class="Icon"></span>
                                                                            </asp:LinkButton>
                                                                        </div>
                                                                    </td>
                                                                    <td class="controlWidth">
                                                                        <telerik:RadComboBox ID="ddlAsset" runat="server" Width="100%"
                                                                            Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false"
                                                                            NoWrap="True" AllowCustomText="true" AutoPostBack="true"
                                                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                                            OnItemsRequested="ddl_ItemsRequested"
                                                                            Style="font-size: 11px" Height="250px">
                                                                        </telerik:RadComboBox>
                                                                    </td>
                                                                </tr>
                                                                <tr runat="server"  id="trAssetType">
                                                                    <td class="labelWidth">
                                                                        <asp:Label ID="lblAssetType" runat="server" meta:Resourcekey="lblAssetType" Text="Asset Type"></asp:Label>
                                                                    </td>
                                                                    <td class="controlWidth">
                                                                        <telerik:RadComboBox ID="ddlAssetType" runat="server" Width="100%" OnSelectedIndexChanged="ddlAssetType_SelectedIndexChanged"
                                                                            Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false"
                                                                            NoWrap="True" AllowCustomText="true" AutoPostBack="true"
                                                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                                            OnItemsRequested="ddl_ItemsRequested"
                                                                            Style="font-size: 11px" Height="250px">
                                                                        </telerik:RadComboBox>
                                                                    </td>
                                                                </tr>
                                                                      <tr runat="server"  id="trCondition">
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
                                                                  <uc1:InspectionDynamicFields ID="InspectionDynamicFields1" runat="server" />                                           
                                                            </table>

                                                        </div>
                                                      
                                                        <div class="col-4 col-4-right">
                                                            <uc2:AssetRotator ID="PMrot" runat="server" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <asp:Label runat="server" Text="Click the New button to add a point" ID="lblSelectionLabel" meta:resourcekey="lblNewPoint"
                                                Style="margin-left: 50px; top: 220px; font-size: 14px; color: #666; opacity: 0.7; position: relative;"></asp:Label>
                                            <asp:HiddenField ID="hdnRefreshInspectionData" Value="" runat="server" />
                                            <asp:HiddenField ID="hdnDrawPoint" Value="" runat="server" />
                                            <asp:HiddenField ID="hdnGridId" Value="" runat="server" />
                                            <asp:HiddenField ID="hdnForwardArrowDisabled" Value="" runat="server" />
                                            <asp:HiddenField ID="hdnBackArrowDisabled" Value="" runat="server" />
                                            <asp:HiddenField ID="hdnAssetId" Value="" runat="server" />
                                            <asp:HiddenField ID="hdnMouseX" Value="" runat="server" />
                                            <asp:HiddenField ID="hdnMouseY" Value="" runat="server" />
                                            <asp:Button runat="server" ID="btnRefreshInspectionData" CssClass="Hide" />
                                            <asp:Button runat="server" ID="btnRefreshAfterClose" CssClass="Hide" />
                                            <asp:HiddenField ID="hdnAssetSaved" Value="" runat="server" />
                                            <asp:PlaceHolder ID="pnlDrawings" runat="server"></asp:PlaceHolder>
                                        </telerik:RadAjaxPanel>

                                    </telerik:RadSlidingPane>
                                </telerik:RadSlidingZone>
                            </telerik:RadPane>
                            <telerik:RadPane ID="RadPane1" runat="server" Scrolling="None" Style="height: calc(100vh - 135px) !important;">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="background-color: #C4DBF9; border-width: 0px;" valign="top">
                                            <div class="RL_Info">
                                                <table style="width: 100%; height: 100%; background-color: #F8F8F8" cellpadding="0" cellspacing="0" border="0">
                                                    <tr>
                                                        <td style="vertical-align: top; background-color: #EFEFEF" id="tdZoomer" class="disableSelection">
                                                            <div id="divZoomer" style="position: relative; height: 510px; width: auto; overflow: auto">
                                                                <div id="Canvas" class="InspectionImageImg" style="cursor: default; position: absolute; top: 0px; left: 0px;" onmousedown="ImageClick(event)"  ontouchstart="MobileImgClick(event)">
                                                                    <%--width:100%;max-width:100%;--%>
                                                                    <img id="imgCanvas" runat="server" />
                                                                    <div id="floatButtonMenu" class="floatButton" runat="server" onclick="ShowContextMenu(event)">
                                                                        <span class="circle"></span>
                                                                        <span class="circle"></span>
                                                                        <span class="circle"></span>
                                                                    </div>
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
                        </telerik:radsplitter>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>

<div style="margin-top: 10px;">
</div>
<div id="divUpload" runat="server" class="Js-DropZone" style="text-align: center; height: 510px; width: 100%">
    <div style="position: relative; top: calc(50% - 125px)">
        <input type="image" runat="server" style="height: 200px; width: 200px; display: inline-block" src="CSS/Images/ImageUpload.png" onclick="OpenSyncUpload(event)" autopostback="false" />
        <br />
        <asp:Label ID="lblUpload" meta:Resourcekey="lblUpload" runat="server" Style="font-size: 14px; color: #666; opacity: 0.7"></asp:Label>
    </div>

    <div>
        <telerik:radasyncupload runat="server" id="rauInspectionImage" skin="Default" onclientfileuploadfailed="onDocFileUploadFailed" width="100px" style="margin-left: 30%;"
            tooltip="Click button to select file to upload or drop one in this box" cssclass="Hide rauInspectionImage"
            onclientfileselected="onDocFileSelected" onclientfileuploaded="onDocFileUploaded"
            multiplefileselection="Automatic" onclientvalidationfailed="ClientDocFileValidationFailed" hidefileinput="true" dropzones=".TeamDropZone">
        <Localization Select="Select" />
    </telerik:radasyncupload>
        <asp:Button ID="btnUpload" runat="server" CssClass="Hide btnUpload" />
        <asp:FileUpload ID="fileUpload" runat="server" CssClass="Hide inputFile" />
    </div>
</div>

<asp:Button ID="btnRefreshUserImage" runat="server" CssClass="Hide" />
<asp:Button ID="btnDeleteImage" runat="server" CssClass="Hide DeleteImage" />
<asp:Button ID="btnAddAsset" runat="server" CssClass="Hide" />


<telerik:radcontextmenu id="rcmInspection" enableimagesprites="true" runat="server" onclientitemclicking="RadContextMenu_ClientItemClicking" onclientshowing="OnMenuShowing" cssclass="InspectionMenu InspectionCenteredMenu" style="border: 3px solid #316888 !important; border-radius: 8px; padding: 10px !important;">
    <Targets>
        <telerik:ContextMenuElementTarget ElementID="Canvas" />
    </Targets>
    <Items>
        <telerik:RadMenuItem Value="AddPoint" Text="Add a Point" CssClass="AddPoint"></telerik:RadMenuItem>
        <telerik:RadMenuItem Value="ChangeImage" Text="Change Image" CssClass="ChangeImage"></telerik:RadMenuItem>
        <telerik:RadMenuItem Value="DeleteImage" Text="Delete Image" CssClass="RadMenuDeleteImage"></telerik:RadMenuItem>
    </Items>
</telerik:radcontextmenu>



<telerik:radcontextmenu id="rcmInspectionPoint" enableimagesprites="true" runat="server" onclientitemclicking="RadContextMenu_ClientItemClicking" onclientshowing="OnMenuShowing" cssclass="InspectionMenu InspectionCenteredMenu">
    <Items>
        <telerik:RadMenuItem Value="AddPoint" Text="Add a Point" CssClass="AddPoint"></telerik:RadMenuItem>
        <telerik:RadMenuItem IsSeparator="true" />
        <telerik:RadMenuItem Value="ViewDetails" Text="View Details" CssClass="ViewDetails"></telerik:RadMenuItem>
        <telerik:RadMenuItem Value="RemoveSelectedPoint" Text="Remove Selected Point from Image" CssClass="RemoveSelectedPoint"></telerik:RadMenuItem>
        <telerik:RadMenuItem Value="DeleteSelectedPoint" Text="Delete Selected Point" CssClass="DeleteSelectedPoint"></telerik:RadMenuItem>
        <telerik:RadMenuItem IsSeparator="true" />
        <telerik:RadMenuItem Value="ChangeImage" Text="Change Image" CssClass="ChangeImage"></telerik:RadMenuItem>
        <telerik:RadMenuItem Value="DeleteImage" Text="Delete Image" CssClass="RadMenuDeleteImage"></telerik:RadMenuItem>
    </Items>
</telerik:radcontextmenu>



