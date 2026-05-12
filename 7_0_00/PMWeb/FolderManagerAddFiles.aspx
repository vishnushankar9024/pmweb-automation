<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="FolderManagerAddFiles.aspx.vb"
    Inherits="Website.FolderManagerAddFiles" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add File(s)</title>
</head>
<body>
    <form id="form1" runat="server">
        <style type="text/css">
            .RadGrid_PM .rgRow td div, .RadGrid_PM .rgAltRow td div, .RadGrid_PM .rgRow td span, .RadGrid_PM .rgAltRow td span {
                white-space: normal !important;
                text-align: left;
            }

            .RadGrid .rgRow td div, .RadGrid .rgAltRow td div, .RadGrid .rgRow td span, .RadGrid .rgAltRow td span {
                white-space: normal !important;
                text-align: left;
            }

            #rdgAttributes .rgDataDiv{
                height:100% !important;
                overflow-x:auto !important;
                overflow-y:hidden !important;
            }

            /*.deleteContainer {
                position: absolute;
                margin-top: -7px;
            }*/

            .deleteLinkButton {
                position: absolute;
                left: 26px;
                display: inline-block;
            }

            .RadInput {
                display: initial !important;
            }

            .RadUpload .ruFakeInput {
                float: left !important;
                margin-top: 1px !important;
                margin-left: 0px !important;
                margin-right: 2px !important;
                width: 295px !important;
            }

            .deleteIcon {
                width: 16px;
                height: 16px;
                display: block;
                background-image: url('CSS/Images/ResponsiveIcons/16Enabled.png');
                background-position: -512px 0px;
            }

            .RadGrid_Default .rgMasterTable tbody tr.rgFooter > td.LabelValidator {
                color: #FF2400 !important;
                background-color: #fff !important;
                border: none !important;
                text-align: left !important;
            }

            .RadGrid.RadGrid_Default.rdgAttributes .rgFooter > td {
                background-color: #fff !important;
                border: none !important;
            }

            .RadGrid.RadGrid_Default.rdgAttributes {
                border: none !important;
            }

                .rgDataDiv,
                .RadGrid.RadGrid_Default.rdgAttributes .rgHeaderWrapper {
                    border-left: 1px solid #666 !important;
                    border-right: 1px solid #666 !important;
                    box-sizing: border-box;
                }


            .RadGrid_Default .rgFooterDiv, .RadGrid_Default .rgFooterWrapper {
                margin-right: 0 !important;
            }

            .RadGrid.RadGrid_Default.rdgAttributes .rgHeaderWrapper {
                border-top: 1px solid #666 !important;
            }

            .ErrorCell {
                border-color: #FF2400 !important;
                border-width: 1px !important;
            }

            .rgHeaderWrapper .rgHeaderDiv{
                    margin-right: 0px !important;
            }

            .RadToolBar .rtbOuter {
                background-color: white !important;
            }

            .documentSinglePage {
                margin-top: 100px !important;
            }

            .ToolBar {
                border-bottom: 1px solid RGB(237,237,237);
            } 

            @media screen and (max-width: 467px) {
                .deleteLinkButton {
                    left: 10px;
                }
            }
        </style>
        <script language="javascript" type="text/javascript">


            var attributes = new Map();
            var lstAttrId = [];
                function RefreshPmwebRecords() {
                    if (window.parent.location.href.toLowerCase().indexOf('pmwebrecord') > 0) {

                        window.parent.refreshPage = true;
                    }
                }

                function RedirectPmwebRecords() {
                    if (window.parent.location.href.toLowerCase().indexOf('pmwebrecord') > 0) {

                        window.parent.RedirectPage();
                    }
                }
            function copyDown() {
                lstAttrId = [];
                attributes.clear();
                $.ajax({
                    type: "POST",
                    url: "AjaxService.aspx/GetAttributes",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    success: function (data) {
                        if (data.d.length > 0) {
                            $(data.d).each(function (index, attr) {
                                lstAttrId.push(attr.Id);
                                attributes.set(attr.Id, attr.TypeId);
                            });
                            debugger;
                            lstAttrId.forEach(function (el) {
                                var typeId = attributes.get(el);
                                switch (typeId) {
                                    case "1":
                                        var nbr = 6;
                                        var firstElement = document.querySelector("#rdgAttributes_ctl00_ctl04_txt_Att" + el);
                                        var value = firstElement.value;
                                        while (nbr < 10 ? document.querySelector("#rdgAttributes_ctl00_ctl0" + nbr + "_txt_Att" + el) : document.querySelector("#rdgAttributes_ctl00_ctl" + nbr + "_txt_Att" + el)) {
                                            var element = nbr < 10 ? document.querySelector("#rdgAttributes_ctl00_ctl0" + nbr + "_txt_Att" + el) : document.querySelector("#rdgAttributes_ctl00_ctl" + nbr + "_txt_Att" + el);
                                            element.value = value;
                                            nbr = nbr + 2;
                                        }
                                        break;
                                    case "2":
                                        var nbr = 6;
                                        var firstElement = $find("rdgAttributes_ctl00_ctl04_dtp_Att" + el);
                                        var value = firstElement.get_selectedDate();
                                        while (nbr < 10 ? $find("rdgAttributes_ctl00_ctl0" + nbr + "_dtp_Att" + el) : $find("rdgAttributes_ctl00_ctl" + nbr + "_dtp_Att" + el)) {
                                            var element = nbr < 10 ? $find("rdgAttributes_ctl00_ctl0" + nbr + "_dtp_Att" + el) : $find("rdgAttributes_ctl00_ctl" + nbr + "_dtp_Att" + el);
                                            element.set_selectedDate(value);
                                            nbr = nbr + 2;
                                        }
                                        break;
                                    case "3":
                                        var nbr = 6;
                                        var firstElement = document.querySelector("#rdgAttributes_ctl00_ctl04_Chk_Att" + el);
                                        var checked = firstElement.checked;
                                        while (nbr < 10 ? document.querySelector("#rdgAttributes_ctl00_ctl0" + nbr + "_Chk_Att" + el) : document.querySelector("#rdgAttributes_ctl00_ctl" + nbr + "_Chk_Att" + el)) {
                                            var element = nbr < 10 ? document.querySelector("#rdgAttributes_ctl00_ctl0" + nbr + "_Chk_Att" + el) : document.querySelector("#rdgAttributes_ctl00_ctl" + nbr + "_Chk_Att" + el);
                                            element.checked = checked;
                                            nbr = nbr + 2;
                                        }
                                        break;


                                    case "4":
                                        var nbr = 6;
                                        var firstElement = $find("rdgAttributes_ctl00_ctl04_ddl_Att" + el);
                                        var value = firstElement.get_value();
                                        var text = firstElement.get_text();
                                        while (nbr < 10 ? $find("rdgAttributes_ctl00_ctl0" + nbr + "_ddl_Att" + el) : $find("rdgAttributes_ctl00_ctl" + nbr + "_ddl_Att" + el)) {
                                            var element = nbr < 10 ? $find("rdgAttributes_ctl00_ctl0" + nbr + "_ddl_Att" + el) : $find("rdgAttributes_ctl00_ctl" + nbr + "_ddl_Att" + el);
                                            element.set_value(value);
                                            element.set_text(text);
                                            nbr = nbr + 2;
                                        }
                                        break;
                                    case "5":
                                        var nbr = 6;
                                        var firstElement = document.querySelector("#rdgAttributes_ctl00_ctl04_txtNumber_Att" + el);
                                        var value = firstElement.value;
                                        while (nbr < 10 ? document.querySelector("#rdgAttributes_ctl00_ctl0" + nbr + "_txtNumber_Att" + el) : document.querySelector("#rdgAttributes_ctl00_ctl" + nbr + "_txtNumber_Att" + el)) {
                                            var element = nbr < 10 ? document.querySelector("#rdgAttributes_ctl00_ctl0" + nbr + "_txtNumber_Att" + el) : document.querySelector("#rdgAttributes_ctl00_ctl" + nbr + "_txtNumber_Att" + el);
                                            element.value = value;
                                            nbr = nbr + 2;
                                        }
                                        break;
                                }
                            });
                        }
                    },
                    error: function (err) {
                        alert(err);
                    }
                });

                return false;
            }

            var uploadsDocFileInProgress = 0;

            function onDocFileSelected(sender, args) {

                //if (uploadsDocFileInProgress == 2) {
                //    $telerik.$(".ruRemove", args.get_row()).click();
                //return;
                //}
                uploadsDocFileInProgress++;

            }

            function onDocFileUploading(sender, args) {
                // while(){

                var async = $find("rauAttachment");
                $telerik.$(".ruCancel", async.get_element()).bind('click', function () {
                    decrementUploadsDocFileInProgress();
                    args.set_cancel(true)
                });
                // }

            }

            function ClearLoadingMessage(rnd) {
                var DivUploadingMessage = $("span[id$=DivUploadingMessage]");
                DivUploadingMessage.hide();
            }

            function onDocFileUploaded(sender, args) {
                decrementUploadsDocFileInProgress();
                debugger;
                if (uploadsDocFileInProgress <= 0) {
                    var btnRefreshAttributesGrid = $("[id$=btnRefreshAttributesGrid]");
                    if ($('#rdgAttributes').length == 0) {
                        var DivUploadingMessage = $("Div[id$=DivUploadingMessage]");
                        DivUploadingMessage.show();
                    }
                    document.getElementById("lblResult").innerText = "";
                    btnRefreshAttributesGrid.click();
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

            function addedDocFile(sender, args) {
                if (document.getElementById('lblUploadOption')) {
                    if (Telerik.Web.UI.RadAsyncUpload.Modules.FileApi.isAvailable()) {
                        $("#lblUploadOption").html(lblUploadOptionChFFText);
                    } else {
                        //$("#lblUploadOption").html(lblUploadOptionIEText);
                        document.getElementById('tdUploadOption').style.display = 'none';
                        document.getElementById('rauAttachment').style["padding-top"] = "15px !important";

                    }
                }
            }

            function ClientDocFileValidationFailed(sender, args) {
                decrementUploadsDocFileInProgress();
                alert(WarningMsg_InvalidFile);
            }

            function CloseParent() {
                if (window.parent.location.toString().toLowerCase().indexOf("foldermanager.aspx") > -1)
                    window.parent.document.querySelector("#ctl00_CPH1_btnRefreshCurrentWorkingFolder").click();
                else {
                    for (var i = 0; i < window.parent.length; i++) {
                        if (typeof window.parent[i].rebindFileGrid === 'function')
                            window.parent[i].rebindFileGrid();
                    }
                }

            }
            function showAttributes() {
                var divAttr = document.querySelector("#divAttributes");
                divAttr.style.display = "block";
            }
            function hideAttributes() {
                var divAttr = document.querySelector("#divAttributes");
                divAttr.style.display = "none";
            }
        </script>
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>

        <telerik:RadAjaxManager ID="RadajaxManager1" EnablePageHeadUpdate="true" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgAttributes">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgAttributes" LoadingPanelID="test" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>

        <telerik:RadAjaxLoadingPanel ID="test" runat="server" Skin="Default" />

        <div class="ProfileTitle">
            <asp:Label runat="server" ID="TitleUser" Text=""></asp:Label>
            <asp:LinkButton runat="server" CssClass="closepopup" ID="btnCloseProfilePopup" OnClientClick="window.close();return false;">
        <div class="CloseProfilePopup">
                                                                                 &nbsp;
                                                                            </div></asp:LinkButton>
        </div>
        <table class="ToolBar NewStylePopupToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr id="trToolBar" runat="server" valign="top">
                <td valign="top">
                    <table style="width: 100%;" cellpadding="0" cellspacing="0"  border="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true"  Width="100%" CssClass="small-toolbar">
                                    <Items>
                                        <telerik:RadToolBarButton CausesValidation="true" ValidationGroup="Save" EnableImageSprite="true" CssClass="ToolbarSaveAndExit"
                                            CommandName="SaveAndExit" Style="margin-right: -8px !important;">
                                        </telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CausesValidation="false" CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel" Style="margin-right: -8px !important;">
                                        </telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                            <td class="ToolbarTd" style="width: 100%;">
                                <asp:Button ID="btnCopyDown" runat="server" Text="Copy Down" Style="width: 90px; display: inline; margin-left:-8px !important;" OnClientClick="copyDown();return false;" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div class="PMMainPage PMPopupMainPage documentSinglePage TitleToolbarTop">
            <div class="row">
                <div class="col-12">
                    <table class="colTable">
                        <tr>
                            <td>
                                <%--<fieldset>
                                    <legend>
                                        <asp:Label ID="lblFilesUpload" runat="server" meta:resourcekey="lblFilesUpload" Text="Files Upload"></asp:Label>
                                    </legend>--%>
                                <%--  <asp:Panel ID="pnlQuickFileUpload" runat="server">
                                    <table border="0" style="width: 100%">
                                        <tr>
                                            <td align="left">
                                                <fieldset style="border: 5px dashed #d5d5d5 !important; width: 98% !important">
                                                    <div id="UploadDropZone">
                                                        <table border="0">
                                                            <tr>
                                                                <td>
                                                                    <div id="DivUploadingMessage" runat="server" style="display: none;">
                                                                        <asp:Label ID="lblUploadingMessage" runat="server" meta:resourcekey="lblUploadingMessage" Text="Files are being processed, please wait " Style="padding-left: 5px; font-weight: bold; color: #818181;">
                                                                        </asp:Label>
                                                                        <img src="Images/Toolbox/dots.gif" style="height: 5px;" />
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="left">--%>
                                <table style="width: 100%">
                                    <tr>
                                        <td>
                                            <div id="DivUploadingMessage" runat="server" style="display: none;">
                                                <asp:Label ID="lblUploadingMessage" runat="server" meta:resourcekey="lblUploadingMessage" Text="Files are being processed, please wait " Style="padding-left: 5px; font-weight: bold; color: #818181;">
                                                </asp:Label>
                                                <img src="Images/Toolbox/dots.gif" style="height: 5px;" />
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                                <telerik:RadAsyncUpload runat="server" ID="rauAttachment" Skin="Default" OnClientFileUploadFailed="onDocFileUploadFailed"
                                    OnClientFileSelected="onDocFileSelected" OnClientFileUploaded="onDocFileUploaded" OnClientFileUploading="onDocFileUploading"
                                    OnClientAdded="addedDocFile" MultipleFileSelection="Automatic" OnClientValidationFailed="ClientDocFileValidationFailed"
                                    OnFileUploaded="rauAttachment_FileUploaded" HideFileInput="true" Width="100%" CssClass="ProjectCenterUpload">
                                    <Localization Select="<%$ Resources:PMWeb, ProjectCenterSelect %>" />
                                </telerik:RadAsyncUpload>
                                <%-- </td>
                                                                <td id="tdUploadOption" style="text-align: left; padding-left: 10px; color: #999999; background-color: #FFFFFF;" runat="server">
                                                                    <span id="lblUploadOption"></span>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </fieldset>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>--%>
                                <%--</fieldset>--%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblResult" runat="server" CssClass="Validator"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-12" id="divAttributes" style="padding-top: 24px;">
                    <%--<div style="width: 40px; padding-top: 31px; display: inline-block; float: left; display: none" id="divRpt" runat="server" visible="false">
                        <asp:Repeater ID="rptDeleteFolder" runat="server">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkBtnDelete" runat="server" Style="display: block; margin-top: 14px;" CommandName='<%#Eval("FileGuid") %>'>
                                    <div class="deleteIcon" ></div>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>--%>
                    <div id="divgrid" runat="server">
                        <telerik:RadGrid ID="rdgAttributes" runat="server" ShowFooter="true" CssClass="rdgAttributes"
                            AutoGenerateColumns="False" ShowStatusBar="True" HeaderStyle-Font-Size="8" Width="100%"
                            ShowGroupPanel="False" AllowMultiRowEdit="false" AllowFilteringByColumn="False" setwidth="true" fitparentcontainer="true" ClientSettings-Scrolling-AllowScroll="true" 
                            AllowMultiRowSelection="False" AllowSorting="False" ItemStyle-Height="20px" GridLines="None"
                            AllowPaging="false">
                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                DataKeyNames="FileGuid" CommandItemDisplay="None" TableLayout="Fixed" UseAllDataFields="true"
                                EnableHeaderContextMenu="False" Width="100%">
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="File" HeaderStyle-Width="200px" ItemStyle-Wrap="false" ItemStyle-CssClass="test"
                                        UniqueName="FileName" DataField="FileName">
                                        <ItemTemplate>
                                            <div class="deleteContainer">
                                                <asp:LinkButton ID="lnkBtnDelete" runat="server" CommandName='<%#Eval("FileGuid") %>' OnClick="lnkBtnDelete_Click" CssClass="deleteLinkButton">
                                                    <div class="deleteIcon" ></div>
                                                </asp:LinkButton>
                                                <span style="white-space: nowrap !important">
                                                    <%# IIf(Container.DataItem("FileName").ToString = String.Empty, "&nbsp;", Container.DataItem("FileName").ToString & "." & Container.DataItem("Extension"))%>
                                                </span>
                                            </div>

                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Version" UniqueName="Version" ItemStyle-Wrap="false" Groupable="true" GroupByExpression="Version [GridColumn_Version] Group By Version ASC"
                                        SortExpression="Version" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <asp:Label ID="lblVersion" runat="server" Text='<%#Eval("Version")%>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle Width="50px"></HeaderStyle>
                                        <ItemStyle Wrap="False" />
                                    </telerik:GridTemplateColumn>
                                </Columns>
                            </MasterTableView>

                            <ClientSettings AllowDragToGroup="true" Resizing-AllowColumnResize="true">
                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                            </ClientSettings>
                        </telerik:RadGrid>
                    </div>
                </div>
            </div>
        </div>
        <asp:Button ID="btnRefreshAttributesGrid" runat="server" CssClass="Hide" />
    </form>
</body>
</html>
