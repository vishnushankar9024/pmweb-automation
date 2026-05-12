<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SelectUserPopup.aspx.vb"
    Inherits="Website.SelectUserPopup" meta:resourcekey="Page" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <style type="text/css">
        .documentTabs, .documentTabWithoutToolbar {
            position: fixed !important;
            top: 50px !important;
            z-index: 990 !important;
            background-color: #fff !important;
            padding-top: 5px !important;
        }

        .documentMultiPages {
            margin-top: 88px !important;
            margin-bottom: 36px !important;
        }

        .NoTab .rgDataDiv {
            height: calc(100vh - 179px) !important;
        }

        .RadWindow.rwReminder{
            z-index:12000 !important;
        }

        .circularProfile{
           border-radius:50%;
        }

        .RadGrid.RadGrid_Default .rgRow > td, .RadGrid.RadGrid_Default .rgAltRow > td {
            text-align:center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <script type="text/javascript">

            function pageLoad() {
                CheckParentBox();
                CheckBiddersParentBox();
                CheckRolesParentBox();
            }

            function AllCheckClicked(iObj) {
                var i = 0;
                var rdgRights = $("div[id$='rdgUsers']");
                var j = 0;
                var k = 0;
                rdgRights.find("input[type='checkbox']").each(function () {
                    if (i > 0) {
                        if (!this.disabled && this.id.indexOf("chkSelect") > 0) {
                            if (!this.checked)
                                j = j + 1;
                            if (this.checked)
                                k = k + 1;
                            this.checked = iObj.checked;
                        }

                    }
                    i++;
                });


                var Value = 0
                if (iObj.checked) {
                    Value = Value + j;
                }
                else {
                    if ((Value - k) >= 0)
                        Value = Value - k;
                }
            }

            function SelectParent(chk) {
                var rdgRights = $("div[id$='rdgUsers']");
                if (rdgRights.find("input[type='checkbox']")[0] == null) return;
                var chkPArent = rdgRights.find("input[type='checkbox']")[0];

                var i = 0;
                var isChecked = true;
                rdgRights.find("input[type='checkbox']").each(function () {
                    if (i > 0) {
                        if (chk.checked) {
                            if (!this.checked && this.id.indexOf("chkSelect") > 0) isChecked = false;
                        }
                    }
                    i++;
                });

                var Value = 0;
                if (!chk.checked) {
                    chkPArent.checked = false;
                    if (Value > 0)
                        Value = Value - 1;


                } else {
                    chkPArent.checked = isChecked;
                    Value = Value + 1;
                }

                return false;
            }

            function CheckParentBox() {
                var rdgRights = $("div[id$='rdgUsers']");
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

            function AllBiddersCheckClicked(iObj) {
                var i = 0;
                var rdgRights = $("div[id$='rdgBidders']");
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

                var Value = 0;
                if (iObj.checked) {
                    Value = Value + j;
                }
                else {
                    if ((Value - k) >= 0)
                        Value = Value - k;
                }
            }

            function BiddersSelectParent(chk) {
                var rdgRights = $("div[id$='rdgBidders']");
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

                var Value = 0

                if (!chk.checked) {
                    chkPArent.checked = false;
                    if (Value > 0)
                        Value = Value - 1;


                } else {
                    chkPArent.checked = isChecked;
                    Value = Value + 1;
                }
                return false;
            }

            function CheckBiddersParentBox() {
                var rdgRights = $("div[id$='rdgBidders']");
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

            function AllRolesCheckClicked(iObj) {
                var i = 0;
                var rdgRights = $("div[id$='rdgRoles']");
                var j = 0;
                var k = 0;
                rdgRights.find("input[type='checkbox']").each(function () {
                    if (i > 0) {
                        if (!this.disabled && this.id.indexOf("chkSelectRole") > 0) {
                            if (!this.checked)
                                j = j + 1;
                            if (this.checked)
                                k = k + 1;
                            this.checked = iObj.checked;
                        }
                    }
                    i++;
                });

                var Value = 0;
                if (iObj.checked) {
                    Value = Value + j;
                }
                else {
                    if ((Value - k) >= 0)
                        Value = Value - k;
                }
            }

            function RolesSelectParent(chk) {
                var rdgRights = $("div[id$='rdgRoles']");
                var chkPArent = rdgRights.find("input[type='checkbox']")[0];
                var i = 0;
                var isChecked = true;
                rdgRights.find("input[type='checkbox']").each(function () {
                    if (i > 0) {
                        if (chk.checked) {
                            if (!this.disabled && !this.checked && this.id.indexOf("chkSelectRole") > 0) isChecked = false;
                        }
                    }
                    i++;
                });

                var Value = 0

                if (!chk.checked) {
                    chkPArent.checked = false;
                    if (Value > 0)
                        Value = Value - 1;
                } else {
                    chkPArent.checked = isChecked;
                    Value = Value + 1;
                }
                return false;
            }

            function CheckRolesParentBox() {
                var rdgRights = $("div[id$='rdgRoles']");
                if (rdgRights.find("input[type='checkbox']")[0] == null) return;
                var ParentIsNotChecked = true;
                var i = 0;
                var d = 1;
                var c = 1;
                rdgRights.find("input[type='checkbox']").each(function () {
                    if (i > 0) {
                        if (!this.disabled && !this.checked) {
                            if (this.id.indexOf("chkSelectRole") > 0)
                                ParentIsNotChecked = false;
                        }
                        if (this.disabled) {
                            d = d + 1;
                        }
                        if (this.id.indexOf("chkSelectRole") > 0) {

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
                    if (typeof window.parent[i].AddUsers === 'function') {
                        window.parent[i].AddUsers();
                        break;
                    }
                }
                lo
                return false;
            }

            function AddUsersToBoxReminder() {
                for (var i = 0; i < window.parent.length; i++) {
                    if (typeof window.parent[i].AddUsers === 'function') {
                        window.parent[i].AddUsers();
                        break;
                    }
                }
                return false;
            }
            function AddUsersToBox() {

                if (typeof window.parent.AddUsers === 'function')
                                            window.parent.AddUsers();
            }
            function RowClick(sender, eventArgs) {
                if (querySt('Source') == 'WorkRequest') {
                    return SetWorkRequest(sender, eventArgs);
                }
            }

            function SetWorkRequest(sender, eventArgs) {
                var FirstName = eventArgs.getDataKeyValue("FirstName");
                var LastName = eventArgs.getDataKeyValue("LastName");
                var Email = eventArgs.getDataKeyValue("Email");
                var Cell = eventArgs.getDataKeyValue("Cell");
                var PhoneDay = eventArgs.getDataKeyValue("PhoneDay");
                var ExtDay = eventArgs.getDataKeyValue("DayExt");
                $(window.parent.document).find("[id$=txtContactName]").val(FirstName + ' ' + LastName);
                $(window.parent.document).find("[id$=txtCell]").val(Cell);
                $(window.parent.document).find("[id$=txtContactEmail]").val(Email);
                $(window.parent.document).find("[id$=txtContactPhoneDay]").val(PhoneDay);
                $(window.parent.document).find("[id$=txtContactPhoneDayExt]").val(ExtDay);
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
            function AddContactsToCC() {
                window.parent.AddUsersAndRolesToCC();
                return false;
            }
            function AddUsersToSuperUsers() {
                window.parent.AddUsersAndRolesToCC();
                return false;
            }

        </script>
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="tbsDocument">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="mlpList" LoadingPanelID="ldpItems" />
                        <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="mlpList">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="mlpList" LoadingPanelID="ldpItems" />
                        <telerik:AjaxUpdatedControl ControlID="tbsDocument" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rdgUsers">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgUsers" LoadingPanelID="ldpItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="rdgBidders">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgBidders" LoadingPanelID="ldpItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <%--<telerik:AjaxSetting AjaxControlID="rdgRoles">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgRoles" LoadingPanelID="ldpItems" />
                </UpdatedControls>
            </telerik:AjaxSetting>--%>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpItems" runat="server" Skin="Default" />

        <div id="ProfileTitle" class="ProfileTitle" runat="server" visible="false">
            
             <asp:label runat="server" ID="TitleUser"></asp:label>
    <asp:LinkButton runat="server" CssClass="closepopup closesize" ID="btnCloseProfilePopup" OnClientClick="window.close()">
        <div class="CloseProfilePopup closesize">
                                                                                 &nbsp;
                                                                            </div></asp:LinkButton>
    </div>

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0" runat="server" id="ToolBar">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar"
                        Width="100%">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <telerik:RadTabStrip OnClientTabSelecting="onTabSelecting" ID="tbsDocument" SelectedIndex="1" CssClass="documentTabs"
            runat="server" MultiPageID="mlpList" Skin="Default" Width="100%" CausesValidation="False" Style="top: 50px">
            <Tabs>
                <telerik:RadTab Value="Bidders" Text="<%$Resources: Tab_Bidders%>" />
                <telerik:RadTab Value="CompaniesContact" Text="<%$Resources: Tab_Users%>" Selected="true" />
                <telerik:RadTab Value="Roles" Text="<%$Resources: Tab_Roles%>" />
            </Tabs>
        </telerik:RadTabStrip>
        <telerik:RadMultiPage ID="mlpList" runat="server" SelectedIndex="1" Width="100%" CssClass="documentMultiPages" Style="margin-bottom: 0 !important"
            RenderSelectedPageOnly="True">
            <telerik:RadPageView ID="pvBiddes" runat="server">
                <div class="PMHeader">
                    <div class="row">
                        <div class="col-12 ResponsiveMargin">
                            <telerik:RadGrid ID="rdgBidders" AllowMultiRowSelection="true" runat="server"
                                FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                                HeaderStyle-Font-Size="8" AutoGenerateColumns="False" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                AllowFilteringByColumn="true" AllowSorting="true" ShowGroupPanel="True" AllowMultiRowEdit="true" ClientSettings-Resizing-AllowResizeToFit="true"
                                ShowStatusBar="true" AllowPaging="True">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    ClientDataKeyNames="Id" CommandItemDisplay="none" InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage"
                                    EditMode="InPlace" EnableHeaderContextMenu="true">
                                    <Columns>
                                        <telerik:GridTemplateColumn Reorderable="false" UniqueName="TemplateColumn" Groupable="False"
                                            AllowFiltering="false" HeaderStyle-Width="50px">
                                            <HeaderTemplate>
                                                <asp:CheckBox ID="chkAllBidders" onClick="AllBiddersCheckClicked(this)" runat="server" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkSelectBidder" onClick="BiddersSelectParent(this)" runat="server" />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="UserName"
                                            SortExpression="UserName" UniqueName="UserName" GroupByExpression="UserName [GridColumn_UserName] Group By UserName ASC"
                                            DataField="UserName" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <%# Eval("UserName").ToString%>&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="Contact"
                                            SortExpression="Contact" UniqueName="Contact" GroupByExpression="Contact [GridColumn_Contact] Group By Contact ASC"
                                            DataField="Contact" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <%# Eval("Contact").ToString%>&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle Width="120px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="First Name"
                                            SortExpression="FirstName" UniqueName="FirstName" GroupByExpression="FirstName [GridColumn_FirstName] Group By FirstName ASC"
                                            DataField="FirstName" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <%# Eval("FirstName").ToString%>&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="Last Name"
                                            SortExpression="LastName" UniqueName="LastName" GroupByExpression="LastName [GridColumn_LastName] Group By LastName ASC"
                                            DataField="LastName" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <%# Eval("LastName").ToString%>&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="Company"
                                            SortExpression="Company" UniqueName="Company" GroupByExpression="Company [GridColumn_Company] Group By Company ASC"
                                            DataField="Company" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <%# Eval("Company").ToString%>&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle Width="120px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="Group"
                                            SortExpression="Group" UniqueName="Group" GroupByExpression="Company [GridColumn_Group] Group By Group ASC"
                                            DataField="Group" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <%# Eval("Group").ToString%>&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="Email"
                                            SortExpression="Email" UniqueName="Email" GroupByExpression="Email [GridColumn_Email] Group By Email ASC"
                                            DataField="Email" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <%# Eval("Email").ToString%>&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="Cell"
                                            SortExpression="Cell" UniqueName="Cell" GroupByExpression="Cell [GridColumn_Cell] Group By Cell ASC"
                                            DataField="Cell" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <%# Eval("Cell").ToString%>&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                </MasterTableView>
                                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="True" AllowColumnsReorder="true"
                                    ColumnsReorderMethod="Reorder" Resizing-AllowColumnResize="True">
                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
                                </ClientSettings>
                            </telerik:RadGrid>
                        </div>
                    </div>
                </div>
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvDetails" runat="server" Selected="true">
                <div class="PMHeader">
                    <div class="row">
                        <div class="col-12 ResponsiveMargin">
                            <telerik:RadGrid ID="rdgUsers" AllowMultiRowSelection="true" runat="server" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                                HeaderStyle-Font-Size="8" Width="100%" AutoGenerateColumns="False" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                AllowFilteringByColumn="true" AllowSorting="true" ShowGroupPanel="True" AllowMultiRowEdit="true"
                                ShowStatusBar="true" AllowPaging="True" PageSize="10">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    ClientDataKeyNames="Id,FirstName,LastName,Email,Cell,PhoneDay,DayExt" CommandItemDisplay="none"
                                    InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace"
                                    EnableHeaderContextMenu="true">
                                    <Columns>
                                        <telerik:GridTemplateColumn Reorderable="false" UniqueName="TemplateColumn" Groupable="False"
                                            AllowFiltering="false" HeaderStyle-Width="50px">
                                            <HeaderTemplate>
                                                <asp:CheckBox ID="chkAll" onClick="AllCheckClicked(this)" runat="server" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkSelect" onClick="SelectParent(this)" runat="server" />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                         <telerik:GridTemplateColumn Visible="false" HeaderText="Image" UniqueName="Image"  AllowFiltering="false" Groupable="false">
                                            <ItemTemplate>
                                                <asp:Image ID="imgImage" CssClass="circularProfile" runat="server" Height="45px" Width="45px" />
                                                
                                            </ItemTemplate>
                                            <HeaderStyle Width="120px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="UserName"
                                            SortExpression="UserName" UniqueName="UserName" GroupByExpression="UserName [GridColumn_UserName] Group By UserName ASC"
                                            DataField="UserName" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <%# Eval("UserName").ToString%>&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="Contact"
                                            SortExpression="Contact" UniqueName="Contact" GroupByExpression="Contact [GridColumn_Contact] Group By Contact ASC"
                                            DataField="Contact" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <%# Eval("Contact").ToString%>&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle Width="120px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="First Name"
                                            SortExpression="FirstName" UniqueName="FirstName" GroupByExpression="FirstName [GridColumn_FirstName] Group By FirstName ASC"
                                            DataField="FirstName" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <%# Eval("FirstName").ToString%>&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="Last Name"
                                            SortExpression="LastName" UniqueName="LastName" GroupByExpression="LastName [GridColumn_LastName] Group By LastName ASC"
                                            DataField="LastName" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <%# Eval("LastName").ToString%>&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="Company"
                                            SortExpression="Company" UniqueName="Company" GroupByExpression="Company [GridColumn_Company] Group By Company ASC"
                                            DataField="Company" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <%# Eval("Company").ToString%>&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle Width="120px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="Group"
                                            SortExpression="Group" UniqueName="Group" GroupByExpression="Company [GridColumn_Group] Group By Group ASC"
                                            DataField="Group" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <%# Eval("Group").ToString%>&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="Email"
                                            SortExpression="Email" UniqueName="Email" GroupByExpression="Email [GridColumn_Email] Group By Email ASC"
                                            DataField="Email" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <%# Eval("Email").ToString%>&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="Phone(Day)"
                                            SortExpression="PhoneDay" UniqueName="PhoneDay" GroupByExpression="PhoneDay [GridColumn_PhoneDay] Group By PhoneDay ASC"
                                            DataField="PhoneDay" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <%# Eval("PhoneDay").ToString%>&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="Ext(Day)"
                                            SortExpression="DayExt" UniqueName="DayExt" GroupByExpression="DayExt [GridColumn_DayExt] Group By DayExt ASC"
                                            DataField="DayExt" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <%# Eval("DayExt").ToString%>&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="Cell"
                                            SortExpression="Cell" UniqueName="Cell" GroupByExpression="Cell [GridColumn_Cell] Group By Cell ASC"
                                            DataField="Cell" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <%# Eval("Cell").ToString%>&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                </MasterTableView>
                                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="True" AllowColumnsReorder="true"
                                    ColumnsReorderMethod="Reorder" Resizing-AllowColumnResize="True">
                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
                                    <ClientEvents OnRowClick="RowClick" />
                                </ClientSettings>
                            </telerik:RadGrid>
                        </div>
                    </div>
                </div>
            </telerik:RadPageView>
            <telerik:RadPageView ID="pvRoles" runat="server">
                <div class="PMHeader">
                    <div class="row">
                        <div class="col-12 ResponsiveMargin">
                            <telerik:RadGrid ID="rdgRoles" AllowMultiRowSelection="true" runat="server" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
                                HeaderStyle-Font-Size="8" Width="100%" AutoGenerateColumns="False" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                AllowFilteringByColumn="true" AllowSorting="true" ShowGroupPanel="True" AllowMultiRowEdit="true"
                                ShowStatusBar="true" AllowPaging="True" PageSize="10">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    ClientDataKeyNames="Id,FirstName,LastName,Email,Cell" CommandItemDisplay="none"
                                    InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace"
                                    EnableHeaderContextMenu="true">
                                    <Columns>
                                        <telerik:GridTemplateColumn Reorderable="false" UniqueName="TemplateColumn" Groupable="False"
                                            AllowFiltering="false" HeaderStyle-Width="50px">
                                            <HeaderTemplate>
                                                <asp:CheckBox ID="chkAllRoles" onClick="AllRolesCheckClicked(this)" runat="server" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkSelectRole" onClick="RolesSelectParent(this)" runat="server" />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="<%$Resources: GridColumn_Role %>"
                                            SortExpression="RoleName" UniqueName="RoleName" GroupByExpression="RoleName [GridColumn_RoleName] Group By RoleName ASC"
                                            DataField="RoleName" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <%# Eval("RoleName").ToString%>&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle Width="180px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="110px" ItemStyle-Wrap="false" HeaderText="<%$Resources: GridColumn_Level %>"
                                            SortExpression="Level" UniqueName="Level" GroupByExpression="Level [GridColumn_Level] Group By Level ASC"
                                            DataField="Level" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <asp:Label ID="lblLevel" runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle Width="180px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="<%$Resources: GridColumn_UserName %>"
                                            SortExpression="UserName" UniqueName="UserName" GroupByExpression="UserName [GridColumn_UserName] Group By UserName ASC"
                                            DataField="UserName" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <%# Eval("UserName").ToString%>&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="<%$Resources: GridColumn_Contact %>"
                                            SortExpression="Contact" UniqueName="Contact" GroupByExpression="Contact [GridColumn_Contact] Group By Contact ASC"
                                            DataField="Contact" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <%# Eval("Contact").ToString%>&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle Width="120px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="<%$Resources: GridColumn_FirstName %>"
                                            SortExpression="FirstName" UniqueName="FirstName" GroupByExpression="FirstName [GridColumn_FirstName] Group By FirstName ASC"
                                            DataField="FirstName" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <%# Eval("FirstName").ToString%>&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="<%$Resources: GridColumn_LastName %>"
                                            SortExpression="LastName" UniqueName="LastName" GroupByExpression="LastName [GridColumn_LastName] Group By LastName ASC"
                                            DataField="LastName" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <%# Eval("LastName").ToString%>&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="<%$Resources: GridColumn_Company %>"
                                            SortExpression="Company" UniqueName="Company" GroupByExpression="Company [GridColumn_Company] Group By Company ASC"
                                            DataField="Company" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <%# Eval("Company").ToString%>&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle Width="120px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="<%$Resources: GridColumn_Group %>"
                                            SortExpression="Group" UniqueName="Group" GroupByExpression="Company [GridColumn_Group] Group By Group ASC"
                                            DataField="Group" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <%# Eval("Group").ToString%>&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="<%$Resources: GridColumn_Email %>"
                                            SortExpression="Email" UniqueName="Email" GroupByExpression="Email [GridColumn_Email] Group By Email ASC"
                                            DataField="Email" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <%# Eval("Email").ToString%>&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="<%$Resources: GridColumn_Cell %>"
                                            SortExpression="Cell" UniqueName="Cell" GroupByExpression="Cell [GridColumn_Cell] Group By Cell ASC"
                                            DataField="Cell" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType"
                                            AutoPostBackOnFilter="true">
                                            <ItemTemplate>
                                                <%# Eval("Cell").ToString%>&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle Width="100px"></HeaderStyle>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                </MasterTableView>
                                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="True" AllowColumnsReorder="true"
                                    ColumnsReorderMethod="Reorder" Resizing-AllowColumnResize="True">
                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
                                    <ClientEvents OnRowClick="RowClick" />
                                </ClientSettings>
                            </telerik:RadGrid>
                        </div>
                    </div>
                </div>
            </telerik:RadPageView>
        </telerik:RadMultiPage>
    </form>
</body>
</html>
