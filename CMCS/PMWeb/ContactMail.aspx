<%@ Page Language="vb" Title="Contacts" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="ContactMail.aspx.vb" Inherits="Website.ContactMail" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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

    var currentToValue = '';
    var currentCCValue = '';
    var txtId = '';
    var CurrentToIds = ''
    var CurrentCCIds = ''


    function pageLoad() {
        txtId = $(window.parent.document).find("input[id$=hdnBtnId]").val();

            if (txtId == "txtTo") {
                currentToValue = $(window.parent.document).find("input[id$=txtTo]").val();
            }
            else { currentToValue = $(window.parent.document).find("input[id$=txtBCC]").val(); }

            CurrentToIds = $(window.parent.document).find("input[id$=hdnToIds]").val();

            currentCCValue = $(window.parent.document).find("input[id$=txtCC]").val();
            CurrentCCIds = $(window.parent.document).find("input[id$=hdnCCIds]").val();


        if (currentToValue != '') currentToValue = currentToValue + ';';
        if (currentCCValue != '') currentCCValue = currentCCValue + ';';

        if (CurrentToIds != '') CurrentToIds = CurrentToIds + ';';
        if (CurrentCCIds != '') CurrentCCIds = CurrentCCIds + ';';

    }

    function SelectParent(chk) {
        var grid = $find($("[id$=rdgContacts]")[0].id);

        var ToEmails = currentToValue;
        var ToIds = CurrentToIds;

        var CCEmails = currentCCValue;
        var CCIds = CurrentCCIds;

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

        if (txtId == "txtTo" || txtId == "txtBCC") {
            for (var i = 0; i < grid.MasterTableView.get_dataItems().length; i++) {
                if ($("#rdgContacts").find("input[type='checkbox']")[i].checked) {

                    var row = grid.MasterTableView.get_dataItems()[i];
                    var Email = row.getDataKeyValue("Email");
                    var Id = row.getDataKeyValue("Id");
                    if (ToIds == "" || ToIds.indexOf(Id) < 0) {
                        ToEmails = ToEmails + Email + ';';
                        ToIds = ToIds + Id + ';';
                    }
                    if (CCIds != "" && CCIds.indexOf(Id) >= 0) {
                        CCEmails = CCEmails.replace(Email + ';', "");
                        CCIds = CCIds.replace(Id + ';', "");
                    }

                }
                else {
                    var row = grid.MasterTableView.get_dataItems()[i];
                    var Email = row.getDataKeyValue("Email");
                    var Id = row.getDataKeyValue("Id");
                    if (ToIds != "" && ToIds.indexOf(Id) >= 0) {
                        ToEmails = ToEmails.replace(Email + ';', "");
                        ToIds = ToIds.replace(Id + ';', "");
                    }
                }
            }

            if (txtId == "txtTo") {
                $(window.parent.document).find("input[id$=txtTo]").val(ToEmails.replace(/;$/, ""));
            }
            else {
                $(window.parent.document).find("input[id$=txtBCC]").val(ToEmails.replace(/;$/, ""));
            }
            $(window.parent.document).find("input[id$=hdnToIds]").val(ToIds.replace(/;$/, ""));
            $(window.parent.document).find("input[id$=txtCC]").val(CCEmails.replace(/;$/, ""));
            $(window.parent.document).find("input[id$=hdnCCIds]").val(CCIds.replace(/;$/, ""));
        }
        else {
            for (var i = 0; i < grid.MasterTableView.get_dataItems().length; i++) {
                if ($("#rdgContacts").find("input[type='checkbox']")[i].checked) {

                    var row = grid.MasterTableView.get_dataItems()[i];
                    var Email = row.getDataKeyValue("Email");
                    var Id = row.getDataKeyValue("Id");
                    if (CCIds == "" || CCIds.indexOf(Id) < 0) {
                        CCEmails = CCEmails + Email + ';';
                        CCIds = CCIds + Id + ';';
                    }

                }
                else {
                    var row = grid.MasterTableView.get_dataItems()[i];
                    var Email = row.getDataKeyValue("Email");
                    var Id = row.getDataKeyValue("Id");
                    if (CCIds != "" && CCIds.indexOf(Id) >= 0) {
                        CCEmails = CCEmails.replace(Email + ';', "");
                        CCIds = CCIds.replace(Id + ';', "");
                    }
                }
            }
            
            $(window.parent.document).find("input[id$=txtCC]").val(CCEmails.replace(/;$/, ""));
            $(window.parent.document).find("input[id$=hdnCCIds]").val(CCIds.replace(/;$/, ""));
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
            </AjaxSettings>
        </telerik:RadAjaxManager>

  <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
                <tr id="trTbsDetails" runat="server">
                    <td>
                        <table width="100%" border="0">
                            <tr>
                                <td>
                                    <div class="PMHeader">
                                        <div class="row documentSinglePage">
                                            <div class="col-12">
                                                <table class="colTable" border="0"> 
            <%--<tr>
        <td>
        <div style ="display :inline ">
        <asp:Label ID ="lblSearch" CssClass ="Bold" runat ="server" Text ="Search:" meta:resourcekey="lblSearch" ></asp:Label>
        &nbsp;
        <asp:TextBox ID ="txtSearch" Width ="200px" AutoPostBack ="true" runat ="server" ></asp:TextBox>
        </div>
        </td>
    </tr>
    <tr>
        <td>
          <br />
        </td>
    </tr>--%>
            <tr>
                <td style="width: 50%">

                    <telerik:RadGrid ID="rdgContacts" AllowMultiRowSelection="false" runat="server" EnableHeaderContextFilterMenu="true" AllowFilteringByColumn="true"
                        ShowGroupPanel="false" HeaderStyle-Font-Size="8" 
                        AutoGenerateColumns="False" AllowSorting="true" ShowStatusBar="true" AllowPaging="true"
                        PageSize="250">
                        <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>

                        <MasterTableView ClientDataKeyNames="Email,Id" NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" Width="100%"
                            InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed">
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="false" />
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Select" UniqueName="MasterSelect" AllowFiltering="false"
                                    Groupable="false" Reorderable="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkIsIncluded" runat="server" CssClass="mobile-switch"
                                            onclick="SelectParent(this);" />
                                    </ItemTemplate>

                                    <HeaderStyle HorizontalAlign="Center" Width="35px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn SortExpression="CompanyName" HeaderText="Company" UniqueName="Company" AllowFiltering="true"
                                    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="CompanyName" Groupable="false">
                                    <ItemTemplate>
                                        <span><%#Eval("CompanyName").ToString%></span>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="70px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn SortExpression="ContactName" HeaderText="Contact" UniqueName="Contact" AllowFiltering="true"
                                   CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="ContactName" Groupable="false">
                                    <ItemTemplate>
                                        <span><%#Eval("ContactName").ToString%></span>&nbsp;
                                    </ItemTemplate>
                                    <HeaderStyle Width="50px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn SortExpression="Email" HeaderText="Email" UniqueName="Email" AllowFiltering="true"
                                    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataField="Email" Groupable="false">
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
