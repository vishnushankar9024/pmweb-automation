<%@ Page meta:resourcekey="PageTitle" Language="vb" AutoEventWireup="false" CodeBehind="DocumentTeamManagerPopup.aspx.vb" Inherits="Website.DocumentTeamManagerPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">


            function ValidateCombo(source, args) {

                var NoneValue = '<%= Me.JSEscape(Me.GetLocalResourceObject("None"))%>';
                args.IsValid = false;
                var combo = $find(source.controltovalidate);
                if (combo != null) {
                    var text = combo.get_text();
                    if (text.length < 1) {
                        args.IsValid = false;
                    }
                    else {
                        //var value = combo.get_value();
                        if (text.length > 0 && combo.get_text() == NoneValue) {
                            args.IsValid = false;
                        }
                        else {
                            args.IsValid = true;
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

            function RefreshGrids() {
                var btnRefresh = window.parent.$("[id$=btnRefreshGrids]")[0];
                if (btnRefresh) {
                    btnRefresh.click();
                }
                
            }
        </script>
    </telerik:RadCodeBlock>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager1" runat="server"></asp:ScriptManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%" CssClass="popup-toolbar">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit" ValidationGroup="Save" style="margin-right:-8px !important;"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage">
            <div class="row documentSinglePage" style="margin-bottom:24px !important;margin-left:16px !important;">
                <div class="col-4 col-4-left">
                    <asp:Label ID="lblWorkflowMsg" runat="server" CssClass="Validator" Visible="false"></asp:Label>
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth" style="width:160px !important;">
                                <asp:Label ID="lblSubmitter" runat="server" Text="Submitter" meta:resourcekey="lblSubmitter"></asp:Label>
                            </td>
                            <td class="controlWidth" style="width:240px !important;">
                                <asp:TextBox ID="txtSubmitter" runat="server" ReadOnly="true"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblRequestTeamInput" runat="server" Text="Request Team Input" meta:resourcekey="lblRequestCollaboration"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlRequestTeamInput" Height="150px" runat="server" meta:resourcekey="ddlRequestTeamInput" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                    AllowCustomText="True" Width="100%" Skin="Default" EnableItemCaching="false" OnClientDropDownClosing="OnClientDropDownClosing"
                                    OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="GetValueToReturn" OnClientSelectedIndexChanging="OnClientSelectedIndexChanging"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnClientDropDownClosed="OnClientDropDownClosed">
                                    <ItemTemplate>
                                        <div onclick="StopPropagation(event)" class="combo-item-template">
                                            <asp:CheckBox runat="server" ID="chkApply" />
                                        </div>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                <br />
                                <asp:CustomValidator ID="csvTeamInput" runat="server" ControlToValidate="ddlRequestTeamInput"
                                    ClientValidationFunction="ValidateCombo" Display="Dynamic" ValidationGroup="Save" meta:Resourcekey="csvTeamInput"
                                    CssClass="Validator">
                                </asp:CustomValidator>
                                <asp:RequiredFieldValidator ID="rfvTeamInput" runat="server" ControlToValidate="ddlRequestTeamInput"
                                    Display="Dynamic" ValidationGroup="Save" ErrorMessage="Required" meta:Resourcekey="rfvTeamInput"
                                    CssClass="Validator">
                                </asp:RequiredFieldValidator>
                                <asp:HiddenField runat="server" ID="hddnIds" />
                                <asp:HiddenField runat="server" ID="hddnNames" />
                                <asp:Button runat="server" CssClass="Hide" ID="btnRequestTeamInput" />
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCanEditRecord" runat="server" Text="Can Edit Record" meta:resourcekey="lblCanEditRecord"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <label runat="server" class="switch">
                                    <asp:CheckBox ID="chkCanEditRecord" runat="server" />
                                    <span class="slider round"></span>
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCanEditNotes" runat="server" Text="Can Edit Notes" meta:resourcekey="lblCanEditNotes"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <label runat="server" class="switch">
                                    <asp:CheckBox ID="chkCanEditNotes" runat="server" />
                                    <span class="slider round"></span>
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblCanEditAttachments" runat="server" Text="Can Edit Attachments" meta:resourcekey="lblCanEditAttachments"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <label runat="server" class="switch">
                                    <asp:CheckBox ID="chkCanEditAttachments" runat="server" />
                                    <span class="slider round"></span>
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth" >
                                <asp:Label ID="lblNotifyOnTeamChanges" runat="server" Text="Notify On Team Changes" meta:resourcekey="lblNotifyOnTeamChanges" ></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <label runat="server" class="switch">
                                    <asp:CheckBox ID="chkNotifyOnTeamChanges" runat="server" />
                                    <span class="slider round"></span>
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDueDate" runat="server" Text="Due Date" meta:resourcekey="lblDueDate"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <%-- <table cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="width: 130px">--%>
                                <telerik:RadDatePicker ID="dtpDueDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                    Width="100%" Skin="Default" Culture="English (United States)"
                                    EnableTyping="true" DatePopupButton-Visible="true">
                                    <DateInput ID="DateInput2" ReadOnly="false" runat="server"></DateInput>
                                </telerik:RadDatePicker>
                            </td>
                            <%--<td>
                                            <telerik:RadTimePicker ID="tmpDueDate" runat="server" Culture="English (United States)"
                                                EnableTyping="True" MaxDate="2100-01-01" MinDate="1901-01-01" Skin="Default" Width="120px">
                                                <dateinput id="DateInput1" runat="server" labelcssclass="radLabelCss_Office2007"
                                                    skin="Default">
                                            </dateinput>
                                                <calendar id="Calendar1" runat="server"   skin="Default">
                                            </calendar>
                                            </telerik:RadTimePicker>
                                        </td>--%>
                            <%--        </tr>
                                </table>
                            </td>--%>
                        </tr>
                           <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblMessage" runat="server" Text="Message" meta:resourcekey="lblMessage"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadTextBox ID="txtMessage" runat="server" TextMode="MultiLine" Width="100%" Height="80px" InputType="Text"></telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="width: 100%">
                                <fieldset>
                                    <legend>
                                        <asp:Label ID="lblTeamProgress" runat="server" Text="Team Progress" meta:resourcekey="lblTeamProgress"></asp:Label>
                                    </legend>
                                    <telerik:RadGrid ID="rdgTeamProgress" runat="server" AutoGenerateColumns="False" ShowStatusBar="False"
                                        Font-Size="8px" ShowGroupPanel="False" AllowMultiRowEdit="False" AllowMultiRowSelection="False"
                                        AllowSorting="False" GridLines="None" Width="100%" FitParentContainer="true" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true">

                                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" CommandItemDisplay="None" TableLayout="Fixed"
                                            Width="300px" UseAllDataFields="true" EnableHeaderContextMenu="False">

                                            <Columns>

                                                <telerik:GridTemplateColumn HeaderText="Team Member" UniqueName="TeamMember" ItemStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <%#Eval("TeamMemberName").ToString%>&nbsp;
                                                    </ItemTemplate>
                                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                                    <HeaderStyle Wrap="false" Width="200px" HorizontalAlign="Left" />
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn HeaderText="Progress" UniqueName="Progress" ItemStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblProgress" runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle Wrap="false" HorizontalAlign="Left" />
                                                    <HeaderStyle Wrap="false" Width="198px" HorizontalAlign="Left" />
                                                </telerik:GridTemplateColumn>

                                            </Columns>

                                        </MasterTableView>
                                        <ClientSettings AllowColumnHide="False" AllowColumnsReorder="False" AllowDragToGroup="False">
                                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="False" ClipCellContentOnResize="false"
                                                AllowColumnResize="False" />
                                            <Selecting AllowRowSelect="False" EnableDragToSelectRows="False" />
                                        </ClientSettings>
                                    </telerik:RadGrid>
                                </fieldset>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <asp:HiddenField runat="server" ID="hdnFirstLoad" Value="1"></asp:HiddenField>
    </form>
</body>
</html>
