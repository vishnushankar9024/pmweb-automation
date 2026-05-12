<%@ Page Language="vb" Title="Contacts" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="CompanyContact.aspx.vb" Inherits="Website.CompanyContact" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
</head>
<script language="javascript" type="text/javascript">

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

    function SelectAll(chk) {
        $("#rdgContacts").find("input[type='checkbox']").each(function () {
            this.checked = chk.checked;
        });
        var Emails = '';
        var grid = $find($("[id$=rdgContacts]")[0].id);
        for (var i = 0; i < grid.MasterTableView.get_dataItems().length; i++) {
            var row = grid.MasterTableView.get_dataItems()[i];
            var Email = row.getDataKeyValue("Email");
            Emails = Emails + Email + ';';

        }
        $("input[id$=txtTo]").val(Emails.replace(/;$/, ""));
    }

    var currentValue = '';
    var currentComp = '';
    var txtId = '';
    var CurrentIds = ''
    function pageLoad() {
        txtId = $(window.parent.document).find("input[id$=hdnBtnId]").val();

        if (txtId == "txtTo" || txtId == "txtBCC") {
            if (txtId == "txtTo") {

                currentValue = $(window.parent.document).find("input[id$=txtTo]").val();

                currentComp = $(window.parent.document).find("textarea[id$=txtToCompany]").val();
            }
            else {
                currentValue = $(window.parent.document).find("input[id$=txtBCC]").val();
                currentComp = $(window.parent.document).find("textarea[id$=txtBCCCompany]").val();
            }
            CurrentIds = $(window.parent.document).find("input[id$=hdnIds]").val();
        }
        else {
            if (txtId == "txtCC") {
                currentValue = $(window.parent.document).find("input[id$=txtCC]").val();
                currentComp = $(window.parent.document).find("textarea[id$=txtCCCompany]").val();
            }
        }
        if (currentValue != '') currentValue = currentValue + ';';
        if (currentComp != '') currentComp = currentComp + '\n';
        if (CurrentIds != '') CurrentIds = CurrentIds + ';';

    }

    function SelectParent(chk) {


        var grid = $find($("[id$=rdgContacts]")[0].id);
        var Comp = currentComp;
        var Emails = currentValue;
        var Ids = CurrentIds;
        var FromId;
        var FromComp;
        var FromCont;
        if (querySt('OneSelect')) {
            if (querySt('OneSelect') == 'True') {

                for (var i = 0; i < grid.MasterTableView.get_dataItems().length; i++) {
                    var chki = $("#rdgContacts").find("input[type='checkbox']")[i];
                    if (chki.checked && (chki.id != chk.id)) {

                        chki.checked = false;

                    }
                }
            }

        }


        for (var i = 0; i < grid.MasterTableView.get_dataItems().length; i++) {
            if ($("#rdgContacts").find("input[type='checkbox']")[i].checked) {

                var row = grid.MasterTableView.get_dataItems()[i];
                var Email = row.getDataKeyValue("Email");
                var Company = row.getDataKeyValue("CompanyName");
                var contact = row.getDataKeyValue("ContactName");

                var Id = row.getDataKeyValue("Id");
                FromId = Id;
                FromCont = contact;
                FromComp = contact + ' ' + '[' + Company + ']';
                Emails = Emails + Email + ';';
                Comp = Comp + contact + ' ' + '[' + Company + ']' + '\n';

                Ids = Ids + Id + ';';
            }


        }
        if (txtId == "txtTo" || txtId == "txtBCC") {

            if (txtId == "txtTo") {

                $(window.parent.document).find("input[id$=txtTo]").val(Emails.replace(/;$/, ""));
                $(window.parent.document).find("textarea[id$=txtToCompany]").val(Comp.replace(/\n$/, ""));
            }
            else {
                $(window.parent.document).find("input[id$=txtBCC]").val(Emails.replace(/;$/, ""));
                $(window.parent.document).find("textarea[id$=txtBCCCompany]").val(Comp.replace(/\n$/, ""));
            }
            $(window.parent.document).find("input[id$=hdnIds]").val(Ids.replace(/;$/, ""));
        }
        else {
            if (txtId == "txtCC") {
                $(window.parent.document).find("input[id$=txtCC]").val(Emails.replace(/;$/, ""));
                $(window.parent.document).find("textarea[id$=txtCCCompany]").val(Comp.replace(/\n$/, ""));

            }
            else {
                $(window.parent.document).find("input[id$=txtFrom]").val(FromComp);
                $(window.parent.document).find("input[id$=hdnFromId]").val(FromId.replace(/;$/, ""));
                $(window.parent.document).find("input[id$=hdnFrom]").val(FromCont.replace(/;$/, ""));

            }
        }





        return false;
    }

