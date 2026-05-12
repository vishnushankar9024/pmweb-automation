<%@ Page Language="vb" meta:resourcekey="Page" Title="Team Input" AutoEventWireup="false" CodeBehind="WorkflowTeamInput.aspx.vb" Inherits="Website.WorkflowTeamInput" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        @media screen and (min-width:320px) and (max-width:827px) { 
            .width6col {
               width:400px !important;
            }
        }
        @media screen and (min-width:828px) {
            .width6col {
               width:424px !important;
            }
        }
    </style>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script src="JS/jQuery-v2.1.2.js" type="text/javascript"></script>
        <script src="JS/jQuery-migrate-1.1.1.js" type="text/javascript"></script>
        <script type="text/javascript">
            var MobileScreenWidth = 1024;
            //var isCommentsRequired = false;

            function OnClientLoad(sender, args) {
                var hdnFirstLoad = $("[id$=hdnFirstLoad]")[0];
                window.parent.TeamInputIds = '<%= PM.Workflow.DocumentInfo.TeamInputIds %>';

                //var txtAddCC = $("[id$=txtAddCC]")[0];
                //txtAddCC.value = $(window.parent.document).find("input[id$=txtAddCc]").val();
                //var RequireComments = '<//%= PM.Workflow.DocumentInfo.RequireComments%>';
                //if (RequireComments == 'True') isCommentsRequired = true;

                if (hdnFirstLoad.value == "1") {
                    $("textarea[id$='txtMessage']").val(window.parent.jQuery("textarea[id$='txtComments']").val());
                    hdnFirstLoad.value = "0"
                }
                //
            }

            function CloseTeamInputPopup() {
                //if (!(querySt('DocumentId') > 0)) {
                window.parent.TeamInputIds = '<%= PM.Workflow.DocumentInfo.TeamInputIds %>';
                window.parent.TeamInputPopup = '<%= PM.Workflow.DocumentInfo.IsTeamInputPopup %>';
                window.parent.jQuery("textarea[id$='txtComments']").val($("textarea[id$='txtMessage']").val());
                UpdateTeamInputAction();
                // }
                CloseRadWnd();
            }

            function ValidateCombo(source, args) {
                args.IsValid = false;
                var combo = $find(source.controltovalidate);
                if (combo != null) {
                    var text = combo.get_text();
                    if (text.length < 1) {
                        args.IsValid = false;
                    }
                    else {
                        var value = combo.get_value();
                        if (value > 0 || value == '') {
                            args.IsValid = true;
                        }
                        else {
                            args.IsValid = false;
                        }
                    }
                }
                else
                    args.IsValid = true;
            }


            var allowdropdownClose;
            function GetValueToReturn(combobox, eventArgs) {
                var hdn = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + 'hddnIds';
                var hdnField = $("[id$=" + hdn + "]")[0];
                var context = eventArgs.get_context();
                context["Ids"] = hdnField.value;
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

            function OnClientDropDownClosed(sender, args) {
                var btn = $("[id$=btnRequestTeamInput]");
                btn.click();
            }

            function check(sender, ddl, resultId, ResultName) {
                var combo = $find(ddl);
                var hdnNames = $("[id$=hddnNames]")[0];
                var hdnField = $("[id$=hddnIds]")[0];

                var vlue = hdnField.value;
                if (sender.checked) {
                    if (vlue.indexOf("0") == 0 && resultId != "0") {
                        hdnField.value = ""
                        hdnNames.value = "";
                        vlue = "";
                        var items = combo.get_items();
                        for (var i = 0; i < items.get_count() ; i++) {
                            var item = items.getItem(i);
                            if (item.get_value() == "0") {
                                var checkbox = item.get_element().getElementsByTagName("input")[0];
                                checkbox.checked = false;
                                break;
                            }
                        }
                    }
                    if (hdnField.value == '')
                        hdnField.value = resultId;
                    else
                        hdnField.value = vlue + ',' + resultId;
                    if (hdnNames.value == '') {
                        hdnNames.value = ResultName;
                        combo.set_text(ResultName)
                    }
                    else
                        hdnNames.value = hdnNames.value + ',' + ResultName;
                    combo.set_text(hdnNames.value)
                    if (resultId == "0") {
                        hdnField.value = resultId;
                        hdnNames.value = ResultName;
                        combo.set_text(ResultName)
                        var items = combo.get_items();
                        for (var i = 0; i < items.get_count() ; i++) {
                            var item = items.getItem(i);
                            if (item.get_value() != "0") {
                                var checkbox = item.get_element().getElementsByTagName("input")[0];
                                checkbox.checked = false;
                            }
                        }
                    }
                }
                else {
                    var results = vlue.split(',');
                    var resultNames = hdnNames.value.split(',');
                    var i = 0;
                    var newVal = '';
                    var newNames = '';
                    for (i = 0; i < results.length; i++) {
                        if (results[i] != resultId) {
                            if (newVal == '') {
                                newVal = results[i];
                            }
                            else {
                                newVal = newVal + ',' + results[i];
                            }
                        }
                    }
                    var find = 1
                    for (i = 0; i < resultNames.length; i++) {
                        if (resultNames[i] != ResultName || find == 0) {
                            if (newNames == '') {
                                newNames = resultNames[i];
                            }
                            else {
                                newNames = newNames + ',' + resultNames[i];
                            }
                        }
                        else
                            find = 0;
                    }
                    hdnField.value = newVal;
                    if (newNames != '') {
                        hdnNames.value = newNames;
                        combo.set_text(hdnNames.value)
                    }
                    else {
                        hdnNames.value = newNames;
                        combo.set_text(hdnNames.value)
                    }
                }

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

            //function cvComments_validate(sender, args) {
            //    if (isCommentsRequired == true) {
            //        if ($("textarea[id$='txtMessage']").val() == '') {
            //            args.IsValid = false;
            //        } else {
            //            args.IsValid = true;
            //        }

            //    } else {
            //        args.IsValid = true;
            //    }
            //}


        </script>
    </telerik:RadCodeBlock>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%" OnClientLoad="OnClientLoad">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" ValidationGroup="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" Value="SaveExit" CommandName="SaveExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage JustifyContent">
            <div class="PMHeader">
                <div class="row documentSinglePage">
                    <div class="col-6" style="padding-bottom:20px;">
                        <table class="colTable" style="width: 400px !important;">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblStep" runat="server" Text="Step" meta:resourcekey="lblStep"></asp:Label>
                                </td>
                                <td class="controlWidth" style="width: 240px !important;">
                                    <asp:TextBox ID="txtStep" runat="server" ReadOnly="True"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblApprover" runat="server" Text="Approver" meta:resourcekey="lblApprover"></asp:Label>
                                </td>
                                <td class="controlWidth" style="width: 240px !important;">
                                    <asp:TextBox ID="txtApprover" runat="server" ReadOnly="True"></asp:TextBox>
                                </td>
                            </tr>

                        </table>
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth" style="width: 160px !important;">
                                    <asp:Label ID="lblRequestTeamInput" runat="server" Text="Request Team Input" meta:resourcekey="lblRequestTeamInput"></asp:Label>
                                </td>
                                <td class="controlWidth" style="min-width: 240px !important;">
                                    <telerik:RadComboBox ID="ddlRequestTeamInput" Height="150px" runat="server" meta:resourcekey="ddlRequestTeamInput" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                        AllowCustomText="True" Width="100%" Skin="Default" EnableItemCaching="false" OnClientDropDownClosing="OnClientDropDownClosing"
                                        OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="GetValueToReturn" OnClientSelectedIndexChanging="OnClientSelectedIndexChanging"
                                        EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnClientDropDownClosed="OnClientDropDownClosed" Style="font-size: 11px">
                                        <ItemTemplate>
                                            <div onclick="StopPropagation(event)" class="combo-item-template">
                                                <asp:CheckBox runat="server" ID="chkApply" />
                                            </div>
                                        </ItemTemplate>
                                    </telerik:RadComboBox>
                                    <asp:Label ID="lblMsg" runat="server" CssClass="Validator" Visible="false"></asp:Label>
                                    <asp:HiddenField runat="server" ID="hddnIds" />
                                    <asp:HiddenField runat="server" ID="hddnNames" />
                                    <asp:Button runat="server" CssClass="Hide" ID="btnRequestTeamInput" />
                                </td>
                            </tr>
                            <tr id="trCurrentTeam" runat="server">
                                <td class="labelWidth">
                                    <asp:Label ID="lblCurrentTeam" runat="server" Text="Current Team" meta:resourcekey="lblCurrentTeam"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtCurrentTeam" runat="server" ReadOnly="True"></asp:TextBox>
                                </td>
                            </tr>
                            <tr id="trReviewedBy" runat="server">
                                <td class="labelWidth">
                                    <asp:Label ID="lblReviewedBy" runat="server" Text="Reviewed By" meta:resourcekey="lblReviewedBy"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtReviewedBy" runat="server" ReadOnly="True"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblCanEditRecord" runat="server" Text="Can Edit Record" meta:resourcekey="lblCanEditRecord"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:CheckBox ID="chkCanEditRecord" runat="server" class="mobile-switch" />
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblCanEditNotes" runat="server" Text="Can Edit Notes" meta:resourcekey="lblCanEditNotes"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:CheckBox ID="chkCanEditNotes" runat="server" class="mobile-switch" />
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblCanEditAttachments" runat="server" Text="Can Edit Attachments" meta:resourcekey="lblCanEditAttachments"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:CheckBox ID="chkCanEditAttachments" runat="server" class="mobile-switch" />
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblMessage" runat="server" Text="Message" meta:resourcekey="lblMessage"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <telerik:RadTextBox ID="txtMessage" runat="server" TextMode="MultiLine" Width="100%" Height="390px" InputType="Text"></telerik:RadTextBox>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-6 width6col">
                        <telerik:RadGrid ID="rdgTeamProgress" runat="server" AutoGenerateColumns="False" ShowStatusBar="False"
                            Font-Size="8px" ShowGroupPanel="False" AllowMultiRowEdit="False" AllowMultiRowSelection="False"
                            SetWidth="true" FitParentContainer="true" ClientSettings-Scrolling-AllowScroll="true" Width="400px"
                            AllowSorting="False" GridLines="None">
                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" CommandItemDisplay="None" TableLayout="Fixed"
                                Width="300px" UseAllDataFields="true" EnableHeaderContextMenu="False">
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="Team Member" UniqueName="TeamMember" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <%#Eval("TeamMemberName").ToString%>&nbsp;
                                        </ItemTemplate>
                                        <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                        <HeaderStyle Wrap="false" Width="218px" HorizontalAlign="Left" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="Progress" UniqueName="Progress" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <%#Eval("Progress").ToString%>&nbsp;
                                        </ItemTemplate>
                                        <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                        <HeaderStyle Wrap="false" Width="180px" HorizontalAlign="Left" />
                                    </telerik:GridTemplateColumn>
                                </Columns>
                            </MasterTableView>
                            <ClientSettings AllowColumnHide="False" AllowColumnsReorder="False" AllowDragToGroup="False">
                                <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="False" ClipCellContentOnResize="false"
                                    AllowColumnResize="False" />
                                <Selecting AllowRowSelect="False" EnableDragToSelectRows="False" />
                            </ClientSettings>
                        </telerik:RadGrid>
                    </div>
                </div>
            </div>
        </div>
        <asp:HiddenField runat="server" ID="hdnFirstLoad" Value="1"></asp:HiddenField>
        <%--<asp:TextBox runat="server" ID="txtAddCC" CssClass="Hide"></asp:TextBox>--%>
    </form>
</body>
</html>
