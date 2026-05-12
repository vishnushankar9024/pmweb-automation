<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DocumentAttachments.ascx.vb"
    Inherits="Website.DocumentAttachments" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="PMRotator.ascx" TagName="PMRotator" TagPrefix="uc6" %>
<style type="text/css">
    .ruDropZone {
        padding: 1px;
        width: 1px;
        height: 1px;
    }
      
    .CenterDiv {
        text-align: center;
        text-align: -moz-center;
    }
     
     
.BlueBeam .BlueBeamIcon {
        background-image: url('CSS/Images/2007Small.png');
        background-repeat: no-repeat !important;
        background-position: -3552px  0px;
        display: inline-block;
        width: 16px;
        height: 16px;
    }
    .SelectButtonStyle {
        text-align: center;
        height: 32px;
        background-color: #FFFFFF;
        border: 1px solid #666666;
        border-radius: 6px;
        margin: 4px;
    }

    input.ruButton.ruBrowse {
        background: none !important;
        border: none !important;
        text-transform: uppercase !important;
        color: #666666;
    }

    @media screen and (min-width:1101px) {
        .UploadAttachmentWidth {
            width: 99% !important;
        }
    }

    @media screen and (max-width:1100px) and (min-width:600px) {
        .UploadAttachmentWidth {
            width: 98% !important;
        }
    }

    @media screen and (max-width:599px) and (min-width:400px) {
        .UploadAttachmentWidth {
            width: 97% !important;
        }
    }

    @media screen and (max-width:399px) and (min-width:320px) {
        .UploadAttachmentWidth {
            width: 95% !important;
        }
    }
