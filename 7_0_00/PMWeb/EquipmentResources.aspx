<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="EquipmentResources.aspx.vb" Inherits="Website.EquipmentResources" %>

<%@ Register Src="EquipmentResourceDetails.ascx" TagName="EquipmentResourceDetails" TagPrefix="uc1" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc2" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="Uc3" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc4" %>
<%@ Register Src="ResourceCalendar.ascx" TagName="ResourceCalendar" TagPrefix="uc5" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc6" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc7" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc15" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">
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
            var forceradmenuToClose = false;
            var forceMoreMenuToClose = true;

            function RadAsyncUploadclick() {
                var imageuploader = $("[id$=rauUserImagefile0]");
                imageuploader.click();
                return false;
            }

            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
                if (args.get_item().get_value() == "Active") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("Activate");
                    button.click();
                }
                if (args.get_item().get_value() == "InActive") {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findItemByValue("Activate");
                    button.click();
                }
                maintoolbarClick(args.get_item().get_value())
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }


            function maintoolbarClick(Value) {
                var HasMergeTemplate = '<%= PM.EquipmentResourcesInfo.HasMergeTemplate%>';
                var HasReports = '<%= PM.EquipmentResourcesInfo.HasReports%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("EQUIPMENTRESOURCES")%>';
                var RecordDescription = '<%=JSEscape(PM.EquipmentResourcesInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.EquipmentResourcesInfo.Description)%>';
                var Id = '<%= PM.EquipmentResourcesInfo.Id%>';

                switch (Value) {

                    case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            OpenPOPUp("MergeTemplatePopup.aspx?ObjectType=EQUIPMENTRESOURCES&Id=" +
                                    '<%= PM.EquipmentResourcesInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=0" + "&EntityType=1", 1045, 515, false);
                        }
                        break;

                    case 'ViewReports':
                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=EQUIPMENTRESOURCES&Id=" +
                                    Id
                                    + "&RecordDescription=" + RecordDescription
                                    + "&EntityId=0" + "&EntityType=1", 1045, 515, false);
                        }
                        break;

                        case 'Print':

                        if (HasReports == 'True') {
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=EQUIPMENTRESOURCES&Id=" +
                                    Id
                                    + "&RecordDescription=" + RecordDescription
                                    + "&EntityId=0" + "&EntityType=1", 1045, 515, false);;
                        } else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                            args.set_cancel(true);
                        }
                        break;
                    case 'BIReporting':

                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        args.set_cancel(true);
                        break;

                    case 'ViewPMWebReports':
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=EQUIPMENTRESOURCES&Id=" +
                        '<%= PM.EquipmentResourcesInfo.Id%>'
                    + "&EntityId=0" + "&EntityType=1", 1045, 515, false);

                        }
                        break;

                    case 'New':
                        window.location = "EquipmentResources.aspx";
                        break;

                    case 'Notification':
                        if (Id == 0) break;
                        OpenPOPUp("Notification.aspx?ObjectType=EQUIPMENTRESOURCES&Id=" +
                     '<%= PM.EquipmentResourcesInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=0&EntityType=0", 1045, 515, false);
                         break;

                     default:
                         //                        eventArgs.set_cancel(false);
                         break;
                 }
             }

             function GetValueToReturn(combobox, eventArgs) {
                 var SelectedValue;
                 var hdn = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_hddnResourceGroupIds';
                 var hdnField = $("[id$=" + hdn + "]")[0];
                 var context = eventArgs.get_context();
                 context["Ids"] = hdnField.value;
             }

             function check(sender, ddl, resultId, ResultName) {
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

             function OpenEquipmentResourceBarCodePopup() {
                 return OpenBarCodePopup('txtBarcode', 'htnBarcodeFormat', 'EQUIPMENTRESOURCES', '<%= PM.EquipmentResourcesInfo.Id%>');
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


            function OpenGoogleEquipmentResourcesAddressesPicker() {
                var Id = '<%= PM.EquipmentResourcesInfo.Id%>';
                if (Id > 0) {
                    var left = (screen.width - 900) / 2;
                    var top = (screen.height - 600) / 2;
                    OpenPOPUp("GoogleAddressesPicker.aspx?RecordType=EQUIPMENTRESOURCES&ObjectId=" + Id + "&PickerSender=RecordAddress",
                            'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=900,height=600,top=' + top + ',left=' + left);
                }
                return false;
            }


            function MoreMenuOpening(sender, args) {
                if (!forceMoreMenuToClose) { args.set_cancel(true); return; }

            }
            function MoreMenuClosing(sender, args) {
                if (forceMoreMenuToClose) {
                    //forceradmenuToClose = false;
                    return;
                }
                args.set_cancel(true);
            }
            function loadText() {
                var combo = $find('ctl00_CPH1_ddlClassifications');
                combo.set_text($('#ctl00_CPH1_hddnEquClassificationText').val());
            }
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings> 
              <telerik:AjaxSetting AjaxControlID="mlpEquipmentResources">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpEquipmentResources" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpEquipmentResources" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="ddlEquipment">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpEquipmentResources" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="mlpClasue" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                    <telerik:AjaxUpdatedControl ControlID="ddlEquipmentType" />
                    <telerik:AjaxUpdatedControl ControlID="ddlOwnership" />
                    <telerik:AjaxUpdatedControl ControlID="ddlFunctionStatus" />
                    <telerik:AjaxUpdatedControl ControlID="ddlCondition" />
                    <telerik:AjaxUpdatedControl ControlID="rdpDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtDescription" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rauUserImage">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="imgUserImage" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <table class="ToolBar LargeToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr>
            <td class="ToolbarTd">
                <asp:HyperLink runat="server" ID="btnSearchDocument" CssClass="lnkPage" NavigateUrl="SearchDocument.aspx?O=284">
                                <div class="btnToolbarSearchDocument">
                                                   &nbsp; 
                                                </div>
                </asp:HyperLink>
            </td>
            <td class="ToolbarTd HideOnMobileToolbar showOnIpad Recent">
                <asp:LinkButton runat="server" ID="btnRecent">
                                <div class="btnToolbarRecent">
                                                   &nbsp; 
                                                </div>
                </asp:LinkButton>
            </td>

            <td style="width: 240px" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                <telerik:RadComboBox ID="ddlEquipmentResources" runat="server" AllowCustomText="true" Skin="Default"
                    Height="400px" OnClientTextChange="LOD_DropDownTextChange" EmptyMessage="Select a Resource..." OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging"
                    Width="240px" NoWrap="true" CausesValidation="False" meta:Resourcekey="ddlEquipmentResources" OnItemsRequested="ddl_ItemsRequested"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True" AutoPostBack="false" DropDownCssClass="ToolbarDropdown">
                    <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                    <Items>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                            CausesValidation="true" CommandName="Save" AccessKey="s" ValidationGroup="Save"
                            ToolTip="Save (Alt+s)">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="120px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="New">
                                </telerik:RadToolBarButton>

                                <telerik:RadToolBarButton Width="150px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="Copy"  ValidationGroup="Save">
                                </telerik:RadToolBarButton>

                            </Buttons>
                        </telerik:RadToolBarSplitButton>

                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                            CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete" CausesValidation="false">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                        </telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read" CssClass="ToolbarPrint" OuterCssClass="HideOnMobileToolbar"
                            EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                </telerik:RadToolBarButton>

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
                                <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                    <Items>
                                        <telerik:RadMenuItem CssClass="menuMore">
                                            <Items>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Print" Value="Print" CssClass="Print">
                                                    <Items>
                                                        <telerik:RadMenuItem Text="Go To Bi Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Word" Value="ViewTemplates"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Active" Value="Active" CssClass="ActiveLocation" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="InActive" Value="InActive" CssClass="InactiveLocation" EnableImageSprite="true"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('EQUIPMENTRESOURCES');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" CssClass="Help" onclick="helpClick();"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>
                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Active.png" CausesValidation="false" Value="Activate" CommandName="Activation" ToolTip="Activate"></telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td style="width: 100%"></td>
        </tr>
    </table>
    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="1" OnClientTabSelecting="onTabSelecting"
        runat="server" MultiPageID="mlpEquipmentResources" Skin="Default" ScrollChildren="true" ScrollButtonsPosition="Left"
        Width="100%" EnableViewState="true" CausesValidation="false" CssClass="documentTabs">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="true"></telerik:RadTab>
            <telerik:RadTab Text="Details" Value="Details" Visible="false" />
            <telerik:RadTab Text="Calendar" Value="Calendar"></telerik:RadTab>
            <telerik:RadTab Text="Specifications" Value="Spec" />
            <telerik:RadTab Text="Notes" Value="Notes"></telerik:RadTab>
            <telerik:RadTab Text="Attachments" Value="Attachments"></telerik:RadTab>
            <telerik:RadTab Text="Notification" Value="NotificationLog"></telerik:RadTab>
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpEquipmentResources" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="true" CssClass="documentMultiPages">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True" Width="100%">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" EnableAJAX="false">
                <div class="PMMainPage">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblId" runat="server" Text="ID*" meta:Resourcekey="lblId"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtCode" runat="server" MaxLength="30"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCode" runat="server" ValidationGroup="Save" ControlToValidate="txtCode"
                                            CssClass="Validator" Display="Dynamic" meta:Resourcekey="rfv_Code"
                                            ForeColor=""></asp:RequiredFieldValidator>
                                        <asp:Label ID="lblEquResourceIDUnique" runat="server" Text="ID is unique." meta:Resourcekey="lblEquResourceIDUnique"
                                            Visible="False" Class="Validator"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:HyperLink runat="server" CssClass="Link" ID="hliEquipment" meta:Resourcekey="hliEquipment" Text="Equipment11"></asp:HyperLink>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlEquipment" runat="server" ItemRequestTimeout="1000" EmptyMessage="Select Equipment..."
                                            Skin="Default" Width="100%" AutoPostBack="true" NoWrap="True" AllowCustomText="True"
                                            CausesValidation="False" Height="330px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                            ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                            EnableVirtualScrolling="True" OnItemsRequested="ItemsLoadRequested" meta:Resourcekey="ddlEquipment">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDescription" runat="server" Text="Description" meta:Resourcekey="lblDescription"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtDescription" Text=""></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ValidationGroup="Save" ControlToValidate="txtDescription"
                                            CssClass="Validator" Display="Dynamic" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>"
                                            ForeColor=""></asp:RequiredFieldValidator>
                                        <asp:Label ID="lblUniqueDescription" runat="server" Text="Code must be unique" meta:Resourcekey="lblUniqueDescription" Visible="false" CssClass="Validator"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLaborResource" runat="server" Text="Labor Resource" meta:Resourcekey="lblLaborResource"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlLaborResource" Height="250px" Filter="Contains" AllowCustomText="true" Skin="Default" runat="server"
                                            Width="100%" EmptyMessage="Select Labor Resource..." meta:Resourcekey="ddlLaborResource">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblEquipmentType" runat="server" Text="Equipment Type" meta:Resourcekey="lblEquipmentType"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlEquipmentType" AllowCustomText="true" Filter="Contains" runat="server" EmptyMessage="Select Equipment Type..."
                                            Skin="Default" Width="100%" meta:Resourcekey="ddlEquipmentType">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblOwnership" runat="server" Text="Ownership1" meta:Resourcekey="lblOwnershipLabel"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlOwnership" AllowCustomText="true" Filter="Contains" runat="server" EmptyMessage="Select Ownership..."
                                            Skin="Default" Width="100%" meta:Resourcekey="ddlOwnership">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblFunctionStatus" runat="server" Text="Function Status" meta:Resourcekey="lblFunctionStatus"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlFunctionStatus" AllowCustomText="true" Filter="Contains" runat="server" EmptyMessage="Select Function Status..."
                                            Skin="Default" Width="100%" meta:Resourcekey="ddlFunctionStatus">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCondition" runat="server" Text="Condition" meta:Resourcekey="lblCondition"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCondition" AllowCustomText="true" Filter="Contains" runat="server" EmptyMessage="Select Condition..."
                                            Skin="Default" Width="100%" meta:Resourcekey="ddlCondition">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDate" runat="server" Text="Date" meta:Resourcekey="lblConditionDate"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                         <span runat="server" id="rmd_rdpDate" style="display: block">
                                        <telerik:RadDatePicker ID="rdpDate" runat="server" MinDate="1901-01-01" DateInput-EnabledStyle-HorizontalAlign="Right"
                                            MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default">
                                            <DateInput ID="DateInput3" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                            <Calendar ID="Calendar3" Skin="Default" runat="server"></Calendar>
                                        </telerik:RadDatePicker>
                                             </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblManager" runat="server" Text="Manager" meta:Resourcekey="lblManager"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlManager" runat="server" AllowCustomText="true" MarkFirstMatch="True"
                                            Skin="Default" Width="100%" CloseDropDownOnBlur="true" Height="300"
                                            EnableItemCaching="false" EmptyMessage="Select Manager..."
                                            NoWrap="True" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested" meta:Resourcekey="ddlManager">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblResourceGroup" runat="server" Text="Resource Group" meta:Resourcekey="lblResourceGroups"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <%--<telerik:RadComboBox ID="ddlResourceGroups" runat="server" Height="200px"  Skin="Default" Width="250px" DropDownWidth="250px"
                                                                    CloseDropDownOnBlur="true" meta:resourcekey="ddlResourceGroups" EmptyMessage="Select Resource group..." NoWrap="False"
                                                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnClientItemsRequesting="GetValueToReturn"
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
                                        <asp:Label ID="lblClassifications" runat="server" Text="Classifications" meta:Resourcekey="lblClassification"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlClassifications" runat="server" Height="200px" Skin="Default" Width="100%"
                                            CloseDropDownOnBlur="true" meta:resourcekey="ddlClassifications" EmptyMessage="Select Classification..." NoWrap="False" OnClientLoad="loadText">
                                            <HeaderTemplate>
                                                <table style="width: 100%" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td style="width: 20%;">
                                                            <asp:Literal ID="Literal3" runat="server" Text='Allow'></asp:Literal>
                                                            <asp:CheckBox ID="chkAllowAll" runat="server" onclick="EquipmentResourcesAllowClassificationComboCheckAll(this,'ctl00_CPH1_ddlClassifications', '')" />
                                                        </td>
                                                        <td style="width: 60%;">
                                                            <asp:Literal ID="Literal4" runat="server" Text='Classification'></asp:Literal>
                                                        </td>
                                                        <td style="width: 20%; padding-right: 24px;">
                                                            <asp:Literal ID="Literal1" runat="server" Text='Default'></asp:Literal>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table style="width: 100%" cellspacing="0" cellpadding="2">
                                                    <tr>
                                                        <td style="width: 20%;">
                                                            <asp:CheckBox ID="chkAllow" runat="server" onclick="EquipmentResourcesAllowClassificationComboCheckParent(this,'ctl00_CPH1_ddlClassifications')" />
                                                        </td>
                                                        <td style="width: 60%;">
                                                            <%#DataBinder.Eval(Container, "Attributes['Classification']")%>
                                                        </td>
                                                        <td style="width: 20%; padding-right: 24px;">
                                                            <asp:CheckBox ID="chkDefault" runat="server" onclick="EquipmentResourcesClassificationComboDefaultClick(this,'ctl00_CPH1_ddlClassifications')" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                        <asp:HiddenField ID="hddnEquClassificationsIds" runat="server" />
                                        <asp:HiddenField ID="hddnEquClassifications" runat="server" />
                                        <asp:HiddenField ID="hddnEquDefaultClassificationsId" runat="server" /> 
                                        <asp:HiddenField ID="hddnEquClassificationText" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCSIDivisions" runat="server" Text="CSI Divisions" meta:Resourcekey="lblCSIDivision"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCSIDivisions" runat="server" Width="100%" Filter="Contains"
                                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true" EmptyMessage="Select CSI Division..."
                                            NoWrap="True" AllowCustomText="true" OnItemsRequested="ddl_ItemsRequested" Height="250px"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" meta:resourcekey="ddlCSIDivisions" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCostCodes" runat="server" Text="Cost Codes" meta:Resourcekey="lblCostCode"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlCostCode" runat="server" Height="200px" Skin="Default" Width="100%"
                                            CloseDropDownOnBlur="true" meta:resourcekey="ddlCostCode" EmptyMessage="Select Cost..." NoWrap="False"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblCountry" runat="server" Text="Country" meta:Resourcekey="lblCountries"></asp:Label>
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
                                        <asp:Label ID="lblRegion" runat="server" Text="Region" meta:Resourcekey="lblRegions"></asp:Label>
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
                                <tr style="display: none">
                                    <td class="labelWidth">
                                        <asp:Label ID="lblVisibleToUserGroups" runat="server" Text="Visible to User Groups" Visible="false" meta:Resourcekey="lblVisibleToUserGroups"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <%--<telerik:RadComboBox ID="ddlVisibleToUserGroups" runat="server" Height="200px"  Skin="Default" Width="250px" DropDownWidth="250px"
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
                                        <telerik:RadComboBox ID="ddlVisibleToUserGroups" AutoPostBack="False" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true" runat="server"
                                            Skin="Default" NoWrap="true" Width="100%" Height="200px" Visible="false">
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
                                        <asp:Label ID="lblTile" runat="server" meta:Resourcekey="lbltitle" Text="title"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtTitle" MaxLength="500" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblOperating" runat="server" Text="Operating1" meta:Resourcekey="lblOperatingLabel"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtOperating" Text="" CssClass="Double"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStandby" runat="server" Text="Standby" meta:Resourcekey="lblStandby"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtStandby" Text="" CssClass="Double"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblIdle" runat="server" Text="Idle" meta:Resourcekey="lblIdle"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox runat="server" ID="txtIdle" Text="" CssClass="Double"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDefaultCostMode" runat="server" Text="Default Cost Mode" meta:Resourcekey="lblDefaultCostMode"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlDefaultCostMode" AllowCustomText="true" Filter="Contains" runat="server" Skin="Default" EmptyMessage="Select Cost Mode..."
                                            Width="100%" meta:resourcekey="ddlDefaultCostMode">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDefaultStartTime" runat="server" Text="Default Start Time" meta:Resourcekey="lblDefaultStartTime"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadTimePicker ID="dtpStartTime" runat="server" Culture="English (United States)"
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
                                        <asp:Label ID="lblDefaultFinishTime" runat="server" Text="Default Finish Time" meta:Resourcekey="lblDefaultFinishTime"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadTimePicker ID="dtpFinishTime" runat="server" Culture="English (United States)"
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
                                        <asp:Label ID="lblTargetUtilizationPercent" runat="server" Text="Target Utilization %" meta:Resourcekey="lblTargetUtilizationPercent"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtTargetUtilizationPercent" runat="server" CssClass="Percent" MaxNumber="100" MinNumber="0"></asp:TextBox>
                                    </td>
                                </tr>
                                <%--  <tr>
                                                                <td>
                                                                    <asp:Label ID="lblOverbookingSetting" runat="server" Text="Overbooking Setting" meta:Resourcekey="lblOverbookingSetting"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <telerik:RadComboBox ID="ddlOverbookingSetting" AllowCustomText="true" Filter="Contains" runat="server" Skin="Default" EmptyMessage="Select Overbooking Setting..."
                                                                        Style="font-size: 11px" Width="255px" meta:resourcekey="ddlOverbookingSetting"></telerik:RadComboBox>
                                                                </td>
                                                            </tr>--%>

                                <!--EquipmentResourcesDetails-->
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblInServiceDate" runat="server" Text="In Service Date" meta:Resourcekey="lblInServiceDate"></asp:Label>
                                    </td>
                                    <td class="controlwidth">
                                        <span runat="server" id="rmd_rdpInServiceDate" style="display: block">
                                        <telerik:RadDatePicker ID="rdpInServiceDate" runat="server" MinDate="1901-01-01" DateInput-EnabledStyle-HorizontalAlign="Right"
                                            MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default">
                                            <DateInput ID="DateInput4" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                            <Calendar ID="Calendar4" Skin="Default" runat="server"></Calendar>
                                        </telerik:RadDatePicker>
                                            </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblReceivedDate" runat="server" Text="Received Date" meta:Resourcekey="lblReceivedDate"></asp:Label>
                                    </td>
                                    <td class="controlwidth">
                                        <span runat="server" id="rmd_rdpReceivedDate" style="display: block">
                                        <telerik:RadDatePicker ID="rdpReceivedDate" runat="server" MinDate="1901-01-01" DateInput-EnabledStyle-HorizontalAlign="Right"
                                            MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default">
                                            <DateInput ID="DateInput5" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                            <Calendar ID="Calendar5" Skin="Default" runat="server"></Calendar>
                                        </telerik:RadDatePicker>
                                            </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblVendor" runat="server" Text="Vendor" meta:Resourcekey="lblVendor"></asp:Label>
                                    </td>
                                    <td class="controlwidth">
                                        <telerik:RadComboBox ID="ddlVendor" runat="server" Width="100%" Skin="Default" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                            OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged1" Height="300px" EmptyMessage="Select Vendor..."
                                            OnClientDropDownClosed="dllcompClientClosed1" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested" meta:Resourcekey="ddlVendor">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                        <asp:HiddenField ID="HiddenField2" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblManufacturer" runat="server" Text="Manufacturer" meta:Resourcekey="lblManufacturer"></asp:Label>
                                    </td>
                                    <td class="controlwidth">
                                        <telerik:RadComboBox ID="ddlManufacturer" runat="server" Width="100%" Skin="Default" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                            OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged" Height="300px" meta:Resourcekey="ddlManufacturer"
                                            OnClientDropDownClosed="dllcompClientClosed" EmptyMessage="Select Manufacturer..."
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                        <asp:HiddenField ID="HiddenField1" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblMfrNumber" runat="server" Text="Mfr. #" meta:Resourcekey="lblMfrNumber"></asp:Label>
                                    </td>
                                    <td class="controlwidth">
                                        <asp:TextBox ID="txtMfrNumber" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblSerialNumber" runat="server" Text="Serial #" meta:Resourcekey="lblSerialNumber"></asp:Label>
                                    </td>
                                    <td class="controlwidth">
                                        <asp:TextBox ID="txtSerialNumber" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLotNumber" runat="server" Text="Lot #" meta:Resourcekey="lblLotNumber"></asp:Label>
                                    </td>
                                    <td class="controlwidth">
                                        <asp:TextBox ID="txtLotNumber" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblItem" runat="server" Text="Item" meta:Resourcekey="lblItem"></asp:Label>
                                    </td>
                                    <td class="controlwidth">
                                        <telerik:RadComboBox ID="ddlItem" runat="server" Width="100%"
                                            Skin="Default" LoadingMessage="<%$ Resources:PMWeb, Loading %>" Height="300px"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested" EmptyMessage="Select Item..." meta:Resourcekey="ddlItem">
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblPrice" runat="server" Text="Price" meta:Resourcekey="lblPrice"></asp:Label>
                                    </td>
                                    <td class="controlwidth">
                                        <asp:TextBox ID="txtPrice" CssClass="Currency" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblWarrantyExpires" runat="server" Text="Warranty Expires" meta:Resourcekey="lblWarrantyExpires"></asp:Label>
                                    </td>
                                    <td class="controlwidth">
                                         <span runat="server" id="rmd_rdpWarrantyExpires" style="display: block">
                                        <telerik:RadDatePicker ID="rdpWarrantyExpires" runat="server" MinDate="1901-01-01" DateInput-EnabledStyle-HorizontalAlign="Right"
                                            MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default">
                                            <DateInput ID="DateInput6" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                            <Calendar ID="Calendar6" Skin="Default" runat="server"></Calendar>
                                        </telerik:RadDatePicker>
                                             </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left;">
                                            <asp:Label runat="server" ID="lblGoogleAddress" meta:resourcekey="lblGoogleAddress" Text="Google Address11"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <asp:LinkButton CssClass="SearchButton" runat="server" ID="btnGoogleAddress" OnClientClick="return OpenGoogleEquipmentResourcesAddressesPicker();">
                                                                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtGoogleAddress" MaxLength="255" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left">
                                            <asp:Label ID="lblBarcode" runat="server" meta:resourcekey="lblBarcodes" Text="Barcode"></asp:Label>
                                        </div>
                                        <div style="float: right;">
                                            <telerik:RadCodeBlock runat="server">
                                                <asp:LinkButton CssClass="SearchButton" runat="server" ID="lbtPMbarcode">
                                                                            <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </telerik:RadCodeBlock>
                                        </div>
                                    </td>
                                    <td class="controlwidth">
                                        <div class="NoWrap">
                                            <asp:TextBox ID="txtBarcode" runat="Server" Style="vertical-align: middle;" MaxLength="255"></asp:TextBox>
                                            <asp:HiddenField ID="htnBarcodeFormat" runat="server" />
                                            <asp:Label runat="server" ID="lblBarCodeUnique" CssClass="Validator" Text="<%$ Resources:PMWeb, BarCodeUniqueMsg %>"></asp:Label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <telerik:RadAsyncUpload runat="server" ID="rauUserImage" Skin="Default" OnClientFileUploadFailed="onDocFileUploadFailed" Style="display: none;"
                                            OnClientFileSelected="onDocFileSelected" OnClientFileUploaded="onDocFileUploaded" OnFileUploaded="onFileUploaded"
                                            MultipleFileSelection="Disabled" OnClientValidationFailed="ClientDocFileValidationFailed" HideFileInput="true" Width="60%">
                                            <Localization Select="<%$ Resources:PMWeb, btn_SelectImage %>" />
                                        </telerik:RadAsyncUpload>
                                        <asp:Button ID="btnRefreshUserImage" runat="server" CssClass="Hide" />
                                        <div style="float: left">
                                            <asp:Label ID="lblImage" meta:Resourcekey="lblImage" runat="server" Text="image"></asp:Label>

                                        </div>
                                        <div style="float: right">
                                            <asp:LinkButton runat="server" ID="btnuserimage" CssClass="SearchButton" OnClientClick="return RadAsyncUploadclick()">
    					                                                    <span class="Icon"></span>                                                              
                                            </asp:LinkButton>
                                        </div>

                                        <div style="width: 16px; height: 16px; margin-right: 13px; margin-top: 25px; float: right">
                                            <asp:Button ID="btnClearImage" runat="server" CssClass="btnclearimage" Style="background-color: transparent !important" />
                                        </div>

                                    </td>
                                    <td class="controlWidth">
                                        <img id="imgUserImage" runat="server" src="Images/Global/WhiteDot.gif"/>

                                    </td>
                                </tr>
                                <tr>
                                </tr>
                                <!------------------------------------>
                            </table>
                        </div>
                        <div class="col-4  col-4-right">
                            <uc15:AssetRotator ID="PMrot" runat="server" />
                            <uc6:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />

                        </div>
                    </div>
                </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" Width="100%">
            <uc1:EquipmentResourceDetails ID="EquipmentResourceDetails1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvCalendar" runat="server">
            <uc5:ResourceCalendar ID="ResourceCalendar" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="RadPageView1" runat="server">
            <uc7:DocumentSpecifications ID="Specification1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc2:DocumentNotes ID="DocumentNotes1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvAttachments" runat="server">
            <Uc3:DocumentAttachments ID="DocumentAttachments1" runat="server" />
        </telerik:RadPageView>

        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc4:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>
</asp:Content>
