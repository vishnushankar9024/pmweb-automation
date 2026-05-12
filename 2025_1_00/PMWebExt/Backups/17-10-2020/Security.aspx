<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="Security.aspx.vb" Inherits="Website.Security" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/Groups.ascx" TagName="Groups" TagPrefix="uc1" %>
<%@ Register Src="~/UserEntities.ascx" TagName="UserEntities" TagPrefix="uc6" %>
<%@ Register Src="~/Users.ascx" TagName="Users" TagPrefix="uc5" %>
<%@ Register Src="~/EntityUsers.ascx" TagName="EntityUsers" TagPrefix="uc7" %>
<%@ Register Src="~/OnlineUsers.ascx" TagName="OnlineUsers" TagPrefix="uc8" %>
<%@ Register Src="~/ConditionalSecurity.ascx" TagName="ConditionalSecurity" TagPrefix="uc2" %>
<%@ Register Src="PasswordSetup.ascx" TagName="PasswordSetup" TagPrefix="uc3" %>
<%@ Register Src="~/ExternalUsers.ascx" TagName="ExternalUsers" TagPrefix="uc4" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <script src="JS/Security/ConditionalSecurity.js" type="text/javascript"></script>
    <script src="JS/Security/Security.js" type="text/javascript"></script>
    <link href="CSS/ControlsCSS/Tree.css" rel="stylesheet" />
    <style type="text/css">

        #ctl00_CPH1_tbsSecurity{
            position:fixed;
        }

         input#ctl00_CPH1_Users_dtpExpiryDate_dateInput:focus{
           outline-width: 0px;
         }
        input#ctl00_CPH1_Users_dtpExpiryDate_dateInput {
    border: 0 !important;
}
        .rspResizeBar {
            background-image: none !important;
        }

        .rgGroupHeader TD {
            padding: 0px !important;
            border: 0px transparent none;
        }

        TD.rgGroupCol {
            PADDING-RIGHT: 0px !important;
            PADDING-LEFT: 4px !important;
            PADDING-BOTTOM: 0px !important;
            PADDING-TOP: 0px !important;
            border: 0px transparent none;
        }

        .rtDisabled .rtIn {
            COLOR: #000 !important;
        }

        .MarginTop1 {
            margin-top: 24px !important;
        }

        @media screen and (min-width:320px) and (max-width:843px) {
            .marginBottomOnMobile {
                margin-bottom: 36px;
            }
        }

        .removeLeft {
            left: 0 !important;
        }

        .SecurityMainTab {
            padding-top: 8px;
            background-color: white;
            z-index: 999;
        }
    </style>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">


        <script language="javascript" type="text/javascript">
            function treeToolbarClick(sender, args) {
                if (args.get_item().get_commandName() == 'ToggleSplitter') {
                    ToggleTree(false);
                }
            }

            function ToggleTree(bool) {
                if (bool)
                    $('[id$=rpRecordTypeRules]')[0].style.display = 'inline-block';
                else
                    $('[id$=rpRecordTypeRules]')[0].style.display = 'none';
                return false;
            }
            function rdgRuleConditionsCreated(sender, args) {
                $("[id*='txtLeftBrackets']").keypress(function (e) {
                    var intKey = (window.Event) ? e.which : e.keyCode;
                    if (!((intKey == 40) || (intKey == 41) || (intKey == 8))) {
                        return false;
                    }

                });
                $("[id*='txtRightBrackets']").keypress(function (e) {
                    var intKey = (window.Event) ? e.which : e.keyCode;
                    if (!((intKey == 40) || (intKey == 41) || (intKey == 8))) {

                        return false;
                    }


                });

                $("[id*='txtBrackets']").keypress(function (e) {
                    var intKey = (window.Event) ? e.which : e.keyCode;
                    if (!((intKey == 40) || (intKey == 41) || (intKey == 8))) {

                        return false;
                    }


                });

                $("[id*='ddlDynamicValues']").each(function (e) {
                    if (document.getElementById(this.id.substring(this.id.lastIndexOf('_'), this.id.lenght - 1) + '_txtValueString')) {
                        var txtValue = document.getElementById(this.id.substring(this.id.lastIndexOf('_'), this.id.lenght - 1) + '_txtValueString');
                        var rfvValueString = document.getElementById(this.id.substring(this.id.lastIndexOf('_'), this.id.lenght - 1) + '_rfvValueString');
                        if ($(this).val() != 0) {
                            txtValue.value = '';
                            txtValue.disabled = 'disabled';
                            rfvValueString.enabled = false;
                        } else {
                            txtValue.disabled = false;
                            rfvValueString.enabled = true;
                        }
                    }

                });

                $("[id*='ddlDynamicValues']").change(function () {
                    if (document.getElementById(this.id.substring(this.id.lastIndexOf('_'), this.id.lenght - 1) + '_txtValueString')) {
                        var txtValue = document.getElementById(this.id.substring(this.id.lastIndexOf('_'), this.id.lenght - 1) + '_txtValueString');
                        var rfvValueString = document.getElementById(this.id.substring(this.id.lastIndexOf('_'), this.id.lenght - 1) + '_rfvValueString');
                        if ($(this).val() != 0) {
                            txtValue.value = '';
                            txtValue.disabled = 'disabled';
                            rfvValueString.enabled = false;
                        } else {
                            txtValue.disabled = false;
                            rfvValueString.enabled = true;
                        }
                    }
                });

            }
            function ToggleModule(sender) {
                if ((sender.id.indexOf('imgEstimating') > -1) && (sender.className == 'Expand')) {
                    $("[id$='trOnlineBidding']").show(100, function () {
                        this.style.display = '';
                        sender.className = 'Collapse';
                    });
                    return;
                }
                if ((sender.id.indexOf('imgEstimating') > -1) && (sender.className == 'Collapse')) {
                    $("[id$='trOnlineBidding']").hide(100, function () {
                        this.style.display = 'none';
                        sender.className = 'Expand';
                    });
                    return;
                }

                if ((sender.id.indexOf('imgAssetManagement') > -1) && (sender.className == 'Expand')) {
                    $("[id$='trAssetExplorer']").show(100, function () {
                        this.style.display = '';
                        sender.className = 'Collapse';
                    });
                    return;
                }
                if ((sender.id.indexOf('imgAssetManagement') > -1) && (sender.className == 'Collapse')) {
                    $("[id$='trAssetExplorer']").hide(100, function () {
                        this.style.display = 'none';
                        sender.className = 'Expand';
                    });
                    return;
                }
            }


            function ConfirmCopyUsers() {

                var grid = $find($("[id$=rdgUsers]")[0].id);


                if (grid.MasterTableView.get_selectedItems().length == 0) {
                    return false;
                }
                return confirm(Msg_ConfirmCopy);
            }

            function Users_OnRowSelected(sender, eventArgs) {


                var btnDelete = $($("a[id$=btnDelete]")[0]);

                if (btnDelete[0] == 'undefined' && btnDelete[0].id == null)
                { return; }


                var Count = sender.get_masterTableView().get_selectedItems().length;

                if (Count == 0)
                { return; }


                if (Count != 1) {
                    btnDelete.hide();
                }
                else {
                    btnDelete.show();
                }


                var IncludesAdmin = 0;

                for (var i = 0; i < Count ; i++) {
                    var row = sender.get_masterTableView().get_selectedItems()[i];
                    if (row.getDataKeyValue("Id") == 5) {
                        IncludesAdmin = 1;
                        btnDelete.hide();
                        break;
                    }

                }

                var btnCopyUser = $($("a[id$=btnCopyUser]")[0]);
                if (btnCopyUser[0].id == null)
                { return; }

                if (IncludesAdmin == 1) {
                    btnCopyUser.hide();
                }
                else {
                    btnCopyUser.show();
                }
            }
            function OpenReminderPropupFromUser() {
                OpenPOPUp("DefineReminderPopup.aspx?ProjectId=0"
                                     + "&LocationId=0"
                                     + "&ProgramId=0"
                                     + "&ObjectTypeId=262"
                                     + "&FieldId=4880"
                                     + "&RecordId=0"
                                     + "&DocumentId=0"
                                     + "&IsDetail=0"
                                     + "&SpecFieldId=0"
                                     + "&CustomFormFieldId=0"
                                     + "&CustomFormColumnDataId=0"
                                     + "&ReferenceDateType=License",
                                 477, 690, false);
                try {
                    event.preventDefault();
                }
                catch (err) {

                }
                try {
                    event.returnValue = false;
                }
                catch (err) {

                }
            }
            function OnClientButtonClicking(sender, args) {

                var command = args.get_item().get_commandName();
                if (command == "ToggleFlyoutTree") {
                    var treeDiv = document.getElementById("dvFlyoutTree");
                    if (treeDiv.style.display == "none")
                        treeDiv.style.display = "block";
                    else
                        treeDiv.style.display = "none";
                }
                if (command == "ToggleTree") {
                    var treeDiv = document.getElementById("dvFlyoutTree");
                    if ($('[id$=rpRecordTypeRules]')[0].style.display == 'none')
                        ToggleTree(true);
                    else
                        ToggleTree(false);
                }
            }
            function ToggleAssetMenu() {
                var tdAssetMenu = $('[id$=tdAssetMenu]')[0];
                var tdAssetExplorerBar = $('[id$=tdAssetExplorerBar]')[0];
                var form = $('form')[0]
                var btnToggleAssetMenu = $('[id$=btnToggle]')[0];
                if (tdAssetMenu.style.display == 'none') {
                    tdAssetMenu.style.display = '';
                    tdAssetExplorerBar.style.left = "285px";
                    tdAssetExplorerBar.className = 'ReportManagerBar BiReportingExplorerBar'
                    btnToggleAssetMenu.className = 'AsserExplorerbutton HideAssetMenu MobileAsserExplorerbutton'
                    setCookie('AssetMenuStatus', 'inline', 60);
                } else {
                    tdAssetMenu.style.display = 'none';
                    tdAssetExplorerBar.style.left = "0px";
                    tdAssetExplorerBar.className = 'ReportManagerBar BiReportingExplorerBarClosed'
                    btnToggleAssetMenu.className = 'AsserExplorerbutton ShowAssetMenu MobileAsserExplorerbutton'
                    setCookie('AssetMenuStatus', 'none', 60);
                }
                return false;
            }

            function AssetSplitterResized(sender, ags) {
                setTimeout(FloatDivs, 100);
                ClientResized();
            }
            function OnClientCollapsed(sender, ags) {
                var tabsDocuments = $find("<%=tbsSecurity.ClientID%>");
                var value = tabsDocuments.get_selectedTab().get_value();
                switch (value) {
                    case "ConditionalSecurity":
                        $("#ctl00_CPH1_ConditionalSecurity1_Splitter").addClass("removeLeft");
                        setTimeout(FloatDivs, 100);
                        setCookie('ConditionalSecurityStatus', 'none', 60);
                        setTimeout(ClientResized(sender), 100)
                        break;

                }

            }
            function OnClientExpanded(sender, ags) {
                var tabsDocuments = $find("<%=tbsSecurity.ClientID%>");
            var value = tabsDocuments.get_selectedTab().get_value();
            switch (value) {
                case "ConditionalSecurity":
                    $("#ctl00_CPH1_ConditionalSecurity1_Splitter").removeClass("removeLeft");
                    setTimeout(FloatDivs, 100);
                    setCookie('ConditionalSecurityStatus', 'inline', 60);
                    setTimeout(ClientResized(sender),100)
                    break;

            }
        }
        var mainsplitter = null;
        function onResized(sender, ags) {
            ////var NewWidth = sender._panes[1].get_width() - 20;
            ////sender._panes[1].set_width(NewWidth);
            ////return false; 
            mainsplitter = sender;

        }
        function AssetSplitterResized(sender, ags) {
            setTimeout(FloatDivs, 100);
        }
        function fixSplitterSize(isRail) {
            var tabsDocuments = $find("<%=tbsSecurity.ClientID%>");
            var value = tabsDocuments.get_selectedTab().get_value();
            if (value === "ConditionalSecurity") {
                var sender = mainsplitter._panes[1];
                var browserWidth = $telerik.$(window).width();
                if (isRail) {
                    sender.set_width(browserWidth - mainsplitter._panes[0].get_width() - 80);
                }
                else {
                    sender.set_width(browserWidth - mainsplitter._panes[0].get_width() - 200);
                }
                if (browserWidth <= 843) {
                    sender.set_width(browserWidth - 20);
                    return;
                }
                $(document).scrollLeft(1);
                while ($(document).scrollLeft() != 0) {
                    var NewWidth = sender.get_width() - 5
                    sender.set_width(NewWidth);
                    $(document).scrollLeft(1);
                    if (NewWidth <= 100) break;
                }
            }

        }
        function ClientResized(sender, ags) {

            setTimeout(FloatDivs, 100);
            var splitter = sender.get_parent();
            var pane1 = splitter._panes[0];
            var pane2 = splitter._panes[1];
            var pane1Td = pane1._element;
           
            if ($('#RAD_SPLITTER_PANE_CONTENT_ctl00_CPH1_ConditionalSecurity1_treeGroupsAndItemsPane').css("position")=='fixed') {
                pane2.set_width(splitter._element.clientWidth - 10);
            }
            else
            pane2.set_width(splitter._element.clientWidth - pane1Td.clientWidth - 10);
            

        }

        </script>


    </telerik:RadCodeBlock>

    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="tbsSecurity">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpSecurity" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsSecurity" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <telerik:RadAjaxLoadingPanel ID="ldpSecurity" runat="server" EnableSkinTransparency="true" BackgroundPosition="Center" Skin="Default" />



    <telerik:RadTabStrip ID="tbsSecurity" SelectedIndex="0" OnClientTabSelecting="onTabSelecting"
        runat="server" MultiPageID="mlpSecurity" Skin="Default" CssClass="SecurityMainTab"
        OnTabClick="tbsSecurity_TabClick" Width="100%" EnableViewState="False" ScrollChildren="true" ScrollButtonsPosition="Left"
        CausesValidation="False">
        <Tabs>
            <telerik:RadTab Text="Groups" meta:resourcekey="tab_Groups" Value="Groups" />
            <telerik:RadTab Text="Define Users" meta:resourcekey="tab_Users" Value="Users" Selected="True" />
            <telerik:RadTab Text="User Access" meta:resourcekey="tab_UserEntities" Value="UserEntities" />
            <telerik:RadTab Text="Project Users" meta:resourcekey="tab_EntityUsers" Value="EntityUsers" />
            <telerik:RadTab Text="Conditional Security" meta:resourcekey="tab_ConditionalSecurity" Value="ConditionalSecurity" />

            <telerik:RadTab Text="Activity Monitor" meta:resourcekey="tab_OnlineUsers" Value="ActivityMonitor" />
            <telerik:RadTab Text="Password Setup" Value="PasswordSetup" meta:resourcekey="tab_PasswordSetup" />
            <telerik:RadTab Text="External Users" Value="External_Users" meta:resourcekey="tab_ExternalUsers" />
        </Tabs>
    </telerik:RadTabStrip>

    <telerik:RadMultiPage ID="mlpSecurity" runat="server" SelectedIndex="0"
        Width="100%" RenderSelectedPageOnly="true">
   
        <telerik:RadPageView ID="pvGroups" runat="server">
            <uc1:Groups ID="Groups" runat="server" />
        </telerik:RadPageView>
             <telerik:RadPageView ID="pvUsers" runat="server">
            <uc5:Users ID="Users" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvUserEntities" runat="server">
            <uc6:UserEntities ID="UserEntities" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvEntityUsers" runat="server">
            <uc7:EntityUsers ID="EntityUsers" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvConditionalSecurity" runat="server">
            <uc2:ConditionalSecurity ID="ConditionalSecurity1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvOnlineUsers" runat="server">
            <uc8:OnlineUsers ID="OnlineUsers" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="RadPageView1" runat="server">
            <uc3:PasswordSetup ID="PasswordSetup1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvExternalUsers" runat="server">
            <uc4:ExternalUsers ID="ExternalUsers1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>


</asp:Content>
