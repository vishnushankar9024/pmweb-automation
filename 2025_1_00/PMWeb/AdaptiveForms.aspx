<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="AdaptiveForms.aspx.vb" Inherits="Website.AdaptiveForms" %>

<%@ Register Src="ngDocNotes.ascx" TagName="DocumentNotes" TagPrefix="uc1" %>
<%@ Register Src="ngDocAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc2" %>
<%@ Register Src="~/ngDocWorkflow.ascx" TagName="WorkflowDocument" TagPrefix="uc3" %>
<%@ Register Src="ngDocCollaborate.ascx" TagName="DocumentTeam" TagPrefix="uc4" %>
<%@ Register Src="ngDocNotifications.ascx" TagName="NotificationLog" TagPrefix="uc5" %>


<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <style type="text/css">
        .rcbSlide div.ToolbarDropdown {
            display: none;
            position: relative !important;
            overflow: hidden;
            top: 0px !important;
        }
    </style>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">


        <script language="javascript" type="text/javascript">
            window.addEventListener('message', function (event) {
                if (event.data.event_id === 'FromSaved') {
                    debugger;
                    console.log('redired the form windows.location.href ' + event.data.FormId);
                    //redired the form windows.location.href ........
                    alert("AdaptiveForms.aspx?TemplateId=" + "<%=PM.AdaptiveFormInfo.TemplateId%>" + "&Id=" + event.data.FormId + "&ModuleId=" + "<%=PM.intCurrModuleId%>" + "&PageId=" + "<%=PM.intCurrPageId%>");
                }
                else if (event.data.event_id === 'FormInvalid' || event.data.event_id === 'FormLoaded' ) {
                    $("[id=DisableAllControlsOnPostback]").addClass("Hide");
                }
                else if (event.data.event_id === 'FormLocales') {
                    var arrLocales = event.data.Locales.usedLocales;
                    var currLocale = event.data.Locales.currLocale;
                    if (currLocale == '') currLocale = 'en';
                    var userLang = "<%=PM.UserInfo.Language%>";
                    if (userLang && (userLang.length) > 2) {
                        if (arrLocales.indexOf(userLang.substr(0, 2)) != -1)  currLocale = userLang.substr(0, 2);
                    }
                    var ddlLocales = $find($("[id$=ddlLocales]")[0].id);
                    ddlLocales.clearItems();
                    ddlLocales.trackChanges();
                    $(arrLocales).each(function (index, element) {
                        var objItem = new Telerik.Web.UI.RadComboBoxItem();
                        objItem.set_text(element);
                        ddlLocales.get_items().add(objItem);
                        if (element == currLocale) objItem.select();
                    });
                    ddlLocales.commitChanges();
                    dirty = false;
                }
            });

            function ddlLocales_SelectedIndexChanging(sender, eventArgs) {
                var selectedLocale = eventArgs._item.get_text();
                const targetWindow = document.getElementById('ctl00_CPH1_ngFrame');
                if (targetWindow) {
                    const messageData = {
                        event_id: 'SetLocale',
                        Locale: selectedLocale
                    };
                    targetWindow.contentWindow.postMessage(messageData, '*');
                }
            }

            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0) {
                    sender.close(true);

                    if (args.get_item().get_value() == "Print") {
                        var mainToolBar = $find("<%= mainToolBar.ClientID%>");
                        var button = mainToolBar.findItemByValue("Print");
                        button.click();
                    }

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
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName(), args.get_item().get_element(),args)
            }

            function ToolbarGlobalClientButtonClicking(sender, args) {
                var value = args.get_item().get_commandName();
                if (value == 'Save') {
                 
                        $("[id=DisableAllControlsOnPostback]").removeClass("Hide");
                    
                    
                    const targetWindow = document.getElementById('ctl00_CPH1_ngFrame');
                    if (targetWindow) {
                        const messageData = {
                            event_id: 'ServerSave',
                            FromId: 'nothing'
                        };
                        targetWindow.contentWindow.postMessage(messageData, '*');
                        args.set_cancel(true);
                    }
                }
                else if (value == "Delete") {
                    if (!confirm(Msg_ConfirmDeleteDocument)) {
                        args.set_cancel(true);
                    }
                }
            }
            function maintoolbarClick(Value, ItemElement, args) {
                var HasMergeTemplate = '<%= PM.AdaptiveFormInfo.HasMergeTemplate%>';
                var HasReports = '<%= PM.AdaptiveFormInfo.HasReports%>';
                var RecordDescription = '<%=JSEscape(PM.AdaptiveFormInfo.RecordDescription)%>';
                var Description = '<%=JSEscape(PM.AdaptiveFormInfo.Description)%>';
                var Id = '<%= PM.AdaptiveFormInfo.Id%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports(PM.AdaptiveFormInfo.ObjectType)%>';
                var ObjectType = '<%=PM.AdaptiveFormInfo.ObjectType%>';
                var EntityType = '<%=PM.AdaptiveFormInfo.EntityTypeId %>';
                var EntityId = '<%=PM.AdaptiveFormInfo.EntityId %>';
                var EntityTypeId = -1;
                if (EntityType == 249 || EntityType == 251)
                    EntityTypeId = 0;
                if (EntityType == 252)
                    EntityTypeId = 1;
                switch (Value) {
                  case 'ViewTemplates':
                        if (HasMergeTemplate == 'True') {
                            var left = (screen.width - 1045) / 2;
                            var top = (screen.height - 515) / 2;
                            var URL = "MergeTemplatePopup.aspx?ObjectType=" + ObjectType + "&Id=" +
                                    '<%= PM.AdaptiveFormInfo.Id%>' + "&Description="+ Description
                                    + "&RecordDescription=" + RecordDescription
                        
                            return OpenPOPUp(URL, 1045, 515, false, '');
        

                        }
                             break;
                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        var URL = "Notification.aspx?ObjectType=" + ObjectType + "&Id=" +
                              '<%= PM.AdaptiveFormInfo.Id%>' + "&Description="
                            + Description
                            + "&RecordDescription=" + RecordDescription
                            + "&EntityId=" + EntityId + "&EntityType=" + EntityTypeId
                        return OpenPOPUp(URL, 820, 500, false, '');
                        break;
                    case 'Print':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;

                            var URL = "ReportsPreviewPopup.aspx?ObjectType=" + ObjectType + "&Id=" +
                                '<%= PM.AdaptiveFormInfo.Id%>'
                                + "&RecordDescription=" + RecordDescription
                                + "&EntityId=" + EntityId + "&EntityType=" + EntityTypeId;
                            return OpenPOPUp(URL, 890, 430, false, '');
                        }
                        break;
                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            var URL = "PMWebReports.aspx?ObjectType=" + ObjectType + "&Id=" + Id
                      + "&EntityId=" + EntityId + "&EntityType=" + EntityTypeId;
                            return OpenPOPUp(URL, 890, 430, false, '');
                        }
                        break;
                     case 'ViewReports':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;

                            var URL = "ReportsPreviewPopup.aspx?ObjectType="+ ObjectType +"&Id=" +
                                  '<%= PM.AdaptiveFormInfo.Id%>'
                           + "&RecordDescription=" + RecordDescription
                           + "&EntityId=" + EntityId + "&EntityType=" + EntityTypeId;
                            return OpenPOPUp(URL, 890, 430, false, '');
                        }
                        break;
                    case 'BIReporting':
                        window.location = "ReportManager.aspx?ModuleId=" + Global_CurrentModuleId;
                        break;
                    case 'New', "NewInitiative":
                        window.location = "AdaptiveForms.aspx?TemplateId=" + "<%=PM.AdaptiveFormInfo.TemplateId%>" + "&Id=0&ModuleId=" + "<%=PM.intCurrModuleId%>" + "&PageId=" + "<%=PM.intCurrPageId%>";
                        break;
                    case 'Submit':
                        return OpenWorkflowSubmitPopup();
                        break;
                    default:
                        break;
                }
            }

            function OpenWorkflowSubmitPopup() {
                var ObjectType = '<%=PM.AdaptiveFormInfo.ObjectType%>';
                OpenSubmitPOPUpToRedirect("WorkflowSubmitPopup.aspx?ObjectType=" + ObjectType);
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
            function ddlAdaptiveForms_SelectedIndexChanging(sender, eventArgs) {
                var TemplateId = '<%=PM.AdaptiveFormInfo.TemplateId%>';
                var RecordId = eventArgs._item.get_value();
                if (parseInt(RecordId) > 0) {

                    window.location.href = currPageName + '?TemplateId=' + TemplateId + '&Id=' + RecordId + '&ModuleId=' + currModuleId + '&PageId=' + currPageId;
                    eventArgs.set_cancel(true);
                    
                }
            }
           
        </script>
        
    </telerik:RadCodeBlock>
   
    <table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar">
        <tr valign="top">
            <td valign="top">
                <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                      <%--  <td style="width: 240px" class="ToolbarTd HideOnMobileToolbar">
                            <telerik:RadComboBox ID="ddlAdaptiveForms" runat="server" Skin="Default" CloseDropDownOnBlur="true"
                                EmptyMessage="Select Custom Form ..." Width="240px" AutoPostBack="True" AllowCustomText="true"
                                CausesValidation="False" Height="400px" NoWrap="true" OnItemsRequested="ddl_ItemsRequested"
                                ShowMoreResultsBox="True" OnClientSelectedIndexChanging="ddlAdaptiveForms_SelectedIndexChanging" EnableLoadOnDemand="true" OnClientTextChange="LOD_DropDownTextChange"
                                EnableVirtualScrolling="True" DropDownCssClass="ToolbarDropdown">
                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                            </telerik:RadComboBox>
                        </td>--%>

                        <td valign="middle" style="vertical-align: middle; width: 70%" class="ToolbarTd">
                                  
                            <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicking="mainToolbarClicking">
                                <Items>

                                 <%--   <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                                    </telerik:RadToolBarButton>--%>

                                    <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CommandName="Save" Value="Save" ValidationGroup="Save" AccessKey="s"
                                        ToolTip="Save (Alt+s)">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="NewInitiative"
                                        SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                                        <Buttons>
                                            <telerik:RadToolBarButton SecurityButtonType="Add" Width="150px" ImageUrl="Images/ToolBar/NewDoc.png" PostBack="false" Value="New"
                                                CommandName="NewInitiative" AccessKey="n" ToolTip="New (Alt+n)" CausesValidation="false">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton SecurityButtonType="Copy" Width="150px"
                                                CommandName="Copy" Value="CopyRecord" ImageUrl="Images/ToolBar/CopyRecord.png" ValidationGroup="Save">
                                            </telerik:RadToolBarButton>
                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>

                                    <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CausesValidation="false"
                                        CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton SecurityButtonType="Edit" CausesValidation="false" PostBack="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint"
                                        EnableDefaultButton="false" PostBack="false">
                                        <Buttons>
                                            <telerik:RadToolBarButton PostBack="false" Width="170px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="BIReporting">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CausesValidation="false" CommandName="ViewPMWebReports">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CausesValidation="false" CommandName="ViewTemplates">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CausesValidation="false" CommandName="PrintAdaptiveFormToWord" Visible="false">
                                            </telerik:RadToolBarButton>
                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>

                                    <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                                        <ItemTemplate>
                                            <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked">
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
                                                            <telerik:RadMenuItem Text="Submit" Value="Submit" onclick="OpenWorkflowSubmitPopup();" CssClass="Help" EnableImageSprite="true" ></telerik:RadMenuItem>
                                                            <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" CssClass="Help" onclick="helpClick();"></telerik:RadMenuItem>
                                                        </Items>
                                                    </telerik:RadMenuItem>

                                                </Items>
                                            </telerik:RadMenu>
                                        </ItemTemplate>
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton>
                                        <ItemTemplate>
                                            <telerik:RadLabel ID="txtLocales" runat="server" AssociatedControlID="ddlLocales" Text="Language1" 
                                                meta:resourcekey="txtLocales" style="margin: 0 5px;">
                                            </telerik:RadLabel>
                                            <telerik:RadComboBox ID="ddlLocales" runat="server" Skin="Default" CloseDropDownOnBlur="true"
                                                AutoPostBack="false" AllowCustomText="false" Width="60px"
                                                CausesValidation="False" NoWrap="true" 
                                                ShowMoreResultsBox="false" OnClientSelectedIndexChanging="ddlLocales_SelectedIndexChanging" EnableLoadOnDemand="false"
                                                EnableVirtualScrolling="false" DropDownCssClass="ToolbarDropdown">
                                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                            </telerik:RadComboBox>
                                        </ItemTemplate>
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton ID="btnSubmit" PostBack="false" runat="server" CssClass="lnkButtonBar" OuterCssClass="HideOnMobileToolbar" Value="Submit"
                                        meta:resourcekey="btnSubmit" CommandName="Submit" Text="Submit" ImageUrl="Images/ToolBar/PMWebW.gif" ValidationGroup="Save">
                                    </telerik:RadToolBarButton>

                                </Items>
                            </telerik:RadToolBar>
                        </td>
                        <td style="width: 100%; text-align:left">
                        </td> 
                    </tr>
                </table>
            </td>
        </tr>
    </table>
   <telerik:RadAjaxPanel ID="pnlDetailPane" LoadingPanelID="ldpPM" runat="server" Width="100%" EnableAJAX="false"> 
    <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="0" ScrollChildren="true" ScrollButtonsPosition="Left" CssClass="documentTabs"
        runat="server" MultiPageID="mlpAdaptiveForm" Width="100%" EnableViewState="True" CausesValidation="False">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True" />
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
            <telerik:RadTab Text="Workflow" Value="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            
        </Tabs>
    </telerik:RadTabStrip>

    <telerik:RadMultiPage ID="mlpAdaptiveForm" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="True" CssClass="documentMultiPages">
        <telerik:RadPageView ID="pvHeader" runat="server" Selected="True">
            <iframe runat="server" id="ngFrame" width="100%" style="height: Calc(100VH - 240px); padding: 0px; margin: 0px; z-index:7000; position:relative; background-color: white"></iframe>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server">
            <uc1:DocumentNotes ID="DocumentNotes" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc2:DocumentAttachments ID="DocumentAttachments" runat="server" />
        </telerik:RadPageView> 
            <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc5:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server">
            <uc3:WorkflowDocument ID="WorkflowDocument1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc4:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
   
    </telerik:RadMultiPage>
  </telerik:RadAjaxPanel>  
</asp:Content>