</style>

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgDocumentAttachments">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgDocumentAttachments" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="pnlQuickFileUpload" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">

    <script type="text/javascript">
        /*******Drag and Drop ***********/
        var uploadsInProgress = 0;

        function onFileSelected(sender, args) {
            uploadsInProgress++;
        }

        function onFileUploaded(sender, args) {
            decrementUploadsInProgress();
            if (uploadsInProgress <= 0) {
                $("[id$=btnRefresh]").each(function () {
                    if (this.id.toLowerCase().indexOf("rdgdocumentattachments") >= 0) {
                        eval(this.href);
                    }
                });
            }
        }

        function onUploadFailed(sender, args) {
            decrementUploadsInProgress();
        }

        function decrementUploadsInProgress() {
            uploadsInProgress--;
        }

        function added(sender, args) {
            if (document.getElementById('lblUploadOption')) {
                if (Telerik.Web.UI.RadAsyncUpload.Modules.FileApi.isAvailable()) {
                    $("#lblUploadOption").html(lblUploadOptionChFFText);
                } else {
                    $("#lblUploadOption").html(lblUploadOptionIEText);
                }
            }
        }

        function ClientValidationFailed(sender, args) {
            decrementUploadsInProgress();
            alert(WarningMsg_InvalidFile);
        }

        function OpenBlubeamMarkup(url) {
            window.location = url;
            return false;
        }

    </script>

    <script type="text/javascript">
        var isChecked = "0";
        function OnSelectedFileAttachementChanged(row) {
            var rdbFileManager = row.find("input[id$='rdbFileManager']");
            var rdbLink = row.find("input[id$='rdbLink']");
            var rdbWSS = row.find("input[id$='rdbWSS']");
            var rdbAconex = row.find("input[id$='rdbAconex']");
            var rdbUpload = row.find("input[id$='rdbUpload']");
            var rbdEmail = row.find("input[id$='rdbEmail']");
            window['UploadId'] = row.find('[id$=FileToUpload]').attr("Id");

            if ($(rdbFileManager).is(":checked")) {
                row.find('input[id$=txtFileName]').attr("readOnly", "readOnly").show();
                row.find('[id$=btnBrowseFileManager]').show();
                row.find('input[id$=txtAconex]').hide();
                row.find('[id$=btnBrowseAconex]').hide();
                //            row.find('[id$=spFileManager]').show();
                row.find('input[id$=txtLink]').hide();
                row.find('[id$=FileToUpload]').hide();
                row.find('input[id$=txtEmailName]').hide();
                row.find('[id$=btnBrowseEmail]').hide();
                var chkRotator = $('[id*=rdgDocumentAttachments][id$=chkIsInRotator]');
                if (isChecked == "0") isChecked = $(chkRotator).is(":checked");
                $(chkRotator).attr("checked", isChecked).removeAttr("disabled");
            }
            else if ($(rbdEmail).is(":checked")) {
                row.find('input[id$=txtFileName]').hide();
                row.find('[id$=btnBrowseFileManager]').hide();
                row.find('input[id$=txtAconex]').hide();
                row.find('[id$=btnBrowseAconex]').hide();
                row.find('[id$=FileToUpload]').hide();
                row.find('input[id$=txtLink]').hide();
                row.find('input[id$=txtEmailName]').attr("readOnly", "readOnly").show();
                row.find('[id$=btnBrowseEmail]').show();
                var chkRotator = $('[id*=rdgDocumentAttachments][id$=chkIsInRotator]');
                isChecked = $(chkRotator).is(":checked");
                $(chkRotator).attr("checked", false).attr("disabled", "disabled");

            }
            else if ($(rdbLink).is(":checked")) {
                row.find('input[id$=txtFileName]').hide();
                row.find('[id$=btnBrowseFileManager]').hide();
                row.find('input[id$=txtAconex]').hide();
                row.find('[id$=btnBrowseAconex]').hide();
                //            row.find('[id$=spFileManager]').hide();
                row.find('input[id$=txtLink]').show();
                row.find('[id$=FileToUpload]').hide();
                row.find('input[id$=txtEmailName]').hide();
                row.find('[id$=btnBrowseEmail]').hide();
                var chkRotator = $('[id*=rdgDocumentAttachments][id$=chkIsInRotator]');
                isChecked = $(chkRotator).is(":checked");
                $(chkRotator).attr("checked", false).attr("disabled", "disabled");
            }
            else if ($(rdbWSS).is(":checked")) {
                row.find('input[id$=txtFileName]').hide();
                row.find('[id$=btnBrowseFileManager]').hide();
                row.find('input[id$=txtAconex]').hide();
                row.find('[id$=btnBrowseAconex]').hide();
                //            row.find('[id$=spFileManager]').hide();
                row.find('input[id$=txtLink]').show();
                row.find('[id$=FileToUpload]').hide();
                row.find('input[id$=txtEmailName]').hide();
                row.find('[id$=btnBrowseEmail]').hide();
                var chkRotator = $('[id*=rdgDocumentAttachments][id$=chkIsInRotator]');
                isChecked = $(chkRotator).is(":checked");
                $(chkRotator).attr("checked", false).attr("disabled", "disabled");
            }
            else if ($(rdbAconex).is(":checked")) {
                row.find('input[id$=txtAconex]').attr("readOnly", "readOnly").show();
                row.find('[id$=btnBrowseAconex]').show();
                row.find('input[id$=txtFileName]').hide();
                row.find('[id$=btnBrowseFileManager]').hide();
                //            row.find('[id$=spFileManager]').hide();
                row.find('input[id$=txtLink]').hide();
                row.find('[id$=FileToUpload]').hide();
                row.find('input[id$=txtEmailName]').hide();
                row.find('[id$=btnBrowseEmail]').hide();
                var chkRotator = $('[id*=rdgDocumentAttachments][id$=chkIsInRotator]');
                isChecked = $(chkRotator).is(":checked");
                $(chkRotator).attr("checked", false).attr("disabled", "disabled");
            }
            else if ($(rdbUpload).is(":checked")) {
                row.find('input[id$=txtFileName]').hide();
                row.find('[id$=btnBrowseFileManager]').hide();
                row.find('input[id$=txtAconex]').hide();
                row.find('[id$=btnBrowseAconex]').hide();
                //            row.find('[id$=spFileManager]').hide();
                row.find('input[id$=txtLink]').hide();
                row.find('[id$=FileToUpload]').show();
                row.find('input[id$=txtEmailName]').hide();
                row.find('[id$=btnBrowseEmail]').hide();
                var chkRotator = $('[id*=rdgDocumentAttachments][id$=chkIsInRotator]');
                if (isChecked == "0") isChecked = $(chkRotator).is(":checked");
                $(chkRotator).attr("checked", isChecked).removeAttr("disabled");
            }
            row.find('[id$=FileToUpload]').removeClass("Hide");
            row.find('[id$=txtLink]').removeClass("Hide");
            row.find('[id$=btnBrowseFileManager]').removeClass("Hide");
            row.find('[id$=txtFileName]').removeClass("Hide");
            row.find('[id$=txtAconex]').removeClass("Hide");
            row.find('[id$=txtEmailName]').removeClass("Hide");
            row.find('[id$=btnBrowseEmail]').removeClass("Hide");

        }

        function BindFileAttachement() {
            $("input[id$=rdbFileManager]").click(function () { var row = $(this).parents("tr:first"); OnSelectedFileAttachementChanged(row); });
            $("input[id$=rdbLink]").click(function () { var row = $(this).parents("tr:first"); OnSelectedFileAttachementChanged(row); });
            $("input[id$=rdbWSS]").click(function () { var row = $(this).parents("tr:first"); OnSelectedFileAttachementChanged(row); });
            $("input[id$=rdbAconex]").click(function () { var row = $(this).parents("tr:first"); OnSelectedFileAttachementChanged(row); });
            $("input[id$=rdbUpload]").click(function () { var row = $(this).parents("tr:first"); OnSelectedFileAttachementChanged(row); });
            $("input[id$='rdbFileManager']").each(function () { var row = $(this).parents("tr:first"); OnSelectedFileAttachementChanged(row); });
            $("input[id$='rdbEmail']").click(function () { var row = $(this).parents("tr:first"); OnSelectedFileAttachementChanged(row); });
        }

        function Validate(sender) {
            var rdbFileManager = $("input[id$='rdbFileManager']");
            var rdbLink = $("input[id$='rdbLink']");
            var rdbWSS = $("input[id$='rdbWSS']");
            var rdbUpload = $("input[id$='rdbUpload']");
            var rbdEmail = $("input[id$='rdbEmail']");
            if ($(rdbFileManager).is(":checked")) {
                var ObjectId = $("input[id$='hdnOjectId']").val();
                var ddlItems = $find($(rdbFileManager)[0].id.substring($(rdbFileManager)[0].id.lastIndexOf('_'), $(rdbFileManager)[0].id.lenght - 1) + '_ddlItems');
                if (ddlItems != null) {
                    var Item = ddlItems.get_selectedItem()
                    if (Item != null) {
                        var EntityId = Item._attributes.getAttribute("EntityId");
                        if (EntityId > 0) {
                            if (ObjectId > 0 && EntityId != ObjectId) {
                                $('[id$=lblFileError]').html(Msg_ProjectNotMatch);
                                return false;
                            }

                        }

                    }
                }
                if ($('input[id$=txtFileName]').val() == "") {
                    $('[id$=lblFileError]').html(Msg_ChooseFile);
                    return false;
                }
            }
            else if ($(rbdEmail).is(":checked")) {
                if ($('input[id$=txtEmailName]').val() == "") {
                    $('[id$=lblFileError]').html(Msg_ChooseFile);
                    return false;
                }
            }
                //        else if ($(rdbLink).is(":checked")) {
                //            if ($('input[id$=txtLink]').val() == "") {
                //                $('[id$=lblFileError]').html(Msg_InvalidLink);
                //                return false;
                //            }
                //        }
            else if ($(rdbWSS).is(":checked")) {
                if ($('input[id$=txtLink]').val() == "") {
                    $('[id$=lblFileError]').html(Msg_InvalidLink);
                    return false;
                }
            }
            else if ($(rdbUpload).is(":checked")) {
                if ($('[id$=FileToUploadfile0]').val() == "") {
                    $('[id$=lblFileError]').html(Msg_ChooseFile);
                    return false;
                }
            }
            if (Page_ClientValidate()) {
                sender.onclick = function () { return false; }
            }
            return true;
        }


        function AttachFileForFileManager(me) {
            var row = $(me).parents("tr:first");
            var hdnFileId = row.find("input[id$='hdnFileId']");
            $(hdnFileId).attr("IsWaiting", "true");
            $("input[id$='hdnSelectedElementId']").val($(hdnFileId)[0].id);
            var me = $(me)
            var ddlItems = $find($(hdnFileId)[0].id.substring($(hdnFileId)[0].id.lastIndexOf('_'), $(hdnFileId)[0].id.lenght - 1) + '_ddlItems');
            if (ddlItems != null) {
                var Item = ddlItems.get_selectedItem()
                if (Item != null) {
                    var EntityId = Item._attributes.getAttribute("EntityId");
                    if (EntityId > 0) {
                        DocId = '<%=Me.PM.DocumentAttachmentInfo.EntityTypeId %>' + "_" + EntityId
                    }

                }
            }

            return OpenPOPUp('FilesLookup.aspx?EntityId=' + DocId, 1135, 680, false);
            DocId = '<%=Me.PM.DocumentAttachmentInfo.EntityTypeId %>' + "_" + '<%=Me.PM.DocumentAttachmentInfo.EntityId %>'
        }




        function OpenFolderManagerPopup() {
            return OpenPOPUp('FilesLookup.aspx?EntityId=' + DocId + '&MultiSelect=1', 1135, 680, true, 'rdgDocumentAttachments');
        }

        function AttachFileForAconex(me) {
            var row = $(me).parents("tr:first");
            var hdnFileId = row.find("input[id$='hdnFileId']");
            $(hdnFileId).attr("IsWaiting", "true");
            $("input[id$='hdnSelectedElementId']").val($(hdnFileId)[0].id);
            return OpenPOPUp('AconexDocumentsLookup.aspx?EntityId=' + DocId, 1100, 500, false);
        }


        var DocId = '<%=Me.PM.DocumentAttachmentInfo.EntityTypeId %>' + "_" + '<%=Me.PM.DocumentAttachmentInfo.EntityId %>'
        //    function DocAttachRowDblClick(sender, eventArgs) {
        //        var btnEditSelected = $("a[id$=btnEditSelected][id*=rdgDocumentAttachments]")[0];
        //        if (btnEditSelected) { eval(btnEditSelected.href.split(":")[1]); }
        //    }

        function AttachEmail(me) {
            var row = $(me).parents("tr:first");
            var hdnFileId = row.find("input[id$='hdnFileId']");
            $(hdnFileId).attr("IsWaiting", "true");
            $("input[id$='hdnSelectedElementId']").val($(hdnFileId)[0].id);
            return OpenPOPUp('EmailHomePopup.aspx?EntityId=' + DocId, 1080, 510, false);
        }

        var ALLOWED_IMAGE_EXTENSION = '<%=Me.PM.Parameters.ALLOWED_IMAGE_EXTENSION%>'
        function DisplayFileName() {
            var txtDescription = $("input[id$='txtDescription'][id*='rdgDocumentAttachments']");
            var FileToUpload = $("input[id$='FileToUpload'][id*='rdgDocumentAttachments']");
            var chkIsInRotator = $("input[id$='chkIsInRotator'][id*='rdgDocumentAttachments']");
            var name = $(FileToUpload).val().substring($(FileToUpload).val().lastIndexOf('\\') + 1, $(FileToUpload).val().lastIndexOf('.'));
            var ext = $(FileToUpload).val().substring($(FileToUpload).val().lastIndexOf('.') + 1, $(FileToUpload).val().length);
            if ($(txtDescription).val() === "") {
                $(txtDescription).val(name);
            }
            $(chkIsInRotator).attr("checked", (ALLOWED_IMAGE_EXTENSION.indexOf(ext) >= 0 || ext == "dwf" || ext == "dwfx"));
        }

        function ddlItems_OnClientSelectedIndexChanged(sender, eventArgs) {
            var item = eventArgs.get_item();
            if (item != null) {
                var EntityId = item._attributes.getAttribute("EntityId");
                if (EntityId > 0) {
                    var hdnEntityId = document.getElementById(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_hdnEntityId');
                    if (hdnEntityId != null) {
                        $(hdnEntityId).val(EntityId);
                    }
                }
            }
        }
        function OpenRedlining(url) {
            window.location = url;
            return false;
        }

        function Attachments_OpenMultipleCompaniesPopup() {
            return OpenWindowPOPUp('CompaniesFilterPopup.aspx?txtContact=NOTExist&txtEmail=NOTExist&Type=Contacts&txtIds=NotExist&ddlType=Multiple&Source=BLUEBEAMMARKUPS&ProjectId=' + 0 + '&ProjectRequired=0&FileIds=' + DocAttachIds.join(',') + '&FilesSource=UPLOAD', 900, 420);
        }

        var OnRowSelected_IsEligible = true;
        var DocAttachIds = [];

        function DocAttach_OnRowSelected(sender, args) {
            var btnBluebeam = $($("a[id$=btnAttachBluebeam]")[0]);
            if (args._dataKeyValues.IsEligible == 'True') {
                DocAttachIds.push(args._dataKeyValues.Id);
                if (OnRowSelected_IsEligible == true) {
                    btnBluebeam.attr('disabled', '');
                    btnBluebeam.removeClass("BluebeamIconDisabled");
                    btnBluebeam.addClass("BluebeamIconEnabled");
                    btnBluebeam.attr('onclick', 'return Attachments_OpenMultipleCompaniesPopup();');
                }
            }
            else {
                btnBluebeam.attr('disabled', 'disabled');
                btnBluebeam.removeClass("BluebeamIconEnabled");
                btnBluebeam.addClass("BluebeamIconDisabled");
                OnRowSelected_IsEligible = false;
                btnBluebeam.attr('onclick', 'return false;');
            }
        }


        function DocAttach_OnRowDeselected(sender, args) {
            var btnBluebeam = $($("a[id$=btnAttachBluebeam]")[0]);
            var IsEligible = false;
            var index;
            var SelectedRows = sender.MasterTableView.get_selectedItems();
            var SelectedRowsCount = sender.MasterTableView.get_selectedItems().length;
            index = DocAttachIds.indexOf(args._dataKeyValues.Id);
            if (index >= 0) DocAttachIds.splice(DocAttachIds.indexOf(args._dataKeyValues.Id), 1);
            for (index = 0; index < SelectedRowsCount; index++) {
                if (SelectedRows[index].getDataKeyValue("IsEligible") == 'True') {
                    IsEligible = true;
                }
                else {
                    IsEligible = false;
                    break;
                }
            }
            if (IsEligible == true) {
                btnBluebeam.attr('disabled', '');
                btnBluebeam.removeClass("BluebeamIconDisabled");
                btnBluebeam.addClass("BluebeamIconEnabled");
                OnRowSelected_IsEligible = true;
                btnBluebeam.attr('onclick', 'return Attachments_OpenMultipleCompaniesPopup();');
            }
            else {
                btnBluebeam.attr('disabled', 'disabled');
                btnBluebeam.removeClass("BluebeamIconEnabled");
                btnBluebeam.addClass("BluebeamIconDisabled");
                btnBluebeam.attr('onclick', 'return false;');
            }
            if (SelectedRowsCount == 0) OnRowSelected_IsEligible = true;
        }

    </script>

</telerik:RadScriptBlock>
<div class="PMHeader">
    <div class="row">
        <table class="TableNoSpacingNoBorder" style="width:100%;table-layout:fixed;">
            <tr>
                <td style="width: 98% !important; padding: 24px 24px 24px 24px;">
                    <%--  
                            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                <tr>
                                    <td style="width: 80px;">
                                        <telerik:RadAsyncUpload runat="server" ID="rauAtdtachment" OnClientFileUploadFailed="onUploadFailed" CssClass="SelectButtonStyle"
                                            OnClientFileSelected="onFileSelected" OnClientFileUploaded="onFileUploaded" OnClientAdded="added" HideFileInput="true"
                                            MultipleFileSelection="Automatic" OnClientValidationFailed="ClientValidationFailed" Width="80px" OnFileUploaded="rauAttachment_FileUploaded">
                                        </telerik:RadAsyncUpload>
                                    </td>
                                    <td id="tdUploadOption" style="text-align: left; padding-left: 10px; color: #999999; background-color: #FFFFFF;" runat="server">
                                        <span id="lblUploadOption"></span>
                                    </td>
                                </tr>
                            </table>--%>
                    <asp:Panel ID="Panel1" runat="server">
                        <fieldset style="padding: 0px; border: 0px; width: 100%" id="pnlQuickFileUpload" runat="server" class="UploadAttachmentWidth">
                            <div id="TeamAttachmentContainer" runat="server">
                                <table border="0" style="width: 100%" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td align="center">
                                            <table border="0" style="width: 100%">
                                                <tr>
                                                    <td>
                                                        <telerik:RadAsyncUpload runat="server" Width="100%" CssClass="ProjectCenterUpload" ID="rauAttachment" Skin="Default"
                                                            OnClientFileUploadFailed="onUploadFailed" OnClientFileSelected="onFileSelected" OnClientFileUploaded="onFileUploaded" OnClientAdded="added"
                                                            MultipleFileSelection="Automatic" OnClientValidationFailed="ClientValidationFailed" OnFileUploaded="rauAttachment_FileUploaded"
                                                            HideFileInput="true" DropZones=".TeamDropZone">
                                                            <Localization Select="<%$ Resources:PMWeb, ProjectCenterSelect %>" />
                                                        </telerik:RadAsyncUpload>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </fieldset>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadGrid ID="rdgDocumentAttachments" runat="server" AllowMultiRowSelection="True" UseEditFormInMobile="true"
                        AutoGenerateColumns="False" AllowSorting="True" ShowStatusBar="False" CssClass="WithoutTopBorder"
                        GridLines="None" PageSize="20" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                        AllowPaging="True" ShowFooter="false" ShowGroupPanel="True" GroupPanelPosition="Top">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                        <ValidationSettings CommandsToValidate="UpdateEdited,PerformInsert" ValidationGroup="DocumentAttachments" />
                        <ClientSettings AllowColumnHide="True" AllowColumnsReorder="True">
                            <%--<ClientEvents OnRowDblClick="DocAttachRowDblClick" />--%>
                            <Resizing AllowColumnResize="false" />
                        </ClientSettings>
                        <MasterTableView ShowGroupFooter="true" NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            CommandItemDisplay="Top" DataKeyNames="Id" EditMode="InPlace" ClientDataKeyNames="Id,IsEligible" InsertItemPageIndexAction="ShowItemOnFirstPage">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="" HeaderStyle-Width="80px" Groupable="False" Reorderable="false"
                                    ItemStyle-HorizontalAlign="Center" AllowFiltering="false" UniqueName="ImageToDisplay" ItemStyle-Height="50px">
                                    <ItemTemplate>
                                        <asp:Image runat="server" ID="imgToDisplay" Height="50px" Width="50px"/>
                                    </ItemTemplate>
                                    <EditItemTemplate></EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="pmweb viewer" UniqueName="ViewerIcon" HeaderStyle-Width="70px" Groupable="False"
                                    ItemStyle-HorizontalAlign="Center" AllowFiltering="false">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lbtIconViewer" Style="cursor: pointer" meta:resourcekey="Redlining" runat="server" Visible="false"
                                            CssClass="PMwebViewerButton">
                                                                     <span class="Icon"></span>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="bluebeam"  UniqueName="IsInBluebeamSession" Groupable="false" HeaderStyle-Width="80px" ItemStyle-HorizontalAlign="Center" AllowFiltering="false">

                                    <ItemTemplate>
                                        <asp:LinkButton ID="imgBluebeam" Reorderable="false" runat="server" SecurityButtonType="ItemMode_Edit" Visible='<%# Eval("IsInBluebeamSession")%>'
                                            CssClass="BlueBeam">
                                        
                                        <span class="BlueBeamIcon"></span>
                                        
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Linked Line" SortExpression="Item"
                                    UniqueName="Items" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Item"
                                    GroupByExpression="Item [GridColumn_Items] Group By Item">
                                    <EditItemTemplate>
                                        <telerik:RadComboBox ID="ddlItems" runat="server" Width="100%" DropDownWidth="300px" Filter="Contains"
                                            Skin="Metro" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                            NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="ddlItems_OnClientSelectedIndexChanged"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested"
                                            Style="font-size: 11px" Height="250px">
                                        </telerik:RadComboBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <%#IIf(Container.DataItem("Item") = String.Empty, "&nbsp;", Container.DataItem("Item"))%>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="false" />
                                    <HeaderStyle Width="220px" />
                                </telerik:GridTemplateColumn>
                                
                                <telerik:GridTemplateColumn Visible="false" ItemStyle-HorizontalAlign="Center" UniqueName="IncludeInBid" HeaderText="" Groupable="False" HeaderStyle-Width="80px"
                                    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Select">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelect" AutoPostBack="true" runat="server" OnCheckedChanged="chkUserUnits_OnChekedChanged" />
                                    </ItemTemplate>
                                    <EditItemTemplate>&nbsp;</EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="ID" SortExpression="Id" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Id" DataType="System.String"
                                    UniqueName="Id" GroupByExpression="Id [GridColumn_Id] Group By Id" >
                                    <ItemTemplate>
                                        <%#Container.DataItem("Id")%>
                                    </ItemTemplate>
                                    <EditItemTemplate>&nbsp;</EditItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                    <ItemStyle HorizontalAlign="right" Wrap="false" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Description*" SortExpression="Description"
                                    UniqueName="Description" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Description"
                                    GroupByExpression="Description [GridColumn_Description] Group By Description">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtDescription" MaxLength="500" runat="server" Text='<%# Eval("Description") %>'
                                            Width="99%"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription"
                                            CssClass="Validator" Display="Dynamic" ForeColor="" meta:resourcekey="rfvRequired"
                                            ValidationGroup="DocumentAttachments"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>

                                    <ItemTemplate>
                                        <%# IIf(Container.DataItem("Description") = String.Empty, "&nbsp;", Container.DataItem("Description")) %>
                                    </ItemTemplate>
                                    <HeaderStyle Width="150px" />
                                    <ItemStyle Wrap="false" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="File*" UniqueName="File" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="FileFilterName"
                                    Groupable="false">
                                    <EditItemTemplate>
                                        <table border="0" width="100%" style="height: 20px; white-space: normal;">
                                            <tr style="height: 30px; vertical-align: top">
                                                <td class="Top">

                                                    <asp:RadioButton ID="rdbFileManager" GroupName="AttachmentOption" meta:ResourceKey="rdbFileManager"
                                                        runat="server" Text="Document Manager" CssClass="RadioCss RadioAttachmentCss" />
                                            <asp:RadioButton ID="rdbLink" GroupName="AttachmentOption" runat="server" Text="Link"
                                                meta:ResourceKey="rdbLink" CssClass="RadioCss RadioAttachmentCss" />
                                            <asp:RadioButton ID="rdbWSS" GroupName="AttachmentOption" runat="server" Text="SharePoint"
                                                meta:ResourceKey="rdbWSS" CssClass="RadioCss RadioAttachmentCss" />
                                            <asp:RadioButton ID="rdbAconex" GroupName="AttachmentOption" runat="server" Text="Aconex"
                                                meta:ResourceKey="rdbAconex" CssClass="RadioCss RadioAttachmentCss" />
                                               <asp:RadioButton ID="rdbEmail" GroupName="AttachmentOption" runat="server" Text="Email"
                                                   meta:ResourceKey="rdbEmail" CssClass="RadioCss RadioAttachmentCss" />
                                            <asp:RadioButton ID="rdbUpload" GroupName="AttachmentOption" runat="server" Text="Upload"
                                                meta:ResourceKey="rdbUpload" CssClass="RadioCss RadioAttachmentCss" />
                                            <asp:HiddenField ID="hdnFileSize" runat="server" />
                                                    <asp:HiddenField ID="hdnOjectId" runat="server" />
                                                    <asp:HiddenField ID="hdnEntityId" runat="server" />
                                                    <asp:HiddenField ID="hdnFileId" runat="server" />
                                                    <asp:HiddenField ID="hdnSelectedEmailId" runat="server" />
                                                    <asp:HiddenField ID="hdnAconexUrlEdit" runat="server" />
                                                </td>
                                                <td style="vertical-align: middle;">
                                                    <asp:TextBox ID="txtLink" CssClass="Hide" runat="server" Text="http://" Width="150px"></asp:TextBox>
                                                    <asp:FileUpload ID="FileToUpload" runat="server" Width="180px" onchange="DisplayFileName();" />
                                                    <telerik:RadUpload ID="FileToUpload1" runat="server" CssClass="Hide" Skin="Office2007" ControlObjectsVisibility="none"
                                                        MaxFileInputsCount="1" Visible="true" Width="300px">
                                                        <Localization Add="<%$ Resources:PMWeb, RadUploadAdd %>" Clear="<%$ Resources:PMWeb, RadUploadClear %>"
                                                            Delete="<%$ Resources:PMWeb, RadUploadDelete %>" Remove="<%$ Resources:PMWeb, RadUploadRemove %>"
                                                            Select="<%$ Resources:PMWeb, RadUploadSelect %>" />
                                                    </telerik:RadUpload>
                                                    <span id="spFileManager" runat="server">
                                                        <asp:TextBox ID="txtFileName" runat="server" Text=""
                                                            Width="100px"></asp:TextBox>
                                                        <asp:LinkButton ID="btnBrowseFileManager" runat="server" Text="Browse" Style="text-decoration: underline;"
                                                            meta:resourcekey="btnBrowseFileManager" OnClientClick="AttachFileForFileManager(this);"></asp:LinkButton>
                                                    </span>
                                                    <span id="spAconex" runat="server">
                                                        <asp:TextBox ID="txtAconex" runat="server" Text=""
                                                            Width="100px"></asp:TextBox>
                                                        <asp:LinkButton ID="btnBrowseAconex" runat="server" Text="Browse" Style="text-decoration: underline;"
                                                            meta:resourcekey="btnBrowseAconex" OnClientClick="AttachFileForAconex(this);"></asp:LinkButton>
                                                    </span>
                                                    <span id="spEmail" runat="server">
                                                        <asp:TextBox ID="txtEmailName" runat="server" Text=""
                                                            Width="100px"></asp:TextBox>
                                                        <asp:LinkButton ID="btnBrowseEmail" runat="server" Text="Browse" Style="text-decoration: underline;"
                                                            meta:resourcekey="btnBrowseEmail" OnClientClick="AttachEmail(this);"></asp:LinkButton>

                                                    </span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="padding-left:7px">
                                                    <asp:Label ID="lblFileError" CssClass="Validator" runat="server"
                                                        Text=""></asp:Label>
                                                    <asp:HyperLink ID="btnDownloadEdit" runat="server" CausesValidation="false" Style="text-decoration: underline; cursor: hand;"
                                                        Text='' ToolTip="<%$ Resources:PMWeb, Download %>"></asp:HyperLink>
                                                    <asp:LinkButton ID="lbtWSSEdit" runat="server" CausesValidation="false" Style="text-decoration: underline; cursor: hand;"
                                                        Text="" ToolTip="<%$ Resources:PMWeb, Download %>" OnClick="lbtWSS_Click" />
                                                    <asp:LinkButton ID="lbtAconexEdit" runat="server" CausesValidation="false" Style="text-decoration: underline; cursor: hand;"
                                                        Text="" ToolTip="<%$ Resources:PMWeb, Download %>" OnClick="lbtAconex_Click" />
                                                    <asp:HyperLink ID="hliPMwebRecord" Style="text-decoration: underline; cursor: hand;" runat="server" CssClass="NoWrap"></asp:HyperLink>
                                                </td>
                                            </tr>
                                        </table>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <div style="width: 100%; white-space: nowrap;">
                                            <asp:HyperLink ID="hplDownload" runat="server" CausesValidation="false" Style="text-decoration: underline; cursor: hand;"
                                                Text=''
                                                ToolTip="<%$ Resources:PMWeb, Download %>">
                                        <span class:"Icon" />
                                            </asp:HyperLink>
                                            <asp:LinkButton ID="imgdownlaod" runat="server"
                                                CssClass="GridCmdDownloadSelectedFiles" Style="border-width: 0px; cursor: pointer; float: right;">
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
                                    <HeaderStyle HorizontalAlign="Center" Width="450px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Size" UniqueName="Size" ItemStyle-Wrap="false" Groupable="false"
                                    SortExpression="FileSize" DataField="FileSize" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFileSize" runat="server" Text='<%#IIf(ParseInt(Eval("FileSize")) = 0, "&nbsp;", FormatByte(ParseInt(Eval("FileSize"))))%>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Width="60px"></HeaderStyle>
                                    <ItemStyle Wrap="False" HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Version" SortExpression="FileVersion" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="FileVersion"
                                    UniqueName="FileVersion" GroupByExpression="FileVersion [GridColumn_FileVersion] Group By FileVersion">
                                    <EditItemTemplate>
                                        <%# Eval("FileVersion") %> &nbsp;
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <%# Eval("FileVersion") %> &nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Width="98px" />
                                    <ItemStyle HorizontalAlign="Right" Wrap="false" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Type" SortExpression="DisplayType" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="DisplayType"
                                    UniqueName="DisplayType" GroupByExpression="DisplayType [GridColumn_DisplayType] Group By DisplayType">
                                    <EditItemTemplate>
                                        <%# Eval("DisplayType") %> &nbsp;
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <%# Eval("DisplayType") %> &nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Width="90px" />
                                    <ItemStyle Wrap="false" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Display" SortExpression="IsInRotator" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="IsInRotator"
                                    UniqueName="IsDisplayed" Groupable="false">
                                    <EditItemTemplate>
                                        <asp:CheckBox ID="chkIsInRotator" runat="server" Checked='<%# CBool(IIF(Eval("IsInRotator") is system.DBNULL.value, 0, Eval("IsInRotator"))) %>' />
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <img id="imgCheckBox" runat="server" src='Images/Global/<%# CStr(IIF(Eval("IsInRotator"),"checked.png" , "unchecked.png")) %>' />
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Center" Width="80px" />
                                    <ItemStyle Wrap="false" HorizontalAlign="Center"  />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Notes" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Notes"
                                    SortExpression="Notes" UniqueName="Notes" GroupByExpression="Notes [GridColumn_Notes] Group By Notes">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtNotes" runat="server" Text='<%# Eval("Notes") %>' Width="99%"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <%# IIf(Container.DataItem("Notes") = String.Empty, "&nbsp;", Container.DataItem("Notes")) %>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="true"></ItemStyle>
                                    <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Create Date" CurrentFilterFunction="GreaterThanOrEqualTo" FilterListOptions="VaryByDataType" DataField="CreateDate"
                                    SortExpression="CreateDate" UniqueName="CreateDate" GroupByExpression="CreateDate [GridColumn_CreateDate] Group By CreateDate" DataType="System.DateTime">
                                    <ItemTemplate>
                                        <span><%#FormatDate(Container.DataItem("CreateDate"))%></span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                    <EditItemTemplate>
                                        <span><%#FormatDate(Eval("CreateDate"))%></span>
                                    </EditItemTemplate>
                                    <ItemStyle Wrap="false" />
                                    <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Created By" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="CreatedByUserName"
                                    SortExpression="CreatedByUserName" UniqueName="CreatedByUserName" GroupByExpression="CreatedByUserName [GridColumn_CreatedByUserName] Group By CreatedByUserName">
                                    <EditItemTemplate>
                                        <span><%# Eval("CreatedByUserName")%></span>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <%# IIf(Container.DataItem("CreatedByUserName") = String.Empty, "&nbsp;", Container.DataItem("CreatedByUserName"))%>
                                    </ItemTemplate>
                                    <ItemStyle Wrap="false" />
                                    <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <EditFormSettings>
                                <EditColumn InsertImageUrl="Update.gif" UpdateImageUrl="Update.gif" EditImageUrl="Edit.gif"
                                    CancelImageUrl="Cancel.gif">
                                </EditColumn>
                            </EditFormSettings>
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CssClass="GridCmdEditRows"
                                        CommandName="EditRows" Visible="<%# rdgDocumentAttachments.EditIndexes.Count = 0 AND (Not rdgDocumentAttachments.MasterTableView.IsItemInserted) %>">
                                        <span class="Icon"></span>
                                        <asp:Label runat="server" ID="lblEditSelectedLine"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited" SecurityButtonType="AddEditMode_Edit"
                                        ValidationGroup="DocumentAttachments"
                                        Visible="<%# rdgDocumentAttachments.EditIndexes.Count > 0 %>">
                                        <span class="Icon"></span>
                                        <asp:Label runat="server" ID="lblUpdateRecord"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnSave" runat="server" CommandName="PerformInsert" CssClass="GridCmdPerformInsert" ValidationGroup="DocumentAttachments" OnClientClick="javascript:return Validate(this);"
                                        SecurityButtonType="AddEditMode_Add" Visible="<%# rdgDocumentAttachments.MasterTableView.IsItemInserted %>">
                                        <span class="Icon"></span>
                                        <asp:Label runat="server" ID="lblSave"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode"
                                        CommandName="CancelAll" CssClass="GridCmdCancelAll" Visible="<%# rdgDocumentAttachments.EditIndexes.Count > 0 Or rdgDocumentAttachments.MasterTableView.IsItemInserted %>">
                                        <span class="Icon"></span>
                                        <asp:Label runat="server" ID="lblCancel"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add"
                                        CommandName="InitNewRow" CssClass="GridCmdInitNewRow" Visible="<%# rdgDocumentAttachments.EditIndexes.Count = 0 AND (Not rdgDocumentAttachments.MasterTableView.IsItemInserted) %>">
                                        <span class="Icon"></span>
                                        <asp:Label runat="server" ID="lblAddLine"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDocumentManager" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add" CssClass="GridCmdAddDocumentManager" CommandName="AddDocumentManager" OnClientClick="return OpenFolderManagerPopup();"
                                        Visible='<%# rdgDocumentAttachments.EditIndexes.Count = 0 AND (Not rdgDocumentAttachments.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblDocumentManager" runat="server" Text="Document Manager1"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnLinkPMWebRecords" runat="server" CausesValidation="False" CommandName="LinkPMWebRecords" CssClass="GridCmdLinkPMWebRecords"
                                        SecurityButtonType="ItemMode_Add"
                                        Visible='<%# rdgDocumentAttachments.EditIndexes.Count = 0 AND (Not rdgDocumentAttachments.MasterTableView.IsItemInserted) %>'>
                                        <span class="Icon"></span>
                                        <asp:Label ID="lbLinkRecords" meta:resourcekey="lbLinkRecords" runat="server" Text="Link PMWeb Record(s)"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnAttachBluebeam" runat="server" SecurityButtonType="ItemMode_Edit" CausesValidation="false"
                                        OnClientClick="return false;" CommandName="CreateBluebeamSession"
                                        Visible="<%# rdgDocumentAttachments.EditIndexes.Count = 0 AND (Not rdgDocumentAttachments.MasterTableView.IsItemInserted) %>">
                                        <span class="Icon"></span>
                                        <asp:Label runat="server" ID="lblBluebeam" CssClass="rtbText"></asp:Label>&nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Delete"
                                        CommandName="DeleteSelectedLine" CssClass="GridCmdDeleteSelectedLine" OnClientClick="return ConfirmDelete()" Visible="<%# rdgDocumentAttachments.EditIndexes.Count = 0 AND (Not rdgDocumentAttachments.MasterTableView.IsItemInserted) %>">
                                        <span class="Icon"></span>
                                        <asp:Label runat="server" ID="lblDeleteSelectedLine"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <%--                            <asp:LinkButton ID="lbtPMWebViewer" runat="server" CausesValidation="false" CommandName="PMWebViewer" CssClass="GridCmdPMWebViewer" Visible="true">
                                <span class="Icon"></span>
                                <asp:Label runat="server" ID="lblPMWebViewer" meta:resourcekey="lblPMWebViewer"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>--%>
                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode"
                                        CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible="<%# rdgDocumentAttachments.EditIndexes.Count = 0 AND (Not rdgDocumentAttachments.MasterTableView.IsItemInserted) %>">
                                        <span class="Icon"></span>
                                        <asp:Label runat="server" ID="lblRefresh"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnMultipleDownload" runat="server" CausesValidation="False" SecurityButtonType="ItemMode"
                                        CommandName="DownloadSelectedFiles" CssClass="GridCmdDownloadSelectedFiles" Visible="<%# rdgDocumentAttachments.EditIndexes.Count = 0 AND (Not rdgDocumentAttachments.MasterTableView.IsItemInserted) %>">
                                        <span class="Icon"></span>
                                        <asp:Label runat="server" ID="lblDownloadSelectedLine" meta:resourcekey="lblDownloadSelectedLine"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                        CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                        runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                        EnableShadows="true" CausesValidation="false"
                                        Visible="true">
                                    </telerik:RadMenu>
                                </div>
                            </CommandItemTemplate>
                        </MasterTableView>
                        <ClientSettings AllowDragToGroup="true">
                            <Selecting EnableDragToSelectRows="true" AllowRowSelect="true" />
                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                AllowColumnResize="True" />
                            <ClientEvents OnRowSelected="DocAttach_OnRowSelected" OnRowDeselected="DocAttach_OnRowDeselected" />
                        </ClientSettings>
                        <HeaderStyle Font-Size="8pt"></HeaderStyle>
                    </telerik:RadGrid>
                    <br />
                </td>
            </tr>
        </table>
    </div>
</div>
<asp:Button ID="btnRefresh" runat="server" CssClass="Hide" />
<asp:HiddenField ID="hdnSelectedElementId" runat="server" />
