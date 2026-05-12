<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="LaborResources.aspx.vb" Inherits="Website.LaborResources" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="ResourcesLaborDetails.ascx" TagName="ResourcesLaborDetails" TagPrefix="uc1" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc2" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc3" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc4" %>
<%@ Register Src="ResourceCalendar.ascx" TagName="ResourceCalendar" TagPrefix="uc5" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc6" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc7" %>
<%@ Register Src="AssetRotator.ascx" TagName="LaborResourcesRotator" TagPrefix="uc8" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">
    <link href="CSS/ControlsCSS/Toolbar.css" rel="stylesheet" />
    <style>
        .RadUpload .ruBrowse {
            width: 150px;
            padding-left: 20px !important;
        }

        .RadUpload .ruButton {
            background-position: 0 -45px !important;
            background-position-x: 0px;
            background-position-y: -45px;
            text-align: left;
        }

        .clearImage {
            background-image: url('../Images/rtbCheck.png');
            background-position: 18px 9px !important;
            background-repeat: no-repeat;
            vertical-align: middle;
            padding-left: 36px !important;
            padding-right: 30px !important;
            font-size: 11px !important;
            border: none !important;
            border-radius: 12px !important;
        }

            .clearImage:hover {
                background-color: lightgray;
            }
    </style>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            var allowdropdownClose;

            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
                maintoolbarClick(args.get_item().get_value())
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }

            function maintoolbarClick(Value) {
                var HasMergeTemplate = '<%= PM.LaborResourcesInfo.HasMergeTemplate%>';
                var RecordDescription = '<%=JSEscape(PM.LaborResourcesInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.LaborResourcesInfo.Description)%>';
                var HasReports = '<%= PM.LaborResourcesInfo.HasReports%>';
                var Id = '<%= PM.LaborResourcesInfo.Id%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("LABORRESOURCES")%>';
                switch (Value) {
                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            var left = (screen.width - 1045) / 2;
                            var top = (screen.height - 415) / 2;
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=LABORRESOURCES&Id=" +
                                        Id + "&Description="
                                        + Description
                                        + "&RecordDescription=" + RecordDescription
                                        + "&EntityId=0" + "&EntityType=0", 1045, 515, false);

                        }
                        break;
                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=LABORRESOURCES&Id=" +
                                '<%= PM.Estimate.PreBidInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + '<%=PM.Estimate.PreBidInfo.ProjectId%>' + "&EntityType=0", 890, 430, false);
                        }
                        break;

                    case 'Print':
                        OpenReportViewerPOPUp("PrintPreview.aspx?ReportId=127&Param=ProcurementId&Values=" + '<%=PM.Estimate.PreBidInfo.Id%>');
                        //            eventArgs.set_cancel(true);
                        break;
                    case 'Notification':
                        if (Id == 0) break;
                        OpenPOPUp("Notification.aspx?ObjectType=LABORRESOURCES&Id=" +
                     '<%= PM.LaborResourcesInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=0&EntityType=0", 820, 500, false);
                        break;

                    case 'PurchaseOrder':
                        OpenPOPUpToRedirect('ProcurementContracts.aspx?type=PurchaseOrder', 950, 500);
                        break;

                    case 'ViewPMWebReports':
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=LABORRESOURCES&Id=" + Id
                        + "&EntityId=" + '<%=PM.Estimate.PreBidInfo.ProjectId%>' + "&EntityType=0", 820, 500, false);
                        }
                        break;

                    case 'New':
                        window.location = "LaborResources.aspx";
                        break;

                    default:
                        //                        eventArgs.set_cancel(false);
                        break;
                }
            }

            function RadAsyncUploadclcik() {

                var imageuploader = document.getElementById("rauUserImagefile0");
                //var imgupld =  $find("<%= rauUserImage.ClientID%>");
                imageuploader.click();
                return false;
            }

            function GetResourceGroupValueToReturn(combobox, eventArgs) {
                var SelectedValue;
                var hdn = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_hddnResourceGroupIds';
                var hdnField = $("[id$=" + hdn + "]")[0];
                var context = eventArgs.get_context();
                context["Ids"] = hdnField.value;
            }
            function ResourceGroupcheck(sender, ddl, resultId, ResultName) {

                var combo = $find(ddl);
                var hdn = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnResourceGroupIds';
                var hdn1 = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnResourceGroupNames';
                var hdnNames = $("[id$=" + hdn1 + "]")[0];
                var hdnField = $("[id$=" + hdn + "]")[0];
                var vlue = hdnField.value;
                if (sender.checked) {
                    hdnField.value = vlue + ',' + resultId;
                    if (hdnNames.value == '') {
                        hdnNames.value = ResultName;
                        combo.set_text(ResultName)
                    }
                    else
                        hdnNames.value = hdnNames.value + ',' + ResultName;
                    combo.set_text(hdnNames.value)
                }
                else {
                    var results = vlue.split(',');
                    var resultNames = hdnNames.value.split(',');
                    var i = 0;
                    var newVal = '';
                    var newNames = '';
                    for (i = 0; i < results.length; i++) {
                        if (results[i] != resultId)
                            newVal = newVal + ',' + results[i];

                    }
                    var find = 1
                    for (i = 0; i < resultNames.length; i++) {
                        if (resultNames[i] != ResultName || find == 0) {
                            newNames = newNames + ',' + resultNames[i];
                        }
                        else
                            find = 0;
                    }
                    hdnField.value = newVal;
                    if (newNames != '') {
                        hdnNames.value = newNames.substring(1);
                        combo.set_text(hdnNames.value)
                    }
                    else {
                        hdnNames.value = newNames;
                        combo.set_text(hdnNames.value)
                    }
                }

            }

            function GetManagerValueToReturn(combobox, eventArgs) {
                var SelectedValue;
                var hdn = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_hddnManagerIds';
                var hdnField = $("[id$=" + hdn + "]")[0];
                var context = eventArgs.get_context();
                context["Ids"] = hdnField.value;
            }
            function Managercheck(sender, ddl, resultId, ResultName) {

                var combo = $find(ddl);
                var hdn = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnManagerIds';
                var hdn1 = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnManagerNames';
                var hdnNames = $("[id$=" + hdn1 + "]")[0];
                var hdnField = $("[id$=" + hdn + "]")[0];
                var vlue = hdnField.value;
                if (sender.checked) {
                    hdnField.value = vlue + ',' + resultId;
                    if (hdnNames.value == '') {
                        hdnNames.value = ResultName;
                        combo.set_text(ResultName)
                    }
                    else
                        hdnNames.value = hdnNames.value + ',' + ResultName;
                    combo.set_text(hdnNames.value)
                }
                else {
                    var results = vlue.split(',');
                    var resultNames = hdnNames.value.split(',');
                    var i = 0;
                    var newVal = '';
                    var newNames = '';
                    for (i = 0; i < results.length; i++) {
                        if (results[i] != resultId)
                            newVal = newVal + ',' + results[i];

                    }
                    var find = 1
                    for (i = 0; i < resultNames.length; i++) {
                        if (resultNames[i] != ResultName || find == 0) {
                            newNames = newNames + ',' + resultNames[i];
                        }
                        else
                            find = 0;
                    }
                    hdnField.value = newVal;
                    if (newNames != '') {
                        hdnNames.value = newNames.substring(1);
                        combo.set_text(hdnNames.value)
                    }
                    else {
                        hdnNames.value = newNames;
                        combo.set_text(hdnNames.value)
                    }
                }

            }

            function GetSkillsValueToReturn(combobox, eventArgs) {
                var SelectedValue;
                var hdn = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_hddnSkillsIds';
                var hdnField = $("[id$=" + hdn + "]")[0];
                var context = eventArgs.get_context();
                context["Ids"] = hdnField.value;
            }
            function Skillscheck(sender, ddl, resultId, ResultName) {

                var combo = $find(ddl);
                var hdn = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnSkillsIds';
                var hdn1 = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnSkillsNames';
                var hdnNames = $("[id$=" + hdn1 + "]")[0];
                var hdnField = $("[id$=" + hdn + "]")[0];
                var vlue = hdnField.value;
                if (sender.checked) {
                    hdnField.value = vlue + ',' + resultId;
                    if (hdnNames.value == '') {
                        hdnNames.value = ResultName;
                        combo.set_text(ResultName)
                    }
                    else
                        hdnNames.value = hdnNames.value + ',' + ResultName;
                    combo.set_text(hdnNames.value)
                }
                else {
                    var results = vlue.split(',');
                    var resultNames = hdnNames.value.split(',');
                    var i = 0;
                    var newVal = '';
                    var newNames = '';
                    for (i = 0; i < results.length; i++) {
                        if (results[i] != resultId)
                            newVal = newVal + ',' + results[i];

                    }
                    var find = 1
                    for (i = 0; i < resultNames.length; i++) {
                        if (resultNames[i] != ResultName || find == 0) {
                            newNames = newNames + ',' + resultNames[i];
                        }
                        else
                            find = 0;
                    }
                    hdnField.value = newVal;
                    if (newNames != '') {
                        hdnNames.value = newNames.substring(1);
                        combo.set_text(hdnNames.value)
                    }
                    else {
                        hdnNames.value = newNames;
                        combo.set_text(hdnNames.value)
                    }
                }

            }

            function GetUsersGroupsValueToReturn(combobox, eventArgs) {
                var SelectedValue;
                var hdn = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_hddnUsersGroupsIds';
                var hdnField = $("[id$=" + hdn + "]")[0];
                var context = eventArgs.get_context();
                context["Ids"] = hdnField.value;
            }

            function UsersGroupscheck(sender, ddl, resultId, ResultName) {

                var combo = $find(ddl);
                var hdn = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnUsersGroupsIds';
                var hdn1 = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnUsersGroupsNames';
                var hdnNames = $("[id$=" + hdn1 + "]")[0];
                var hdnField = $("[id$=" + hdn + "]")[0];
                var vlue = hdnField.value;
                if (sender.checked) {
                    hdnField.value = vlue + ',' + resultId;
                    if (hdnNames.value == '') {
                        hdnNames.value = ResultName;
                        combo.set_text(ResultName)
                    }
                    else
                        hdnNames.value = hdnNames.value + ',' + ResultName;
                    combo.set_text(hdnNames.value)
                }
                else {
                    var results = vlue.split(',');
                    var resultNames = hdnNames.value.split(',');
                    var i = 0;
                    var newVal = '';
                    var newNames = '';
                    for (i = 0; i < results.length; i++) {
                        if (results[i] != resultId)
                            newVal = newVal + ',' + results[i];

                    }
                    var find = 1
                    for (i = 0; i < resultNames.length; i++) {
                        if (resultNames[i] != ResultName || find == 0) {
                            newNames = newNames + ',' + resultNames[i];
                        }
                        else
                            find = 0;
                    }
                    hdnField.value = newVal;
                    if (newNames != '') {
                        hdnNames.value = newNames.substring(1);
                        combo.set_text(hdnNames.value)
                    }
                    else {
                        hdnNames.value = newNames;
                        combo.set_text(hdnNames.value)
                    }
                }

            }

            function OnClientSelectedIndexChanging(combobox, eventArgs) {
                allowdropdownClose = false;
                eventArgs.set_cancel(true);
            }
            function OnClientDropDownClosing(combobox, eventArgs) {
                if (allowdropdownClose == false) {
                    eventArgs.set_cancel(true);
                }
                allowdropdownClose = true;

            }
            function onDocFileSelected(sender, args) {
            }
            function onDocFileUploadFailed(sender, args) {
            }
            function onDocFileUploaded(sender, args) { }
            function ClientDocFileValidationFailed(sender, args) { }




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

            //function GetPayTypesValueToReturn(combobox, eventArgs) {
            //    var SelectedValue;
            //    var hdn = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_hddnPayTypesIds';
            //    var hdn1 = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_hddnDefaultPayTypeId';
            //    var hdnField = $("[id$=" + hdn + "]")[0];
            //    var hdnDefaultPayTypeId = $("[id$=" + hdn1 + "]")[0];
            //    var items = combobox.get_items();
            //    var PayTypesIds = hdnField.value;
            //    var DefaultPayTypeId = hdnDefaultPayTypeId.value;
            //    //var context = eventArgs.get_context();
            //    //context["Ids"] = hdnField.value;
            //    var i = 0;
            //    $("#" + combobox.get_id() + "_DropDown").find("input[id*='chkAllow']").each(function () {
            //        if (i != 0) {
            //            var item = items.getItem(i - 1);
            //            if (PayTypesIds.lastIndexOf(item.get_value()) >= 0) {
            //                this.checked = true;
            //            }
            //        }
            //        i++;
            //    });

            //    var j = 0;
            //    $("#" + combobox.get_id() + "_DropDown").find("input[id*='chkDefault']").each(function () {
            //            var item = items.getItem(j);
            //            if (DefaultPayTypeId.lastIndexOf(item.get_value()) >= 0) {
            //                this.checked = true;
            //            }
            //        j++;
            //    });

            //}

            function loadText() {
                var combo = $find('ctl00_CPH1_ddlClassifications');
                combo.set_text($('#ctl00_CPH1_hddnClassificationText').val());
            }

            function loadPayTypeText() {
                var combo = $find('ctl00_CPH1_ddlPayTypes');
                combo.set_text($('#ctl00_CPH1_hddnPayTypesText').val());
            }

        </script>
    </telerik:RadCodeBlock>

    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings> 
       <telerik:AjaxSetting AjaxControlID="mlpLaborResources">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpLaborResources" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpLaborResources" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
     
            <telerik:AjaxSetting AjaxControlID="ddlContacts">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ddlContacts" />
                    <telerik:AjaxUpdatedControl ControlID="mlpLaborResources" />
                    <telerik:AjaxUpdatedControl ControlID="ddlCompanies" />
                    <telerik:AjaxUpdatedControl ControlID="txtFirstName" />
                    <telerik:AjaxUpdatedControl ControlID="txtLastName" />
                    <telerik:AjaxUpdatedControl ControlID="txtDescription" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <table class="ToolBar SmallToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=283">
                                <div class="btnToolbarSearchDocument">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>
            <td class="ToolbarTd HideOnMobileToolbar showOnIpad Recent">
                <asp:LinkButton runat="server" ID="btnRecent">
                                <div class="btnToolbarRecent">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>
            <td style="width: 240px" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                <telerik:RadComboBox ID="ddlLaborResources" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                    Skin="Default" AllowCustomText="true" EmptyMessage="Select Labor Resource..." OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging"
                    Width="240px" AutoPostBack="False" NoWrap="true" CausesValidation="False" Height="400px" ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                    EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                    <Items>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <%--  <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png"
                                        Value="Delete" NavigateUrl="SearchDocument.aspx?O=283" CausesValidation="false">
                                    </telerik:RadToolBarButton>--%>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CommandName="Save" AccessKey="s" ValidationGroup="Save" CausesValidation="true" ToolTip="Save (Alt+s)">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png" Width="150px"
                                    CommandName="New" AccessKey="n" ToolTip="New (Alt+n)" CausesValidation="false" PostBack="false">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton SecurityButtonType="Copy" PostBack="true" CommandName="Copy" Width="150px"
                                    ImageUrl="Images/ToolBar/Revision.png">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read" CssClass="ToolbarPrint HideOnMobileToolbar"
                            EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewPMWebReports">
                                </telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewTemplates">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                            <ItemTemplate>
                                <telerik:RadMenu runat="server" ID="MobileRadmen" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem Text="Print" Value="Print">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Word" Value="ViewTemplates"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Active" Value="Active" CssClass="ActiveLocation"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="InActive" Value="InActive" CssClass="InactiveLocation"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('LABORRESOURCES');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Help" Value="Help" onclick="helpClick();"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Active.png" OuterCssClass="HideOnMobileToolbar"
                            Value="Activate" CommandName="Activation" ToolTip="Activate">
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td style="width: 100%"></td>
        </tr>
    </table>


    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="0" runat="server" MultiPageID="mlpLaborResources" ScrollChildren="true" ScrollButtonsPosition="Left"
        Skin="Default" Width="100%" CssClass="documentTabs">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="true" />
            <%-- <telerik:RadTab Text="Details" PageViewID="pvDetails" Value="Details" />--%>
            <telerik:RadTab Text="Calendar" Value="Calendar"></telerik:RadTab>
            <telerik:RadTab Text="Specifications" Value="Spec" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>

    <telerik:RadMultiPage ID="mlpLaborResources" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="true" CssClass="documentMultiPages">

        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">

            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" LoadingPanelID="ldpPM" EnableAJAX="false">
                <div class="PMMainPage">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblID" runat="server" meta:Resourcekey="lblID" Text="ID*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtID" MaxLength="500" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvLaborID" runat="server" ValidationGroup="Save" ControlToValidate="txtID"
                                            CssClass="Validator" Display="Dynamic" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                            ForeColor=""></asp:RequiredFieldValidator>
                                        <asp:Label ID="lblUniqueID" runat="server" Text="Code must be unique" meta:Resourcekey="lblUniqueID" Visible="false" CssClass="Validator"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliCompany" meta:Resourcekey="hliCompany" Text="Company11"></asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCompanies" runat="server" Height="200px" Skin="Default" Width="100%" DropDownWidth="250px"
                                            CloseDropDownOnBlur="true" meta:resourcekey="ddlCompanies" EmptyMessage="Select Company..." NoWrap="False"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" AutoPostBack="true"
                                            OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblContact" runat="server" meta:Resourcekey="lblContact" Text="Contact"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlContacts" runat="server" Height="200px" Skin="Default" Width="100%" DropDownWidth="250px"
                                            CloseDropDownOnBlur="true" meta:resourcekey="ddlContacts" EmptyMessage="Select Contact..." NoWrap="False"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" AutoPostBack="true"
                                            OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLastName" runat="server" meta:Resourcekey="lblLastName" Text="Last Name"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtLastName" MaxLength="500" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblFirstName" runat="server" meta:Resourcekey="lblFirstName" Text="First Name"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtFirstName" MaxLength="500" runat="server"></asp:TextBox>
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
                                        <asp:Label ID="lblCountry" runat="server" meta:Resourcekey="lblCountry" Text="Country"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCountries" AutoPostBack="False" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true" runat="server"
                                            Skin="Default" NoWrap="true" Width="100%" Height="200px">
                                            <ItemTemplate>
                                                <div onclick="StopPropagation(event)" class="combo-item-template">
                                                    <asp:CheckBox runat="server" ID="chk" />
                                                    <asp:Label runat="server" ID="Label2" AssociatedControlID="chk"></asp:Label>
                                                    <%#DataBinder.Eval(Container, "Text")%>
                                                </div>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:HiddenField runat="server" ID="hddnCountryIds" />
                                        <asp:HiddenField runat="server" ID="hddnCountryNames" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRegion" runat="server" meta:Resourcekey="lblRegion" Text="Region(s)"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlRegions" AutoPostBack="False" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true" runat="server"
                                            Skin="Default" NoWrap="true" Width="100%" Height="200px">
                                            <ItemTemplate>
                                                <div onclick="StopPropagation(event)" class="combo-item-template">
                                                    <asp:CheckBox runat="server" ID="chk" />
                                                    <asp:Label runat="server" ID="Label2" AssociatedControlID="chk"></asp:Label>
                                                    <%#DataBinder.Eval(Container, "Text")%>
                                                </div>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:HiddenField runat="server" ID="hddnRegionIds" />
                                        <asp:HiddenField runat="server" ID="hddnRegionNames" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblTile" runat="server" meta:Resourcekey="lbltitle" Text="title"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtTitle" MaxLength="500" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblResourceGroup" runat="server" meta:Resourcekey="lblResourceGroup" Text="Resource Group(s)"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <%-- <telerik:RadComboBox ID="ddlResourceGroups" runat="server" Height="200px"  Skin="Default" Width="250px" DropDownWidth="250px"
                                                            CloseDropDownOnBlur="true" meta:resourcekey="ddlResourceGroups" EmptyMessage="Select Resource group..." NoWrap="False"
                                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnClientItemsRequesting="GetResourceGroupValueToReturn"
                                                            OnItemsRequested="ddl_ItemsRequested" OnClientDropDownClosing="OnClientDropDownClosing"  OnClientSelectedIndexChanging="OnClientSelectedIndexChanging">
                                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                                              <ItemTemplate>
                                                                <div onclick="StopPropagation(event)" class="combo-item-template">
                                                                <asp:CheckBox runat="server" ID="chkApplyRole" />
                                                                </div>
                                                            </ItemTemplate>
                                                        </telerik:RadComboBox>--%>
                                        <telerik:RadComboBox ID="ddlResourceGroups" AutoPostBack="False" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true" runat="server"
                                            Skin="Default" NoWrap="true" Width="100%" Height="200px">
                                            <ItemTemplate>
                                                <div onclick="StopPropagation(event)" class="combo-item-template">
                                                    <asp:CheckBox runat="server" ID="chk" />
                                                    <asp:Label runat="server" ID="Label2" AssociatedControlID="chk"></asp:Label>
                                                    <%#DataBinder.Eval(Container, "Text")%>
                                                </div>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:HiddenField runat="server" ID="hddnResourceGroupIds" />
                                        <asp:HiddenField runat="server" ID="hddnResourceGroupNames" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblManager" runat="server" meta:Resourcekey="lblManager" Text="Manager(s)"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <%-- <telerik:RadComboBox ID="ddlManagers" runat="server" Height="200px"  Skin="Default" Width="250px" DropDownWidth="250px"
                                                                CloseDropDownOnBlur="true" meta:resourcekey="ddlManagers" EmptyMessage="Select Manager..." NoWrap="False"
                                                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnClientItemsRequesting="GetManagerValueToReturn"
                                                                OnItemsRequested="ddl_ItemsRequested" OnClientDropDownClosing="OnClientDropDownClosing"  OnClientSelectedIndexChanging="OnClientSelectedIndexChanging">
                                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                                                 <ItemTemplate>
                                                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                                                    <asp:CheckBox runat="server" ID="chkApplyRole" />
                                                                    </div>
                                                                </ItemTemplate>
                                                            </telerik:RadComboBox>--%>
                                        <telerik:RadComboBox ID="ddlManagers" AutoPostBack="False" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true" runat="server"
                                            Skin="Default" NoWrap="true" Width="100%" Height="200px">
                                            <ItemTemplate>
                                                <div onclick="StopPropagation(event)" class="combo-item-template">
                                                    <asp:CheckBox runat="server" ID="chk" />
                                                    <asp:Label runat="server" ID="Label2" AssociatedControlID="chk"></asp:Label>
                                                    <%#DataBinder.Eval(Container, "Text")%>
                                                </div>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:HiddenField runat="server" ID="hddnManagerIds" />
                                        <asp:HiddenField runat="server" ID="hddnManagerNames" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblClassification" runat="server" meta:Resourcekey="lblClassification" Text="Classification(s)"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlClassifications" runat="server" Height="200px" Skin="Default" Width="100%"
                                            CloseDropDownOnBlur="true" OnClientLoad="loadText" NoWrap="False">
                                            <HeaderTemplate>
                                                <table style="width: 235px" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td style="width: 50px;">
                                                            <asp:Literal ID="Literal3" runat="server" Text='Allow'></asp:Literal>
                                                            <asp:CheckBox ID="chkAllowAll" runat="server" onclick="ResourcesAllowClassificationComboCheckAll(this,'ctl00_CPH1_ddlClassifications')" />
                                                        </td>
                                                        <td style="width: 135px;">
                                                            <asp:Literal ID="Literal4" runat="server" Text='Classification'></asp:Literal>
                                                        </td>
                                                        <td style="width: 50px;">
                                                            <asp:Literal ID="Literal1" runat="server" Text='Default'></asp:Literal>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table style="width: 235px" cellspacing="0" cellpadding="2">
                                                    <tr>
                                                        <td style="width: 50px;">
                                                            <asp:CheckBox ID="chkAllow" runat="server" onclick="ResourcesAllowClassificationComboCheckParent(this,'ctl00_CPH1_ddlClassifications')" />
                                                        </td>
                                                        <td style="width: 135px;">
                                                            <%#DataBinder.Eval(Container, "Attributes['Classification']")%>
                                                        </td>
                                                        <td style="width: 50px;">
                                                            <asp:CheckBox ID="chkDefault" runat="server" onclick="ResourcesClassificationComboDefaultClick(this,'ctl00_CPH1_ddlClassifications')" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:HiddenField ID="hddnClassificationsIds" runat="server" />
                                        <asp:HiddenField ID="hddnClassifications" runat="server" />
                                        <asp:HiddenField ID="hddnDefaultClassificationId" runat="server" />
                                        <asp:HiddenField ID="hddnClassificationText" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPayTypes" runat="server" meta:Resourcekey="lblPayTypes" Text="Pay Type(s)"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlPayTypes" runat="server" Height="200px" Skin="Default" Width="100%"
                                            CloseDropDownOnBlur="true" NoWrap="False" OnClientLoad="loadPayTypeText">
                                            <HeaderTemplate>
                                                <table style="width: 235px" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td style="width: 50px;">
                                                            <asp:Literal ID="Literal3" runat="server" Text='Allow'></asp:Literal>
                                                            <asp:CheckBox ID="chkAllowAll" runat="server" />
                                                        </td>
                                                        <td style="width: 135px;">
                                                            <asp:Literal ID="Literal4" runat="server" Text='Pay Type'></asp:Literal>
                                                        </td>
                                                        <td style="width: 50px;">
                                                            <asp:Literal ID="Literal1" runat="server" Text='Default'></asp:Literal>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table style="width: 235px" cellspacing="0" cellpadding="2">
                                                    <tr>
                                                        <td style="width: 50px;">
                                                            <asp:CheckBox ID="chkAllow" runat="server" />
                                                        </td>
                                                        <td style="width: 135px;">
                                                            <%#DataBinder.Eval(Container, "Attributes['PayType']")%>
                                                        </td>
                                                        <td style="width: 50px;">
                                                            <asp:CheckBox ID="chkDefault" runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:HiddenField ID="hddnPayTypesIds" runat="server" />
                                        <asp:HiddenField ID="hddnPayTypes" runat="server" />
                                        <asp:HiddenField ID="hddnDefaultPayTypeId" runat="server" />
                                        <asp:HiddenField ID="hddnPayTypesText" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDefaultCostCode" runat="server" meta:Resourcekey="lblDefaultCostCode" Text="Default Cost Code"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlDefaultCodeCodes" runat="server" Height="200px" Skin="Default" Width="100%"
                                            CloseDropDownOnBlur="true" meta:resourcekey="ddlDefaultCodeCodes" NoWrap="False"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblSkills" runat="server" meta:Resourcekey="lblSkills" Text="Skills"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <%--<telerik:RadComboBox ID="ddlSkills" runat="server" Height="200px"  Skin="Default" Width="250px" 
                                                                CloseDropDownOnBlur="true" meta:resourcekey="ddlSkills" EmptyMessage="Select Skills..." NoWrap="False"
                                                                EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnClientItemsRequesting="GetSkillsValueToReturn"
                                                                OnItemsRequested="ddl_ItemsRequested" OnClientDropDownClosing="OnClientDropDownClosing"  OnClientSelectedIndexChanging="OnClientSelectedIndexChanging">
                                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                                                 <ItemTemplate>
                                                                    <div onclick="StopPropagation(event)" class="combo-item-template">
                                                                    <asp:CheckBox runat="server" ID="chkApplyRole" />
                                                                    </div>
                                                                </ItemTemplate>
                                                            </telerik:RadComboBox>--%>
                                        <telerik:RadComboBox ID="ddlSkills" AutoPostBack="False" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true" runat="server"
                                            Skin="Default" NoWrap="true" Width="100%" Height="200px">
                                            <ItemTemplate>
                                                <div onclick="StopPropagation(event)" class="combo-item-template">
                                                    <asp:CheckBox runat="server" ID="chk" />
                                                    <asp:Label runat="server" ID="Label2" AssociatedControlID="chk"></asp:Label>
                                                    <%#DataBinder.Eval(Container, "Text")%>
                                                </div>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>

                                        <asp:HiddenField runat="server" ID="hddnSkillsIds" />
                                        <asp:HiddenField runat="server" ID="hddnSkillsNames" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblEmploymentStatus" runat="server" meta:Resourcekey="lblEmploymentStatus" Text="Employment Status"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlEmploymentStatuses" runat="server" Height="200px" Skin="Default" Width="100%"
                                            CloseDropDownOnBlur="true" NoWrap="False" AllowCustomText="true" Filter="Contains">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblVisibleToUserGroups" runat="server" meta:Resourcekey="lblVisibleToUserGroups" Text="Visible To User Groups"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <%--<telerik:RadComboBox ID="ddlUserGroups" runat="server" Height="200px"  Skin="Default" Width="250px" 
                                                                    CloseDropDownOnBlur="true" meta:resourcekey="ddlUserGroups" EmptyMessage="Select User Groups..." NoWrap="False"
                                                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnClientItemsRequesting="GetUsersGroupsValueToReturn"
                                                                    OnItemsRequested="ddl_ItemsRequested"  OnClientDropDownClosing="OnClientDropDownClosing"  OnClientSelectedIndexChanging="OnClientSelectedIndexChanging">
                                                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                                                     <ItemTemplate>
                                                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                                                        <asp:CheckBox runat="server" ID="chkApplyRole" />
                                                                        </div>
                                                                    </ItemTemplate>
                                                                </telerik:RadComboBox>--%>

                                        <telerik:RadComboBox ID="ddlUserGroups" AutoPostBack="False" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true" runat="server"
                                            Skin="Default" NoWrap="true" Width="100%" Height="200px">
                                            <ItemTemplate>
                                                <div onclick="StopPropagation(event)" class="combo-item-template">
                                                    <asp:CheckBox runat="server" ID="chk" />
                                                    <asp:Label runat="server" ID="Label2" AssociatedControlID="chk"></asp:Label>
                                                    <%#DataBinder.Eval(Container, "Text")%>
                                                </div>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:HiddenField runat="server" ID="hddnUsersGroupsIds" />
                                        <asp:HiddenField runat="server" ID="hddnUsersGroupsNames" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDefaultHoursPerDay" runat="server" meta:Resourcekey="lblDefaultHoursPerDay" Text="Default Hours Per Day"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadNumericTextBox ID="ntxtDefaultHoursPerDay" Type="Number" MinValue="0" MaxValue="24" runat="server"
                                            Style="text-align: right; width: 100% !important;" MaxLength="9" Width="100%">
                                            <%--<ClientEvents OnValueChanged="OperateHourRatechanged" />--%>
                                        </telerik:RadNumericTextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDefaultStartTime" runat="server" meta:Resourcekey="lblDefaultStartTime" Text="Default Start Time"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadTimePicker ID="dtpStartTimePicker" runat="server" Culture="English (United States)"
                                            EnableTyping="True" MaxDate="2100-01-01" MinDate="1901-01-01" SelectedDate="<%# Date.Today %>"
                                            Skin="Default" Width="100%">
                                            <DateInput ID="DateInput1" runat="server" LabelCssClass="radLabelCss_Office2007"
                                                Skin="Default">
                                            </DateInput>
                                            <Calendar ID="Calendar1" runat="server" Skin="Default">
                                            </Calendar>
                                        </telerik:RadTimePicker>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDefaultFinishTime" runat="server" meta:Resourcekey="lblDefaultFinishTime" Text="Default Finish Time"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadTimePicker ID="dtpFinishimePicker" runat="server" Culture="English (United States)"
                                            EnableTyping="True" MaxDate="2100-01-01" MinDate="1901-01-01" SelectedDate="<%# Date.Today %>"
                                            Skin="Default" Width="100%">
                                            <DateInput ID="DateInput2" runat="server" LabelCssClass="radLabelCss_Office2007"
                                                Skin="Default">
                                            </DateInput>
                                            <Calendar ID="Calendar2" runat="server" Skin="Default">
                                            </Calendar>
                                        </telerik:RadTimePicker>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliDefaultCost" meta:Resourcekey="hliDefaultCost" Text="Default Cost"></asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtDefaultCost" MaxLength="500" runat="server" Enabled="false" CssClass="Currency"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblTargetUtilizationPerCentage" runat="server" meta:Resourcekey="lblTargetUtilizationPerCentage" Text="Target Utilization %"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtTargetUtilization" MaxLength="500" runat="server" CssClass="PositivePercent"></asp:TextBox>
                                    </td>
                                </tr>
                                <%--<tr>
                                                        <td>
                                                            <asp:Label ID="lblOverbookingSetting" runat="server" meta:Resourcekey="lblOverbookingSetting"  Text="Overbooking Setting"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <telerik:RadComboBox ID="ddlOverbookingSettings" runat="server"  Skin="Default" Width="155px"
                                                                CloseDropDownOnBlur="true" meta:resourcekey="ddlOverbookingSettings" NoWrap="False"
                                                                AllowCustomText="true" Filter="Contains">
                                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>--%>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblHireDate" meta:Resourcekey="lblHireDate" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadDatePicker ID="dtpHireDate" runat="server" MinDate="1901-01-01" DateInput-EnabledStyle-HorizontalAlign="Right"
                                            MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default" Culture="English (United States)">
                                            <DateInput ID="DateInput3" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                            <Calendar ID="Calendar3" Skin="Default" runat="server"></Calendar>
                                        </telerik:RadDatePicker>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblTerminationDate" meta:Resourcekey="lblTerminationDate" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadDatePicker ID="dtpTerminatonDate" runat="server" MinDate="1901-01-01" DateInput-EnabledStyle-HorizontalAlign="Right"
                                            MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default" Culture="English (United States)">
                                            <DateInput ID="DateInput4" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                            <Calendar ID="Calendar4" Skin="Default" runat="server"></Calendar>
                                        </telerik:RadDatePicker>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPhone" meta:Resourcekey="lblPhone" runat="server"></asp:Label>
                                    </td>

                                    <td class="controlWidth">
                                        <table width="100%" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td width="50%" style="padding-right: 4px;">
                                                    <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
                                                </td>
                                                <td width="50%" style="padding-left: 4px;">
                                                    <asp:TextBox ID="txtExt" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCell" meta:Resourcekey="lblCell" runat="server"></asp:Label>
                                    </td>

                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtCell" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblAltPhone" meta:Resourcekey="lblAltPhone" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtAltPhone" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblEmail" meta:Resourcekey="lblEmail" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblAddress1" meta:Resourcekey="lblAddress1" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtAddress1" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblAddress2" meta:Resourcekey="lblAddress2" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtAddress2" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCity" meta:Resourcekey="lblCity" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtCity" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblState" meta:Resourcekey="lblState" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table width="100%" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td style="width: 50%; padding-right: 4px;">
                                                    <telerik:RadComboBox ID="ddlStates" runat="server" Height="400px" Filter="Contains" MarkFirstMatch="true"
                                                        meta:Resourcekey="ddlState" Skin="Default" AllowCustomText="true"
                                                        EmptyMessage="Select State..." Width="100%" AutoPostBack="False" CausesValidation="False">
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td width="50%" style="padding-left: 4px;">
                                                    <asp:TextBox ID="txtZip" runat="server" Width="100%"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="Label1" meta:Resourcekey="lblCountry" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCountry" runat="server" Height="400px" Filter="Contains" MarkFirstMatch="true"
                                            meta:Resourcekey="ddlCountry" Skin="Default" AllowCustomText="true"
                                            EmptyMessage="Select Country..." Width="100%" AutoPostBack="False"
                                            CausesValidation="False">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblEmergencyContact" meta:Resourcekey="lblEmergencyContact" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtEmergencyContact" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblEmergencyContactNbr" meta:Resourcekey="lblEmergencyContactNbr" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtEmergencyContactNbr" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblScheduling" runat="server" meta:Resourcekey="lblScheduling" Text="Scheduling"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:CheckBox ID="chkScheduling" runat="server" Checked="true" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblSub" runat="server" meta:Resourcekey="lblSub" Text="Sub"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:CheckBox ID="chkSub" runat="server" Checked="false" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <telerik:RadAsyncUpload runat="server" ClientIDMode="Static" ID="rauUserImage" Skin="Default" OnClientFileUploadFailed="onDocFileUploadFailed" Width="122px" Style="display: none"
                                            OnClientFileSelected="onDocFileSelected" OnClientFileUploaded="onDocFileUploaded" OnFileUploaded="onFileUploaded"
                                            MultipleFileSelection="Disabled" OnClientValidationFailed="ClientDocFileValidationFailed" HideFileInput="true">
                                            <Localization Select="<%$ Resources:PMWeb, btn_SelectImage %>" />
                                        </telerik:RadAsyncUpload>
                                        <asp:Button ID="btnRefreshUserImage" runat="server" CssClass="Hide" />
                                        <div style="float: left">
                                            <asp:Label ID="Image" meta:Resourcekey="Image" runat="server" Text="Image"></asp:Label>

                                        </div>
                                        <div style="float: right">
                                            <asp:LinkButton runat="server" ID="btnuserimage" CssClass="SearchButton" OnClientClick="return RadAsyncUploadclcik()">
    					                                                    <span class="Icon"></span>                                                              
                                            </asp:LinkButton>


                                        </div>
                                        <div style="width: 16px; height: 16px; margin-right: 13px; margin-top: 25px; float: right">
                                            <asp:Button ID="btnClearImage" runat="server" CssClass="btnclearimage" Style="background-color: transparent !important;" />
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <img id="imgLaborImage" runat="server" src="Images/Global/WhiteDot.gif" />
                                    </td>
                                </tr>
                            </table>
                            <%--  <telerik:RadAsyncUpload runat="server" ID="rauUserImage" Skin="Default" OnClientFileUploadFailed="onDocFileUploadFailed"
                                                        OnClientFileSelected="onDocFileSelected" OnClientFileUploaded="onDocFileUploaded" OnFileUploaded="onFileUploaded"
                                                        MultipleFileSelection="Disabled" OnClientValidationFailed="ClientDocFileValidationFailed" HideFileInput="true">
                                                        <Localization Select="<%$ Resources:PMWeb, btn_SelectImage %>" />
                                                    </telerik:RadAsyncUpload>
                                                    <asp:Button ID="btnRefreshUserImage" runat="server" CssClass="Hide" />
                                                    <asp:Button ID="btnClearImage" runat="server" Text="Clear Image" />
                                                    <img id="imgLaborImage" runat="server" src="Images/Global/WhiteDot.gif" />--%>
                        </div>
                        <div class="col-4 col-4-right">
                            <uc8:LaborResourcesRotator ID="PMrot" runat="server" />
                            <uc6:documentspecificationsheader id="DocumentSpecificationsHeader1" runat="server" />
                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>

        </telerik:RadPageView>

        <%--<telerik:RadPageView ID="pvDetails" runat="server">
                                    <uc1:ResourcesLaborDetails ID="ResourcesLaborDetails1" runat="server" />
                                </telerik:RadPageView>--%>

        <telerik:RadPageView ID="pvCalendar" runat="server">
            <uc5:ResourceCalendar ID="ResourceCalendar" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvSpec" runat="server">
            <uc7:DocumentSpecifications ID="Specification1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc2:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc3:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc4:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>

</asp:Content>
