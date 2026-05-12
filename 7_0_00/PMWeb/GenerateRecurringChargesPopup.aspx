<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="GenerateRecurringChargesPopup.aspx.vb" Inherits="Website.GenerateRecurringChargesPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <telerik:RadCodeBlock runat="server">
        <script language="javascript" type="text/javascript">
            function OpenChargeLinkToAssetFromPopup(Id, hdnLinkedAsset) {
                var Value = $("#" + hdnLinkedAsset)[0].value;
                return OpenPOPUp('LinkedAssetChargesPopup.aspx?Id=0' + '&IsEditMode=1&isFromPopup=1' + '&LinkedAssetIds=' + Value + '&hdnLinkedAsset=' + hdnLinkedAsset, 885, 390, true);
            }

            function AdjustAmountCalculation(gridId) {
                var grid = $("#" + gridId);
                var OldAmount = 0;
                $("input[id*=" + gridId + "][id$=txtAmount]").change(function () {
                    var row = $(this).parents("tr:first"); Calculate(row, 'Amount');
                }
                ).focus(function () {
                    OldAmount = $(this).val();
                }
                );
            }

            function Calculate(row, sender) {
                var hdnDetailRentable = row.find("input[id$='hdnDetailRentable']");
                var txtAnnual = row.find("input[id$='txtAnnual']");
                var txtAmount = row.find("input[id$='txtAmount']");
                var Amount = CDbl(txtAmount.val());
                var hdnPostEvery = row.find("input[id$='hdnPostEvery']");
                var Conversion = CDbl(hdnPostEvery.val());
                var txtAnnualized = row.find("input[id$='txtAnnualized']");
                if (sender == 'Amount') {
                    txtAnnualized.val(CCur(Amount * Conversion));
                    if (CDbl(hdnDetailRentable.val()) == 0)
                        txtAnnual.val(CCur(0));
                    else
                        txtAnnual.val(CCur(CDbl((Amount * Conversion) / CDbl(hdnDetailRentable.val()))));
                }
            }

            function dllPostEverySelectedIndexChanged(combobox, eventArgs) {

                var HiddenField = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_hdnPostEvery';
                var Annualized = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_txtAnnualized';
                var Amount = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_txtAmount';
                var DetailRentable = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_hdnDetailRentable';
                var Annual = combobox.get_id().substring(combobox.get_id().lastIndexOf('_'), combobox.get_id().lenght - 1) + '_txtAnnual'
                var hdnPostEvry = document.getElementById(HiddenField);
                var txtAnnualized = document.getElementById(Annualized);
                var hdnDetailRentable = document.getElementById(DetailRentable);
                var txtAmount = document.getElementById(Amount);
                var txtAnnual = document.getElementById(Annual);
                var SelectedItem = eventArgs.get_item();
                var Conversion = CDbl(SelectedItem.get_attributes().getAttribute("Conv"));

                if (hdnPostEvry != null) {
                    hdnPostEvry.value = FPrec(Conversion);
                    txtAnnualized.value = CCur(CDbl(txtAmount.value) * Conversion);
                    if (CDbl(hdnDetailRentable.value) == 0)
                        txtAnnual.value = CCur(0);
                    else
                        txtAnnual.value = CCur((CDbl(txtAmount.value) * Conversion) / CDbl(hdnDetailRentable.value));
                }
            }
        </script>
    </telerik:RadCodeBlock>

    <style type="text/css">
        @media screen and (max-width: 843px) and (min-width: 320px) {
            .documentSinglePage {    
                margin-top: 50px !important;
                margin-bottom: 0px !important;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
         <telerik:RadWindowManager ID="PMWindowManager" runat="server" VisibleStatusbar="False"
            ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
            IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
            Top="">
        </telerik:RadWindowManager>
        <%-- <telerik:RadAjaxManager ID="PMAjaxManager1" runat="server">
        <ajaxsettings>
            <telerik:AjaxSetting AjaxControlID="rdbUntil">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdpUntil"/>
                    <telerik:AjaxUpdatedControl ControlID="rdbUntil"/>
                    <telerik:AjaxUpdatedControl ControlID="txtNbrOfRecurrences"/>
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="rdbNbrOfRecurrences">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdpUntil"/>
                    <telerik:AjaxUpdatedControl ControlID="rdbNbrOfRecurrences"/>
                    <telerik:AjaxUpdatedControl ControlID="txtNbrOfRecurrences"/>
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="rdbFixedAmount">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="tblAmounts"/>
                </UpdatedControls>
            </telerik:AjaxSetting>

            <telerik:AjaxSetting AjaxControlID="rdbPercentage">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="tblAmounts"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
            </ajaxsettings>
    </telerik:RadAjaxManager>--%>

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd" style="width: 174px !important;">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" ValidationGroup="Save"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveToLease"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton SecurityButtonType="Read" CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel" Value="Cancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
                <td class="ToolbarTd">
                    <asp:Button ID="btnCreateRecurrences" runat="server" Text="Create Recurrences" Width="160px" meta:resourcekey="btnCreateRecurrences" />
                </td>
                <td></td>
            </tr>
        </table>
        <div class="PMHeader documentSinglePage" style="margin-bottom: 0px;">
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgLeaseCharges" runat="server" AutoGenerateColumns="False" ShowStatusBar="False" HeaderStyle-Font-Size="8"
                        SetWidth="true" FitParentContainer="true" ClientSettings-Scrolling-AllowScroll="true" Width="100%"
                        ShowGroupPanel="false" AllowMultiRowEdit="True" PageSize="20" AllowPaging="False" AllowMultiRowSelection="False" AllowSorting="False" ItemStyle-Height="20px" GridLines="None">
                        <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="None"
                            InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true" EditMode="InPlace"
                            EnableHeaderContextMenu="False">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" HeaderStyle-Wrap="false"
                                    Groupable="false" Reorderable="false" AllowFiltering="false">
                                    <ItemTemplate>
                                        <span><%#Container.DataItem("LineNumber").ToString%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Start" UniqueName="StartDate"
                                    HeaderStyle-Width="120px">
                                    <ItemTemplate>
                                        <span><%#FormatDate(Container.DataItem("StartDate"))%>&nbsp;</span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="End" UniqueName="EndDate"
                                    HeaderStyle-Width="120px">
                                    <ItemTemplate>
                                        <span><%#FormatDate(Container.DataItem("EndDate"))%>&nbsp;</span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="100px" ItemStyle-Wrap="false" HeaderText="Type" UniqueName="Type" DataField="Type"
                                    Groupable="false">
                                    <ItemTemplate>
                                        <span><%#Eval("Type").ToString%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="120px" HeaderText="Description" ItemStyle-Wrap="false" UniqueName="Description" DataField="Description"
                                    Groupable="false">
                                    <ItemTemplate>
                                        <span><%#Eval("Description").ToString%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="120px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="90px" ItemStyle-Wrap="false" HeaderText="Post Every" UniqueName="PostEvery" DataField="PostEvery"
                                    Groupable="false">
                                    <ItemTemplate>
                                        <span><%# Eval("PostEvery").ToString%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="90px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="70px" ItemStyle-Wrap="false" HeaderText="Est." UniqueName="Est" DataField="Est"
                                    Groupable="false">
                                    <ItemTemplate>
                                        <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("Est"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                    <HeaderStyle Width="70px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Amount" ItemStyle-Wrap="false" UniqueName="Amount" DataField="Amount"
                                    Groupable="false" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <span><%# FormatCurrency(Eval("Amount"))%>&nbsp;</span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Annualized" ItemStyle-Wrap="false" UniqueName="Annualized" DataField="Annualized"
                                    Groupable="false" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <span><%# FormatCurrency(Eval("Annualized"))%>&nbsp;</span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Annual" ItemStyle-Wrap="false" UniqueName="Annual" DataField="Annual"
                                    Groupable="false" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <span><%# FormatCurrency(Eval("Annual"))%>&nbsp;</span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="100px" ItemStyle-Wrap="false" HeaderText="Cost Code" UniqueName="CostCode" DataField="CostCode"
                                    Groupable="false">
                                    <ItemTemplate>
                                        <span><%# Eval("CostCode").ToString%>&nbsp;</span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Last Posted" UniqueName="LastPostedDate"
                                    HeaderStyle-Width="90px">
                                    <ItemTemplate>
                                        <span><%#FormatDate(Container.DataItem("LastPostedDate"))%>&nbsp;</span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Next Posting" UniqueName="NextPostingDate"
                                    HeaderStyle-Width="90px">
                                    <ItemTemplate>
                                        <span><%#FormatDate(Container.DataItem("NextPostingDate"))%>&nbsp;</span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Asset(s)" UniqueName="LinkedAssets" HeaderStyle-Width="175px">
                                    <ItemTemplate>
                                        <%#IIf(Container.DataItem("LinkedAssets").ToString = String.Empty, "&nbsp;", Container.DataItem("LinkedAssets").ToString)%>&nbsp;
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="200px" HeaderText="Notes" ItemStyle-Wrap="false" UniqueName="Notes" DataField="Notes"
                                    Groupable="false">
                                    <ItemTemplate>
                                        <span><%#Eval("Notes").ToString%>&nbsp;</span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="200px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="70px" HeaderText="Charge ID" ItemStyle-Wrap="false" UniqueName="ChargeID" DataField="ChargeID"
                                    Groupable="false">
                                    <ItemTemplate>
                                        <span><%# Eval("ChargeID").ToString%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="70px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="70px" ItemStyle-Wrap="false" HeaderText="Inactive" UniqueName="Inactive" DataField="Inactive"
                                    Groupable="false">
                                    <ItemTemplate>
                                        <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("Inactive"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                    <HeaderStyle Width="70px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="70px" HeaderText="System Id" ItemStyle-Wrap="false" UniqueName="Id" DataField="Id"
                                    Groupable="false">
                                    <ItemTemplate>
                                        <span>&nbsp</span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="70px" />
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                        <ClientSettings AllowDragToGroup="False" Resizing-AllowColumnResize="true">
                            <Selecting AllowRowSelect="False" EnableDragToSelectRows="false" />
                        </ClientSettings>
                    </telerik:RadGrid>
                </div>
            </div>
        </div>
        <div class="PMMainPage PMPopupMainPage">
            <div class="row">
                <div class="col-4 col-4-left">
                    <table runat="server" id="tblAmounts" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <fieldset>
                                    <legend>
                                        <asp:Label ID="lblRecurOptions" runat="server" meta:resourcekey="lblRecurOptions" Text="Recur Options"></asp:Label>
                                    </legend>
                                    <table class="colTable">
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:Label ID="lblRecur" runat="server" meta:resourcekey="lblRecur" Text="Recur"></asp:Label>
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadComboBox ID="ddlRecurOptions" kin="Default" runat="server"></telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:RadioButton ID="rdbUntil" runat="server" Text="Until" GroupName="RecurOptions" meta:resourcekey="rdbUntil" AutoPostBack="true" CssClass="RadioCss" />
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadDatePicker ID="rdpUntil" runat="server" Skin="Default"></telerik:RadDatePicker>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelWidth">
                                                <asp:RadioButton ID="rdbNbrOfRecurrences" runat="server" Text="# Of Recurrences" Checked="true" GroupName="RecurOptions"
                                                    meta:resourcekey="rdbNbrOfRecurrences" AutoPostBack="true" CssClass="RadioCss" />
                                            </td>
                                            <td class="controlWidth">
                                                <telerik:RadNumericTextBox ID="txtNbrOfRecurrences" CssClass="Right" Value="1" MinValue="1" Type="Number"
                                                    ShowSpinButtons="true" runat="server">
                                                    <NumberFormat DecimalDigits="0" />
                                                </telerik:RadNumericTextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-4 col-4-right">
                    <fieldset>
                        <legend>
                            <asp:Label ID="lblEscalationOptions" runat="server" meta:resourcekey="lblEscalationOptions" Text="Escalation Options"></asp:Label>
                        </legend>
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:RadioButton ID="rdbFixedAmount" runat="server" Text="Fixed Amount" CssClass="RadioCss" GroupName="EscalationOptions" Checked="true" meta:resourcekey="rdbFixedAmount" AutoPostBack="true" />
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtFixedAmount" runat="server" CssClass="Currency"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="labelWidth">
                                    <asp:RadioButton ID="rdbPercentage" runat="server" Text="Percentage" CssClass="RadioCss" GroupName="EscalationOptions" meta:resourcekey="rdbPercentage" AutoPostBack="true" />
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox ID="txtPercentage" runat="server" CssClass="Percent"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                        <%--DirectCast((MobileMenu.FindControl("MobileRadmen")), Telerik.Web.UI.RadMenu).FindItemByValue("Active")--%>
                    </fieldset>
                </div>
            </div>
        </div>

        <div class="PMMainPage PMPopupMainPage">
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgRecurrenceCharges" runat="server" AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8"
                        SetWidth="true" FitParentContainer="true" ClientSettings-Scrolling-AllowScroll="true" Width="100%"
                        ShowGroupPanel="false" AllowMultiRowEdit="True" PageSize="250" AllowPaging="true" AllowMultiRowSelection="true" AllowSorting="true" ItemStyle-Height="20px" GridLines="None">
                        <HeaderContextMenu EnableViewState="false"></HeaderContextMenu>
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top"
                            InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true" EditMode="InPlace"
                            EnableHeaderContextMenu="False" InsertItemDisplay="Top">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" HeaderStyle-Wrap="false" SortExpression="LineNumber"
                                    Groupable="false" Reorderable="false" AllowFiltering="false">
                                    <ItemTemplate>
                                        <span><%#Container.DataItem("LineNumber").ToString%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Start" UniqueName="StartDate" SortExpression="StartDate"
                                    HeaderStyle-Width="170px" Reorderable="true">
                                    <ItemTemplate>
                                        <telerik:RadDatePicker ID="rdpStartDate" runat="server" Width="100%"
                                            SelectedDate='<%# Eval("StartDate")%>' Skin="Default">
                                            <DateInput ID="DateInput1" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                            <Calendar ID="Calendar1" Skin="Default" runat="server"></Calendar>
                                        </telerik:RadDatePicker>
                                    </ItemTemplate>
                                    <HeaderStyle Width="170px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="End" UniqueName="EndDate" SortExpression="EndDate"
                                    HeaderStyle-Width="170px" Reorderable="true">
                                    <ItemTemplate>
                                        <telerik:RadDatePicker ID="rdpEndDate" runat="server" Width="100%"
                                            SelectedDate='<%# Eval("EndDate")%>' Skin="Default">
                                            <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                            <Calendar ID="Calendar2" Skin="Default" runat="server"></Calendar>
                                        </telerik:RadDatePicker>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="100px" ItemStyle-Wrap="false" HeaderText="Type" UniqueName="Type" DataField="Type"
                                    Groupable="false" SortExpression="Type" Reorderable="true">
                                    <ItemTemplate>
                                        <telerik:RadComboBox ID="ddlTypes" runat="server"></telerik:RadComboBox>
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="120px" HeaderText="Description" ItemStyle-Wrap="false" UniqueName="Description" DataField="Description"
                                    Groupable="false" SortExpression="Description" Reorderable="true">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtDescription" runat="server" Width="100px" Text='<%# Container.DataItem("Description") %>'></asp:TextBox>
                                    </ItemTemplate>
                                    <HeaderStyle Width="120px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="160px" ItemStyle-Wrap="false" HeaderText="Post Every" UniqueName="PostEvery" DataField="PostEvery"
                                    Groupable="false" SortExpression="PostEvery" Reorderable="true">
                                    <ItemTemplate>
                                        <telerik:RadComboBox ID="ddlPostEvery" DropDownWidth="140px" Width="145px" Skin="Default" runat="server"
                                            OnClientSelectedIndexChanged="dllPostEverySelectedIndexChanged">
                                        </telerik:RadComboBox>
                                        <asp:HiddenField runat="server" ID="hdnPostEvery" />
                                    </ItemTemplate>
                                    <HeaderStyle Width="160px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="70px" ItemStyle-Wrap="false" HeaderText="Est." UniqueName="Est" DataField="Est"
                                    Groupable="false" SortExpression="Est" Reorderable="true">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkEst" runat="server" Checked='<%# Container.DataItem("EST") %>' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                    <HeaderStyle Width="70px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Amount" ItemStyle-Wrap="false" UniqueName="Amount" DataField="Amount"
                                    Groupable="false" ItemStyle-HorizontalAlign="Right" SortExpression="Amount" Reorderable="true">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtAmount" runat="server" Width="80px" CssClass="Currency" Text='<%# FormatCurrency(Container.DataItem("Amount")) %>'></asp:TextBox>
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Annualized" ItemStyle-Wrap="false" UniqueName="Annualized" DataField="Annualized"
                                    Groupable="false" ItemStyle-HorizontalAlign="Right" SortExpression="Annualized" Reorderable="true">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtAnnualized" runat="server" Enabled="false" CssClass="Currency" Width="80px" Text='<%# FormatCurrency(Container.DataItem("Annualized")) %>'></asp:TextBox>
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="100px" HeaderText="Annual" ItemStyle-Wrap="false" UniqueName="Annual" DataField="Annual"
                                    Groupable="false" ItemStyle-HorizontalAlign="Right" SortExpression="Annual" Reorderable="true">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtAnnual" runat="server" Enabled="false" CssClass="Currency" Width="80px" Text='<%# FormatCurrency(Container.DataItem("Annual")) %>'></asp:TextBox>
                                        <asp:HiddenField runat="server" ID="hdnDetailRentable" />
                                    </ItemTemplate>
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="170px" ItemStyle-Wrap="false" HeaderText="Cost Code" UniqueName="CostCode" DataField="CostCode"
                                    Groupable="false" SortExpression="CostCode" Reorderable="true">
                                    <ItemTemplate>
                                        <telerik:RadComboBox ID="ddlCostCodes" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true"
                                            runat="server" AutoPostBack="False" Skin="Default" DropDownWidth="140px" NoWrap="true" Width="150px"
                                            Height="200px" OnItemsRequested="ddl_ItemsRequested" ShowMoreResultsBox="True" EnableVirtualScrolling="True" EnableLoadOnDemand="true">
                                        </telerik:RadComboBox>
                                    </ItemTemplate>
                                    <HeaderStyle Width="170px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Last Posted" UniqueName="LastPostedDate" SortExpression="LastPostedDate" Reorderable="true"
                                    HeaderStyle-Width="90px">
                                    <ItemTemplate>
                                        <%-- <telerik:RadDatePicker id="rdpLastPosted" Runat="server" MinDate="1901-01-01" 
                                           MaxDate="2100-01-01" SelectedDate='<%# FormatDate(Eval("StartDate")) %>' Width="100%" Skin="Default">                                                    
                                           <DateInput ID="DateInput3" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                           <Calendar ID="Calendar3"   Skin="Default" runat="server"></Calendar>
                                    </telerik:RadDatePicker> --%>
                                        <span>&nbsp</span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Next Posting" UniqueName="NextPostingDate" SortExpression="NextPostingDate" Reorderable="true"
                                    HeaderStyle-Width="170px">
                                    <ItemTemplate>
                                        <telerik:RadDatePicker ID="rdpNextPosting" runat="server" MinDate="1901-01-01"
                                            MaxDate="2100-01-01" SelectedDate='<%# Eval("NextPostingDate")%>' Width="100%" Skin="Default">
                                            <DateInput ID="DateInput4" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                            <Calendar ID="Calendar4" Skin="Default" runat="server"></Calendar>
                                        </telerik:RadDatePicker>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Asset(s)" UniqueName="LinkedAssets" HeaderStyle-Width="175px" SortExpression="LinkedAssets" Reorderable="true">
                                    <ItemTemplate>
                                        <div style="width: 130px; float: left" title='<%# Eval("LinkedAssets") %>'>
                                            <asp:Label ID="lblLinkedAssets" Text='<%# Eval("LinkedAssets") %>' runat="server"> </asp:Label>
                                        </div>
                                        <div style="width: 20px; float: right">
                                            <asp:LinkButton runat="server" ID="imgLinkAsset" meta:resourcekey="imgLinkAsset"
                                                CssClass="EmptyDetails">
                                               <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                        <asp:HiddenField runat="server" Value="" ID="hdnLinkedAssetIds" />
                                        <asp:HiddenField runat="server" Value="" ID="hdnLinkedAssetNames" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="200px" HeaderText="Notes" ItemStyle-Wrap="false" UniqueName="Notes" DataField="Notes"
                                    Groupable="false" SortExpression="Notes" Reorderable="true">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtNotes" runat="server" Width="180px" Text='<%# Container.DataItem("Notes") %>'></asp:TextBox>
                                    </ItemTemplate>
                                    <HeaderStyle Width="200px"></HeaderStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="70px" HeaderText="Charge ID" ItemStyle-Wrap="false" UniqueName="ChargeID" DataField="ChargeID"
                                    Groupable="false" SortExpression="ChargeID" Reorderable="true">
                                    <ItemTemplate>
                                        <span><%# Eval("ChargeID").ToString%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="70px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="70px" ItemStyle-Wrap="false" HeaderText="Inactive" UniqueName="Inactive" DataField="Inactive"
                                    Groupable="false" SortExpression="Inactive" Reorderable="true">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkInactive" runat="server" Checked='<%# Container.DataItem("Inactive") %>' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                    <HeaderStyle Width="70px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="70px" HeaderText="System Id" ItemStyle-Wrap="false" UniqueName="Id" DataField="Id"
                                    Groupable="false" SortExpression="Id" Reorderable="true">
                                    <ItemTemplate>
                                        <span>&nbsp</span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="70px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderStyle-Width="70px" HeaderText="Base Charge System Id" ItemStyle-Wrap="false" UniqueName="BaseChargeId" DataField="ChargeId"
                                    Groupable="false" SortExpression="ChargeId" Reorderable="true">
                                    <ItemTemplate>
                                        <span><%# Eval("BaseChargeId").ToString%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="140px" />
                                    <ItemStyle HorizontalAlign="Right" />
                                </telerik:GridTemplateColumn>

                            </Columns>
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow"
                                        SecurityButtonType="ItemMode_Add">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblAddLine" runat="server"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="return ConfirmDelete()" CssClass="GridCmdDeleteRows"
                                        SecurityButtonType="ItemMode_Delete"
                                        runat="server" CommandName="DeleteRows">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                </div>
                            </CommandItemTemplate>
                        </MasterTableView>
                        <ClientSettings AllowDragToGroup="False" Resizing-AllowColumnResize="true">
                            <Selecting AllowRowSelect="true" EnableDragToSelectRows="false" />
                        </ClientSettings>
                    </telerik:RadGrid>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
