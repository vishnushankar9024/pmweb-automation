<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ViewInspectionDetailPopup.aspx.vb" Inherits="Website.ViewInspectionDetailPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc2" %>
<%@ Register Src="InspectionDynamicFields.ascx" TagName="InspectionDynamicFields" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Inspection Details</title>
    <style>
        .dynamicFields >tbody{display:flex;flex-direction:column}
        .FirstArrow {
            background-image: url('CSS/Images/ResponsiveIcons/16x16 EnabledNewest.png') !important;
            background-position: -1968px 0px !important;
            display: inline-block !important;
            width: 16px !important;
            height: 16px !important;
            transform: rotate(-90deg);
        }

        .BackArrow {
            background-image: url('CSS/Images/ResponsiveIcons/16x16 EnabledNewest.png') !important;
            background-position: -177px 0px !important;
            display: inline-block !important;
            width: 16px !important;
            height: 16px !important;
        }

        .ForWardArrow {
            background-image: url('CSS/Images/ResponsiveIcons/16x16 EnabledNewest.png') !important;
            background-position: -191px 0px !important;
            display: inline-block !important;
            width: 16px !important;
            height: 16px !important;
        }

        .LastArrow {
            background-image: url('CSS/Images/ResponsiveIcons/16x16 EnabledNewest.png') !important;
            background-position: -1968px 0px !important;
            display: inline-block !important;
            width: 16px !important;
            height: 16px !important;
            transform: rotate(90deg);
        }
    </style>
    <script>
        function detailClick_handler(sender, args) {
            $("[id$='hdnDrawPoint']")[0].value = '';
            var value = args.get_item().get_commandName();
            if (value == "Delete") {
                var result = ConfirmDelete();
                if (result == false) {
                    args.set_cancel(true);
                    return false;
                }
                DeleteSelectedPointFromGrid(false);
            }
            else if (value == "New") {

                $("[id$='hdnRefreshInspectionData']")[0].value = 0;
                $("[id$='hdnGridId']")[0].value = 0;
                $("[id$='btnRefreshInspectionData']")[0].click();
            }


        }
        function DeleteSelectedPointFromGrid(bool) {
            var selectedId = $("[id$='hdnRefreshInspectionData']")[0].value
            var selectedLineNumber;
            if (selectedId == null || selectedId <= 0) return false;
            for (var i = 0; i < arrDrawings.length; i++) {
                elementId = arrDrawings[i].ID
                if (elementId == selectedId) {
                    selectedLineNumber = arrDrawings[i].LineNumber;
                    arrDrawings.splice(i, 1);
                }
            }
            if (bool) {
                for (var i = 0; i < arrDrawings.length; i++) {
                    if (selectedLineNumber < arrDrawings[i].LineNumber) {
                        arrDrawings[i].LineNumber = arrDrawings[i].LineNumber - 1;
                    }
                }
            } else {
                //document.getElementById("ctl00_CPH1_InspectionImage1_lblSelectionLabel").style.display = "block";
                //document.getElementById("ctl00_CPH1_InspectionImage1_pnlAsset").style.display = "none";
                //document.getElementById("lblSelectionLabel").style.display = "block";
                $("[id$='hdnRefreshInspectionData']")[0].value = 0;
                $("[id$='hdnGridId']")[0].value = 0;
                $("[id$='btnRefreshInspectionData']")[0].click();

            }
            //LoadAllInspectionPoints();
        }

        function LoadFirst() {
            $("[id$='hdnDrawPoint']")[0].value = '';
            var selectedId = $("[id$='hdnRefreshInspectionData']")[0].value;
            if (selectedId == null || selectedId <= 0) return false;
            RefreshInspectionData(arrDetails[0].ID);
        }

        function LoadPrevious() {
            $("[id$='hdnDrawPoint']")[0].value = '';
            var selectedId = $("[id$='hdnRefreshInspectionData']")[0].value;
            if (selectedId == null || selectedId <= 0) return false;
            for (var i = 0; i < arrDetails.length; i++) {
                elementId = arrDetails[i].ID
                if (elementId == selectedId) {
                    RefreshInspectionData(arrDetails[i - 1].ID)
                }
            }
            //redrawPoints()


        }
        function LoadNext() {
            var selectedId = $("[id$='hdnRefreshInspectionData']")[0].value;
            $("[id$='hdnDrawPoint']")[0].value = '';
            if (selectedId == null || selectedId <= 0) return false;
            for (var i = 0; i < arrDetails.length; i++) {
                elementId = arrDetails[i].ID
                if (elementId == selectedId) {
                    RefreshInspectionData(arrDetails[i + 1].ID)
                }
            }
            //redrawPoints()
        }
        function LoadLast() {
            $("[id$='hdnDrawPoint']")[0].value = '';
            var selectedId = $("[id$='hdnRefreshInspectionData']")[0].value;
            if (selectedId == null || selectedId <= 0) return false;
            RefreshInspectionData(arrDetails[arrDetails.length - 1].ID)
        }

        var MobileScreenWidth = 1024;
        function isMobileScreen() {
            var browserWidth = $telerik.$(window).width();
            if (browserWidth <= MobileScreenWidth)
                return true;
            return false;
        }

        function OpenSelectAssetPopupFromDetailPopup() {
            var ParentWidth = $telerik.$(window.parent).width();
            var Parentheight = $telerik.$(window.parent).height();
            var wnd = window.parent.radopen('SelectAsset.aspx?Id=6&opener=btnAssetFlyoutPopup', 1035, 710, true);
            wnd._iframe.parentElement.parentElement.parentElement.parentElement.parentElement.classList.add("DoublePopupWindow");

            wnd.add_close(clickAddAssetButtonPoppup)
            if (isMobileScreen()) {
                wnd.setSize(ParentWidth - 75, Parentheight - 50);
                wnd.Center();

            }
            else {
                wnd.setSize(ParentWidth - 200, Parentheight - 150);
                wnd.Center();
            }
            return false;
        }

        function clickAddAssetButtonPoppup(wnd) {
            var IsAssetSaved = $(window.parent.document).find("[id$=hdnAssetSaved]")[0].value;
            if (IsAssetSaved == 1) {
                $(window.parent.document).find("[id$=hdnAssetSaved]")[0].value = "0";
                var btn = $("input[id$=btnAddAssetToPopup]");
                btn.click();
            }
            wnd.remove_close(clickAddAssetButtonPoppup);
        }

        function OpenInspectionviewAttachmentPopup(DocumentType, LineId, DocumentId, EntityTypeId, EntityId, IsLastRevision) {
            var ParentWidth = $telerik.$(window.parent).width();
            var Parentheight = $telerik.$(window.parent).height();
            var wnd = window.parent.radopen('ViewAttachments.aspx?DocumentType=' + DocumentType + '&LineId=' + LineId + '&DocumentId=' +
                 DocumentId + '&EntityTypeId=' + EntityTypeId + '&EntityId=' + EntityId +
                  '&IsLastRevision=' + IsLastRevision, true);
            wnd._iframe.parentElement.parentElement.parentElement.parentElement.parentElement.classList.add("DoublePopupWindow");
            wnd.add_close(OnAttachmentPopupClosed)
            if (isMobileScreen()) {
                wnd.setSize(ParentWidth - 75, Parentheight - 50);
                wnd.Center();

            }
            else {
                wnd.setSize(ParentWidth - 200, Parentheight - 150);
                wnd.Center();
            }

            return false;
        }
        function OnAttachmentPopupClosed() {
            $("[id$='btnRefreshViewDetailsAfterClose']")[0].click()
        }
        function RefreshInspectionData(id) {
            var isMin = true;
            var isMax = true;
            var index = arrDetails.findIndex(el => el.ID == id)
            for (var i = 0; i < arrDetails.length; i++) {
                if (arrDetails[i].LineNumber > arrDetails[index].LineNumber)
                    isMax = false;
                if (arrDetails[i].LineNumber < arrDetails[index].LineNumber)
                    isMin = false;
            }

            //if (isMax == true) 
            //    ForWardArrow.Enabled = "false";
            //else
            //    ForWardArrow.Enabled = "true";

            if ((isMin == true)) {
                $("[id$='hdnBackArrowDisabled']")[0].value = 'true'

            }
            else {
                $("[id$='hdnBackArrowDisabled']")[0].value = 'false'
            }


            if (isMax == true) {
                $("[id$='hdnForwardArrowDisabled']")[0].value = 'true'
            }

            else {
                $("[id$='hdnForwardArrowDisabled']")[0].value = 'false'
            }


            $("[id$='hdnRefreshInspectionData']")[0].value = id;
            $("[id$='btnRefreshInspectionData']")[0].click();

        }

    </script>
    <telerik:radwindowmanager id="PMWindowManager" runat="server" visiblestatusbar="False"
        reloadonshow="True" modal="True" keepinscreenbounds="True" behavior="Default"
        iconurl="Images/Global/favicon.ico" initialbehavior="None" left="" style="display: none;"
        top="">
    </telerik:radwindowmanager>
