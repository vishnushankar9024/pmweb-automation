<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="AuditTrail.aspx.vb" Inherits="Website.AuditTrail" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">
    <asp:PlaceHolder ID="phAudit" runat="server"></asp:PlaceHolder>

    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RDG">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RDG" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">

        <script language="javascript" type="text/javascript">

            function Audit_StopPropagation(sender, args) {
                var Items = $('[id$=' + sender.get_id() + '_DropDown' + '] .rcbItem.rcbTemplate');
                for (var i = 0; i < Items.length; i++) {
                    Items[i].onclick = stop;
                }
            }

            function dllSelectedIndexChanged(combobox, eventArgs) {
            }


            function removeFirstSemiColon(str) {
                return str.replace(/^;/, "");
            }


            var CalculateChanges = true;
            function sldDate_Changed(sender, args) {
                if (!CalculateChanges) return;
                var dtFrom = new Date();
                var hdnDateFormat = $("[id$=hdnDateFormat]");
                dtFrom.setDate(dtFrom.getDate() + sender.get_selectionStart());
                var dtTo = new Date();
                dtTo.setDate(dtTo.getDate() + sender.get_selectionEnd());
                $('#lblFromDate').html('Date Filter:   ' + dtFrom.format(hdnDateFormat[0].value));
                $('#lblToDate').html(dtTo.format(hdnDateFormat[0].value));
                var rdpStartDate = $find($("[id$=rdpStartDate]")[0].id);
                var rdpEndtDate = $find($("[id$=rdpEndDate]")[0].id);
                CalculateChanges = false;
                if (rdpStartDate && rdpStartDate._dateInput) rdpStartDate._dateInput.set_selectedDate(dtFrom);
                if (rdpEndtDate && rdpEndtDate._dateInput) rdpEndtDate._dateInput.set_selectedDate(dtTo);
                CalculateChanges = true;
            }

            function Audit_DateInputValueChanging(sender, args) {
                if (args.get_newValue() == '') {
                    args.set_cancel(true);
                    return;
                }
                //var CurrDateDiff = new Date(args.get_newValue()).getTime() - new Date().getTime();
                //CurrDateDiff = Math.ceil(CurrDateDiff / (1000 * 3600 * 24));
                //var sldDate = $find($("[id$=sldDate]")[0].id);
                //if (sender.get_element().id.indexOf('rdpStartDate') > -1) {
                //    if (sldDate.get_selectionEnd() < CurrDateDiff || CurrDateDiff < sldDate.get_minimumValue()) args.set_cancel(true);
                //} else {
                //    if (sldDate.get_selectionStart() > CurrDateDiff || CurrDateDiff > sldDate.get_maximumValue()) args.set_cancel(true);
                //}
            }

            function Audit_DateInputChanged(sender, args) {
                if (!CalculateChanges) return;
                var sldDate = $find($("[id$=sldDate]")[0].id);
                var hdnDateFormat = $("[id$=hdnDateFormat]");
                var CurrDate = new Date();
                CurrDate = new Date(CurrDate.getFullYear(), CurrDate.getMonth(), CurrDate.getDate());
                var CurrDateDiff = Date.UTC(sender.get_selectedDate().getFullYear(), sender.get_selectedDate().getMonth(), sender.get_selectedDate().getDate(), 0, 0, 0, 0) - Date.UTC(CurrDate.getFullYear(), CurrDate.getMonth(), CurrDate.getDate(), 0, 0, 0, 0);
                CurrDateDiff = Math.ceil(CurrDateDiff / (1000 * 3600 * 24));
                var lblDate = new Date();
                lblDate.setDate(lblDate.getDate() + CurrDateDiff);
                CalculateChanges = false;
                if (sender.get_element().id.indexOf('rdpStartDate') > -1) {
                    if (sldDate.get_selectionEnd() < CurrDateDiff) {
                        $find($("[id$=rdpEndDate]")[0].id).set_selectedDate(sender.get_selectedDate());
                        sldDate.set_selectionEnd(CurrDateDiff);
                        $('#lblToDate').html(lblDate.format(hdnDateFormat[0].value));
                    }
                    sldDate.set_selectionStart(CurrDateDiff);
                    $('#lblFromDate').html('Date Filter:   ' + lblDate.format(hdnDateFormat[0].value));
                } else {
                    if (sldDate.get_selectionStart() > CurrDateDiff) {
                        $find($("[id$=rdpStartDate]")[0].id).set_selectedDate(sender.get_selectedDate());
                        sldDate.set_selectionStart(CurrDateDiff);
                        $('#lblFromDate').html('Date Filter:   ' + lblDate.format(hdnDateFormat[0].value));
                    }
                    sldDate.set_selectionEnd(CurrDateDiff);
                    $('#lblToDate').html(lblDate.format(hdnDateFormat[0].value));
                }
                CalculateChanges = true;
            }  

            function Audit_GetValueToReturn(combo, eventArgs) {
                if ((combo.get_items().get_count() == 0 && combo.get_value() != '') || typeof $(combo).attr('InitialText') === 'undefined') {
                    $(combo).attr('InitialText', eventArgs.get_context()["Text"]);
                }
                var PreClientId = '';
                var ServerId = combo.get_id();
                if (ServerId.lastIndexOf('_') >= 0) {
                    ServerId = ServerId.substring(ServerId.lastIndexOf('_') + 1, ServerId.length);
                    PreClientId = combo.get_id().substring(0, combo.get_id().lastIndexOf('_') + 1);
                }
                var hdnField = null
                if ($("[id$=" + PreClientId + 'hddn' + ServerId + 'Values' + "]").length > 0)
                    hdnField = $("[id$=" + PreClientId + 'hddn' + ServerId + 'Values' + "]")[0];
                if (hdnField == null) hdnField = $("[id$=" + 'CPH1_' + 'hddn' + ServerId + 'Values' + "]")[0];
                var context = eventArgs.get_context();
                context["Ids"] = hdnField.value;
               
            }

            function CheckComboItem(sender, ComboClientId, SelectedValue) {
                var combo = $find(ComboClientId);
                var SelectedName = combo.findItemByValue(SelectedValue).get_text();
                var PreClientId = '';
                var ServerId = combo.get_id();
                if (ServerId.lastIndexOf('_') >= 0) {
                    ServerId = ServerId.substring(ServerId.lastIndexOf('_') + 1, ServerId.length);
                    PreClientId = combo.get_id().substring(0, combo.get_id().lastIndexOf('_') + 1);
                }
                var hdnNames = null;
                var hdnValues = null;
                if ($("[id$=" + PreClientId + 'hddn' + ServerId + 'Names' + "]").length>0)
                    hdnNames = $("[id$=" + PreClientId + 'hddn' + ServerId + 'Names' + "]")[0];
                if($("[id$=" + PreClientId + 'hddn' + ServerId + 'Values' + "]").length>0)
                 hdnValues = $("[id$=" + PreClientId + 'hddn' + ServerId + 'Values' + "]")[0];
                if (hdnNames == null) hdnNames=$("[id$=" + 'CPH1_' + 'hddn' + ServerId + 'Names' + "]")[0];
                if (hdnValues == null) hdnValues=$("[id$=" + 'CPH1_' + 'hddn' + ServerId + 'Values' + "]")[0];
                var isChecked = true;
                var text = hdnNames.value;
                var values = hdnValues.value;
                var items = combo.get_items();
                var chkParent;
                var AllItem = combo.findItemByValue('0');
                if (AllItem)
                    chkParent = $(AllItem.get_element()).find("input[type='checkbox']")[0];
                if (SelectedValue == '0') {
                    values = '0';
                    var j = 0;
                    if (AllItem)
                        text = AllItem.get_text();
                    else
                        text = TranslatedAll;
                    $("#" + ComboClientId + "_DropDown").find("input[type='checkbox']").each(function () {
                        var item = items.getItem(j);
                        var itemValue = item.get_value();
                        if (itemValue != '0') {
                            this.checked = false;
                        }
                        j++;
                    });
                } else {
                    if (sender.checked) {
                        if (values == '0') {
                            values = SelectedValue;
                            text = SelectedName;
                        }
                        else {
                            values = values + ' ; ' + SelectedValue;
                            text = text + ' ; ' + SelectedName;
                        }
                    } else {
                        var results = values.split(' ; ');
                        var SelectedNames = text.split(' ; ');
                        values = '';
                        text = '';
                        var i = 0;
                        for (i = 0; i < results.length; i++) {
                            if (results[i] != SelectedValue)
                                values = values + ' ; ' + results[i];
                        }
                        var find = 1
                        for (i = 0; i < SelectedNames.length; i++) {
                            if (SelectedNames[i] != SelectedName || find == 0) {
                                text = text + ' ; ' + SelectedNames[i];
                            }
                            else
                                find = 0;
                        }
                    }
                }
                text = removeFirstSemiColon(text.trim()).trim();
                values = removeFirstSemiColon(values.trim()).trim();
                if (values == '') {
                    values = '0';
                    if (AllItem)
                        text = AllItem.get_text();
                    else
                        text = TranslatedAll;
                }
                if (AllItem)
                    chkParent.checked = (values == '0');
                hdnValues.value = values;
                if (text.length > 0) {
                    combo.set_text(text);
                    hdnNames.value = text;
                }
                else {
                    combo.set_text("");
                    hdnNames.value = "";
                }
                return false;
            }

            function Audit_RowDblClick(sender, args) {
                var AuditId = args.getDataKeyValue("Id");
                OpenTrailDetails(AuditId);
            }

            function OpenTrailDetails(AuditId) {
                return OpenPOPUp('AuditTrailPopup.aspx?AuditTrailId=' + AuditId.toString(), 850, 500, false);
            }
            function IntegerOnly(event) {
                var evt = event ? event : window.event;
                var c = evt.keyCode;
                if (c < 48 || c > 57)
                    return false;
            }
          
        </script>
    </telerik:RadCodeBlock>
    <style>
        .rslTrack, .RadSlider.RadSlider_Default, .rslHorizontal {
            width: 100% !important;
        }

        .RadPicker table.rcTable {
            border: 0;
            margin: 0;
            padding: 0;
        }
    </style>
    <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0" class="AuditTrailOnMobile">
        <tr>
            <td>
                <div class="PMMainPage">
                    <div class="row">
                        <div class="col-4 col-4-left">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblSystemId" runat="server" Text="System ID" meta:resourcekey="lblSystemId"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtSystemId" MaxLength="10" runat="server" Width="100%" style="text-align:right"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblProjects" runat="server" Text="Project(s)" meta:resourcekey="lblProjects"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlProjects" runat="server" Width="100%" OnClientItemsRequested="Audit_StopPropagation"
                                            CloseDropDownOnBlur="true" EnableItemCaching="false" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                            NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllSelectedIndexChanged"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="Audit_GetValueToReturn" Height="250px">
                                            <ItemTemplate>
                                                <div class="combo-item-template">
                                                    <asp:CheckBox runat="server" ID="chk" />
                                                    <asp:Label runat="server" ID="Label3" AssociatedControlID="chk"></asp:Label>
                                                    <%#DataBinder.Eval(Container, "Text")%>
                                                </div>
                                            </ItemTemplate>
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                        <asp:HiddenField runat="server" ID="hddnddlProjectsValues" Value="0" />
                                        <asp:HiddenField runat="server" ID="hddnddlProjectsNames" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblUsers" runat="server" Text="User(s)" meta:resourcekey="lblUsers"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlUsers" runat="server" Width="100%" CloseDropDownOnBlur="true" EnableItemCaching="false" OnClientItemsRequested="Audit_StopPropagation"
                                            NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllSelectedIndexChanged"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="Audit_GetValueToReturn"
                                            Height="250px" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                            <ItemTemplate>
                                                <div class="combo-item-template">
                                                    <asp:CheckBox runat="server" ID="chk" />
                                                    <asp:Label runat="server" ID="Label3" AssociatedControlID="chk"></asp:Label>
                                                    <%#DataBinder.Eval(Container, "Text")%>
                                                </div>
                                            </ItemTemplate>
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                        <asp:HiddenField runat="server" ID="hddnddlUsersValues" Value="0" />
                                        <asp:HiddenField runat="server" ID="hddnddlUsersNames" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblNbrOfTransactions" runat="server" Text="Last (N) Transactions" meta:resourcekey="lblNbrOfTransactions"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtNbrOfTransactions" runat="server" Width="100%" CssClass="PositiveInteger" maxnumber="10000"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-middle">
                            <table class="colTable" border="0">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRecordTypes" runat="server" Text="Record Type(s)" meta:resourcekey="lblRecordTypes"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlRecordTypes" runat="server" Width="100%" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                            CloseDropDownOnBlur="true" EnableItemCaching="false" OnClientItemsRequested="Audit_StopPropagation"
                                            NoWrap="True" AllowCustomText="true" OnClientSelectedIndexChanged="dllSelectedIndexChanged"
                                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                            OnItemsRequested="ddl_ItemsRequested" OnClientItemsRequesting="Audit_GetValueToReturn" Height="250px">
                                            <ItemTemplate>
                                                <div class="combo-item-template">
                                                    <asp:CheckBox runat="server" ID="chk" />
                                                    <asp:Label runat="server" ID="Label3" AssociatedControlID="chk"></asp:Label>
                                                    <%#DataBinder.Eval(Container, "Text")%>
                                                </div>
                                            </ItemTemplate>
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                        <asp:HiddenField runat="server" ID="hddnddlRecordTypesValues" Value="0" />
                                        <asp:HiddenField runat="server" ID="hddnddlRecordTypesNames" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRecord" runat="server" Text="Record" meta:resourcekey="lblRecord"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <asp:TextBox ID="txtRecord" MaxLength="500" runat="server" Width="100%"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblRecordTabs" runat="server" Text="Record Tabs(s)" meta:resourcekey="lblRecordTabs"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlRecordTabs" runat="server" Width="100%" AllowCustomText="true" OnClientDropDownOpened="Audit_StopPropagation"
                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>" Filter="Contains" MarkFirstMatch="true"> 
                                            <ItemTemplate>
                                                <div class="combo-item-template">
                                                    <asp:CheckBox runat="server" ID="chk" />
                                                    <asp:Label runat="server" ID="Label3" AssociatedControlID="chk"></asp:Label>
                                                    <%#DataBinder.Eval(Container, "Text")%>
                                                </div>
                                            </ItemTemplate>
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                        <asp:HiddenField runat="server" ID="hddnddlRecordTabsValues" Value="0" />
                                        <asp:HiddenField runat="server" ID="hddnddlRecordTabsNames" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblActionTypes" runat="server" Text="Action Type(s)" meta:resourcekey="lblActionTypes"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadComboBox ID="ddlActionTypes" Filter="Contains" MarkFirstMatch="true" runat="server" Width="100%" AllowCustomText="true" OnClientDropDownOpened="Audit_StopPropagation"
                                            LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                            <ItemTemplate>
                                                <div class="combo-item-template">
                                                    <asp:CheckBox runat="server" ID="chk" />
                                                    <asp:Label runat="server" ID="Label3" AssociatedControlID="chk"></asp:Label>
                                                    <%#DataBinder.Eval(Container, "Text")%>
                                                </div>
                                            </ItemTemplate>
                                            <CollapseAnimation Duration="200" Type="OutQuint" />
                                        </telerik:RadComboBox>
                                        <asp:HiddenField runat="server" ID="hddnddlActionTypesValues" Value="0" />
                                        <asp:HiddenField runat="server" ID="hddnddlActionTypesNames" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-4 col-4-right" style="text-align: center;">
                            <div style="width: 30%; display: inline-block;">
                                <asp:Button ID="btnApplyFilters" runat="server" UseSubmitBehavior="false" meta:ResourceKey="btnApplyFilters" Text="Apply Filters 1" />
                            </div>
                            <div style="width: 5%; display: inline-block;"></div>
                            <div style="width: 30%; display: inline-block;">
                                <asp:Button ID="btnResetFilters" runat="server" UseSubmitBehavior="false" meta:ResourceKey="btnResetFilters" Text="Reset Filters 1" />
                            </div>
                        </div>
                    </div> 
                    <div class="row">
                                            <div class="col-12">
                                                <table class="colTable">
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <span id="lblFromDate"></span>
                                                        </td>
                                                        <td>
                                                            <telerik:RadSlider runat="server" ID="sldDate" IsSelectionRangeEnabled="true" OnClientLoad="sldDate_Changed" Width="86%"
                                                                SmallChange="1" AutoPostBack="false" Skin="Default" OnClientValueChange="sldDate_Changed"
                                                                ShowDecreaseHandle="false" ShowIncreaseHandle="false" />
                                                        </td>
                                                        <td style="text-align: right; width: 70px;">
                                                            <span id="lblToDate"></span>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>   
                    <div class="row JustifyContent">
                            <div class="col-4 col-4-left">
                                <table class="colTable">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblStartDate" runat="server" Text="Start Date" meta:resourcekey="lblStartDate"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <span style="display: block; width: 100%">
                                                <telerik:RadDatePicker ID="rdpStartDate" DateInput-CssClass="Right" Width="100%" Style="display: inline" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                    EnableTyping="True" DateInput-OnClientDateChanged="Audit_DateInputChanged" DateInput-ClientEvents-OnValueChanging="Audit_DateInputValueChanging">
                                                </telerik:RadDatePicker>
                                            </span>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-4 col-4-right">
                                 <table class="colTable">
                                     <tr>
                                         <td class="labelWidth">
                                             <asp:Label ID="lblEndDate" runat="server" Text="End Date" meta:resourcekey="lblEndDate"></asp:Label>
                                         </td>
                                         <td class="controlWidth">
                                             <span>
                                                 <telerik:RadDatePicker ID="rdpEndDate" DateInput-CssClass="Right" Width="100%" Style="display: inline" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                     EnableTyping="True" DateInput-OnClientDateChanged="Audit_DateInputChanged" DateInput-ClientEvents-OnValueChanging="Audit_DateInputValueChanging">
                                                 </telerik:RadDatePicker>
                                             </span>
                                         </td>
                                     </tr>
                                 </table>
                            </div>
                        </div>
                    <div class="row">
                                                <div class="col-12">
                                                    <table class="colTable">
                                                        <tr>
                                                            <td style="">
                                                                <telerik:RadGrid ID="RDG" runat="server" AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" PageSize="20" ClientSettings-Scrolling-AllowScroll="true" SetWidth="true"
                                                                    ShowFooter="False" AllowPaging="True" ShowGroupPanel="True" AllowMultiRowEdit="True"
                                                                    AllowMultiRowSelection="false" AllowSorting="True" GridLines="None" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
                                                                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" ClientDataKeyNames="Id"
                                                                        DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" UseAllDataFields="true"
                                                                        InsertItemPageIndexAction="ShowItemOnFirstPage" Width="100%" EditMode="InPlace"
                                                                        EnableHeaderContextMenu="true" TableLayout="Fixed" ShowGroupFooter="true" GroupLoadMode="Client">
                                                                        <Columns>
                                                                            <telerik:GridTemplateColumn HeaderText="Id" SortExpression="Id" UniqueName="Id"
                                                                                Groupable="false" DataField="Id" AutoPostBackOnFilter="true">
                                                                                <ItemTemplate>
                                                                                    <asp:LinkButton runat="server" ID="btnDetails"> 
                                                                                        <span> <%#Container.DataItem("Id")%></span>
                                                                                    </asp:LinkButton>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle Width="108px"></HeaderStyle>
                                                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                            </telerik:GridTemplateColumn>
                                                                            <telerik:GridTemplateColumn HeaderText="User" SortExpression="User"
                                                                                UniqueName="User"
                                                                                GroupByExpression="User [GridColumn_User] Group By User ASC" DataField="User" AutoPostBackOnFilter="true">
                                                                                <ItemTemplate>
                                                                                    <span><%#IIf(Container.DataItem("User") = String.Empty, "&nbsp;", Container.DataItem("User"))%></span>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle Width="108px"></HeaderStyle>
                                                                            </telerik:GridTemplateColumn>

                                                                            <telerik:GridTemplateColumn HeaderText="Date" DataField="Date"
                                                                                AutoPostBackOnFilter="true" UniqueName="Date" SortExpression="Date"
                                                                                GroupByExpression="Date [GridColumn_Date] Group By Date ASC">
                                                                                <ItemTemplate>
                                                                                    <span><%#FormatDate(Container.DataItem("Date"))%></span>
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                                <HeaderStyle Width="108px"></HeaderStyle>
                                                                            </telerik:GridTemplateColumn>

                                                                            <telerik:GridTemplateColumn HeaderText="Time" DataField="Time"
                                                                                AutoPostBackOnFilter="true" UniqueName="Time" SortExpression="TimeInMilliseconds"
                                                                                GroupByExpression="Time [GridColumn_Time] Group By Time ASC">
                                                                                <ItemTemplate>
                                                                                    <span><%#FormatTime(Container.DataItem("Time"))%></span>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                                <HeaderStyle Width="108px"></HeaderStyle>
                                                                            </telerik:GridTemplateColumn>

                                                                            <telerik:GridTemplateColumn HeaderText="System ID" SortExpression="SystemId" UniqueName="SystemId" DataType="System.Int64"
                                                                                GroupByExpression="SystemId [GridColumn_SystemId] Group By SystemId ASC" DataField="SystemId" AutoPostBackOnFilter="true">
                                                                                <ItemTemplate>
                                                                                    <span><%#Container.DataItem("SystemId")%></span>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle Width="150px"></HeaderStyle>
                                                                                <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                            </telerik:GridTemplateColumn>

                                                                            <telerik:GridTemplateColumn HeaderText="Action Type" SortExpression="Action" UniqueName="Action"
                                                                                GroupByExpression="Action [GridColumn_Action] Group By Action" DataField="Action" AutoPostBackOnFilter="true">
                                                                                <ItemTemplate>
                                                                                    <span><%#IIf(Container.DataItem("Action") = String.Empty, "&nbsp;", Container.DataItem("Action"))%></span>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle Width="108px"></HeaderStyle>
                                                                            </telerik:GridTemplateColumn>

                                                                            <telerik:GridTemplateColumn HeaderText="Project/Location (current)" DataField="Project" AutoPostBackOnFilter="true"
                                                                                SortExpression="Project" UniqueName="Project" GroupByExpression="Project [GridColumn_Project] Group By Project ASC">
                                                                                <ItemTemplate>
                                                                                    <span><%#IIf(Container.DataItem("Project") = String.Empty, "&nbsp;", Container.DataItem("Project"))%></span>
                                                                                </ItemTemplate>

                                                                                <HeaderStyle Width="200px"></HeaderStyle>
                                                                            </telerik:GridTemplateColumn>

                                                                            <telerik:GridTemplateColumn HeaderText="Record Type" DataField="RecordType" AutoPostBackOnFilter="true"
                                                                                SortExpression="RecordType" UniqueName="RecordType" GroupByExpression="RecordType [GridColumn_RecordType] Group By RecordType ASC">
                                                                                <ItemTemplate>
                                                                                    <span><%#IIf(Container.DataItem("RecordType") = String.Empty, "&nbsp;", Container.DataItem("RecordType"))%></span>
                                                                                </ItemTemplate>

                                                                                <HeaderStyle Width="150px"></HeaderStyle>
                                                                            </telerik:GridTemplateColumn>

                                                                            <telerik:GridTemplateColumn HeaderText="Record (current)" SortExpression="RecordNumber" DataField="RecordNumber" AutoPostBackOnFilter="true"
                                                                                UniqueName="RecordNumber" GroupByExpression="RecordNumber [GridColumn_RecordNumber] Group By RecordNumber ASC">
                                                                                <ItemTemplate>
                                                                                    <span><%#IIf(Container.DataItem("RecordNumber") = String.Empty, "&nbsp;", Container.DataItem("RecordNumber"))%></span>
                                                                                </ItemTemplate>

                                                                                <HeaderStyle Width="150px"></HeaderStyle>
                                                                            </telerik:GridTemplateColumn>

                                                                            <telerik:GridTemplateColumn HeaderText="Tab" DataField="Tab" AutoPostBackOnFilter="true"
                                                                                UniqueName="Tab" SortExpression="Tab" GroupByExpression="Tab [GridColumn_Tab] Group By Tab ASC">
                                                                                <ItemTemplate>
                                                                                    <span><%#IIf(CStr(Container.DataItem("Tab")) = String.Empty, "&nbsp;", CStr(Container.DataItem("Tab")))%></span>
                                                                                </ItemTemplate>

                                                                                <HeaderStyle Width="108px"></HeaderStyle>
                                                                            </telerik:GridTemplateColumn>

                                                                            <telerik:GridTemplateColumn HeaderText="Grid" DataField="Grid" AutoPostBackOnFilter="true"
                                                                                UniqueName="Grid" SortExpression="Grid" GroupByExpression="Grid [GridColumn_Grid] Group By Grid ASC">
                                                                                <ItemTemplate>
                                                                                    <span><%#IIf(CStr(Container.DataItem("Grid")) = String.Empty, "&nbsp;", CStr(Container.DataItem("Grid")))%></span>
                                                                                </ItemTemplate>

                                                                                <HeaderStyle Width="108px"></HeaderStyle>
                                                                            </telerik:GridTemplateColumn>

                                                                            <telerik:GridTemplateColumn HeaderText="APIKey" DataField="APIKey" AutoPostBackOnFilter="true"
                                                                                UniqueName="APIKey" SortExpression="APIKey" GroupByExpression="APIKey [GridColumn_APIKey] Group By APIKey ASC">
                                                                                <ItemTemplate>
                                                                                    <span><%#IIf(CStr(Container.DataItem("APIKey")) = String.Empty, "&nbsp;", CStr(Container.DataItem("APIKey")))%></span>
                                                                                </ItemTemplate>

                                                                                <HeaderStyle Width="200px"></HeaderStyle>
                                                                            </telerik:GridTemplateColumn>
                                                                        </Columns>
                                                                        <FooterStyle CssClass="GridFooter" />
                                                                        <HeaderStyle HorizontalAlign="Left" Wrap="false" />
                                                                        <ItemStyle Wrap="false" />

                                                                        <CommandItemTemplate>
                                                                            <div style="padding: 2px">
                                                                                <asp:LinkButton ID="btnCopyToExcel" CommandName="CopyToExcel" CssClass="GridCmdCopyToExcel" runat="server" CausesValidation="False">
                                                                                    <span class="Icon"></span>
                                                                                    <asp:Label ID="lblCopyToExcel" meta:resourcekey="lblCopyToExcel" runat="server" Text="Copy To Excel"></asp:Label>
                                                                                    &nbsp;&nbsp;
                                                                                </asp:LinkButton>
                                                                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                                                                    SecurityButtonType="ItemMode" Visible='<%# RDG.EditIndexes.Count = 0 And (Not RDG.MasterTableView.IsItemInserted)%>'
                                                                                    meta:resourcekey="btnRefreshResource1">
                                                                                    <span class="Icon"></span>
                                                                                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1"></asp:Label>
                                                                                    &nbsp;&nbsp;
                                                                                </asp:LinkButton>
                                                                                <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true" EnableAutoScroll="true"
                                                                                    CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                                                                    runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack"
                                                                                    EnableShadows="true" CausesValidation="false"
                                                                                    Visible="true">
                                                                                </telerik:RadMenu>
                                                                                <%--                    <span style="width: 100%; text-align: left">
                                                                                    <asp:CheckBox runat="server" CssClass="chkAlignMiddle" OnCheckedChanged="chkShowEdited_OnChekedChanged" ID="ckbShowOnlyEditedFields" AutoPostBack="true"
                                                                                        Text="Show Only Edited Fields" meta:resourcekey="ckbShowOnlyEditedFields" />
                                                                                </span>--%>
                                                                            </div>
                                                                        </CommandItemTemplate>
                                                                    </MasterTableView>
                                                                    <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" ColumnsReorderMethod="Reorder" AllowDragToGroup="true">
                                                                        <ClientEvents OnRowDblClick="Audit_RowDblClick" />
                                                                        <Selecting AllowRowSelect="true" EnableDragToSelectRows="true" />
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
    <asp:HiddenField runat="server" ID="hdnDateFormat"></asp:HiddenField>
</asp:Content>
