<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" EnableEventValidation="false" ValidateRequest="false" AutoEventWireup="true" CodeBehind="OCS.aspx.cs" Inherits="SyosysWap.OCS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server" />
    <style>
        html, body {
            font-family: Calibri;
        }

        .form-horizontal {
            padding-left: 30px;
        }

        .form-group label {
            padding-top: 6px;
            font-weight: bold;
        }

        .form-horizontal input, .form-horizontal select, .form-horizontal textarea {
            width: 90%;
        }

        span.red {
            color: #FF0000;
        }

        .rgAltRow td, .rgRow td {
            border-bottom: 1px solid #ddd !important;
        }

        .div_border {
            border: 1px solid #ddd;
            padding-top: 5px;
            padding-bottom: 5px;
            margin-right: 20px;
        }

        input[type="radio"] {
            width: 20px;
        }

        .rgMasterTable input[type="text"], .rgMasterTable textarea {
            border: none;
            background-color: #fff;
        }

        .RadGrid .rgBatchContainer > * {
            width: 100%;
        }

        .RadGrid_Silk .rgInput, .RadGrid_Silk .rgEditRow > td > [type="text"], .RadGrid_Silk .rgEditForm td > [type="text"], .RadGrid_Silk .rgBatchContainer > [type="text"], .RadGrid_Silk .rgFilterBox {
            border-color: #c4c4c4;
            color: #3b3b3b;
            background-color: #fff;
        }

        .RadGrid .rgBatchContainer > textarea {
            overflow: hidden;
            resize: none;
        }

        .RadGrid_Simple .rgCommandRow, .RadGrid_Simple .rgPagerCell, .RadGrid_Simple td.rgGroupCol, .RadGrid_Simple td.rgExpandCol, .RadGrid_Simple .rgPagerCell .rgPagerButton, .RadGrid_Simple .rgPagerCell .rgActionButton {
            background-color: #FFF !important;
        }

        textarea {
            resize: none;
        }

        .detail_table {
            /*margin-bottom:10px;*/
        }

        .RadGrid_Simple .rgMasterTable .rgSelectedCell, .RadGrid_Simple .rgSelectedRow {
            background: #BEBEBE !important;
            color: #000000 !important;
        }

            .RadGrid_Simple .rgSelectedRow > td {
                border-color: #FFFFFF !important;
            }

        .comment-ruler {
            margin-top: 0px !important;
            margin-bottom: 5px !important;
        }

        .grid-control {
            background-color: #BEBEBE !important;
        }

        .NoWrap {
            white-space: nowrap;
        }

        .rgCommandCell img {
            width: 19px !important;
            margin-right: 5px;
        }

        .rgCommandCell a {
            margin-right: 5px;
        }
        #pdfbox {
            width: 100%;
            height: 800px;
            border: 5px solid #ccc;
        }
    </style>
    <link rel="stylesheet" href="App_Themes/Site/tree/themes/proton/style.css" />
    <link href="App_Themes/Site/css/bootstrap.css" rel="stylesheet" />

    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js" type="text/javascript"></script>
    <script src="App_Themes/Site/tree/jstree.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#tree').jstree({
                'core': {
                    'themes': {
                        'name': 'proton',
                        'responsive': true
                    }
                }
            });
        });
        function PreviewFile(guid) {
            var url = 'https://pmweb.hamad.qa/pmwebhelper/WebForms/FileHandler.ashx?guid=' + guid;
            $("#pdfbox").attr("data", url);
        }
    </script>

    <style>
        html, body, .jstree-proton {
            font-family: Calibri;
            font-size: 13px;
        }
    </style>
    <script type="text/javascript">
        var prevReadOnlyControls = ['txtResponse'];
        var firstColumn = 1;
        var lastColumn = 7;

        function keydown(event, obj) {
            var keyCode = ('which' in event) ? event.which : event.keyCode;
            var index = $(obj).closest('td').index();
            if (!event.shiftKey && keyCode == 9) {
                var id = $(obj).attr('id');
                if ($(obj).attr('id')) {
                    id = id.split('_');
                    id = id[id.length - 1];
                }
                var td = "";
                if (index == lastColumn) {
                    td = $(obj).closest('tr').next('tr').find('td:eq(' + firstColumn + ')');
                }
                else if (prevReadOnlyControls.indexOf(id) >= 0) {
                    td = $(obj).closest('tr').next('tr').find('td:eq(1)');
                }
                else {
                    td = $(obj).closest('td').next('td');

                }
                td.click();
                event.preventDefault();
            }
            else if (event.shiftKey && keyCode == 9) {
                var td = "";
                if (index == firstColumn) {
                    td = $(obj).closest('tr').prev('tr').find('td:eq(' + lastColumn + ')');
                }
                else {
                    td = $(obj).closest('td').prev('td').click();

                }
                td.click();
                event.preventDefault();
            }
        }
        $(document).ready(function () {
            $('.rgCommandCellRight').prepend($('<span style="font-size:18px;"><strong><%= draftCount %> Draft (Only visible to you)</strong></span>'));
            $('#hmcCommentsModal').on('hidden.bs.modal', function () {
                var batchManager = $find("<%=RadGrid1.ClientID%>");
                if (batchManager.get_batchEditingManager().hasChanges(batchManager.get_masterTableView())) {
                    batchManager.get_batchEditingManager().saveChanges(batchManager.get_masterTableView());
                }
                $('.modal-body', $("#hmcCommentsModal")).html('');
            });
            $('#hmcCommentsRevisionModal').on('hidden.bs.modal', function () {
                $('.modal-body', $("#hmcCommentsRevisionModal")).html('');
            });

        });
            var rowId = "";
            var newRowCell = "";
            function ConsultantComments(obj) {
                var batchManager = $find("<%=RadGrid1.ClientID%>");
                if (batchManager.get_batchEditingManager().hasChanges(batchManager.get_masterTableView())) {
                    batchManager.get_batchEditingManager().saveChanges(batchManager.get_masterTableView());
                }
                $('#<%=hidCommentTitle.ClientID%>').val('');
                $('#<%=hidComment.ClientID%>').val('');
                $('#<%=hidHMCComment.ClientID%>').val('');
                $('#<%=hidCommentRowNumber.ClientID%>').val('');
                rowId = '';
                rowId = $(obj).find('td:eq(2)').find('input[type="hidden"]:eq(0)').val();
                if (rowId) {
                    $('#<%=hidCommentRowNumber.ClientID%>').val(rowId);

                    $.ajax({
                        url: '/OCS/HMCCommentForms.aspx?cid=<%= Session["CustomFormId"].ToString() %>&row=' + rowId + '&_=' + Math.random(),
                        //url: '/HMCCommentForms.aspx?cid=<%= Session["CustomFormId"].ToString() %>&row=' + rowId + '&_=' + Math.random(),
                        dataType: "html",
                        type: "GET",
                        contentType: 'application/json;charset=utf-8',
                        async: true,
                        cache: false,
                        success: function (data) {
                            $('.modal-body', $("#hmcCommentsModal")).html(data);

                            $('#<%=hidCommentTitle.ClientID%>').val($('#txtTitle').val());
                            $('#<%=hidComment.ClientID%>').val($('#txtConsultantComments').val());
                            $('#<%=hidHMCComment.ClientID%>').val($('#txtComments').val());

                            $("#hmcCommentsModal").modal({
                                show: true,
                                backdrop: 'static',
                                //keyboard: false
                            });
                        },
                        error: function (xhr) {

                        }
                    });
                }
            }

            function ShowComments(obj, isMaster) {
                var revRowId = "";
                if (isMaster == true) {
                    revRowId = $(obj).closest('tr').find('td:eq(2)').find('input[type="hidden"]:eq(0)').val();
                }
                else {
                    revRowId = $(obj).closest('tr').find('td:eq(0)').find('input[type="hidden"]').val();
                }

                if (revRowId) {
                    $.ajax({
                        url: '/OCS/HMCCommentRevisionForms.aspx?cid=<%= Session["CustomFormId"].ToString() %>&row=' + revRowId + '&_=' + Math.random(),
                        //url: '/HMCCommentRevisionForms.aspx?cid=<%= Session["CustomFormId"].ToString() %>&row=' + revRowId + '&_=' + Math.random(),
                        dataType: "html",
                        type: "GET",
                        contentType: 'application/json;charset=utf-8',
                        async: true,
                        cache: false,
                        success: function (data) {
                            $('.modal-body', $("#hmcCommentsRevisionModal")).html(data);

                            $("#hmcCommentsRevisionModal").modal({
                                show: true,
                                backdrop: 'static',
                                //keyboard: false
                            });
                        },
                        error: function (xhr) {

                        }
                    });
                }
            }
            function SaveComments() {
                $('.modal-body', $("#hmcCommentsModal")).html('');
                $("#hmcCommentsModal").modal('hide');
                var batchManager = $find("<%=RadGrid1.ClientID%>");
                if (batchManager.get_batchEditingManager().hasChanges(batchManager.get_masterTableView())) {
                    batchManager.get_batchEditingManager().saveChanges(batchManager.get_masterTableView());
                }
            }
            function TitleChange(obj) {
                $('#<%=hidCommentTitle.ClientID%>').val($(obj).val());
            }
            function CommentChange(obj) {
                $('#<%=hidComment.ClientID%>').val($(obj).val());
            }
            function HMCCommentChange(obj) {
                $('#<%=hidHMCComment.ClientID%>').val($(obj).val());
            }
            function OnBatchEditOpened(sender, args) {
                newRowCell = "";
                var row = args.get_row();
                var isReadOnly = $(row).find('td:eq(2)').find('input[type="hidden"]:eq(1)').val();
                var cell = args.get_cell();

                if (isReadOnly == "True" && args.get_columnUniqueName() != "HMC_HFD_PMC_Comments" && args.get_columnUniqueName() != "Response") {
                    $(cell).find('div:eq(0)').show();
                    $(cell).find('div:eq(1)').hide();
                }
                else if (args.get_columnUniqueName() == "HMC_HFD_PMC_Comments") {
                    $(cell).find('div:eq(0)').show();
                    $(cell).find('div:eq(1)').hide();
                    rowId = '';
                    rowId = $(row).find('td:eq(2)').find('input[type="hidden"]:eq(0)').val();
                    $('#<%=hidCommentTitle.ClientID%>').val('');
                    $('#<%=hidComment.ClientID%>').val('');
                    $('#<%=hidHMCComment.ClientID%>').val('');
                    $('#<%=hidCommentRowNumber.ClientID%>').val('');


                    rowId = $(row).find('td:eq(2)').find('input[type="hidden"]:eq(0)').val();
                    console.log("rowId=>" + rowId);
                    if (rowId) {
                        $('#<%=hidCommentRowNumber.ClientID%>').val(rowId);

                        $.ajax({
                            url: '/OCS/HMCCommentForms.aspx?cid=<%= Session["CustomFormId"].ToString() %>&row=' + rowId + '&_=' + Math.random(),
                            //url: '/HMCCommentForms.aspx?cid=<%= Session["CustomFormId"].ToString() %>&row=' + rowId + '&_=' + Math.random(),
                            dataType: "html",
                            type: "GET",
                            contentType: 'application/json;charset=utf-8',
                            async: true,
                            cache: false,
                            success: function (data) {
                                $('.modal-body', $("#hmcCommentsModal")).html(data);

                                $('#<%=hidCommentTitle.ClientID%>').val($('#txtTitle').val());
                                $('#<%=hidComment.ClientID%>').val($('#txtConsultantComments').val());
                                $('#<%=hidHMCComment.ClientID%>').val($('#txtComments').val());

                                $("#hmcCommentsModal").modal({
                                    show: true,
                                    backdrop: 'static',
                                    //keyboard: false
                                });
                            },
                            error: function (xhr) {

                            }
                        });
                    }
                    else if (parseInt(args.get_row().getAttribute("id").split("__")[1]) < 0) {
                        newRowCell = cell;
                        $("#hmcNewRowCommentsModal").modal({
                            show: true,
                            backdrop: 'static',
                            //keyboard: false
                        });
                    }
                }
        }
        function SaveNewComments() {
            var commentValuue = "[b]Title: " + $("#txtNewRowTitle").val() + "[/b]{~@#$%}" + $("#txtNewRowConsultantComments").val();
            var batchManager = $find("<%=RadGrid1.ClientID%>");
            batchManager.remove_batchEditOpened(OnBatchEditOpened);
            var batchEditingManager = batchManager.get_batchEditingManager();
            batchEditingManager.changeCellValue(newRowCell, commentValuue);
            batchEditingManager.saveChanges(batchManager.get_masterTableView())
            setTimeout(function () {
                batchManager.add_batchEditOpened(OnBatchEditOpened);
            }, 100);
            $("#txtNewRowTitle").val('');
            $("#txtNewRowConsultantComments").val('')
            $("#hmcNewRowCommentsModal").modal('hide');
            newRowCell = "";
        }
        $('#hmcNewRowCommentsModal').on('hidden.bs.modal', function () {
            $("#txtNewRowTitle").val('');
            $("#txtNewRowConsultantComments").val('');
            newRowCell = "";
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <%--<img src="App_Themes/Site/HomeTheme/images/hmc_logo124.png" alt="" class='retina-ready' style="float: right !important;">--%>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphMain" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server" EnablePartialRendering="true">
        <Scripts>
            <%--<asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />--%>
        </Scripts>
    </telerik:RadScriptManager>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadGridExport" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnCommentSave">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadGridExport" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSaveOverallCommnets">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="divOverallComments" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="lnkEditOverallComments">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="divOverallComments" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSaveOverallCommnets">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="divOverallComments" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSaveOverallCommnetsCancel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="divOverallComments" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Glow"></telerik:RadAjaxLoadingPanel>
    <div class="row" style="margin-top: 20px;">
        <div class="box">
            <%-- <div class="box-title">
                <div style="text-align: center; text-decoration: underline; font-size: large; font-weight: bolder;">Observations & Comments Sheet (OCS) </div>
            </div>--%>
            <div class="box-content nopadding">
                <div class="form-horizontal">
                    <br />
                    <div class="row">
                        <div class="col-md-4 div_border" style="line-height: 20px;">
                            <div class="row">
                                <div class="col-md-4">
                                    <strong>Project Title:</strong>
                                </div>
                                <div class="col-md-8">
                                    <asp:Label ID="lblProjectName" runat="server"></asp:Label>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">
                                    <strong>Project Code/No:</strong>
                                </div>
                                <div class="col-md-8">
                                    <asp:Label ID="lblProjectNumber" runat="server"></asp:Label>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">
                                    <strong>PMWeb Form Name:</strong>
                                </div>
                                <div class="col-md-8">
                                    <asp:Label ID="lblFormName" runat="server"></asp:Label>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">
                                    <strong>Record No:</strong>
                                </div>
                                <div class="col-md-8">
                                    <asp:Label ID="lblRecordNumber" runat="server"></asp:Label>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">
                                    <strong>Revision:</strong>
                                </div>
                                <div class="col-md-8">
                                    <asp:Label ID="lblRevision" runat="server"></asp:Label>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">
                                    <strong>Subject:</strong>
                                </div>
                                <div class="col-md-8">
                                    <asp:Label ID="lblSubject" runat="server"></asp:Label>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">
                                    <strong>OCS Date:</strong>
                                </div>
                                <div class="col-md-8">
                                    <asp:Label ID="lblOcsDate" runat="server"></asp:Label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <strong>Stage:</strong>
                                </div>
                                <div class="col-md-8">
                                    <asp:Label ID="lblStage" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 div_border">
                            <div class="col-md-8">
                                <p style="font-weight: bold; text-decoration: italic;">
                                    ASSESSMENT CODE:<br />
                                    A = Approved/No Comments.   
                                    <br />
                                    B = Approved as Noted/Comments as Noted.
                                    <br />
                                    C = Revise and Resubmit for approval.<br />
                                    D = For Information/Voided.
                                    <br />
                                </p>
                            </div>
                            <asp:Button ID="btnExport" runat="server" Text="Export" Style="width: 100px;" CssClass="btn btn-default" OnClick="btnExport_Click" />
                            <%--<asp:Button ID="btnImport" runat="server" Text="Import" Style="width: 100px;" CssClass="btn btn-default" />--%>
                        </div>
                        <div class="col-md-4 div_border" id="divOverallComments" runat="server">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label for="txtOverallComments" class="col-form-label">Overall Comments:</label>&nbsp;&nbsp;<asp:LinkButton ID="lnkEditOverallComments" runat="server" OnClick="lnkEditOverallComments_Click" ToolTip="Edit"><i class="fa fa-edit"></i></asp:LinkButton>
                                    <asp:TextBox ID="txtOverallComments" runat="server" TextMode="MultiLine" Style="width: 100%; height: 100px;" CssClass="form-control" Visible="false"></asp:TextBox>
                                    <br />
                                    <asp:Label ID="lblOverallComments" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <asp:Button ID="btnSaveOverallCommnets" runat="server" Text="Save" Style="width: 100px;" CssClass="btn btn-primary" OnClick="btnSaveOverallCommnets_Click" Visible="false" />
                            <asp:Button ID="btnSaveOverallCommnetsCancel" runat="server" Text="Cancel" Style="width: 100px;" CssClass="btn btn-default" OnClick="btnSaveOverallCommnetsCancel_Click" Visible="false" />
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <%--<telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">--%>
    <asp:HiddenField ID="hidCustomForm" Value="0" runat="server" />
    <div class="box box-color box-bordered">
        <div class="box-content nopadding" style="margin-top: 20px;">
            <telerik:RadTabStrip RenderMode="Lightweight" runat="server" ID="RadTabStrip1" MultiPageID="RadMultiPage1" SelectedIndex="0" Skin="Simple">
                <Tabs>
                    <telerik:RadTab Text="OCS" Width="200px"></telerik:RadTab>
                    <%--<telerik:RadTab Text="Attachments" Width="200px"></telerik:RadTab>--%>
                </Tabs>
            </telerik:RadTabStrip>
            <telerik:RadMultiPage runat="server" ID="RadMultiPage1" SelectedIndex="0" CssClass="outerMultiPage">
                <telerik:RadPageView runat="server" ID="RadPageView1">
                    <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" GridLines="None" runat="server" AllowAutomaticDeletes="True"
                        AllowAutomaticInserts="True" PageSize="10"
                        AllowAutomaticUpdates="True"
                        AllowPaging="True"
                        AllowFilteringByColumn="true"
                        EnableViewState="true"
                        AutoGenerateColumns="false"
                        OnInsertCommand="RadGrid1_InsertCommand" OnUpdateCommand="RadGrid1_UpdateCommand" Skin="Simple"
                        HeaderStyle-BackColor="#16365c" HeaderStyle-ForeColor="#FFFFFF" HeaderStyle-Font-Bold="true" Width="100%"
                        OnDetailTableDataBind="RadGrid1_DetailTableDataBind" OnItemCommand="RadGrid1_ItemCommand" OnItemCreated="RadGrid1_ItemCreated" OnPdfExporting="RadGrid1_PdfExporting"
                        ClientSettings-Selecting-AllowRowSelect="true"
                        AllowSorting="false"
                        OnNeedDataSource="RadGrid1_NeedDataSource"
                        RetainExpandStateOnRebind="true" AlternatingItemStyle-BackColor="White"
                        PagerStyle-AlwaysVisible="true" OnItemDataBound="RadGrid1_ItemDataBound">
                        <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                        <ClientSettings>
                            <Selecting AllowRowSelect="True" CellSelectionMode="MultiColumn"></Selecting>
                            <ClientEvents OnBatchEditOpened="OnBatchEditOpened" OnRowShown  />
                        </ClientSettings>
                        <GroupingSettings CaseSensitive="false" />
                        <ExportSettings OpenInNewWindow="true" ExportOnlyData="true" IgnorePaging="true">
                            <Pdf PageTitle="OCS" PaperSize="Letter" DefaultFontFamily="Calibri" BorderStyle="Medium" BorderColor="#666666" PageHeight="297mm" PageWidth="550mm" PageLeftMargin="10mm" PageRightMargin="10mm" PageTopMargin="10mm" PageBottomMargin="10mm" />
                            <Excel Format="Xlsx" AutoFitImages="true" DefaultCellAlignment="Left" />
                        </ExportSettings>
                        <MasterTableView CommandItemDisplay="Top" DataKeyNames="RowNumber,Revison"
                            HorizontalAlign="NotSet" EditMode="Batch" ClientDataKeyNames="RowNumber"
                            EnableColumnsViewState="true" ViewStateMode="Enabled" HierarchyLoadMode="ServerOnDemand"
                            RetainExpandStateOnRebind="True" Name="GridOCS" PageSize="20">
                            <CommandItemSettings
                                ExportToPdfImageUrl="App_Themes/Site/img/export-pdf.jpg" ShowExportToPdfButton="true"
                                ShowExportToExcelButton="false" ExportToExcelImageUrl="App_Themes/Site/img/export-excel.jpg" />
                            <BatchEditingSettings EditType="Cell" />
                            <HeaderStyle BackColor="#16365C" ForeColor="#FFFFFF" />
                            <SortExpressions>
                                <telerik:GridSortExpression FieldName="OcsIndex" SortOrder="Ascending" />
                            </SortExpressions>
                            <DetailTables>
                                <telerik:GridTableView HeaderStyle-BackColor="#808080" HeaderStyle-ForeColor="White" CssClass="detail_table" Width="100%" runat="server" CommandItemDisplay="None" Name="Revisons" CommandItemSettings-ShowAddNewRecordButton="false" CommandItemSettings-ShowRefreshButton="false" AllowFilteringByColumn="false" RetainExpandStateOnRebind="false">
                                    <CommandItemSettings ShowAddNewRecordButton="False" ShowRefreshButton="False"></CommandItemSettings>
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="#" UniqueName="RowNumber" HeaderStyle-Width="30px" AllowFiltering="false" ReadOnly="true">
                                            <ItemTemplate>
                                                <asp:Label runat="server" ID="lblSequence" Width="50px" Text='<%# Eval("RecordSequence") %>'></asp:Label>
                                                <asp:HiddenField ID="hidRevisionRowNumber" runat="server" Value='<%# Eval("RowNumber") %>' />
                                                <asp:HiddenField ID="hidRevisionHasComments" runat="server" Value='<%# (Eval("HFDComments").ToString().Length > 0 ? "True" : "False") %>' />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn UniqueName="Rev_No" DataField="Rev_No" HeaderText="Rev #" HeaderStyle-Width="30px" ReadOnly="true">
                                            <HeaderStyle Width="30px"></HeaderStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn UniqueName="Document_Title" DataField="Document_Title" HeaderText="Document Title" HeaderStyle-Width="100px" ReadOnly="true">
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn UniqueName="Document_Ref_No" DataField="Document_Ref_No" HeaderText="Document Ref #" HeaderStyle-Width="100px" ReadOnly="true">
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn UniqueName="Discipline_Engineer" DataField="Discipline_Engineer" HeaderText="Discipline Engineer" HeaderStyle-Width="100px" ReadOnly="true">
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn UniqueName="Assess_Code" DataField="Assess_Code" HeaderText="Assessment Code" HeaderStyle-Width="50px" ReadOnly="true">
                                            <ItemTemplate>
                                                <%# Eval("Assess_Code").ToString().Length > 1 ? Eval("Assess_Code").ToString().Substring(0, 1) : Eval("Assess_Code").ToString() %>
                                            </ItemTemplate>
                                            <HeaderStyle Width="50px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn UniqueName="HMC_HFD_PMC_Comments" DataField="HMC_HFD_PMC_Comments" HeaderText="Owner Comments" HeaderStyle-Width="100" ReadOnly="true">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRevisionHasComments" runat="server" Text="<i class='fa fa-comments' aria-hidden='true'></i>" Style="float: right"></asp:Label>
                                                <%# Eval("HMC_HFD_PMC_Comments").ToString().Replace("[b]", "<b>").Replace("[/b]", "</b>") %>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn UniqueName="Response" DataField="Response" HeaderText="Owner Comments" HeaderStyle-Width="100" ReadOnly="true">
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn UniqueName="CreatedDate" DataField="CreatedDate" HeaderText="Created Date" HeaderStyle-Width="50" ReadOnly="true">
                                            <HeaderStyle Width="50px"></HeaderStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn UniqueName="IsActive" DataField="IsActive" HeaderText="Active" HeaderStyle-Width="50" ReadOnly="true">
                                        </telerik:GridBoundColumn>
                                    </Columns>
                                    <NoRecordsTemplate>
                                        <strong>No Revisions</strong>
                                    </NoRecordsTemplate>

                                    <HeaderStyle BackColor="Gray" ForeColor="White"></HeaderStyle>
                                </telerik:GridTableView>
                            </DetailTables>
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="#" UniqueName="RowNumber" HeaderStyle-Width="30px" AllowFiltering="false">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblRowNumber" Width="50px" Text='<%# Container.DataSetIndex+1 %>'></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn UniqueName="Rev_No" DataField="Rev_No" HeaderText="Rev #" HeaderStyle-Width="40px" ReadOnly="true" AllowFiltering="false" ItemStyle-CssClass="NoWrap">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkBtnRevision" CommandName="Revision" ToolTip="Create Revision" CommandArgument='<%# Eval("RowNumber") %>' runat="server" OnClientClick="return Confirm('Please confirm to create revision.')"><i class="fa fa-copy" style="font-size: 16px;"></i></asp:LinkButton>
                                        &nbsp;&nbsp;<%# Eval("Rev_No").ToString().PadLeft(2, '0') %><asp:HiddenField ID="hidRowNumber" runat="server" Value='<%# Eval("RowNumber") %>' />
                                        <asp:HiddenField ID="hidIsReadOnly" runat="server" Value='<%# Eval("IsReadOnly") %>' />
                                        <asp:HiddenField ID="hidIsHide" runat="server" Value='<%# Eval("IsHide") %>' />
                                        <asp:HiddenField ID="hidHasComments" runat="server" Value='<%# (Eval("HFDComments").ToString().Length > 0 ? "True" : "False") %>' />
                                        <%--<asp:Button ID="btnComments" runat="server" Text="Button" CommandName="Comments" CommandArgument='<%# Eval("RowNumber") %>' Style="display: none" />--%>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="Rev_No" TextMode="SingleLine" Text='<%# Eval("Rev_No") %>' runat="server" onkeydown="keydown(event, this)" CssClass="grid-control"></asp:TextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn UniqueName="Document_Title" DataField="Document_Title" HeaderText="Document Title" HeaderStyle-Width="100px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                    <ItemTemplate>
                                        <%# Eval("Document_Title").ToString().Replace("\r\n", "<br />") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="Document_Title" TextMode="MultiLine" CssClass="grid-control" Text='<%# Eval("Document_Title") %>' Height="75" runat="server" onkeydown="keydown(event, this)"></asp:TextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn UniqueName="Document_Ref_No" DataField="Document_Ref_No" HeaderText="Document Ref #" HeaderStyle-Width="100px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                    <ItemTemplate>
                                        <%# Eval("Document_Ref_No").ToString().Replace("\r\n", "<br />") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="Document_Ref_No" TextMode="MultiLine" CssClass="grid-control" Text='<%# Eval("Document_Ref_No") %>' Height="75" Width="100px" runat="server" onkeydown="keydown(event, this)"></asp:TextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn UniqueName="Discipline_Engineer" DataField="Discipline_Engineer" HeaderText="Discipline Engineer" HeaderStyle-Width="100" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                    <ItemTemplate>
                                        <%# Eval("Discipline_Engineer").ToString().Replace("\r\n", "<br />") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="Discipline_Engineer" TextMode="MultiLine" CssClass="grid-control" Text='<%# Eval("Discipline_Engineer") %>' Height="75" runat="server" onkeydown="keydown(event, this)"></asp:TextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn UniqueName="Assess_Code" DataField="Assess_Code" HeaderText="Assessment Code" HeaderStyle-Width="70px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                    <ItemTemplate>
                                        <%# Eval("Assess_Code").ToString().Length > 1 ? Eval("Assess_Code").ToString().Substring(0, 1) : Eval("Assess_Code").ToString() %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadDropDownList RenderMode="Lightweight" runat="server" ID="Assess_CodeId" DataValueField="Id"
                                            DataTextField="Assess_Code" DataSourceID="sqlDataSourceAssessment" Width="70" onkeydown="keydown(event, this)">
                                        </telerik:RadDropDownList>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn UniqueName="HMC_HFD_PMC_Comments" DataField="HMC_HFD_PMC_Comments" HeaderText="Owner Comments" HeaderStyle-Width="350px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                    <ItemTemplate>
                                        <asp:Label ID="lblHasComments" runat="server" Text="<i class='fa fa-comments' aria-hidden='true'></i>" Style="float: right"></asp:Label>
                                        <%# Eval("HMC_HFD_PMC_Comments").ToString().Replace("[b]", "<b>").Replace("[/b]", "</b>") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtConsultantComments" TextMode="MultiLine" CssClass="grid-control" Text='<%# Eval("HMC_HFD_PMC_Comments") %>' Height="150" runat="server" onkeydown="keydown(event, this)"></asp:TextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn UniqueName="Response" DataField="Response" HeaderText="Consultant Response" HeaderStyle-Width="350px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                    <ItemTemplate>
                                        <%# Eval("Response").ToString() %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtResponse" TextMode="MultiLine" CssClass="grid-control" Text='<%# Eval("Response").ToString()  %>' Height="150" runat="server" onkeydown="keydown(event, this)"></asp:TextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn UniqueName="Status" DataField="Status" HeaderText="Status" HeaderStyle-Width="90px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" DefaultInsertValue="Open">
                                    <ItemTemplate>
                                        <%# Eval("Status").ToString().Replace("\r\n", "<br />") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadDropDownList RenderMode="Lightweight" runat="server" ID="StatusId" DataValueField="Id"
                                            DataTextField="Description" DataSourceID="sqlStatus" Width="90px" onkeydown="keydown(event, this)">
                                        </telerik:RadDropDownList>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="CreatedByName" HeaderStyle-Width="100px" HeaderText="Created By" SortExpression="CreatedByName" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" UniqueName="CreatedByName" ReadOnly="true">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="CreatedDate" HeaderStyle-Width="80px" HeaderText="Created Date" SortExpression="CreatedDate" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" UniqueName="CreatedDate" ReadOnly="true">
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn UniqueName="StrIsActive" DataField="StrIsActive" HeaderText="Active" HeaderStyle-Width="100px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" DefaultInsertValue="Active">
                                    <ItemTemplate>
                                        <%# Eval("StrIsActive").ToString() %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadDropDownList RenderMode="Lightweight" runat="server" ID="IsActive">
                                            <Items>
                                                <telerik:DropDownListItem Value="Active" Text="Active" />
                                                <telerik:DropDownListItem Value="In Active" Text="In Active" />
                                            </Items>
                                        </telerik:RadDropDownList>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <%--  <telerik:GridCheckBoxColumn UniqueName="IsActive" DataField="IsActive" HeaderText="Active" HeaderStyle-Width="50px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" DefaultInsertValue="True" CurrentFilterValue="True">
                        </telerik:GridCheckBoxColumn>--%>
                            </Columns>
                        </MasterTableView>

                        <HeaderStyle BackColor="#16365C" Font-Bold="True" ForeColor="White"></HeaderStyle>

                        <FilterMenu RenderMode="Lightweight"></FilterMenu>

                        <HeaderContextMenu RenderMode="Lightweight"></HeaderContextMenu>
                    </telerik:RadGrid>
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView2">
                    <div class="row">
                        <div class="col-md-3" id="treeContainer" runat="server">
                        </div>
                        <div class="col-md-9">
                            <object id='pdfbox' type="application/pdf"></object>
                        </div>
                    </div>
                </telerik:RadPageView>
            </telerik:RadMultiPage>


            <asp:SqlDataSource ID="sqlDataSourceAssessment" runat="server" ConnectionString="<%$ ConnectionStrings:Connection %>"
                ProviderName="System.Data.SqlClient" SelectCommand="SELECT -1 AS Id, '' AS Assess_Code UNION ALL SELECT Id, SUBSTRING(Description, 0, 2) AS Assess_Code FROM PMWeb_ListValues WHERE ListId=10282"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sqlStatus" runat="server" ConnectionString="<%$ ConnectionStrings:Connection %>"
                ProviderName="System.Data.SqlClient" SelectCommand="SELECT -1 AS Id, '' AS Description UNION ALL SELECT Id, Description FROM PMWeb_ListValues WHERE ListId=10283 ORDER BY Description DESC"></asp:SqlDataSource>
        </div>
    </div>
    <div class="modal fade" id="hmcCommentsModal" tabindex="-1" role="dialog" aria-labelledby="hmcCommentsModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="hmcCommentsModalLabel">Owner Comments</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnCommentSave" runat="server" Text="Save" CssClass="btn btn-primary" OnClick="btnCommentSave_Click" OnClientClick="SaveComments()" />
                    <%--<button type="button" class="btn btn-primary" id="btnSaveHMCComments">Save</button>--%>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="hmcCommentsRevisionModal" tabindex="-1" role="dialog" aria-labelledby="hmcCommentsRevisionModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="hmcCommentsRevisionModalLabel">Owner Comments</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="hmcNewRowCommentsModal" tabindex="-1" role="dialog" aria-labelledby="hmcNewRowCommentsModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="hmcNewRowCommentsModalLabel">Owner Comments</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div>
                        <div class="form-group" id="divNewRowTitle" runat="server">
                            <label for="recipient-name" class="col-form-label">Title:</label>
                            <input type="text" style="width: 100%" id="txtNewRowTitle" class="form-control" />
                        </div>
                        <div class="form-group" id="divNewRowConsultantComments" runat="server">
                            <label for="message-text" class="col-form-label">Owner Comments:</label>
                            <textarea id="txtNewRowConsultantComments" style="width: 100%; height: 150px;" class="form-control"></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" onclick="SaveNewComments()">Save</button>
                </div>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hidCommentRowNumber" runat="server" />
    <asp:HiddenField ID="hidCommentTitle" runat="server" />
    <asp:HiddenField ID="hidComment" runat="server" />
    <asp:HiddenField ID="hidHMCComment" runat="server" />
    <%--</telerik:RadAjaxPanel>--%>
</asp:Content>
