<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ViewAttachments.aspx.vb" Inherits="Website.ViewAttachments" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Attachments</title>

    <style type="text/css">
        .ruSelectWrap {
            text-align: center !important;
        }

        .PMHeader {
            padding-top: 0px !important;
        }

        .btnRemove {
            background-image: url(../Css/Images/Upload/ruSprite.png);
            color: #0e2377;
            background-color: transparent;
            overflow: visible;
            height: 23px !important;
            border: 0;
            text-align: left;
            background-position: 2px -70px;
            width: auto;
            padding-left: 16px !important;
            cursor: pointer;
            font-size: 10px;
            width: 80px !important;
        }

        .marginleftright {
            margin-right: 24px;
            margin-left: 24px;
        }
        /***************** Green Uploader****************************/
        .RadUpload.viewAttachmentUpload {
            max-width: none;
            border-radius: 0px;
            background-color: rgb(105,185,50);
            border: 1px solid rgb(105,185,50) !important;
            padding: 6px;
            height: 100px;
        }

            .RadUpload.viewAttachmentUpload .ruFileWrap {
                height: 100px !important;
            }

        .viewAttachmentUpload .ruDropZone {
            height: 100px !important;
            background-color: rgb(105,185,50) !important;
            border-radius: 0px !important;
            color: #fff !important;
            border: 1px solid rgb(105,185,50) !important;
            padding: 0px !important;
            margin-left: 4px !important;
            padding-right: 12px !important;
            margin-top: -6px !important;
        }

        .RadUpload.viewAttachmentUpload .ruButton {
            color: #fff !important;
            width: 100% !important;
            height: 70px !important;
        }

        .RadUpload.viewAttachmentUpload .ruInputs li {
            text-align: center !important;
        }

        .RadUpload.viewAttachmentUpload:hover {
            background-color: rgb(105,185,50) !important;
        }

        .RadUpload.viewAttachmentUpload .ruFileWrap {
            line-height: 65px !important;
        }
        /*****************************************************(*/
    </style>
