<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/AssetMaster.Master"
    CodeBehind="Properties.aspx.vb" Inherits="Website.Properties" %>

<%@ Register Src="PropertyDetails.ascx" TagName="PropertyDetails" TagPrefix="uc1" %>
<%@ Register Src="PropertyBuildings.ascx" TagName="PropertyBuildings" TagPrefix="uc2" %>
<%@ Register Src="PropertyFloors.ascx" TagName="PropertyFloors" TagPrefix="uc3" %>
<%@ Register Src="PropertySpaces.ascx" TagName="PropertySpaces" TagPrefix="uc4" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc5" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc6" %>
<%@ Register Src="~/WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc7" %>
<%@ Register Src="AssetTypeEquipments.ascx" TagName="AssetTypeEquipments" TagPrefix="uc8" %>
<%@ Register Src="AssetTypeWorkOrder.ascx" TagName="AssetTypeWorkOrder" TagPrefix="uc9" %>
<%@ Register Src="PropertyProjects.ascx" TagName="PropertyProjects" TagPrefix="uc10" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc11" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc12" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc13" %>
<%@ Register Src="AssetComponents.ascx" TagName="AssetComponents" TagPrefix="uc14" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc15" %>
<%--<%@ Register Src="DocumentInspections.ascx" TagName="DocumentInspection" TagPrefix="uc16" %>--%>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ACPH1" runat="server">

    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script src="JS/Asset/Components.js" type="text/javascript"></script>
        <script type="text/javascript">
            var forceMoreMenuToClose = true;
            function OpenComponentItemPopup() {
                return OpenPOPUp('EstimateItemsSelect.aspx?SourceId=Components&IsComponent=1', 910, 580, true);
            }
            function OpenGooglepPropertyAddressesPicker() {
                var Id = '<%= PM.Asset.PropertyInfo.Id%>';
                if (Id > 0) {
                    var browserWidth = $telerik.$(window).width();
                    var browserHeight = $telerik.$(window).height();
                    var wnd = window.radopen("GoogleAddressesPicker.aspx?RecordType=PROPERTY&ObjectId=" + Id + "&PickerSender=RecordAddress");
                }
                if (isMobileScreen()) {
                    wnd.setSize(browserWidth - 10, browserHeight - 10);
                    wnd.moveTo(8, 0);
                }
                else {
                    wnd.setSize(browserWidth * 0.9, browserHeight * 0.9);
                    wnd.Center();
                }
                return false;
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }
            function RadFileUploadclcik() {
                var imageuploader = document.getElementById("FileToUploadfile0");

                imageuploader.click();
                return false;
            }

            function maintoolbarClick(Value) {
                var HasReports = '<%= PM.Asset.PropertyInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.Asset.PropertyInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.Asset.PropertyInfo.Name)%>';
                var Id = '<%= PM.Asset.PropertyInfo.Id%>';
                
                switch (Value) {

                    case 'Notification':
                        if (Id == 0) break;
                        var browserWidth = $telerik.$(window).width();
                        var browserHeight = $telerik.$(window).height();
                        var left = window.screenLeft + ((browserWidth - (browserWidth * 0.9)) / 2);
                        var top = window.screenTop + ((browserHeight - (browserHeight * 0.9)) / 2);
                        OpenPOPUp("Notification.aspx?ObjectType=PROPERTY&Id=" +
                        '<%= PM.Asset.PropertyInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=0&EntityType=0", 1045, 515, false);
                        break;

                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=PROPERTY&Id=" +
                            '<%= PM.Asset.PropertyInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=0&EntityType=0", 1045, 515, false);
                        }
                        break;
                    case 'BIReporting':
                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        break;
                    case 'Print':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=PROPERTY&Id=" +
                            '<%= PM.Asset.PropertyInfo.Id%>'
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=0&EntityType=0", 1045, 515, false);
                        }
                        else {
                            window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        }
                        break;

                    default:
                        //                        eventArgs.set_cancel(false);
                        break;
                }
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
                if (args.get_item().get_value() != null && args.get_item().get_value().indexOf("Generate_") == 0) {
                    var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                    var button = mainToolBar.findButtonByCommandName(args.get_item().get_value());
                    button.click();
                }

                maintoolbarClick(args.get_item().get_value())
            }


            function MoreMenuOpening(sender, args) {
                if (!forceMoreMenuToClose) { args.set_cancel(true); return; }
                if (args.get_item().get_value() == 'Assign') {
                    var lblAssigned = $('.lblAssigned');
                    if (lblAssigned.html() == null || lblAssigned.html() == undefined)
                        forceMoreMenuToClose = false;
                }

            }
            function MoreMenuClosing(sender, args) {
                if (forceMoreMenuToClose) {
                    //forceradmenuToClose = false;
                    return;
                }
                args.set_cancel(true);
            }


            function VisualCalculator(Gross, Rentable, Usable) {
                $("input[id$=txtActualRentable]").val(FPrec(Rentable));
                $("input[id$=txtActualGrossArea]").val(FPrec(Gross));
                $("input[id$=txtActualUsable]").val(FPrec(Usable));
            }

            function PropertyBuildingsRowClick(sender, eventArgs) {
                window.location = "Buildings.aspx?Id=" + eventArgs.getDataKeyValue("Id");
            }

            function PropertyFloorsRowClick(sender, eventArgs) {
                window.location = "Floors.aspx?Id=" + eventArgs.getDataKeyValue("Id");
            }

            function PropertySpacesRowClick(sender, eventArgs) {
                window.location = "Spaces.aspx?Id=" + eventArgs.getDataKeyValue("Id");
            }

            function AssetEquipmentRowClick(sender, eventArgs) {
                window.location = "Equipments.aspx?Id=" + eventArgs.getDataKeyValue("Id");
            }

            function AssetWorkOrderRowClick(sender, eventArgs) {
                window.location = "WorkOrders.aspx?Id=" + eventArgs.getDataKeyValue("Id");
            }
            function AssetPropertyProjectsRowClick(sender, eventArgs) {
                window.location = "Projects.aspx?Id=" + eventArgs.getDataKeyValue("Id");
            }
            function rdvOwnerNodeClicking(sender, args) {
                var comboBox = $find($("[id$=ddlOwnerContacts]")[0].id);
                var node = args.get_node();

                var strText = "";
                var strValue = "";
                strValue = node.get_value();
                if (strValue.indexOf("P") < 0) {
                    comboBox.set_text("");
                    comboBox.trackChanges();
                    comboBox.get_items().getItem(0).set_value(0);
                    comboBox.commitChanges();
                    comboBox.hideDropDown();
                    return;
                }
                while (node != null && node._element.id.toString().indexOf(comboBox._element.id) == -1) {
                    strText = "/" + node.get_text() + strText;
                    node = node.get_parent();
                }
                strText = strText.substr(1, strText.toString().length - 1);

                comboBox.set_text(strText);
                comboBox.trackChanges();
                comboBox.get_items().getItem(0).set_value(strValue);
                comboBox.commitChanges();
                comboBox.hideDropDown();
            }

            function Upload() {

                var upload = document.querySelector('.Upload');
                upload.click();
                return false;
            }
            function LoadImage(FileUpload) {

                if (FileUpload.files) {
                    var btnlogo = document.querySelector(".UploadImage");
                    btnlogo.style.visibility = 'visible';
                    var btnclearimage = document.querySelector(".btnclearimage");
                    btnclearimage.style.visibility = 'visible';
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        var result = e.target.result;
                        document.querySelector('.UploadImage').src = result;
                    }
                    reader.readAsDataURL(FileUpload.files[0]);

                }


                return false;
            }

            //function onDocFileSelected(sender, args) {
            //}
            //function onDocFileUploadFailed(sender, args) {
            //}
            //function onDocFileUploaded(sender, args) { }
            //function ClientDocFileValidationFailed(sender, args) { }




            //var uploadsDocFileInProgress = 0;

            //function onDocFileSelected(sender, args) {
            //    uploadsDocFileInProgress++;
            //}
            //function onDocFileUploaded(sender, args) {

            //    decrementUploadsDocFileInProgress();
            //    if (uploadsDocFileInProgress <= 0) {
            //        var btnRefreshUserImage = $("[id$=btnRefreshUserImage]");
            //        btnRefreshUserImage.click();
            //        setTimeout(function () {
            //            sender.deleteAllFileInputs();
            //        }, 10);
            //    }
            //}


            //function onDocFileUploadFailed(sender, args) {
            //    decrementUploadsDocFileInProgress();
            //}

            //function decrementUploadsDocFileInProgress() {
            //    uploadsDocFileInProgress--;
            //}

            //function ClientDocFileValidationFailed(sender, args) {
            //    decrementUploadsDocFileInProgress();
            //    alert(WarningMsg_InvalidFile);
            //}



        </script>

    </telerik:RadCodeBlock>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings> 
            <telerik:AjaxSetting AjaxControlID="mlpProperties">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpProperties" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpProperties" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting> 
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadCodeBlock runat="server" ID="TERS">
        <table style="width:100%" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table class="ToolBar LargeToolBar" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td class="ToolbarTd">
                    <asp:HyperLink runat="server" ID="btnSearchDocument" CssClass="lnkPage" NavigateUrl="SearchDocument.aspx?O=9">
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
                    <telerik:RadComboBox ID="ddlProperties" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                        CloseDropDownOnBlur="true" LoadingMessage="<%$Resources:PMWeb, Loading %>"
                        Width="240px" AutoPostBack="False" NoWrap="true" Height="400px" CausesValidation="False"
                        meta:resourcekey="ddlProperties" ShowMoreResultsBox="True" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging"
                        EnableLoadOnDemand="true" EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" DropDownCssClass="ToolbarDropdown">
                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                    </telerik:RadComboBox>
                </td>
                <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" AutoPostBack="True">
                        <Items>
                            <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                            <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                                CommandName="Save" ValidationGroup="Save" CausesValidation="true" AccessKey="s">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"
                                CommandName="New" AccessKey="n" CausesValidation="false">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png"
                                CommandName="Delete" AccessKey="d" Value="Delete">
                            </telerik:RadToolBarButton>

                            <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>

                            <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                            </telerik:RadToolBarButton>

                            <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read"
                                EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint">
                                <Buttons>
                                     <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting"></telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports"></telerik:RadToolBarButton>
                                </Buttons>
                            </telerik:RadToolBarSplitButton>

                            <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                                <ItemTemplate>
                                    <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked" OnClientItemClosing="MoreMenuClosing" OnClientItemOpening="MoreMenuOpening">
                                        <Items>
                                            <telerik:RadMenuItem CssClass="menuMore">
                                                <Items>
                                                    <telerik:RadMenuItem Text="Print" Value="Print" CssClass="Print" EnableImageSprite="true">
                                                        <Items>
                                                        <telerik:RadMenuItem Text="Go to BI Reporting Center" Value="BIReporting"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="Show Linked BI Reports" Value="ViewReports"></telerik:RadMenuItem>
                                                        </Items>
                                                    </telerik:RadMenuItem>
                                                    <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('Locations');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>

                                                    <telerik:RadMenuItem Text="Generate" Value="Generate" CssClass="Generate" EnableImageSprite="true"></telerik:RadMenuItem>

                                                    <telerik:RadMenuItem Text="Active" Value="Active" CssClass="ActiveLocation" EnableImageSprite="true"></telerik:RadMenuItem>

                                                    <telerik:RadMenuItem Text="InActive" Value="InActive" CssClass="InactiveLocation" EnableImageSprite="true"></telerik:RadMenuItem>

                                                    <telerik:RadMenuItem Text="Help" Value="Help" onclick="helpClick();" CssClass="Help" EnableImageSprite="true"></telerik:RadMenuItem>
                                                </Items>
                                            </telerik:RadMenuItem>
                                        </Items>
                                    </telerik:RadMenu>
                                </ItemTemplate>
                            </telerik:RadToolBarButton>

                            <telerik:RadToolBarSplitButton CommandName="Generate" PostBack="false" ImageUrl="Images/ToolBar/Generate.png"
                                EnableDefaultButton="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarGenerate">
                            </telerik:RadToolBarSplitButton>

                            <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Active.png" OuterCssClass="HideOnMobileToolbar"
                                Value="Activate" CommandName="Activation" ToolTip="Activate">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
                <td style="width: 100%"></td>
            </tr>
        </table></td>
        </tr>   
        
            <tr>
                <td>
            <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
            runat="server" MultiPageID="mlpProperties" Width="100%" EnableViewState="True"
            CausesValidation="False">
            <Tabs>
                <telerik:RadTab Text="Header" Value="Header" Selected="True" />
                <telerik:RadTab Text="Details" Value="Details" />
                <telerik:RadTab Text="Specifications" Value="Spec" />
                <telerik:RadTab Text="Components" Value="Components" />
                <telerik:RadTab Text="Buildings" Value="Buildings" />
                <telerik:RadTab Text="Floors" Value="Floors" />
                <telerik:RadTab Text="Spaces" Value="Spaces" />
                <telerik:RadTab Text="Projects" Value="Projects" />
                <telerik:RadTab Text="WorkOrders" Value="WorkOrders" />
                <%--<telerik:RadTab Text="Inspections" Value="DocumentInspections" />--%>
                <telerik:RadTab Text="Equipment" Value="Equipment" />
                <telerik:RadTab Text="Notes" Value="Notes" />
                <telerik:RadTab Text="Attachments" Value="Attachments" />
                <telerik:RadTab Text="Notification" Value="NotificationLog" />
            </Tabs>
        </telerik:RadTabStrip></td>
            </tr>
        
 

        </table>
        <telerik:RadMultiPage ID="mlpProperties" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="True">
            <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
                <telerik:RadAjaxPanel ID="pnlDetailPane" LoadingPanelID="ldpPM" runat="server" Width="100%" HorizontalAlign="NotSet" EnableAJAX="false">
                    <div class="PMMainPage">
                        <div class="row JustifyContent R3Cols">
                            <div class="col-4 col-4-left">
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblProgram" runat="server" meta:resourcekey="lblProgram"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlPrograms" runat="server" AutoPostBack="false"
                                                meta:resourcekey="ddlPrograms" OnItemsRequested="ddl_ItemsRequested"
                                                NoWrap="true" Height="300px" EnableLoadOnDemand="true" ShowMoreResultsBox="True"
                                                EnableVirtualScrolling="True">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblLocationId" runat="server" meta:resourcekey="lblLocationId"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox runat="server" ID="txtCode" MaxLength="50" Text="10002ABC"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvLocationId" runat="server" ControlToValidate="txtCode"
                                                CssClass="Validator" ValidationGroup="Save" meta:resourcekey="rfvLocationId" Display="Dynamic"
                                                ForeColor="">
                                            </asp:RequiredFieldValidator>
                                            <asp:Label ID="lblPropertyCodeUnique" meta:resourcekey="lblPropertyCodeUnique" CssClass="Validator"
                                                runat="server" Visible="false">
                                            </asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblName" runat="server" meta:resourcekey="lblName"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox runat="server" ID="txtName" MaxLength="200" Text="Downtown Crossroads"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvLocationName" runat="server" ControlToValidate="txtName"
                                                CssClass="Validator" ValidationGroup="Save" meta:resourcekey="rfvLocationName" Display="Dynamic"
                                                ForeColor="">
                                            </asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblLocationType" runat="server" meta:resourcekey="lblLocationType"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlPropertyType" runat="server" Filter="Contains" MarkFirstMatch="true"
                                                CloseDropDownOnBlur="true" meta:resourcekey="ddlPropertyType" AllowCustomText="True"
                                                NoWrap="true" CausesValidation="False" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblOperatingProject" runat="server" meta:resourcekey="lblOperatingProject" Text="Operating Project11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlOperatingProject" runat="server" AutoPostBack="true"
                                                meta:resourcekey="ddlOperatingProject" OnItemsRequested="ddl_ItemsRequested"
                                                NoWrap="true" Height="300px" EnableLoadOnDemand="true" ShowMoreResultsBox="True"
                                                EnableVirtualScrolling="True">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:HyperLink runat="server" CssClass="Link" ID="hliComponentof" meta:Resourcekey="hliComponentof" Text="hliComponentof11"></asp:HyperLink>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtComponentof" runat="server" ReadOnly="true"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblComponentType" runat="server" meta:resourcekey="lblComponentType" Text="Component Type11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlComponentType" runat="server" AllowCustomText="True"
                                                LoadingMessage="<%$ Resources:PMWeb, Loading %>" Filter="Contains" MarkFirstMatch="true">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblServiceInterval" meta:resourcekey="lblServiceInterval"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="TxtServiceInterval" MaxLength="15" runat="server" CssClass="PositiveDouble" Text=""></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblInServiceDate" runat="server" meta:resourcekey="lblInServiceDate" Text="In Service Date11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadCodeBlock runat="server">
                                                <span runat="server" id="rmd_dtpInServiceDate" style="display: block">
                                                    <telerik:RadDatePicker ID="dtpInServiceDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                        SelectedDate='<%# Date.Today %>' Culture="English (United States)"
                                                        EnableTyping="true">
                                                        <DateInput ID="DateInput2" runat="server" LabelCssClass="radLabelCss_Office2007"></DateInput>
                                                        <Calendar ID="Calendar2" runat="server"></Calendar>
                                                    </telerik:RadDatePicker>
                                                </span>
                                            </telerik:RadCodeBlock>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblCondition" runat="server" meta:resourcekey="lbl_Condition" Text="Condition/Date11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlConditions" runat="server" Filter="Contains"
                                                MarkFirstMatch="true" CloseDropDownOnBlur="true" Height="200px"
                                                AutoPostBack="false" NoWrap="true" AllowCustomText="True"
                                                CausesValidation="False">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblConditionDate" runat="server" meta:resourcekey="lblConditionDate" Text="Condition Date11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <span runat="server" id="rmd_dtpConditionDate" style="display: inline">
                                                <telerik:RadDatePicker runat="server" ID="dtpConditionDate" Enabled="false" ReadOnly="true" MaxLength="500"></telerik:RadDatePicker>
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblStatus" runat="server" meta:resourcekey="lblStatus"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlStatus" runat="server">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <div style="float: left;">
                                                <asp:Label runat="server" ID="lblCurrency" meta:Resourcekey="hplCurrency" Text="Currency11"></asp:Label>
                                            </div>
                                            <div style="float: right;">
                                                <asp:LinkButton CssClass="SearchButton" runat="server" ID="imgCurrency">
                                                                                    <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </div>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlCurrencies" runat="server" Height="250px">
                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblTargetBudget" meta:resourcekey="lblTargetBudget" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtTargetBudget" MaxLength="15" CssClass="Currency" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblTargetRevenue" meta:resourcekey="lblTargetRevenue" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtTargetRevenue" MaxLength="15" CssClass="Currency" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblTargetOccupancy" meta:resourcekey="lblTargetOccupancy" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtTargetOccupancy" runat="server" CssClass="Percent" MaxLength="9"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <div style="float: left;">
                                                <asp:Label ID="lblBarcode" runat="server" meta:resourcekey="lblBarcode" Text="Barcode11"></asp:Label>
                                            </div>
                                            <div style="float: right;">
                                                <telerik:RadCodeBlock runat="server">
                                                    <asp:LinkButton CssClass="SearchButton" runat="server" ID="lbtPMbarcode">
                                                                            <span class="Icon"></span>
                                                    </asp:LinkButton>
                                                </telerik:RadCodeBlock>
                                            </div>
                                        </td>
                                        <td class="controlWidth">
                                            <div class="NoWrap">
                                                <asp:TextBox ID="txtBarcode" runat="Server" MaxLength="255"></asp:TextBox>
                                                <asp:HiddenField ID="htnBarcodeFormat" runat="server" />
                                                <asp:Label runat="server" ID="lblBarCodeUnique" CssClass="Validator" Text="<%$ Resources:PMWeb, BarCodeUniqueMsg %>"></asp:Label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="vertical-align: top;" class="labelWidth">
                                            <div style="float: left">
                                                <asp:Label ID="lblUploadLogo" meta:Resourcekey="lblUploadLogo" runat="server"></asp:Label>
                                            </div>
                                            <div style="float: right">
                                                <asp:LinkButton runat="server" ID="btnuserimage" CssClass="SearchButton" OnClientClick="return Upload()">
    					                                                    <span class="Icon"></span>                                                              
                                                </asp:LinkButton>
                                            </div>
                                            <div style="width: 16px; height: 16px; margin-right: 12px; margin-top: 25px; float: right">
                                                <asp:Button ID="btnClearImage" runat="server" Style="background-color: unset !important" CssClass="btnclearimage" />
                                            </div>
                                        </td>
                                        <td class="controlWidth">
                                            <div>
                                                <asp:Image ID="imglogo" runat="server" ImageUrl="Images/Global/WhiteDot.gif" CssClass="UploadImage" Style="height: 80px; width: 240px" />
                                            </div>
                                            <div style="display: none">
                                                <asp:FileUpload ID="FileToUpload" onchange="LoadImage(this)" runat="server" CssClass="Upload" />
                                            </div>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="2">
                                            <asp:Label ID="lblCurrencyError" meta:resourcekey="lblCurrencyError" CssClass="Validator" runat="server" Visible="false"></asp:Label>
                                        </td>
                                        <td></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-4 col-4-middle">
                                <fieldset runat="server" id="fldTransmittals">
                                    <legend>
                                        <asp:Label ID="lblAddress" class="legend" meta:Resourcekey="lblAddress" runat="server" Text="Address11"></asp:Label>
                                    </legend>
                                    <table class="colTable">
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label runat="server" ID="lblAddress1" meta:resourcekey="lblAddress1"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtAddress1" MaxLength="255" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label runat="server" ID="lblAddress2" meta:resourcekey="lblAddress2"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtAddress2" MaxLength="255" runat="server" Text=""></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label runat="server" ID="lblCity" meta:resourcekey="lblCity"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtCity" MaxLength="255" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblStateZip" meta:resourcekey="lblStateZip" runat="server" Text="State/Zip111"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <table width="100%" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td style="width: 50%; padding-right: 4px;">
                                                            <telerik:RadComboBox ID="ddlStates" runat="server"
                                                                NoWrap="true" Height="200px" AllowCustomText="true" Filter="Contains">
                                                                <CollapseAnimation Duration="200" Type="OutQuint" />
                                                            </telerik:RadComboBox>
                                                        </td>
                                                        <td style="width: 50%; padding-left: 4px;">
                                                            <asp:TextBox ID="TxtZip" MaxLength="255" runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblCountry" meta:resourcekey="lblCountry" runat="server"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox ID="ddlCountries" Height="200px" AllowCustomText="true"
                                                    Filter="Contains" runat="server">
                                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblPhone" meta:Resourcekey="lblPhone" runat="server"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtPhone" MaxLength="255" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblFax" meta:Resourcekey="lblFax" runat="server"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtFax" MaxLength="255" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <div style="float: left;">
                                                    <asp:Label runat="server" ID="lblGoogleAddress" meta:resourcekey="lblGoogleAddress" Text="Google Address11"></asp:Label>
                                                </div>
                                                <div style="float: right;">
                                                    <asp:LinkButton CssClass="SearchButton" runat="server" ID="btnGoogleAddress" OnClientClick="return OpenGooglepPropertyAddressesPicker();">
                                                                                                                <span class="Icon"></span>
                                                    </asp:LinkButton>
                                                </div>
                                            </td>
                                            <td class="controlWidth">
                                                <asp:TextBox ID="txtGoogleAddress" MaxLength="255" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                                <fieldset runat="server">
                                    <legend>
                                        <asp:Label ID="lblLinearDefinition" class="legend" runat="server" Text="Linear Definition11" meta:resourcekey="lblLinearDef"></asp:Label>
                                    </legend>
                                    <table class="colTable">
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:LinkButton ID="lbtLinearAssets" runat="server" CssClass="SearchButton">
                                                                                                         <span class="Icon"></span>
                                                </asp:LinkButton>
                                            </td>
                                            <td style="text-align: center; color: #666666; text-transform: uppercase" class="controlWidth">
                                                <table width="100%" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td width="45%"></td>
                                                        <td style="padding-left: 10px; width: 45%; padding-right: 4px;">
                                                            <asp:Label ID="lblDirection" runat="server" Text="Direction11" meta:resourcekey="lblDirection"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblBegin" runat="server" Text="Begin11" meta:resourcekey="lblBegin"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <table width="100%" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td style="padding-right: 4px; width: 50%;">
                                                            <asp:TextBox ID="txtBegin" runat="server"></asp:TextBox>
                                                        </td>
                                                        <td style="padding-left: 4px; width: 50%;">
                                                            <telerik:RadComboBox ID="ddlBeginDirection" runat="server" Filter="Contains" MarkFirstMatch="true"
                                                                CloseDropDownOnBlur="true" meta:resourcekey="ddlBeginDirection" AllowCustomText="True"
                                                                NoWrap="true" CausesValidation="False" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblEnd" runat="server" Text="End11" meta:resourcekey="lblEnd"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <table width="100%" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td style="padding-right: 4px; width: 50%;">
                                                            <asp:TextBox ID="txtEnd" runat="server"></asp:TextBox>
                                                        </td>
                                                        <td style="padding-left: 4px; width: 50%;">
                                                            <telerik:RadComboBox ID="ddlEndDirection" runat="server" Filter="Contains" MarkFirstMatch="true"
                                                                CloseDropDownOnBlur="true" meta:resourcekey="ddlEnd" AllowCustomText="True"
                                                                NoWrap="true" CausesValidation="False" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblLength" runat="server" Text="Approx. Length11" meta:resourcekey="lblLength"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <table width="100%" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td style="padding-right: 4px; width: 50%;">
                                                            <asp:TextBox ID="txtLength" CssClass="PositiveDouble" runat="server"></asp:TextBox>
                                                        </td>
                                                        <td style="padding-left: 4px; width: 50%;">
                                                            <telerik:RadComboBox ID="ddlLengthUOM" runat="server" Filter="Contains" MarkFirstMatch="true" OnClientSelectedIndexChanging="LinearLengthUOMChanging"
                                                                CloseDropDownOnBlur="true" meta:resourcekey="ddlLengthUOM" AllowCustomText="true"
                                                                NoWrap="true" CausesValidation="False" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblLinearArea" runat="server" Text="Area11" meta:resourcekey="lblLinearArea"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <table width="100%" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td style="padding-right: 4px; width: 50%;">
                                                            <asp:TextBox ID="txtLinearArea" CssClass="PositiveDouble" runat="server"></asp:TextBox>
                                                        </td>
                                                        <td style="padding-left: 4px; width: 50%;">
                                                            <telerik:RadComboBox ID="ddlLinearAreaUOM" runat="server" Filter="Contains" MarkFirstMatch="true" OnClientSelectedIndexChanging="LinearAreaUOMChanging"
                                                                CloseDropDownOnBlur="true" meta:resourcekey="ddlLinearAreaUOM" AllowCustomText="true"
                                                                NoWrap="true" CausesValidation="False" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </div>
                            <div class="col-4 col-4-right">
                                <uc12:AssetRotator ID="PMrot" runat="server" />
                                <uc15:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />
                            </div>
                        </div>
                    </div>
                </telerik:RadAjaxPanel>
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvDetails" runat="server">
                <uc1:PropertyDetails ID="PropertyDetails" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvSpec" runat="server">
                <uc11:DocumentSpecifications ID="Specification1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvLocationComponents" runat="server">
                <uc14:AssetComponents ID="AssetComponents1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvBuildings" runat="server">
                <uc2:PropertyBuildings ID="PropertyBuildings" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvFloors" runat="server">
                <uc3:PropertyFloors ID="PropertyFloors" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvSpaces" runat="server">
                <uc4:PropertySpaces ID="PropertySpaces" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvProjects" runat="server">
                <uc10:PropertyProjects ID="PropertyProjects1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvWorkOrders" runat="server">
                <uc9:AssetTypeWorkOrder ID="AssetTypeWorkOrder1" runat="server" />
            </telerik:RadPageView>
            <%--   <telerik:RadPageView ID="pvDocumentInspections" runat="server">
                                        <uc16:DocumentInspection ID="DocumentInspection1" runat="server" />
                                    </telerik:RadPageView>--%>
            <telerik:RadPageView ID="pvEquipment" runat="server">
                <uc8:AssetTypeEquipments ID="AssetTypeEquipments" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvNotes" runat="server" Visible="false">
                <uc5:DocumentNotes ID="DocumentNotes" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvAttachments" runat="server">
                <uc6:DocumentAttachments ID="DocumentAttachments" runat="server" />
            </telerik:RadPageView>
            
            <telerik:RadPageView ID="pvNotificationLog" runat="server">
                <uc13:NotificationLog ID="NotificationLog1" runat="server" />
            </telerik:RadPageView>
        </telerik:RadMultiPage>

        <asp:Button runat="server" ID="btnSwitchComponents" CssClass="Hide" />
        <asp:HiddenField runat="server" ID="hdnCurrentUsage" Value="0"></asp:HiddenField>
    </telerik:RadCodeBlock>
</asp:Content>
