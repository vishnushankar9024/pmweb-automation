<%@ Page Language="vb" meta:resourcekey="Page" Title="Contacts" AutoEventWireup="false" CodeBehind="CompaniesFilterPopup.aspx.vb" Inherits="Website.CompaniesFilterPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="BiddersFilter.ascx" TagName="Bidders" TagPrefix="uc1" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <style type="text/css">
        .documentSplitter, .fullWidthPane, .SplitterPanePopup {
            height: calc(100vh - 63px) !important;
        }

        .CompaniesFilterTabs .rtsLevel.rtsLevel1 {
            width: 100% !important;
        }

        .labelWidth.wide {
            width: 200px !important;
        }

            .labelWidth.wide span {
                width: 200px !important;
            }

        .controlWidth {
            width: 240px !important;
        }

        .PMMainPage > .row .col-4.width440 {
            width: 440px;
        }

        .PMMainPage > .row .col-4.width200 {
            width: 200px;
        }

        .colTable a {
            text-decoration: none;
        }

        .col-4.RrightGutterCalc {
            padding-right: calc(100% - 664px) !important;
        }

        @media screen and (min-width:320px) and (max-width:843px) {
            tr.ToolBar.paddingTop, table.ToolBar.paddingTop {
                top: 34px !important;
            }

            .treeToolbar .RadToolBar_Horizontal .rtbItem:first-child {
                margin-left: 16px !important;
                margin-right: 16px !important;
            }

            div#RadSplitter1 {
                margin-top: 0px !important;
            }
        }

        #rpLinkedRecords {
            position: relative;
        }

        .RadTreeView.CheckBoxesTreeview label .rtChk {
            margin-left: 17px;
            margin-right: -16px;
        }

        .RadTreeView.CheckBoxesTreeview .trvProject label .rtChk {
            display: none !important;
        }

        .RadTreeView.CheckBoxesTreeview .trvPortfolio label .rtChk {
            display: none !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <script type="text/javascript">
            function FillOnlineChangeRequestCompanies(sender, eventArgs) {
                var combo = window.parent.$find(querySt('ddlId'));
                var Control = window.parent.document.getElementById(querySt('ControlId'));
                var ddlvalue = eventArgs.getDataKeyValue("Id");
                ddltext = eventArgs.getDataKeyValue("Company");
                if (combo != null && Control != null) {
                    Control.value = ddlvalue;
                }
                else {
                    Control.value = "0";
                }

                $(window.parent.document).find("input[id$=btnFillCompanies]").click();
                CloseRadWnd();
                return false;
            }

            function RowClick(sender, eventArgs) {
                var ddlvalue = eventArgs.getDataKeyValue("Id")
                if (querySt('Source') == 'OnlineChangeRequest') {
                    return FillOnlineChangeRequestCompanies(sender, eventArgs);
                }
                if (querySt('Source') == 'Notification') {
                    var Comp = eventArgs.getDataKeyValue("Company");
                    var Cont = eventArgs.getDataKeyValue("Contact");
                    var Email = eventArgs.getDataKeyValue("Email");
                    var txtFullContact = window.parent.document.getElementById(querySt('txtFullContact'));
                    var txtContact = window.parent.document.getElementById(querySt('txtContact'));
                    var txtEmail = window.parent.document.getElementById(querySt('txtEmail'));
                    var txtIds = window.parent.document.getElementById(querySt('txtIds'));

                    if (txtContact != null && txtEmail != null && txtIds != null) {
                        txtFullContact.value = Cont + ' ' + '[' + Comp + ']';
                        txtContact.value = Cont;
                        txtEmail.value = Email;
                        txtIds.value = ddlvalue;
                    }
                    window.close();
                    return false;
                }

                var ddltext = ''
                if (querySt('Type') == 'Companies') {
                    ddltext = eventArgs.getDataKeyValue("Company");
                }
                else {
                    ddltext = eventArgs.getDataKeyValue("ContactText");
                }
                var combo = window.parent.$find(querySt('ddlId'));
                var Control = window.parent.document.getElementById(querySt('ControlId'));
                var csvControl = window.parent.$("[id='" + combo.get_id() + "'] ~ [id*='csv']")
                //var ListCompanyUses = ['_csvCompany', '_csvCompanyName', '_csvCompanyId', '_csvCompanies'];
                //var csvControlName;
                //ListCompanyUses.forEach(function (c) {
                //    csvControlName = combo.get_id().substring(combo.get_id().lastIndexOf('_'), combo.get_id().lenght - 1) + c;
                //    csvControl = window.parent.document.getElementById(csvControlName);
                //    if (csvControl != null) {
                //        return;
                //    }
                //});
                if (csvControl != null) csvControl.enabled = false;
                if (combo != null && Control != null) {
                    combo.trackChanges();
                    combo.set_text(ddltext);
                    combo.set_value(ddlvalue);
                    combo.commitChanges();
                    Control.value = ddlvalue;
                    window.parent.setdirty();
                }
                if (csvControl != null) csvControl.enabled = true;
                CloseRadWnd();
                return false;
            }


            function querySt(ji) {
                hu = window.location.search.substring(1);
                gy = hu.split("&");
                for (i = 0; i < gy.length; i++) {
                    ft = gy[i].split("=");
                    if (ft[0] == ji) {
                        return ft[1];
                    }
                }
            }

            var gridId = "RadContentPane";
            function isMouseOverGrid(target) {
                parentNode = target;
                while (parentNode != null) {
                    if (parentNode.id == gridId) {
                        return parentNode;
                    }
                    parentNode = parentNode.parentNode;
                }
                return null;
            }

            function onNodeDragging(sender, args) {
                var target = args.get_htmlElement();

                if (!target) return;
                if (target.tagName == "INPUT") {
                    target.style.cursor = "hand";
                }
                var grid = isMouseOverGrid(target);
                if (grid) {
                    grid.style.cursor = "hand";
                }
            }

            function droppedOnGrid(args) {
                var target = args.get_htmlElement();

                while (target) {
                    if (target.id == gridId) {
                        args.set_htmlElement(target);
                        return;
                    }
                    target = target.parentNode;
                }
                args.set_cancel(true);
            }

            function onNodeDropping(sender, args) {
                if (droppedOnGrid(args)) return;
            }

            function SaveMergeMultiple(ContactEmails) {
                var txtEmail = window.parent.document.getElementById(querySt('txtEmail'));
                txtEmail.value = ContactEmails;
                window.close();
                return false;
            }

            function SaveReportPreviewMultiple(ContactEmails) {
                var txtEmail = window.parent.document.getElementById(querySt('txtEmail'));
                txtEmail.value = ContactEmails;
                window.close();
                return false;
            }

            function SaveNotificationMultiple(ContactIds, ContactNames, ContactEmails) {
                var txtContact = window.parent.document.getElementById(querySt('txtContact'));
                var txtEmail = window.parent.document.getElementById(querySt('txtEmail'));
                var txtIds = window.parent.document.getElementById(querySt('txtIds'));
                var currentIds = ''
                var currentEmail = '';
                var currentComp = '';
                if (txtContact != null && txtEmail != null && txtIds != null) {
                    currentIds = txtIds.value;
                    currentEmail = txtEmail.value;
                    currentComp = txtContact.value;
                    if (currentIds != '')
                        currentIds = currentIds + ';' + ContactIds;
                    else
                        currentIds = ContactIds;
                    if (currentEmail != '')
                        currentEmail = currentEmail + ';' + ContactEmails;
                    else
                        currentEmail = ContactEmails;

                    if (currentComp != '')
                        currentComp = currentComp + '\n' + ContactNames;
                    else
                        currentComp = ContactNames;
                    txtEmail.value = currentEmail.replace(/;$/, "");
                    txtContact.value = currentComp.replace(/\n$/, "");
                    txtIds.value = currentIds.replace(/;$/, "");
                }
                else if (txtContact != null && txtEmail != null) {
                    currentEmail = txtEmail.value;
                    currentComp = txtContact.value;
                    if (currentEmail != '')
                        currentEmail = currentEmail + ';' + ContactEmails;
                    else
                        currentEmail = ContactEmails;

                    if (currentComp != '')
                        currentComp = currentComp + '\n' + ContactNames;
                    else
                        currentComp = ContactNames;
                    txtEmail.value = currentEmail.replace(/;$/, "");
                    txtContact.value = currentComp.replace(/\n$/, "");
                }
                window.close();
                return false;
            }

            function SaveMultiple(ContactIds, ContactNames) {
                var combo = window.parent.$find(querySt('ddlId'));
                var hdnIds = window.parent.document.getElementById(querySt('hdnIds'));
                var hdnNames = window.parent.document.getElementById(querySt('hdnNames'));
                if (combo != null && hdnIds != null && hdnNames != null) {
                    combo.set_text(ContactNames);
                    hdnIds.value = ContactIds;
                    hdnNames.value = ContactNames;
                    window.parent.setdirty();
                }
                window.close();
                return false;
            }

            function pageLoad() {
                CheckParentBox();
                CheckBiddersParentBox();
            }

            function AllCheckClicked(iObj) {
                var i = 0;
                var rdgRights = $("div[id$='rdgContacts']");
                var j = 0;
                var k = 0;
                rdgRights.find("input[type='checkbox']").each(function () {
                    if (i > 0) {

                        var IsBluebeamValid = this.parentElement.getAttribute("IsBluebeamValid");

                        if (IsBluebeamValid && IsBluebeamValid == '0') {
                            this.checked = false;
                        }
                        else {

                            if (!this.disabled && this.id.indexOf("chkSelect") > 0) {
                                if (!this.checked)
                                    j = j + 1;
                                if (this.checked)
                                    k = k + 1;
                                this.checked = iObj.checked;
                            }
                        }
                    }
                    i++;
                });

                var hdnCount = $("[id$=hdnCount]");
                var Value = parseFloat(hdnCount.val());
                if (iObj.checked) {
                    Value = Value + j;
                }
                else {
                    if ((Value - k) >= 0)
                        Value = Value - k;
                }
                hdnCount.val(Value);
                document.title = MsgTitle + ' (' + Value + ' ' + MsgSelected + ')';
            }

            function SelectParent(chk) {
                var rdgRights = $("div[id$='rdgContacts']");
                if (rdgRights.find("input[type='checkbox']")[0] == null) return;
                var chkPArent = rdgRights.find("input[type='checkbox']")[0];

                var i = 0;
                var isChecked = true;
                rdgRights.find("input[type='checkbox']").each(function () {
                    if (i > 0) {
                        if (chk.checked) {
                            if (!this.checked) isChecked = false;
                        }
                    }
                    i++;
                });
                var hdnCount = $("[id$=hdnCount]");
                var Value = parseFloat(hdnCount.val());

                var IsBluebeamValid = chk.parentElement.getAttribute("IsBluebeamValid");

                if (!chk.checked) {
                    chkPArent.checked = false;
                    if (Value > 0)
                        Value = Value - 1;

                } else {
                    if (IsBluebeamValid && IsBluebeamValid == '0') {
                        chk.checked = false;
                    }
                    else {
                        chkPArent.checked = isChecked;
                        Value = Value + 1;
                    }
                }
                hdnCount.val(Value);
                document.title = MsgTitle + ' (' + Value + ' ' + MsgSelected + ')';
                return false;
            }

            function CheckParentBox() {
                var rdgRights = $("div[id$='rdgContacts']");
                var ParentIsNotChecked = true;
                var i = 0;
                rdgRights.find("input[type='checkbox']").each(function () {
                    if (i > 0) {
                        if (!this.checked) {
                            if (this.id.indexOf("chkSelect") > 0)
                                ParentIsNotChecked = false;
                        }
                    }
                    i++;
                });

                if (!ParentIsNotChecked) {
                    rdgRights.find("input[type='checkbox']")[0].checked = false;

                } else {
                    if (i > 0) {
                        rdgRights.find("input[type='checkbox']")[0].checked = true;
                    }
                }
            }

            function SetTitle() {
                var hdnCount = $("[id$=hdnCount]");
                var Value = parseFloat(hdnCount.val());
                if (querySt('ddlType') == 'Multiple') {
                    document.title = MsgTitle + ' (' + Value + ' ' + MsgSelected + ')';

                }
            }

            function AllBiddersCheckClicked(iObj) {


                var i = 0;
                var rdgRights = $("div[id$='rdgBiddersFilter']");
                var j = 0;
                var k = 0;
                rdgRights.find("input[type='checkbox']").each(function () {
                    if (i > 0) {
                        if (!this.disabled && this.id.indexOf("chkSelectBidder") > 0) {
                            if (!this.checked)
                                j = j + 1;
                            if (this.checked)
                                k = k + 1;
                            this.checked = iObj.checked;
                        }

                    }
                    i++;
                });

                var hdnBiddersCount = $("[id$=hdnBiddersCount]");
                var Value = parseFloat(hdnBiddersCount.val());
                if (iObj.checked) {
                    Value = Value + j;
                }
                else {
                    if ((Value - k) >= 0)
                        Value = Value - k;
                }
                hdnBiddersCount.val(Value);

            }

            function BiddersSelectParent(chk) {

                var rdgRights = $("div[id$='rdgBiddersFilter']");
                var chkPArent = rdgRights.find("input[type='checkbox']")[0];

                var i = 0;
                var isChecked = true;
                rdgRights.find("input[type='checkbox']").each(function () {
                    if (i > 0) {
                        if (chk.checked) {
                            if (!this.disabled && !this.checked && this.id.indexOf("chkSelectBidder") > 0) isChecked = false;
                        }
                    }
                    i++;
                });
                var hdnBiddersCount = $("[id$=hdnBiddersCount]");
                var Value = parseFloat(hdnBiddersCount.val());

                if (!chk.checked) {
                    chkPArent.checked = false;
                    if (Value > 0)
                        Value = Value - 1;


                } else {
                    chkPArent.checked = isChecked;
                    Value = Value + 1;
                }
                hdnBiddersCount.val(Value);

                return false;
            }

            function CheckBiddersParentBox() {
                var rdgRights = $("div[id$='rdgBiddersFilter']");
                if (rdgRights.find("input[type='checkbox']")[0] == null) return;
                var ParentIsNotChecked = true;
                var i = 0;
                var d = 1;
                var c = 1;
                rdgRights.find("input[type='checkbox']").each(function () {
                    if (i > 0) {
                        if (!this.disabled && !this.checked) {
                            if (this.id.indexOf("chkSelectBidder") > 0)
                                ParentIsNotChecked = false;
                        }
                        if (this.disabled) {
                            d = d + 1;
                        }
                        if (this.id.indexOf("chkSelectBidder") > 0) {

                            c = c + 1;
                        }
                    }
                    i++;
                });

                if (d == c) {
                    ParentIsNotChecked = false;
                }

                if (!ParentIsNotChecked) {
                    rdgRights.find("input[type='checkbox']")[0].checked = false;

                } else {
                    if (i > 0) {
                        rdgRights.find("input[type='checkbox']")[0].checked = true;
                    }
                }
            }


            function AddContactsToReminder() {
                for (var i = 0; i < window.parent.length; i++) {
                    if (typeof window.parent[i].AddContacts === 'function') {
                        window.parent[i].AddContacts();
                        break;
                    }
                }
                CloseRadWnd();
                return false;
            }



            function AddContactsToSubscription() {
                window.parent.AddContacts();
                CloseRadWnd();
                return false;
            }

            function OpenSessionPopup(SessionId) {
                var left = (screen.width - 720) / 2;
                var top = (screen.height - 570) / 2;
                window.open("https://studio.bluebeam.com/join.html?ID=" + SessionId, "_blanc", "width=440,height=220,top=" + top + ",left=" + left);
                return false;

            }


            function maintoolbarClick(sender, args) {
                var value = args.get_item().get_commandName();

                switch (value) {

                    case 'ToggleSplitter':
                        var pane = $find('rpLinkedRecords');
                        pane.set_visible(true)
                        var paneContent = pane._contentElement;
                        paneContent.style.display = "block";
                        break;
                }
            }
            function treeToolbarClick(sender, args) {
                if (args.get_item().get_commandName() == 'ToggleSplitter' || args.get_item().get_commandName() == 'SaveExit') {
                    var pane = $find('rpLinkedRecords');
                    pane.set_visible(false);
                    return false;
                }
            }
            function ClientResized(sender, ags) {

                setTimeout(FloatDivs, 100);
                var splitter = sender.get_parent();
                var pane1 = splitter._panes[0];
                var pane2 = splitter._panes[1];
                var pane1Td = pane1._element;
                pane2.set_width(splitter.get_width() - pane1Td.clientWidth - 10);


            }
        </script>

        <telerik:RadWindowManager ID="PMWindowManager" runat="server" Skin="Default" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
            Top="">
        </telerik:RadWindowManager>

        <asp:ScriptManager ID="PMScriptManager" runat="server" AsyncPostBackTimeout="1200">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <ClientEvents OnRequestStart="RequestStart" />
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="tbsDocument">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="mlpList" LoadingPanelID="ldpItems" />
                        <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rtvLinkedRecords">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgLinkedRecords" LoadingPanelID="ldpItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnTreeDropItems">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgLinkedRecords" LoadingPanelID="ldpItems" />
                        <telerik:AjaxUpdatedControl ControlID="rtvLinkedRecords" LoadingPanelID="ldpItems" />
                        <telerik:AjaxUpdatedControl ControlID="btnTreeDropItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rdgContacts">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgContacts" LoadingPanelID="ldpItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rdgLinkedRecords">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgLinkedRecords" LoadingPanelID="ldpItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="btnCreateBluebeamSession">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="tbl1" LoadingPanelID="ldpItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="TreeToolbar">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgLinkedRecords" LoadingPanelID="ldpItems" />
                        <telerik:AjaxUpdatedControl ControlID="rtvLinkedRecords" />
                        <telerik:AjaxUpdatedControl ControlID="TreeToolbar" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpItems" runat="server" Skin="Default" />

        <div class="PMMainPage" runat="server" id="trBluebeamSession" visible="false" style="padding-bottom: 24px">
            <div class="row">
                <div class="col-4 width440 col-4-left" style="padding-top: 5px">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth wide">
                                <div style="float: left">
                                    <asp:Label runat="server" ID="lblBluebeamSessionName" meta:resourcekey="lblBluebeamSessionName"></asp:Label>
                                </div>

                            </td>
                            <td class="controlWidth">
                                <asp:TextBox runat="server" ID="txtBluebeamSession" Width="100%"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvBluebeamSession" runat="server" ControlToValidate="txtBluebeamSession" ValidationGroup="save"
                                    CssClass="Validator" Display="Dynamic" ErrorMessage="<br>Required.11111" meta:Resourcekey="rfvBluebeamSessionRequired">
                                </asp:RequiredFieldValidator>
                            </td>

                        </tr>
                    </table>
                </div>
                <div class="col-4 width200 col-4-right">
                    <table class="colTable">
                        <tr>
                            <td>
                                <div>
                                    <asp:Button ID="btnCreateBluebeamSession" runat="server" Width="200px" ValidationGroup="save" meta:Resourcekey="btnCreateBluebeamSession" Text="Start Studio Session1" />
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

        <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="1"
            runat="server" MultiPageID="mlpList" Skin="Default" Width="100%" CssClass="CompaniesFilterTabs"
            CausesValidation="False">
            <Tabs>
                <telerik:RadTab Value="Bidders" Text="<%$Resources: Tab_Bidders%>" />
                <telerik:RadTab Value="CompaniesContact" Text="<%$Resources: Tab_CompaniesContact%>" Selected="true" />
                <telerik:RadTab Text="<%$Resources: Tab_DistributionList%>" Value="DistributionList"></telerik:RadTab>
            </Tabs>
        </telerik:RadTabStrip>

        <telerik:RadMultiPage ID="mlpList" runat="server" SelectedIndex="1" setwidth="true" AppendMenus="true"
            Width="100%" RenderSelectedPageOnly="True">
            <telerik:RadPageView ID="pvBiddes" runat="server">
                <uc1:Bidders ID="Bidders1" runat="server" />
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvDetails" runat="server" Selected="true">
                <div class="PMHeader">
                    <div class="row">
                        <div class="col-12">
                            <telerik:RadGrid ID="rdgContacts" AllowMultiRowSelection="true" runat="server" HeaderStyle-Font-Size="8" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" allow-scroll="true" SetWidth="true" AppendMenus="true"
                                Width="200px" AutoGenerateColumns="True" AllowFilteringByColumn="true" AllowSorting="true" ShowGroupPanel="True" AllowMultiRowEdit="true" ShowStatusBar="true" AllowPaging="True" PageSize="10" FitPageHeightOffset="5">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    ClientDataKeyNames="Id,Company,ContactText,Contact,Email" CommandItemDisplay="Top" InsertItemDisplay="Top"
                                    InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace" EnableHeaderContextMenu="true" HeaderStyle-Width="200px">
                                    <Columns>
                                        <telerik:GridTemplateColumn Reorderable="false" UniqueName="TemplateColumn" Groupable="False" AllowFiltering="false" HeaderStyle-Width="50px">
                                            <HeaderTemplate>
                                                <asp:CheckBox ID="chkAll" onClick="AllCheckClicked(this)" runat="server" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkSelect" onClick="SelectParent(this)" runat="server" />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn UniqueName="$Bound1$" Display="False" AllowFiltering="True" DataType="System.String">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridDateTimeColumn UniqueName="$Date1$" Display="False" AllowFiltering="True" DataType="System.DateTime">
                                        </telerik:GridDateTimeColumn>
                                    </Columns>
                                    <CommandItemTemplate>
                                        <table>
                                            <tr>
                                                <td runat="server" id="tdSpecs">
                                                    <table class="TableNoSpacingNoBorder">
                                                        <tr class="ToolBarTreePane">
                                                            <td class="labelWidth" style="background: #EDEDED !important; padding-left: 24px; box-sizing: border-box; padding-bottom: 0px !important; vertical-align: middle !important;">
                                                                <asp:Label ID="lblSpecification" runat="server" meta:resourcekey="lblSpecification" Visible="True"></asp:Label>

                                                            </td>
                                                            <td class="controlWidth" style="background: #EDEDED !important; padding-bottom: 0px !important;">
                                                                <telerik:RadComboBox ID="ddlSpecGroup" runat="server" Style="width: 240px !important;" AutoPostBack="true" AllowCustomText="true"
                                                                    OnSelectedIndexChanged="ddlSpecGroup_SelectedIndexChanged" Filter="Contains" MarkFirstMatch="true"
                                                                    SecurityButtonType="ItemMode"
                                                                    Visible="true">
                                                                </telerik:RadComboBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td>
                                                    <asp:LinkButton ID="btnUpdateEdited" runat="server" CommandName="SaveContacts" SecurityButtonType="AddEditMode_Edit"
                                                        ValidationGroup="DocumentAttachments" CssClass="GridCmdSaveContacts"
                                                        Visible="True">
                                                        <span class="Icon"></span>
                                                        <asp:Label runat="server" meta:resourcekey="lblSaveAndClose" ID="lblSaveAndClose"></asp:Label>
                                                        &nbsp;&nbsp;
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnSaveState" runat="server" SecurityButtonType="ItemMode" CausesValidation="False"
                                                        CommandName="SaveState" Font-Size="12px">
                                                        <asp:Label ID="Label1" runat="server"></asp:Label>
                                                    </asp:LinkButton>
                                                    <asp:LinkButton ID="btnLoadDefaultState" runat="server" SecurityButtonType="ItemMode"
                                                        CausesValidation="False" CommandName="LoadDefaultState" Font-Size="12px">
                                                        &nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label ID="Label2" runat="server"></asp:Label>
                                                    </asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </CommandItemTemplate>
                                </MasterTableView>
                                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="True" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder" Resizing-AllowColumnResize="True">
                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
                                    <ClientEvents OnRowClick="RowClick" />
                                </ClientSettings>
                            </telerik:RadGrid>
                        </div>
                    </div>
                </div>


            </telerik:RadPageView>

            <telerik:RadPageView ID="RadPageView1" runat="server">
                <table border="0" width="100%" cellpadding="0" cellspacing="0" class="ShowOnMobile paddingTop" style="height: 50px; background-color: RGB(237,237,237); background-image: none;">
                    <tr>
                        <td class="ToolbarTd">
                            <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="60px" CssClass="popup-toolbar" OnClientButtonClicked="maintoolbarClick">
                                <Items>
                                    <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarTreeSearch ShowOnMobile" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                                </Items>
                            </telerik:RadToolBar>
                        </td>
                        <td>
                            <telerik:RadComboBox ID="ddlEntitiesMobile" runat="server" AllowCustomText="true" Skin="Default"
                                Height="300px" OnClientTextChange="LOD_DropDownTextChange" EmptyMessage="-- Portfolio --"
                                Width="240px" AutoPostBack="True" NoWrap="true" CausesValidation="False"
                                ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True"
                                OnItemsRequested="ddl_ItemsRequested">
                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                            </telerik:RadComboBox>
                        </td>
                    </tr>
                </table>
                <table width="100%" cellspacing="0px" cellpadding="0px" border="0">
                    <tr>
                        <td>
                            <table style="width: 100%; height: 30px; background-color: RGB(237,237,237); background-image: none;" cellpadding="0" cellspacing="0" class="HideOnMobileToolbar">
                                <tr>
                                    <td style="padding-left: 16px;">
                                        <telerik:RadComboBox ID="ddlEntities" runat="server" AllowCustomText="true" Skin="Default"
                                            Height="300px" OnClientTextChange="LOD_DropDownTextChange" EmptyMessage="-- Portfolio --"
                                            Width="240px" AutoPostBack="True" NoWrap="true" CausesValidation="False"
                                            ShowMoreResultsBox="True" EnableLoadOnDemand="true" EnableVirtualScrolling="True"
                                            OnItemsRequested="ddl_ItemsRequested">
                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                            </table>
                            <telerik:RadSplitter ID="RadSplitter1" runat="server" Orientation="vertical" Skin="Default" CssClass="documentSplitter"
                                Width="100%" Height="540px">
                                <telerik:RadPane ID="rpLinkedRecords" runat="server" CssClass="NormalWhiteBack SplitterPanePopup" Width="420px" OnClientExpanded="ClientResized">
                                    <table border="0" width="100%" style="padding: 0; margin: 0px;" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td class="treeToolbar">
                                                <telerik:RadToolBar ID="TreeToolbar" runat="server" Height="50px" Skin="Default" AutoPostBack="true" Width="100%" CssClass="popup-toolbar ShowOnMobile" OnClientButtonClicked="treeToolbarClick">
                                                    <Items>
                                                        <telerik:RadToolBarButton EnableImageSprite="true" Height="50px" CssClass="ToolbarCheckMark  ShowOnMobile" CommandName="SaveExit"></telerik:RadToolBarButton>
                                                        <telerik:RadToolBarButton EnableImageSprite="true" Height="50px" CssClass="ToolbarCancel  ShowOnMobile" PostBack="false" CommandName="ToggleSplitter"></telerik:RadToolBarButton>
                                                    </Items>
                                                </telerik:RadToolBar>
                                            </td>
                                        </tr>
                                    </table>
                                    <table>
                                        <tr>
                                            <td>
                                                <telerik:RadTreeView ID="rtvLinkedRecords" runat="server" EnableDragAndDrop="True" AllowNodeEditing="false" CheckBoxes="true" TriStateCheckBoxes="true"
                                                    Skin="Default" MultipleSelect="true" OnClientNodeDropping="onNodeDropping" CssClass="treePaddingOnMobile fullHeight"
                                                    OnClientNodeDragging="onNodeDragging" OnClientNodeChecked="ShowHidebtnTreeDropItems">
                                                    <CollapseAnimation Type="OutQuint" Duration="100"></CollapseAnimation>
                                                    <ExpandAnimation Duration="100"></ExpandAnimation>
                                                </telerik:RadTreeView>
                                                <asp:LinkButton runat="server" ID="btnTreeDropItems" CssClass="Hide">
                                                    <div class="btnTreeDropItems">&nbsp;</div>
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                </telerik:RadPane>
                                <telerik:RadSplitBar ID="Splitter" runat="server" CollapseMode="Forward" />
                                <telerik:RadPane ID="RadContentPane" runat="server" CssClass="fullWidthPane" OnClientResized="ClientResized">
                                    <div id="LinkedRecordsPane" style="vertical-align: top;" class="NormalWhiteBack">
                                        <div class="PMMainPage PopupGridMargin PMPopupMainPage">
                                            <div class="row RowWithNoPaddingTop">
                                                <div class="col-12">
                                                    <telerik:RadGrid ID="rdgLinkedRecords" runat="server" AutoGenerateColumns="False" SetWidth="true" allow-scroll="true" AppendMenus="true"
                                                        ShowStatusBar="true" AllowMultiRowEdit="True" AllowMultiRowSelection="True" HeaderStyle-Font-Size="8" FitPageHeightOffset="5">
                                                        <MasterTableView DataKeyNames="Id,ObjectTypeId" CommandItemDisplay="Top" NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>">
                                                            <Columns>
                                                                <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Company" UniqueName="Company" HeaderStyle-Width="250px">
                                                                    <ItemTemplate>
                                                                        <span><%#IIf(Eval("Company") = String.Empty, "&nbsp;", Eval("Company"))%></span>
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>
                                                                <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Conatct" UniqueName="Contact" HeaderStyle-Width="250px">
                                                                    <ItemTemplate>
                                                                        <span><%#IIf(Eval("Code") & "-" & Eval("Contact") = "-", "&nbsp;", Eval("Code") & "-" & Eval("Contact"))%></span>
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>
                                                                <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Email" UniqueName="Email" HeaderStyle-Width="250px">
                                                                    <ItemTemplate>
                                                                        <span><%#IIf(Eval("Email") = String.Empty, "&nbsp;", Eval("Email"))%></span>
                                                                    </ItemTemplate>
                                                                </telerik:GridTemplateColumn>
                                                            </Columns>
                                                            <CommandItemTemplate>
                                                                <asp:LinkButton ID="btnUpdateEdited" runat="server"
                                                                    CommandName="SaveDistContacts" CssClass="GridCmdSaveDistContacts" SecurityButtonType="AddEditMode_Edit"
                                                                    Visible="True">
                                                                    <span class="Icon"></span>
                                                                    <asp:Label runat="server" meta:resourcekey="lblDistributionListSaveAndClose" ID="lblDistributionListSaveAndClose"></asp:Label>
                                                                    &nbsp;&nbsp;
                                                                </asp:LinkButton>
                                                                <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="False" CommandName="DeleteRows" CssClass="GridCmdDeleteRows"
                                                                    OnClientClick="return ConfirmDelete()" Visible="True">
                                                                    <span class="Icon"></span>
                                                                    <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                                                                    &nbsp;&nbsp;
                                                                </asp:LinkButton>
                                                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid">
                                                                    <span class="Icon"></span>
                                                                    <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                                                                    &nbsp;&nbsp;
                                                                </asp:LinkButton>
                                                            </CommandItemTemplate>
                                                        </MasterTableView>
                                                        <ClientSettings AllowColumnHide="false" AllowColumnsReorder="false"
                                                            AllowDragToGroup="false" AllowRowsDragDrop="false">
                                                            <Selecting AllowRowSelect="true" />
                                                            <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="false" ClipCellContentOnResize="true"
                                                                AllowColumnResize="True"></Resizing>
                                                        </ClientSettings>
                                                    </telerik:RadGrid>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </telerik:RadPane>
                            </telerik:RadSplitter>
                        </td>
                    </tr>
                </table>
            </telerik:RadPageView>
        </telerik:RadMultiPage>
        <asp:HiddenField ID="hdnCount" runat="server" Value="0" />


    </form>
</body>
</html>