</head>
<body>

    <form id="form1" runat="server">
        <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
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

                function onDocFileUploaded(sender, args) {


                    decrementUploadsDocFileInProgress();

                    if (uploadsDocFileInProgress <= 0) {
                        var btnRefreshAttributesSelected = $("[id$=btnRefreshAttributesSelected]");
                        btnRefreshAttributesSelected.click();
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
                            var senderelement = sender.get_element();
                            var inputs = senderelement.getElementsByTagName("span");
                            for (var i = 0; i < inputs.length; i++) {
                                var input = inputs[i]
                                if (input.className == "ruButton ruBrowse") {
                                    $(input).html(lblBrowseIEText)
                                }
                            }
                            document.getElementById('tdUploadOption').style.display = 'none';
                            document.getElementById('rauAttachment').style["padding-top"] = "15px !important";

                        }
                    }
                }

                function ClientDocFileValidationFailed(sender, args) {
                    decrementUploadsDocFileInProgress();
                    alert(WarningMsg_InvalidFile);
                }
                function OpenFolderManagerPopup() {
                    var EntityTypeId = '<%= PM.DocumentAttachmentInfo.EntityTypeId%>'
                    var EntityId = '<%= PM.DocumentAttachmentInfo.EntityId%>'
                    var browserWidth = $telerik.$(window).width();
                    var browserHeight = $telerik.$(window).height();
                    //var wnd = window.open('FilesLookup.aspx?EntityId=' + EntityTypeId + "_" + EntityId + '&MultiSelect=1&Source=ViewAttachments', '',
                    // 'location=no,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=670,height=350,top=' + top);
                    //return false;
                    var wnd = window.radopen('FilesLookup.aspx?EntityId=' + EntityTypeId + "_" + EntityId + '&MultiSelect=1&Source=ViewAttachments');
                    if (isMobileScreen()) {
                        wnd.setSize(browserWidth - 10, browserHeight - 10);
                    }
                    else {
                        wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                        wnd.Center();
                    }
                    wnd.add_close(CloseViewAttachmentsPopup);
                    return false;
                }
                function CloseViewAttachmentsPopup() {
                    var btnRefreshAttributesSelected = $("[id$=btnRefreshAttributesSelected]");
                    if (btnRefreshAttributesSelected) {
                        btnRefreshAttributesSelected.click();
                    }
                }
                function RedirectUrl(Url) {
                    GetRadWnd().BrowserWindow.location.href = Url;
                    CloseRadWnd();
                    return false;
                }
            </script>
        </telerik:RadScriptBlock>
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadFormDecorator ID="rfdMaster" runat="server" DecoratedControls="Buttons,CheckBoxes,H4H5H6,Label,LoginControls,RadioButtons,Select,ValidationSummary" />
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" EnablePageHeadUpdate="true">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgAttachments">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgAttachments" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="flsRepeat">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="flsRepeat" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" Skin="Default" />

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td valign="top">
                    <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" Value="Save" CommandName="Save"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CausesValidation="true" ValidationGroup="Save" EnableImageSprite="true" CssClass="ToolbarSaveAndExit"
                                            CommandName="SaveAndExit" Value="SaveAndExit">
                                        </telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CausesValidation="true" ValidationGroup="Save" CommandName="Close" Value="Close" EnableImageSprite="true" CssClass="ToolbarCancel">
                                        </telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div class="PMMainPage documentSinglePage">
            <div class="row row-8-4">
                <div class="col-4">
                    <asp:Panel ID="pnlQuickFileUpload" runat="server">
                        <table class="TableNoSpacingNoBorder" style="width: 100%">
                            <tr>
                                <td id="tdUploadOption" runat="server">
                                    <telerik:RadAsyncUpload runat="server" CssClass="BigUpload viewAttachmentUpload" Skin="Default" ID="rauAttachment" OnClientFileUploadFailed="onDocFileUploadFailed" Style="height: 100px !important; box-sizing: border-box"
                                        OnClientFileSelected="onDocFileSelected" OnClientFileUploading="onDocFileUploading" OnClientFileUploaded="onDocFileUploaded" OnClientAdded="addedDocFile" HideFileInput="true"
                                        MultipleFileSelection="Automatic" OnClientValidationFailed="ClientDocFileValidationFailed" DropZones="#UploadDropZone" OnFileUploaded="rauAttachment_FileUploaded">
                                        <Localization Select="<%$ Resources:PMWeb, ProjectCenterSelect %>" />
                                    </telerik:RadAsyncUpload>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-top: 24px; text-align: center;">
                                    <asp:Button ID="btnDocumentManager" Text="Attach from Document Manager" OnClientClick="return OpenFolderManagerPopup();" runat="server" Style="width: 60%; text-decoration: none; display: inline-block; padding-left:8px !important; padding-right:8px !important;" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </div>
                <div class="col-8">
                    <fieldset style="min-height: 101px; max-height: 101px;" runat="server" id="flsRepeat">
                        <legend>
                            <asp:Label ID="lblSelected" runat="server" Text="Selected" meta:resourcekey="lblSelected"></asp:Label>
                        </legend>
                        <div style="min-height: 90px; max-height: 90px; overflow: auto;">
                            <asp:Repeater runat="server" ID="rptSelected">
                                <ItemTemplate>
                                    <table border="0">
                                        <tr>
                                            <td style="vertical-align: top">
                                                <asp:Label runat="server" ID="lblFile" Text='<%# CStr(Eval("FileNameWithExtension"))%>' Style="white-space: normal !important"></asp:Label>
                                                <asp:Button ID="btnRemove" Text="Remove" FileGuid='<%# CStr(Eval("FileGuid"))%>' class="btnRemove" runat="server"></asp:Button>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </fieldset>
                </div>
            </div>
            <div class="row ">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgAttachments" runat="server" Skin="Default" ItemStyle-HorizontalAlign="Left" AlternatingItemStyle-CssClass="Left" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" AllowMultiRowSelection="true" setwidth="true" AppendMenus="true"
                        AllowPaging="true" PageSize="10" AutoGenerateColumns="False" HeaderStyle-Font-Size="8" AllowSorting="true" ShowStatusBar="true" ShowGroupPanel="True" GroupPanelPosition="Top">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" CommandItemDisplay="Top" DataKeyNames="AttachmentId" ClientDataKeyNames="Id" InsertItemPageIndexAction="ShowItemOnFirstPage">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="" Groupable="false" AllowFiltering="false" HeaderStyle-Width="55px" ItemStyle-Wrap="false" UniqueName="AttachPreview" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Image ID="imgAttachPreview" runat="server" />&nbsp;
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Linked Line" SortExpression="Item" Groupable="False"
                                    UniqueName="Item" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Item"
                                    GroupByExpression="Item [GridColumn_Item] Group By Item">
                                    <ItemTemplate>
                                        <%#IIf(Container.DataItem("Item") = String.Empty, "&nbsp;", Container.DataItem("Item"))%>
                                    </ItemTemplate>
                                    <HeaderStyle Width="200px" />
                                    <ItemStyle Wrap="false" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="ID" SortExpression="FileId" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" DataField="FileId"
                                    AutoPostBackOnFilter="true" UniqueName="GridColumn_FileId" GroupByExpression="FileId [GridColumn_FileId] Group By FileId">
                                    <ItemTemplate>
                                        <%# Eval("FileId")%> &nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Width="80px" />
                                    <ItemStyle HorizontalAlign="Right" Wrap="false" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Description*" SortExpression="Description"
                                    UniqueName="Description" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Description"
                                    GroupByExpression="Description [GridColumn_Description] Group By Description">
                                    <ItemTemplate>
                                        <%# IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description")) %>
                                    </ItemTemplate>
                                    <HeaderStyle Width="150px" />
                                    <ItemStyle Wrap="false" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="File" HeaderStyle-Width="200px" DataField="FileNameWithExtension" CurrentFilterFunction="Contains"
                                    FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" ItemStyle-Wrap="false" UniqueName="FileNameWithExtension"
                                    SortExpression="FileNameWithExtension" GroupByExpression="FileNameWithExtension [GridColumn_FileNameWithExtension] Group By FileNameWithExtension ASC">
                                    <ItemTemplate>
                                        <div style="width: 100%; white-space: nowrap;">
                                            <asp:HyperLink ID="hplDownload" runat="server" CausesValidation="false" Style="text-decoration: underline; cursor: hand;"
                                                Text=''
                                                ToolTip="<%$ Resources:PMWeb, Download %>">
                                        <span class:"Icon" />
                                            </asp:HyperLink>
                                            <asp:LinkButton ID="imgdownlaod" runat="server" Style="border-width: 0px; cursor: pointer; float: right;"
                                                CssClass="GridCmdDownloadSelectedFiles">
                                                <span class="Icon"></span>                         
                                            </asp:LinkButton>
                                        </div>

                                        <asp:LinkButton ID="lbtAconex" runat="server" CausesValidation="false" Style="text-decoration: underline; cursor: hand;"
                                            Text="" ToolTip="<%$ Resources:PMWeb, Download %>" OnClick="lbtAconex_Click" />
                                        <asp:LinkButton ID="lbtWSS" runat="server" CausesValidation="false" Style="text-decoration: underline; cursor: hand;"
                                            Text="" ToolTip="<%$ Resources:PMWeb, Download %>" OnClick="lbtWSS_Click" />
                                        <asp:LinkButton ID="lbtEmail" runat="server" CausesValidation="false" Style="text-decoration: underline; cursor: hand;"
                                            Text="" />
                                        <asp:HyperLink ID="hliPMwebRecord" Style="text-decoration: underline; cursor: hand;" runat="server" CssClass="NoWrap"></asp:HyperLink>
                                        <asp:HyperLink ID="hplPMWebWord" Style="text-decoration: underline; cursor: hand;" runat="server" CssClass="NoWrap"></asp:HyperLink>
                                        <asp:HiddenField ID="hdnAconexUrl" runat="server" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn ItemStyle-Wrap="false" DataField="FileSize" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" DataType="System.Decimal"
                                    AutoPostBackOnFilter="true" HeaderText="Size" HeaderStyle-Width="90px" UniqueName="FileSize" SortExpression="FileSize"
                                    GroupByExpression="FileSize [GridColumn_FileSize] Group By FileSize ASC">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFileSize" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right" Wrap="false" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Version" SortExpression="FileVersion" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="FileVersion"
                                    UniqueName="FileVersion" GroupByExpression="FileVersion [GridColumn_FileVersion] Group By FileVersion">

                                    <ItemTemplate>
                                        <%# Eval("FileVersion") %> &nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Width="98px" />
                                    <ItemStyle HorizontalAlign="Right" Wrap="false" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Type" SortExpression="DisplayType" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="DisplayType"
                                    UniqueName="DisplayType" GroupByExpression="DisplayType [GridColumn_DisplayType] Group By DisplayType">
                                    <ItemTemplate>
                                        <%# Eval("DisplayType") %> &nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Width="120px" />
                                    <ItemStyle Wrap="false" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Date" CurrentFilterFunction="EqualTo" DataField="CreateDate" AutoPostBackOnFilter="true" DataType="System.DateTime" FilterListOptions="VaryByDataType"
                                    SortExpression="CreateDate" UniqueName="CreateDate" GroupByExpression="CreateDate [GridColumn_Date] Group By CreateDate">
                                    <ItemTemplate>
                                        <span><%#FormatDate(Container.DataItem("CreateDate"))%></span>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="false" />
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Attached By" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="CreatedByUserName"
                                    SortExpression="CreatedByUserName" UniqueName="AttachedBy" GroupByExpression="CreatedByUserName [GridColumn_CreatedByUserName] Group By CreatedByUserName">

                                    <ItemTemplate>
                                        <%# IIf(Container.DataItem("CreatedByUserName") = String.Empty, "&nbsp;", Container.DataItem("CreatedByUserName"))%>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="false"></ItemStyle>
                                    <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Notes" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Notes"
                                    SortExpression="Notes" UniqueName="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes">
                                    <ItemTemplate>
                                        <%# IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes")) %>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="false" />
                                    <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return ConfirmDelete();"
                                        runat="server" CommandName="DeleteRows" CssClass="GridCmdDeleteRows" SecurityButtonType="ItemMode_Delete"
                                        meta:resourcekey="btnDeleteResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblDelete" runat="server" Text="<%$ Resources:PMWeb, DeleteRows %>"></asp:Label>
                                    </asp:LinkButton>

                                    <asp:LinkButton ID="btnSaveState" runat="server" SecurityButtonType="ItemMode" CausesValidation="False"
                                        CommandName="SaveState" Visible='true'>
                                        <asp:Label ID="Label1" runat="server"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode"
                                        CausesValidation="False" CommandName="LoadDefaultState" Visible='true'>
                                        |&nbsp;&nbsp;<asp:Label ID="Label2" runat="server"></asp:Label>
                                    </asp:LinkButton>
                                </div>
                            </CommandItemTemplate>
                        </MasterTableView>
                        <ClientSettings AllowDragToGroup="true">
                            <Selecting AllowRowSelect="true" />
                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                AllowColumnResize="True" />
                        </ClientSettings>
                        <HeaderStyle Font-Size="8pt"></HeaderStyle>
                    </telerik:RadGrid>
                </div>
            </div>
        </div>
        <asp:Button ID="btnRefreshAttributesSelected" runat="server" CssClass="Hide" />
        <telerik:RadWindowManager ID="WindowManager1" runat="server" Skin="Default" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default" IconUrl="Images/Global/favicon.ico"
            InitialBehavior="None" Left="" Style="display: none;" Top="">
        </telerik:RadWindowManager>
    </form>
</body>
</html>
