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
        </style>
        <script language="javascript" type="text/javascript">

            var uploadsDocFileInProgress = 0;

            function onDocFileSelected(sender, args) {

                //if (uploadsDocFileInProgress == 2) {
                //    $telerik.$(".ruRemove", args.get_row()).click();
                //return;
                //}
                uploadsDocFileInProgress++;

            }

            function onDocFileUploading(sender, args) {
                var async = $find("rauAttachment");
                $telerik.$(".ruCancel", async.get_element()).bind('click', function () {
                    decrementUploadsDocFileInProgress();
                    args.set_cancel(true)
                });
            }

            function ClearLoadingMessage(rnd) {
                var DivUploadingMessage = $("span[id$=DivUploadingMessage]");
                DivUploadingMessage.hide();
            }

            function onDocFileUploaded(sender, args) {
                decrementUploadsDocFileInProgress();
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


        </script>
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" EnablePageHeadUpdate="true">
            <%--<AjaxSettings>
         <telerik:AjaxSetting AjaxControlID="btnRefreshAttributesGrid">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="btnRefreshAttributesGrid" />
                <telerik:AjaxUpdatedControl ControlID="rdgAttributes" LoadingPanelID="ldpPM"/>
                <telerik:AjaxUpdatedControl ControlID="lblResult" />
            </UpdatedControls>
            </telerik:AjaxSetting>                      
        </AjaxSettings>--%>
        </telerik:RadAjaxManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr id="trToolBar" runat="server">
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                                    <Items>
                                        <telerik:RadToolBarButton CausesValidation="true" ValidationGroup="Save" EnableImageSprite="true" CssClass="ToolbarSaveAndExit"
                                            CommandName="SaveAndExit">
                                        </telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CausesValidation="false" CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel">
                                        </telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div class="PMMainPage PMPopupMainPage documentSinglePage">
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
                <div class="col-12" style="padding-top:24px;">
                    <table class="colTable">
                        <tr>
                            <td>
                                <telerik:RadGrid ID="rdgAttributes" runat="server"
                                    AutoGenerateColumns="False" ShowStatusBar="True" HeaderStyle-Font-Size="8" Width="100%"
                                    ShowGroupPanel="False" AllowMultiRowEdit="false" AllowFilteringByColumn="False" SetWidth="true" FitParentContainer="true" ClientSettings-Scrolling-AllowScroll="true"
                                    AllowMultiRowSelection="False" AllowSorting="False" ItemStyle-Height="20px" GridLines="None"
                                    AllowPaging="false">
                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                        DataKeyNames="FileGuid" CommandItemDisplay="None" TableLayout="Fixed" UseAllDataFields="true"
                                        EnableHeaderContextMenu="False" Width="100%">
                                        <Columns>
                                            <telerik:GridTemplateColumn HeaderText="File" HeaderStyle-Width="200px" ItemStyle-Wrap="false"
                                                UniqueName="FileName" DataField="FileName">
                                                <ItemTemplate>
                                                    <span style="white-space: nowrap !important">
                                                        <%# IIf(Container.DataItem("FileName").ToString = String.Empty, "&nbsp;", Container.DataItem("FileName").ToString)%></span>
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
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <asp:Button ID="btnRefreshAttributesGrid" runat="server" CssClass="Hide" />
    </form>
</body>
</html>
