<%@ Page Language="vb" Title="Link Schedule" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="LinkSchedulePopup.aspx.vb" Inherits="Website.LinkSchedulePopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<style>
    a {
        text-decoration: none !important;
    }

    .LinkScheduleUpload .ruButton.ruBrowse{
        width:Calc(100% - 15px);
    }

    .RadUpload.LinkScheduleUpload {
        max-width: none;
        border-radius: 0px;
        background-color: rgb(105,185,50);
        border: 1px solid rgb(105,185,50) !important;
        padding: 0;
        height: 48px;
    }

    .RadUpload.LinkScheduleUpload .ruFileWrap {
        height: 48px !important;
    }

    .LinkScheduleUpload .ruDropZone {
        height: 48px !important;
        background-color: rgb(105,185,50) !important;
        border-radius: 0px !important;
        color: #fff !important;
        border: 1px solid rgb(105,185,50) !important;
        padding: 0px !important;
        left:0 !important;
        font-size:12px;
        /*margin-left: 4px !important;*/
        /*padding-right: 12px !important;*/
        /*margin-top: -6px !important;*/
    }

    .LinkScheduleUpload .ruButton {
        color: #fff !important;
        width: 100% !important;
        height: 26px !important;
    }

    .RadUpload.LinkScheduleUpload .ruInputs li {
        text-align: center !important;
    }

    #lblXmlFile{
        margin-top: 7px;
    }
    td.labelWidth.lblSetting{
        width: 385px !important;
    }
    td.controlWidth.chkSetting{
        min-width:15px !important;
    }

    td.labelWidth.lblSetting span{
        width:380px !important;
    }

     .LinkScheduleUpload .ruButton.ruRemove,.LinkScheduleUpload .ruButton.ruCancel{
        display:inline-block !important;

        width:initial !important;
    }

       .LinkScheduleUpload .ruButton.ruRemove:hover,.LinkScheduleUpload .ruButton.ruCancel:hover{
        background-color:RGB(105,170,50) !important;
    }

      .LinkScheduleUpload .ruButton.ruRemove:focus,.LinkScheduleUpload .ruButton.ruCancel:focus{
        background-color:RGB(105,170,50) !important;
          color: #fff !important;
    }
        
</style>
<script type="">
    window.onload = function () {
        var tds = document.querySelectorAll('.controlWidth');
        var arrTd = Array.prototype.slice.call(tds);
        for (var i = 0; i < arrTd.length; i++) {
            if (arrTd[i].innerHTML.trim() === "")
                arrTd[i].parentElement.style.display = 'none';
        }

    };

    function LoadAjaxPanel() {
        $('[id=DisableAllControlsOnPostback]').removeClass('Hide');
    }

    var uploadsDocFileInProgress = 0;

    function onDocFileSelected(sender, args) {
        uploadsDocFileInProgress++;
    }

    function onDocFileUploaded(sender, args) {
        decrementUploadsDocFileInProgress();
        LoadAjaxPanel();
        var btnUploadFile = $("[id$=btnUploadFile]");
        btnUploadFile.click();
    }

    function onDocFileUploadFailed(sender, args) {
        decrementUploadsDocFileInProgress();
    }

    function decrementUploadsDocFileInProgress() {
        uploadsDocFileInProgress--;
    }

    function ClientDocFileValidationFailed(sender, args) {
        decrementUploadsDocFileInProgress();
    }
