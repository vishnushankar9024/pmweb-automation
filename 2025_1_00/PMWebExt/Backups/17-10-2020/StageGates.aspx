<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="StageGates.aspx.vb" Inherits="Website.StageGates" %>

<%@ Register Src="StageGatesDetails.ascx" TagName="StageGatesDetails" TagPrefix="uc1" %>
<%@ Register Src="DocumentNotes.ascx" TagName="DocumentNotes" TagPrefix="uc3" %>
<%@ Register Src="DocumentAttachments.ascx" TagName="DocumentAttachments" TagPrefix="uc4" %>
<%@ Register Src="WorkflowDocument.ascx" TagName="WorkflowDocument" TagPrefix="uc5" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc7" %>
<%@ Register Src="DocumentCheckList.ascx" TagName="DocumentCheckList" TagPrefix="uc2" %>
<%@ Register Src="AssetRotator.ascx" TagName="AssetRotator" TagPrefix="uc9" %>
<%@ Register Src="DocumentScoring.ascx" TagName="StageGateScoring" TagPrefix="uc2" %>
<%@ Register Src="StageRating.ascx" TagName="StageRating" TagPrefix="uc6" %>
<%@ Register Src="NotificationLog.ascx" TagName="NotificationLog" TagPrefix="uc8" %>
<%@ Register Src="DocumentTeam.ascx" TagName="DocumentTeam" TagPrefix="uc9" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc10" %>
<%@ Register Src="DocumentSpecificationsHeader.ascx" TagName="DocumentSpecificationsHeader" TagPrefix="uc11" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="mlpStageGates">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpStageGates" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls> 
            </telerik:AjaxSetting> 
             <telerik:AjaxSetting AjaxControlID="tbsDocument">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpStageGates" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                </UpdatedControls>
            </telerik:AjaxSetting>
          
            <telerik:AjaxSetting AjaxControlID="StageGatesDetails1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpStageGates" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <style type="text/css">
        .AllLightBlueBorder {
            border: 0px solid #C4DBF9;
        }
    </style>
    <script src="JS/Toolbox/StageGate.js" type="text/javascript"></script>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">
            var CurrentRecordProjectId = '<%= PM.StageGateInfo.ProjectId %>';

            function GoToDocument(Url) {
                window.location = Url;
            }

            function chkCompletedChecked(sender, args) {
                var hddnToday = $("[id$=hdnStageGateDetailstodayDate]")[0];
                var chkIsCompleted = $("[id$=" + sender.id + "]")[0];
                var dtpDoneDate = $find(sender.id.substring(0, sender.id.lastIndexOf('_chbDone')) + '_dtpDoneDate');
                if (chkIsCompleted.checked == true) {
                    if (hddnToday.value != "") {    //var myDate = new Date(parseFloat(hddnToday.value));
                        dtpDoneDate.set_selectedDate(new Date());

                    }
                }
                else
                    dtpDoneDate.clear();

            }



            function GetValueToReturn(combobox, eventArgs) {
                var SelectedValue;
                var hdn = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_hddnIds';
                var hdnField = $("[id$=" + hdn + "]")[0];
                var context = eventArgs.get_context();
                context["Ids"] = hdnField.value;
            }
            function check(sender, ddl, resultId, ResultName) {

                var combo = $find(ddl);
                var hdn = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnIds';
                var hdn1 = ddl.substring(ddl.lastIndexOf('_'), ddl.lenght - 1) + '_hddnNames';
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
            function OnClientRated(sender, args) {
                var rating = $("input[id*='rdrating1']").val().split(":")[1].split(",")[0].replace('"', '').replace('"', '');
                //              $("span[id*='lblRating']").html("(" +rating +")");
                var wnd = window.radopen('RatingPopup.aspx?Rating=' + rating + '&Source=StageGate');
                wnd.setSize(424, 435);
                wnd.add_close(RefreshRating);
                wnd.Center();
                return false;
            }
            function RefreshRating(Opener) {
                var updatePanel = $find($("[id$=pnlRating]")[0].id);
                var btnRefreshRating = $("a[id*=rdgRating][id$=btnRefreshRating]")[0];;
                if (updatePanel && btnRefreshRating == null) { __doPostBack(updatePanel.get_id()); }
                else if (btnRefreshRating) {
                    eval(btnRefreshRating.href.split(":")[1]);;
                }

            }

            var forceradmenuToClose = false;
            var forceMoreMenuToClose = true;
            function MoreMenuClicked(sender, args) {
                if (args.get_item().get_value() != null && args.get_item().get_items().get_count() == 0)
                    sender.close(true);
                maintoolbarClick(args.get_item().get_value())
            }

            function click_handler(sender, args) {
                maintoolbarClick(args.get_item().get_commandName())
            }


            function maintoolbarClick(Value) {
                var HasReports = '<%= PM.StageGateInfo.HasReports%>';
                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("STAGEGATE")%>';
                var RecordDescription = '<%=JSEscape(PM.StageGateInfo.ProjectName)%>';
                var Description = '<%=JSEscape(PM.StageGateInfo.Description)%>';
                RecordDescription = RecordDescription + ' - ' + Description;
                var Id = '<%= PM.StageGateInfo.Id%>';
                switch (Value) {

                    case 'Notification':
                        if (Id == 0) break;
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        OpenPOPUp("Notification.aspx?ObjectType=STAGEGATE&Id=" +
                               '<%= PM.StageGateInfo.Id%>' + "&Description="
                                    + Description
                                    + "&RecordDescription=" + RecordDescription
                                    + "&EntityId=" + '<%=PM.StageGateInfo.ProjectId%>' + "&EntityType=0", "Notification",900,500,false);
                        break;

                    case 'ViewPMWebReports':
                        var left = (screen.width - 900) / 2;
                        var top = (screen.height - 500) / 2;
                        if (HasPMWebReports == 'True' && Id > 0) {
                            OpenPOPUp("PMWebReports.aspx?ObjectType=STAGEGATE&Id=" + Id
                          + "&EntityId=" + '<%=PM.StageGateInfo.ProjectId%>' + "&EntityType=0",900,500,false);
                        }
                        break;

                    case 'ViewReports':
                        if (HasReports == 'True') {
                            var left = (screen.width - 890) / 2;
                            var top = (screen.height - 430) / 2;
                            OpenPOPUp("ReportsPreviewPopup.aspx?ObjectType=STAGEGATE&Id=" +
                                  Id
                                  + "&RecordDescription=" + RecordDescription
                                  + "&EntityId=" + '<%=PM.StageGateInfo.ProjectId%>' + "&EntityType=0",890,430,false);
                        }
                        break;
                    case 'New':
                        window.location = "StageGates.aspx";
                        break;

                    default:

                        break;
                }
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
            function StageddlTasksSelectedIndexChanged(sender, eventArgs) {
                var item = eventArgs.get_item();
                var itemId = item.get_parent()._clientStateFieldID;
                var hddnNotificationReviewTime = $("[id$=txtLeadTime]")[0];
                var LeadTime = hddnNotificationReviewTime.value;
                var dtpdueDate = $find(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_dtpDue');
                var StartDate = item.get_attributes().getAttribute("StartMilsc");
                var hdnStart = document.getElementById(sender.get_id().substring(sender.get_id().lastIndexOf('_'), sender.get_id().lenght - 1) + '_hdnStartDate');
                hdnStart.value = StartDate;
                if (StartDate != "") {
                    var myDate = new Date(parseFloat(StartDate));
                    var i = 0;
                    if (LeadTime > 0) {
                        while (i < LeadTime) {
                            myDate.setDate(myDate.getDate() - 1);
                            i = i + 1;
                        }
                    }
                    if (LeadTime < 0) {
                        LeadTime = LeadTime * -1;
                        while (i < LeadTime) {
                            myDate.setDate(myDate.getDate() + 1);
                            i = i + 1;
                        }
                    }
                    dtpdueDate.set_selectedDate(myDate);
                }


            }

            function txtLeadTimeChanged() {
                $("[id$=txtLeadTime]").change(function () {

                    var sender = '<%= txtLeadTime.ClientID %>';
                    txtLeadTime = $("[id$=txtLeadTime]")[0];
                    var dtpdueDate = $find(sender.substring(sender.lastIndexOf('_'), sender.lenght - 1) + '_dtpDue');
                    var hdnStart = document.getElementById(sender.substring(sender.lastIndexOf('_'), sender.lenght - 1) + '_hdnStartDate');
                    if (hdnStart.value != '' && dtpdueDate != null && txtLeadTime) {
                        var LeadTime = txtLeadTime.value;
                        if (LeadTime == '') return;
                        var myDate = new Date(parseFloat(hdnStart.value));
                        var i = 0;
                        if (LeadTime > 0) {
                            while (i < LeadTime) {
                                myDate.setDate(myDate.getDate() - 1);
                                i = i + 1;
                            }
                        }
                        if (LeadTime < 0) {
                            LeadTime = LeadTime * -1;
                            while (i < LeadTime) {
                                myDate.setDate(myDate.getDate() + 1);
                                i = i + 1;
                            }
                        }
                        dtpdueDate.set_selectedDate(myDate);
                    }

                });

            }


        </script>
    </telerik:RadCodeBlock>
    <table class="ToolBar LargeToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td class="ToolbarTd">
                <asp:LinkButton runat="server" ID="btnSearchDocument" PostBackUrl="SearchDocument.aspx?O=177">
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
            <td style="width: 240px;" class="ToolbarTd HideOnMobileToolbar showOnIpad">
                <telerik:RadComboBox ID="ddlStages" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                    Skin="Default" CloseDropDownOnBlur="true" Width="100%" AutoPostBack="false" NoWrap="true"
                    Height="250px" CausesValidation="False" AllowCustomText="true"
                    ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True"
                    OnItemsRequested="ddl_ItemsRequested" OnClientSelectedIndexChanging="MainDropDown_SelectedIndexChanging">
                </telerik:RadComboBox>
            </td>
            <td valign="middle" style="vertical-align: middle;" class="ToolbarTd">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicked="click_handler">
                    <Items>
                        <%--                                    <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Search" ImageUrl="Images/ToolBar/lookup.png" Value="Search" NavigateUrl="SearchDocument.aspx?O=177" CausesValidation="false"></telerik:RadToolBarButton>--%>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CommandName="Save" AccessKey="s" ValidationGroup="Save" ToolTip="Save (Alt+s)" Value="Save"></telerik:RadToolBarButton>
                      
                        <telerik:RadToolBarButton  SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png"  CausesValidation="False" CommandName="New" 
                                                 EnableDefaultButton="false" PostBack="false" ToolTip="New (Alt+n)">
                                               
                         </telerik:RadToolBarButton>
                        
                        
                          <%--<telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="NewInitiative"
                            SecurityButtonType="Add" EnableDefaultButton="false" PostBack="false">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="120px" ImageUrl="Images/Global/AddLine.png"
                                    CommandName="New" SecurityButtonType="Add">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>--%>
                        <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete" CausesValidation="false"></telerik:RadToolBarButton>
                        <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar"></telerik:RadToolBarButton>
                        <%--<telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Office-icon.png" CommandName="WordMerge" SecurityButtonType="Read" EnableDefaultButton="false" PostBack="false" >
                            <Buttons>
                                    <telerik:RadToolBarButton PostBack="false"  CommandName="ViewTemplates">
                                </telerik:RadToolBarButton>
                            </Buttons>
                        </telerik:RadToolBarSplitButton>--%>
                        <telerik:RadToolBarButton SecurityButtonType="Edit" PostBack="false" CausesValidation="false" CommandName="Notification" ImageUrl="Images/ToolBar/EmailMessage.gif" Visible="true"></telerik:RadToolBarButton>

                        <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print" SecurityButtonType="Read" EnableDefaultButton="false" PostBack="false" CssClass="ToolbarPrint" OuterCssClass="HideOnMobileToolbar">
                            <Buttons>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewReports"></telerik:RadToolBarButton>
                                <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif" CommandName="ViewPMWebReports"></telerik:RadToolBarButton>
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
                                                        <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                        <telerik:RadMenuItem Text="PMWeb Reporting" Value="ViewPMWebReports"></telerik:RadMenuItem>
                                                    </Items>
                                                </telerik:RadMenuItem>
                                                <telerik:RadMenuItem Text="Recent" Value="Recent" onclick="OpenRecentDocumentsPopup('STAGEGATE');" CssClass="Help" EnableImageSprite="true" OuterCssClass="Recent"></telerik:RadMenuItem>
                                                <telerik:RadMenuItem EnableImageSprite="true" Text="Help" Value="Help" CssClass="Help" onclick="helpClick();"></telerik:RadMenuItem>
                                            </Items>
                                        </telerik:RadMenuItem>

                                    </Items>
                                </telerik:RadMenu>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                        <telerik:RadToolBarButton OuterCssClass="HideOnMobileToolbar"  style="display:none !important;" PostBack="False" Text="" Value="Rating" CssClass="Hide">
                            <ItemTemplate>
                                <telerik:RadAjaxPanel runat="server" ID="pnlRating">
                                    <table style="padding-right: 20px; width: 100px; height: 100%">
                                        <tr>
                                            <td align="center" style="padding-left: 5px">
                                                <div>
                                                    <span style="padding-bottom: 0px">
                                                    <telerik:RadRating Style="padding-top: 0px" ID="rdrating1" runat="server" ItemCount="5" OnClientRated="OnClientRated"
                                                        Value="3" SelectionMode="Continuous" Height="10px" Skin="Default" Precision="half" Orientation="Horizontal" />
                                                </div>
                                            </td>
                                            <td valign="bottom">
                                                <asp:Label runat="server" ID="lblRating" Style="font-size: 10pt" Text="(3)"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </telerik:RadAjaxPanel>
                            </ItemTemplate>
                        </telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
            <td></td>
        </tr>
    </table>

    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="0" runat="server" MultiPageID="mlpStageGates" Skin="Default" ScrollChildren="true" ScrollButtonsPosition="Left" Width="100%" CssClass="documentTabs">
        <Tabs>
            <telerik:RadTab Text="Header" Value="Header" Selected="True"></telerik:RadTab>
            <telerik:RadTab Text="Details" PageViewID="pvDetails" Value="Details" CssClass="HideTabWhenDetailShownInHeader" />
            <telerik:RadTab Text="Specifications" Value="Spec"></telerik:RadTab>
            <telerik:RadTab Text="Tasks" Value="Checklists" />
            <telerik:RadTab Text="Scoring" Value="Scoring"></telerik:RadTab>
            <telerik:RadTab Text="Ratings" Value="Rating"></telerik:RadTab>
            <telerik:RadTab Text="Notes" Value="Notes" />
            <telerik:RadTab Text="Attachments" Value="Attachments" />
            <telerik:RadTab Value="Workflow" Text="Workflow" />
            <telerik:RadTab Text="Collaborate" Value="DocumentTeam" />
            <telerik:RadTab Text="Notification" Value="NotificationLog" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpStageGates" runat="server" SelectedIndex="0" Width="100%" RenderSelectedPageOnly="true" CssClass="documentMultiPages">
        <telerik:RadPageView ID="pvHeader" runat="server">
            <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" LoadingPanelID="ldpPM" EnableAJAX="false">
                <div class="PMMainPage ">
                    <div class="row JustifyContent R3Cols">
                        <div class="col-4 col-4-left ">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProject" Text="Project" runat="server" meta:resourcekey="lbl_Project"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProject" UseProjectFilter="1" runat="server"
                                            Skin="Default" AutoPostBack="True" NoWrap="True" AllowCustomText="True"
                                            CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                            ShowMoreResultsBox="True" EnableLoadOnDemand="true"
                                            EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlProject"
                                            CssClass="Validator" InitialValue="" ErrorMessage="<%$ Resources:ProjectManagement, ErrorMsg_RequiredProject %>" ValidationGroup="Save"
                                            Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="csvProjects" runat="server" ControlToValidate="ddlProject"
                                            ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save"
                                            CssClass="Validator" ErrorMessage="<%$ Resources:ProjectManagement, ErrorMsg_RequiredProject %>">
                                        </asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStage" Text="Stage" runat="server" meta:resourcekey="lblStage"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtStage" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvSatge" runat="server" ValidationGroup="Save" ControlToValidate="txtStage"
                                            CssClass="Validator" Display="Dynamic" ErrorMessage="Required" ForeColor="">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <div style="float: left">
                                            <asp:Label ID="lblGKeeper" Text="GateKeeper" runat="server" meta:resourcekey="lblGKeeper"></asp:Label>
                                        </div>
                                        <div style="float: right">
                                            <asp:LinkButton runat="server" ID="imgfilter" CssClass="SearchButton" OnClientClick="return OpenCompanyFilterPopup(this.id.replace('imgfilter','HiddenField1'),this.id.replace('imgfilter','ddlGateKeeper'),'Contacts',this.id.replace('imgfilter','ddlProject'))">
                                                                <span class="Icon"></span>
                                            </asp:LinkButton>
                                            <asp:HiddenField ID="HiddenField1" runat="server" />
                                        </div>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlGateKeeper" runat="server"
                                            Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="false"
                                            NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged"
                                            OnClientDropDownClosed="dllcompClientClosed"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested" Height="250px">
                                            <HeaderTemplate>
                                                <table style="width: 100%" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td style="width: 65%;">
                                                            <asp:Literal ID="Literal1" runat="server" Text='<%$Resources:PMWeb, ListColumn_Company %>'></asp:Literal></td>
                                                        <td style="width: 35%;">
                                                            <asp:Literal ID="Literal2" runat="server" Text='<%$Resources:PMWeb, ListColumn_Contact %>'></asp:Literal></td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table style="width: 100%" cellspacing="0" cellpadding="2">
                                                    <tr>
                                                        <td style="width: 65%;">
                                                            <%#DataBinder.Eval(Container, "Attributes['CompanyName']")%>
                                                        </td>
                                                        <td style="width: 35%;">
                                                            <%#DataBinder.Eval(Container, "Attributes['ContactName']")%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDuration" Text="Duration" runat="server" meta:resourcekey="lblDuration"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtDuration" CssClass="PositiveDouble" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="DurationUOM" Text="Duration UOM" runat="server"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlDuration" AllowCustomText="true" runat="server" Skin="Default"  Filter="Contains" MarkFirstMatch="true" Style="font-size: 11px;">
                                            <Items>
                                                <telerik:RadComboBoxItem Text="Days" meta:resourcekey="ListItem_Days" Value="Days" />
                                                <telerik:RadComboBoxItem Text="Months" meta:resourcekey="ListItem_Months" Value="Months" />
                                                <telerik:RadComboBoxItem Text="Quarters" meta:resourcekey="ListItem_Quarters" Value="Quarters" />
                                                <telerik:RadComboBoxItem Text="Weeks" meta:resourcekey="ListItem_Weeks" Value="Weeks" />
                                                <telerik:RadComboBoxItem Text="Years" meta:resourcekey="ListItem_Years" Value="Years" />
                                            </Items>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblType" Text="Type" runat="server" meta:resourcekey="lblType"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlType" AllowCustomText="true" Filter="Contains" runat="server" Skin="Default"></telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblTask" meta:resourcekey="lblTask" runat="server" Text="Task"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlTask" runat="server" Filter="Contains"
                                            MarkFirstMatch="true" Skin="Default" CloseDropDownOnBlur="true" EnableItemCaching="true"
                                            NoWrap="True" AllowCustomText="true" AutoPostBack="false" OnClientSelectedIndexChanged="StageddlTasksSelectedIndexChanged"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested"
                                            Style="font-size: 11px" Height="250px">
                                            <HeaderTemplate>
                                                <table style="width: 435px" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td style="width: 275px;">
                                                            <asp:Literal ID="Literal1" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Task %>'></asp:Literal></td>
                                                        <td style="width: 100px;">
                                                            <asp:Literal ID="Literal2" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Start %>'></asp:Literal></td>
                                                        <td style="width: 120px;">
                                                            <asp:Literal ID="Literal3" runat="server" Text='<%$Resources:PMWeb, ListColumn_Tasks_Finish %>'></asp:Literal></td>
                                                    </tr>
                                                </table>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <table style="width: 435px" cellspacing="0" cellpadding="2">
                                                    <tr>
                                                        <td style="width: 275px;">
                                                            <%# DataBinder.Eval(Container, "Text")%>
                                                        </td>
                                                        <td style="width: 80px;">
                                                            <%#DataBinder.Eval(Container, "Attributes['Start']")%>
                                                        </td>
                                                        <td style="width: 80px;">
                                                            <%#DataBinder.Eval(Container, "Attributes['Finish']")%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblLeadTime" meta:resourcekey="lblLeadTime" runat="server" Text="Lead Time"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtLeadTime" CssClass="Integer" runat="server" MaxLength="5"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDueDate" meta:Resourcekey="lblDueDate" runat="server" Text="Due"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpDue" style="display: block">
                                            <telerik:RadDatePicker ID="dtpDue" runat="server" MinDate="1901-01-01"
                                                MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>'
                                                Width="125px" Skin="Default">
                                                <DateInput ID="DateInput1" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDone" runat="server" Text="Done" meta:Resourcekey="lblDone"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:CheckBox ID="chkDone" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblDoneDate" meta:Resourcekey="lblDoneDate" runat="server" Text="Done"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <span runat="server" id="rmd_dtpDone" style="display: block">
                                            <telerik:RadDatePicker ID="dtpDone" runat="server" MinDate="1901-01-01"
                                                MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>'
                                                Width="125px" Skin="Default">
                                                <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                            </telerik:RadDatePicker>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStatusRevision" runat="server" Text="Status/Revision" meta:Resourcekey="lblStatusRevision"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table style="width: 100%;" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="ddlStatus" AllowCustomText="true" Filter="Contains" runat="server" Skin="Default"></telerik:RadComboBox>
                                                </td>
                                                <td style="width: 50px; padding-left: 8px;">
                                                    <asp:TextBox ID="txtStatusRevision" runat="server" CssClass="PositiveInteger"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblTaskRecap" runat="server" CssClass="legend" Text="Task Recap" meta:resourcekey="lblTaskRecap"></asp:Label>
                                </legend>
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblItems" runat="server" Text="Items" meta:resourcekey="lblItems"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtItems" ReadOnly="true" runat="server" CssClass="PositiveInteger"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblTaskRecapDone" runat="server" Text="Done" meta:resourcekey="lblDone"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtTaskRecapDone" ReadOnly="true" runat="server" CssClass="PositiveInteger"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblTaskRecapDoneperc" runat="server" Text="Done %"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtTaskRecapPercentage" ReadOnly="true" runat="server" CssClass="Percent"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>

                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblStagesRecap" runat="server" CssClass="legend" Text="Stages" meta:resourcekey="lblStages"></asp:Label></legend>
                                <telerik:RadTreeView ID="trvStagesRecap" Height="200px" Width="100%" runat="server" EnableDragAndDrop="False" CausesValidation="False">
                                </telerik:RadTreeView>
                            </fieldset>
                            </div>
                            <div class="col-4 col-4-right">
                                <uc9:AssetRotator ID="PMrot" runat="server" />
                                <uc11:DocumentSpecificationsHeader ID="DocumentSpecificationsHeader1" runat="server" />

                            </div>
                        </div>
                    </div>
            </telerik:RadAjaxPanel>
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDetails" runat="server" CssClass="ShowInHeaderWhenFit Responsive">
            <uc1:StageGatesDetails ID="StageGatesDetails1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="PvSpec" runat="server">
            <uc7:DocumentSpecifications ID="DocumentSpecifications1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvChecklist" runat="server">
            <uc2:DocumentCheckList ID="DocumentCheckList1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvScoring" runat="server">
            <uc2:StageGateScoring ID="StageGateScoring1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvRating" runat="server">
            <uc6:StageRating ID="StageRating1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotes" runat="server" Visible="false">
            <uc3:DocumentNotes ID="DocumentNotes1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvAttachments" runat="server">
            <uc4:DocumentAttachments ID="DocumentAttachments1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvWorkflow" runat="server" Visible="False">
            <uc5:WorkflowDocument ID="WorkflowDocument" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvDocumentTeam" runat="server" Visible="False">
            <uc9:DocumentTeam ID="DocumentTeam1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvNotificationLog" runat="server">
            <uc8:NotificationLog ID="NotificationLog1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>
    <asp:HiddenField ID="hdnStartDate" runat="server" />

</asp:Content>