</head>
<body>

    <form id="form1" runat="server">


        <telerik:radajaxloadingpanel id="ldpPM" runat="server" skin="Default" />
        <telerik:radajaxpanel runat="server" loadingpanelid="ldpPM">
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr class="ToolBar">
                    <td valign="middle" align="left" class="ToolbarTd">
                        <telerik:RadToolBar ID="mainToolBar" runat="server" CssClass="popup-toolbar" OnClientButtonClicked="detailClick_handler">
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
                                    Value="Save">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" ValidationGroup="Users"
                                    CommandName="SaveAndExit" AccessKey="s" Value="SaveAndExit">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="true" ImageUrl="Images/Global/AddLine.png" Value="New" CssClass="NewEntry"
                                    CommandName="New">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" OnClick="javascript:return ConfirmDelete();"
                                    CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete" CausesValidation="false">
                                </telerik:RadToolBarButton>

                            </Items>
                        </telerik:RadToolBar>
                    </td>
                </tr>
            </table>
            <div id="pnlAsset" runat="server">
                <div class="PMMainPage PMPopupMainPage R24SidePadding">
                    <div class="row documentSinglePage">
                        <div class="col-4">
                            <table class="colTable dynamicFields">
                               <tr runat="server" id="trLineNumber">
                                    <td class="labelWidth" style="width: 160px !important">
                                        <asp:Label ID="lblLineNumber" runat="server" meta:Resourcekey="lblLineNumber" Text="Line #" ></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtLineNumber" ReadOnly="false" Enabled="false" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                 <tr  runat="server"  id="trAttachment">
                                    <td class="labelWidth" style="width: 160px !important">
                                        <div style="float: left; width: 128px/*; height: 24px*/">
                                            <asp:Label ID="lblAttachment" runat="server"  meta:Resourcekey="lblAttachment" Text="Attachment"></asp:Label>
                                        </div>
                                        <div style="float: right; /*height: 24px*/">
                                            <asp:LinkButton runat="server" ID="btnAttachment" Style="position: relative; left: 2px" CssClass="SearchButton">
                                                    <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtAttachment" ReadOnly="false" Enabled="false" runat="server"></asp:TextBox>

                                    </td>
                                </tr>
                                <tr runat="server"  id="trAsset">
                                    <td class="labelWidth" style="width: 160px !important">
                                        <div style="float: left; width: 128px">
                                            <asp:Label ID="lblAsset" runat="server" meta:ResourceKey="lblAsset" Text="Asset"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton runat="server" ID="btnAsset" Style="position: relative; left: 2px" CssClass="SearchButton" OnClientClick="return OpenSelectAssetPopupFromDetailPopup();">
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
                                    <td class="labelWidth" style="width: 160px !important">
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
                        <div class="col-4">
                            
                            <uc2:AssetRotator ID="PMrot" runat="server" />
                        </div>

                    </div>

                </div>
            </div>

            <%--<asp:Label runat="server" Text="Click here to create a selection point" ID="lblSelectionLabel" meta:resourcekey="lblSelectionLabel"
                                                Style="margin-left: 50px; top: 220px; font-size: 14px; color: #666;opacity:0.7; position: relative;"></asp:Label>--%>
            <asp:HiddenField ID="hdnRefreshInspectionData" Value="" runat="server" />
            <asp:HiddenField ID="hdnForwardArrowDisabled" Value="" runat="server" />
            <asp:HiddenField ID="hdnBackArrowDisabled" Value="" runat="server" />
            <asp:HiddenField ID="hdnGridId" Value="" runat="server" />
            <asp:HiddenField ID="hdnAssetId" Value="" runat="server" />
            <asp:HiddenField ID="hdnMouseX" Value="" runat="server" />
            <asp:HiddenField ID="hdnMouseY" Value="" runat="server" />
            <asp:Button runat="server" ID="btnRefreshInspectionData" CssClass="Hide" />
            <asp:Button runat="server" ID="btnRefreshViewDetailsAfterClose" CssClass="Hide" />
            <asp:HiddenField ID="hdnDrawPoint" Value="" runat="server" />
            <asp:PlaceHolder ID="pnlDrawings" runat="server"></asp:PlaceHolder>
            <asp:Button ID="btnAddAssetToPopup" runat="server" CssClass="Hide" />
        </telerik:radajaxpanel>


    </form>

</body>
</html>