</script>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadAjaxManager ID="RadAjax1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdglinkedRecords">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdglinkedRecords" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" Skin="Default" />

         <div style="z-index: 89999; width: 100%; height: 100%; position: fixed; zoom: 1; color: black; margin-top: -50px;padding-top: 50px;" class="Hide RadAjax RadAjax_Default" id="DisableAllControlsOnPostback">
            <div class="raDiv"></div>
            <div id="PMLoadingIcon" class="raColor raTransp"></div>
        </div>

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" Width="100%" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="LoadAjaxPanel">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" AccessKey="s" Value="Save">
                            </telerik:RadToolBarButton>

                            <telerik:RadToolBarButton ValidationGroup="SaveAndExit" EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>

                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>


        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row">
                <div class="col-4 col-4-left">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblApplication" meta:resourcekey="lblApplication" runat="server" Text="Application"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlApplication" AutoPostBack="True" Width="100%" runat="server"></telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr ID="pnlP6Database" runat="server">
                            <td class="labelWidth">
                                <asp:Label ID="lblDatabase" meta:resourcekey="lblDatabase" runat="server" Text="Database"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlDatabase" AutoPostBack="True" Width="100%" runat="server"></telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr ID="pnlP6Project" runat="server">
                            <td class="labelWidth">
                                <asp:Label ID="lblProject" meta:resourcekey="lblProject" runat="server" Text="Project"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlProjects" runat="server" Width="100%"
                                    Skin="Default" CloseDropDownOnBlur="true" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                    NoWrap="True" AllowCustomText="true" AutoPostBack="true" EnableItemCaching="false"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested"
                                    Style="font-size: 11px" Height="250px">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr ID="pnlMsProject" runat="server" Visible="false">
                            <td colspan="2">
                                    <table cellspacing="0" cellpadding="0" width="100%">
                                        <tr>
                                            <td>
                                               <telerik:RadAsyncUpload runat="server" id="rauXMLUpload" skin="Default" onclientfileuploadfailed="onDocFileUploadFailed" width="100%" style="text-align: center;"
                                                    tooltip="Click button to select file to upload or drop one in this box"  CssClass="LinkScheduleUpload"
                                                    onclientfileselected="onDocFileSelected" OnClientFileUploaded="onDocFileUploaded" MaxFileInputsCount="1"
                                                    multiplefileselection="Disabled" onclientvalidationfailed="ClientDocFileValidationFailed" hidefileinput="true" dropzones=".TeamDropZone">
                                                <Localization Select="DROP FILE HERE OR CLICK TO ADD" />
                                              </telerik:RadAsyncUpload>
                                                <asp:Button ID="btnUploadFile" runat="server" CssClass="Hide" />
                                            </td>                                            
                                        </tr>
                                        <tr style="height:5px;" />
                                        <tr>
                                            <td style="padding:5px 0 5px 0">
                                                <asp:HyperLink ID="btnDownloadEdit" runat="server" CausesValidation="false" Style="text-decoration: underline; cursor: Pointer;"
                                                    Text='' ToolTip="<%$ Resources:PMWeb, Download %>"></asp:HyperLink>
                                            </td>
                                        </tr>
                                    </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="lblError" meta:resourcekey="lblError" CssClass="Validator" runat="server" Visible="false" Text="Web Service Connection Error"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-4 col-4-right">
                    <table class="colTable" border="0">
                        <tr>
                            <td class="labelWidth lblSetting">
                                 <asp:Label ID="lblLockSchedule" meta:resourcekey="chkLockSchedule" runat="server"  Text="Lock schedule to prevent recalculation"></asp:Label>
                            </td>                             
                            <td class="controlWidth chkSetting">
                                <asp:CheckBox ID="chkLockSchedule" Checked="true" AutoPostBack="true" onclick="LoadAjaxPanel()" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth lblSetting">
                                 <asp:Label ID="lblImportWBS" meta:resourcekey="chkImportWBSCodes" runat="server"  Text="Import WBS codes"></asp:Label>
                            </td>
                            <td class="controlWidth chkSetting">
                                <asp:CheckBox ID="chkImportWBS" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth lblSetting">
                                 <asp:Label ID="lblupdateLinkedTasks" meta:resourcekey="chkupdateLinkedTasks" runat="server"  Text="Update previously linked tasks"></asp:Label>
                            </td>
                            <td class="controlWidth chkSetting">
                                 <asp:CheckBox ID="chkupdateLinkedTasks" runat="server" />
                            </td>
                        </tr>
                      </table>
                    <table class="colTable" border="0">
                        <tr runat="server" ID="trWorkingHours">
                            <td class="labelWidth">
                                 <asp:Label ID="lblWorkingHours" meta:resourcekey="lblWorkingHours" runat="server" Text="Working Hours"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                 <asp:TextBox ID="txtWorkingDays" MinNumber="1" MaxLength="9" CssClass="PositiveDouble" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr runat="server" ID="trPctComplete">
                            <td class="labelWidth">
                                <asp:Label ID="lblPctComplete" meta:resourcekey="lblPctComplete" runat="server" Text="Percent Complete Method"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                 <telerik:RadComboBox ID="ddlPctComplete" Width="150px" runat="server"></telerik:RadComboBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="ResponsiveMargin col-12">
                    <telerik:RadGrid ID="rdglinkedRecords" runat="server" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" FitPageHeightOffset="24"
                        AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                        PageSize="250" AllowPaging="true" ShowFooter="false" ShowGroupPanel="false" Width="100%"
                        AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowSorting="true" ItemStyle-Height="20px">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                        <GroupPanel Text="Group by"></GroupPanel>
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" InsertItemDisplay="Top"
                            InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true"
                            EditMode="InPlace" EnableHeaderContextMenu="false">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="UID" GroupByExpression="Id [GridColumn_Id] Group By Id ASC"
                                    HeaderStyle-Width="75px" SortExpression="Id" UniqueName="Id">
                                    <ItemTemplate>
                                        <span>
                                            <%#Container.DataItem("Id").ToString%>&nbsp;</span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Parent UID" GroupByExpression="ParentId [GridColumn_ParentId] Group By ParentId ASC"
                                    HeaderStyle-Width="75px" SortExpression="ParentId" UniqueName="ParentId">
                                    <ItemTemplate>
                                        <span>
                                            <%#Container.DataItem("ParentId").ToString%>&nbsp;</span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Summary" GroupByExpression="IsSummary [GridColumn_IsSummary] Group By IsSummary ASC"
                                    HeaderStyle-Width="75px" SortExpression="IsSummary" UniqueName="IsSummary">
                                    <ItemTemplate>
                                        <img alt="" src='Images/Global/<%# CStr(IIf(Eval("IsSummary"), "checked.png", "unchecked.png")) %>' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                    <HeaderStyle Width="75px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Code" UniqueName="Code" Groupable="false"
                                    Reorderable="false" SortExpression="Code">
                                    <ItemTemplate>
                                        <span>
                                            <%#IIf(CStr(Eval("Code")) = String.Empty, "&nbsp;", Eval("Code"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="90px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Name" SortExpression="Name" UniqueName="Name"
                                    GroupByExpression="Name [GridColumn_Name] Group By Name ASC">
                                    <ItemTemplate>
                                        <span>
                                            <%#IIf(Container.DataItem("Name") = String.Empty, "&nbsp;", Container.DataItem("Name"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="238px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Start"
                                    HeaderStyle-Width="80px" GroupByExpression="Start [GridColumn_Start] Group By Start ASC" SortExpression="Start" UniqueName="Start">
                                    <ItemTemplate>
                                        <span>
                                            <%#FormatDate(Container.DataItem("Start"))%>&nbsp;</span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Finish" GroupByExpression="Finish [GridColumn_Finish] Group By Finish ASC"
                                    HeaderStyle-Width="80px" SortExpression="Finish" UniqueName="Finish">
                                    <ItemTemplate>
                                        <span>
                                            <%#FormatDate(Container.DataItem("Finish"))%>&nbsp;</span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Duration Days" GroupByExpression="Duration [GridColumn_Duration] Group By Duration ASC"
                                    HeaderStyle-Width="132px" SortExpression="Duration" UniqueName="Duration">
                                    <ItemTemplate>
                                        <span>
                                            <%#FormatNumber(Container.DataItem("Duration"))%>&nbsp;</span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Actual Start"
                                    HeaderStyle-Width="80px" GroupByExpression="ActualStart [GridColumn_ActualStart] Group By ActualStart ASC" SortExpression="ActualStart" UniqueName="ActualStart">
                                    <ItemTemplate>
                                        <span>
                                            <%#FormatDate(Container.DataItem("ActualStart"))%>&nbsp;</span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Actual Finish" GroupByExpression="ActualFinish [GridColumn_ActualFinish] Group By ActualFinish ASC"
                                    HeaderStyle-Width="80px" SortExpression="ActualFinish" UniqueName="ActualFinish">
                                    <ItemTemplate>
                                        <span>
                                            <%#FormatDate(Container.DataItem("ActualFinish"))%>&nbsp;</span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Actual Duration Days" GroupByExpression="ActualDuration [GridColumn_ActualDuration] Group By ActualDuration ASC"
                                    HeaderStyle-Width="132px" SortExpression="ActualDuration" UniqueName="ActualDuration">
                                    <ItemTemplate>
                                        <span>
                                            <%#FormatNumber(Container.DataItem("ActualDuration"))%>&nbsp;</span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Remaining Duration Hours" GroupByExpression="RemainingDurationHours [GridColumn_RemainingDurationHours] Group By RemainingDurationHours ASC"
                                    HeaderStyle-Width="132px" SortExpression="RemainingDurationHours" UniqueName="RemainingDurationHours">
                                    <ItemTemplate>
                                        <span>
                                            <%#FormatNumber(Container.DataItem("RemainingDurationHours"))%>&nbsp;</span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Remaining Duration Days" GroupByExpression="RemainingDurationDays [GridColumn_RemainingDurationDays] Group By RemainingDurationDays ASC"
                                    HeaderStyle-Width="132px" SortExpression="RemainingDurationDays" UniqueName="RemainingDurationDays">
                                    <ItemTemplate>
                                        <span>
                                            <%#FormatNumber(Container.DataItem("RemainingDurationDays"))%>&nbsp;</span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Complete" GroupByExpression="PctComplete [GridColumn_PctComplete] Group By PctComplete ASC"
                                    HeaderStyle-Width="70px" SortExpression="PctComplete" UniqueName="PctComplete">
                                    <ItemTemplate>
                                        <span><%#FormatPercent(Container.DataItem("PctComplete"))%></span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Total Float" GroupByExpression="TotalFloat [GridColumn_TotalFloat] Group By TotalFloat ASC"
                                    HeaderStyle-Width="70px" SortExpression="TotalFloat" UniqueName="TotalFloat">
                                    <ItemTemplate>
                                        <span><%# Container.DataItem("TotalFloat")%></span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="WBSCode" GroupByExpression="WBSCode [GridColumn_WBSCode] Group By WBSCode ASC"
                                    HeaderStyle-Width="70px" SortExpression="WBSCode" UniqueName="WBSCode">
                                    <ItemTemplate>
                                        <span>
                                            <%#IIf(CStr(Eval("WBSCode")) = String.Empty, "&nbsp;", Eval("WBSCode"))%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="WBSDescription" GroupByExpression="WBSDescription [GridColumn_WBSDescription] Group By WBSDescription ASC"
                                    HeaderStyle-Width="150px" SortExpression="WBSDescription" UniqueName="WBSDescription">
                                    <ItemTemplate>
                                        <span>
                                            <%#IIf(CStr(Eval("WBSDescription")) = String.Empty, "&nbsp;", Eval("WBSDescription"))%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <CommandItemTemplate>

                                <table style="padding: 0px; height: 20px;" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="padding-left: 5px;">
                                            <asp:LinkButton ID="btnRefresh" runat="server" SecurityButtonType="ItemMode" CausesValidation="false" CommandName="RebindGrid" CssClass="GridCmdRebindGrid">
                                                <span class="Icon"></span>
                                                <asp:Label runat="server" ID="lblRefresh" Text="Refresh"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </CommandItemTemplate>
                            <ItemStyle Wrap="false" />
                            <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                            <FooterStyle CssClass="GridFooter" />
                        </MasterTableView>
                        <ClientSettings
                            AllowDragToGroup="false">
                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                AllowColumnResize="True" />
                        </ClientSettings>
                        <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="PerformInsert,UpdateEdited" />
                    </telerik:RadGrid>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