</script>
<body>

    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" EnableSkinTransparency="true"
            BackgroundPosition="Center" Skin="Default" />
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" EnablePageHeadUpdate="true"
            DefaultLoadingPanelID="ldpPM">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgContacts">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgContacts" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="txtSearch">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgContacts" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>





        <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
            <tr id="trTbsDetails" runat="server">
                <td>
                    <table width="100%" border="0">
                        <tr>
                            <td>
                                <div class="PMHeader">
                                    <div class="row ">
                                        <div class="col-12">
                                            <table class="colTable" border="0">

                                                <tr>
                                                    <td>
                                                        <div style="display: inline">
                                                            <asp:Label ID="lblSearch" CssClass="Bold" runat="server" Text="Search:" meta:resourcekey="lblSearch"></asp:Label>
                                                            &nbsp;
        <asp:TextBox ID="txtSearch" Width="200px" AutoPostBack="true" runat="server"></asp:TextBox>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="100%">

                                                        <telerik:RadGrid ID="rdgContacts" AllowMultiRowSelection="false" runat="server"
                                                            ShowGroupPanel="false" HeaderStyle-Font-Size="8"
                                                            AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" AllowPaging="true"
                                                            PageSize="10">
                                                            <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>

                                                            <MasterTableView ClientDataKeyNames="Email,Id,CompanyName,ContactName" NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                                DataKeyNames="Id" Width="100%"
                                                                InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed">
                                                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="false" />
                                                                <Columns>
                                                                    <telerik:GridTemplateColumn HeaderText="Select" UniqueName="MasterSelect"
                                                                        Groupable="false" Reorderable="false">
                                                                        <ItemTemplate>
                                                                            <asp:CheckBox ID="chkIsIncluded" runat="server"
                                                                                onclick="SelectParent(this);" CssClass="mobile-switch" />
                                                                        </ItemTemplate>

                                                                        <HeaderStyle HorizontalAlign="Center" Width="35px"></HeaderStyle>
                                                                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                                                    </telerik:GridTemplateColumn>

                                                                    <telerik:GridTemplateColumn SortExpression="CompanyName" HeaderText="Company" UniqueName="Company"
                                                                        Groupable="false">
                                                                        <ItemTemplate>
                                                                            <span><%#Eval("CompanyName").ToString%></span>&nbsp;
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="70px"></HeaderStyle>
                                                                    </telerik:GridTemplateColumn>

                                                                    <telerik:GridTemplateColumn SortExpression="ContactName" HeaderText="Contact" UniqueName="Contact"
                                                                        Groupable="false">
                                                                        <ItemTemplate>
                                                                            <span><%#Eval("ContactName").ToString%></span>&nbsp;
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="50px"></HeaderStyle>
                                                                    </telerik:GridTemplateColumn>

                                                                    <telerik:GridTemplateColumn SortExpression="Email" HeaderText="Email" UniqueName="Email"
                                                                        Groupable="false">
                                                                        <ItemTemplate>
                                                                            <span><%#Eval("Email").ToString%></span>&nbsp;
                                                                        </ItemTemplate>
                                                                        <HeaderStyle Width="90px"></HeaderStyle>
                                                                    </telerik:GridTemplateColumn>

                                                                </Columns>
                                                            </MasterTableView>
                                                            <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                                            <ItemStyle Wrap="false" />
                                                            <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                                                            <ClientSettings EnableRowHoverStyle="False" AllowDragToGroup="True" AllowRowsDragDrop="False">
                                                                <Selecting AllowRowSelect="False" EnableDragToSelectRows="False" />
                                                                <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                                                    AllowColumnResize="True" />
                                                            </ClientSettings>
                                                        </telerik:RadGrid>

                                                    </td>
                                                </tr>


                                            </table>

                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
