<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="IntegrationManagerSchedule.ascx.vb" Inherits="Website.IntegrationManagerSchedule" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rblFrequency">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="pnlDaily" />
                <telerik:AjaxUpdatedControl ControlID="pnlWeekly" />
                <telerik:AjaxUpdatedControl ControlID="pnlMonthly" />
                <telerik:AjaxUpdatedControl ControlID="rblFrequency" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnSave">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="tblscheduler" LoadingPanelID="LdpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<%--<table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
    <tr>
        <td>
            <table style="width: 100%;" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="ToolbarTd"></td>
                </tr>
            </table>
        </td>
    </tr>
</table>--%>
<div class="PMMainPage">
    <div class="row">
        <div class="col-4 col-4-left">
            <table id="tblscheduler" runat="server" class="TableNoSpacingNoBorder">
                <tr>
                    <td style="width: 100%;">
                        <%--<asp:Label ID="lblFrequency" runat="server" meta:resourcekey="lblFrequency" Text="Frequency"></asp:Label>--%>
                        <asp:RadioButtonList ID="rblFrequency" AutoPostBack="true" CssClass="RadioCss RadioPadding"
                            runat="server" RepeatLayout="Table" RepeatColumns="1" RepeatDirection="Vertical">
                            <asp:ListItem meta:resourcekey="rblFrequency_Hourly" Text="Hourly" Value="Hourly" style="padding-bottom: 7px;">
                            </asp:ListItem>
                            <asp:ListItem meta:resourcekey="rblFrequency_Daily" Text="Daily" Value="Daily" Selected="True" style="padding-bottom: 7px;">
                            </asp:ListItem>
                            <asp:ListItem meta:resourcekey="rblFrequency_Weekly" Text=" " Value="Weekly" style="padding-bottom: 7px;"></asp:ListItem>
                            <asp:ListItem meta:resourcekey="rblFrequency_Monthly" Text="Monthly" Value="Monthly" style="padding-bottom: 7px;">
                            </asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlDaily" runat="server">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblStartDate2" runat="server" meta:resourcekey="lblStartDate" Text="Start Date*"></asp:Label>
                                    </td>
                                    <td class="controlWidth" style="width: 240px !important">
                                        <telerik:RadDatePicker ID="dtpDailyStartDate" runat="server" Skin="Default" Width="100%"></telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator ID="rfvRequireDate" ControlToValidate="dtpDailyStartDate" ValidationGroup="Schedule"
                                            runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>" Display="dynamic"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblTime2" runat="server" meta:resourcekey="lblTime" Text="Time*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadTimePicker ID="tpDailyTime" runat="server" Skin="Default" Width="100%"></telerik:RadTimePicker>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="tpDailyTime" ValidationGroup="Schedule" Display="dynamic"
                                            runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblEndDate" runat="server" meta:resourcekey="lblEndDate" Text="End Date*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadDatePicker ID="dtpDailyEndDate" runat="server" Skin="Default" Width="100%"></telerik:RadDatePicker>
                                        <asp:CompareValidator ID="cvDailyDate" runat="server" ValidationGroup="Schedule" ControlToCompare="dtpDailyStartDate"
                                            ControlToValidate="dtpDailyEndDate" Operator="GreaterThan" Display="Dynamic" meta:resourceKey="cpvStartDateEndDate" ErrorMessage="End Date must be greater Than Start Date"></asp:CompareValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="dtpDailyEndDate" ValidationGroup="Schedule" Display="dynamic"
                                            runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlWeekly" runat="server">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="Label1" runat="server" meta:resourcekey="lblStartDate" Text="Start Date*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadDatePicker ID="dtpWeeklyStartDate" runat="server" Skin="Default"></telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="dtpWeeklyStartDate" Display="dynamic"
                                            ValidationGroup="Schedule" runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblTime3" runat="server" meta:resourcekey="lblTime" Text="Time*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadTimePicker ID="tpWeeklyTime" runat="server" Skin="Default"></telerik:RadTimePicker>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="tpWeeklyTime" Display="dynamic"
                                            ValidationGroup="Schedule" runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblEvery" runat="server" meta:resourcekey="lblEvery" Text="Every"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table style="width: 100%" cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td style="width: 77%" align="left">
                                                    <telerik:RadNumericTextBox ID="txtEveryWeek" Width="100%" CssClass="Right" Value="1"
                                                        MinValue="1" Type="Number" ShowSpinButtons="true" runat="server">
                                                        <NumberFormat DecimalDigits="0" />
                                                    </telerik:RadNumericTextBox>
                                                </td>
                                                <td style="padding-left: 10px">
                                                    <asp:Label ID="lblWeekOn" runat="server" meta:resourcekey="lblWeekOn" Text="Week(s)">  </asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblOn" runat="server" meta:resourcekey="lblOn" Text="On"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table style="width: 100%" cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="chkMonday" meta:resourcekey="chkMonday" Text="Mon" runat="server" />
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkTuesday" meta:resourcekey="chkTuesday" Text="Tue" runat="server" />
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkWednesday" meta:resourcekey="chkWednesday" Text="Wed" runat="server" />
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkThursday" meta:resourcekey="chkThursday" Text="Thu" runat="server" />
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkFriday" meta:resourcekey="chkFriday" Text="Fri" runat="server" />
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkSaturday" meta:resourcekey="chkSaturday" Text="Sat" runat="server" />
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkSunday" meta:resourcekey="chkSunday" Text="Sun" runat="server" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblEndDate2" runat="server" meta:resourcekey="lblEndDate" Text="End Date*">  </asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadDatePicker ID="dtpWeeklyEndDate" runat="server" Skin="Default"></telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="dtpWeeklyEndDate"
                                            ValidationGroup="Schedule" runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>" Display="dynamic"></asp:RequiredFieldValidator>
                                        <asp:CompareValidator ID="CompareValidator1" runat="server" ValidationGroup="Schedule"
                                            ControlToCompare="dtpWeeklyStartDate" ControlToValidate="dtpWeeklyEndDate" Operator="GreaterThan"
                                            Display="Dynamic" meta:resourceKey="cpvStartDateEndDate" ErrorMessage="End Date must be greater Than Start Date"></asp:CompareValidator>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="pnlMonthly" runat="server">
                            <table class="colTable">
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="Label2" runat="server" meta:resourcekey="lblStartDate" Text="Start Date*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadDatePicker ID="dtpMonthlyStartDate" runat="server" Skin="Default"></telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ControlToValidate="dtpMonthlyStartDate" ValidationGroup="Schedule" Display="dynamic"
                                            runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblTime4" runat="server" meta:resourcekey="lblTime" Text="Time*"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <telerik:RadTimePicker ID="tpMonthlyTime" runat="server" Skin="Default"></telerik:RadTimePicker>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ControlToValidate="tpMonthlyTime" ValidationGroup="Schedule" Display="Dynamic" 
                                            runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:RadioButton ID="rdoMonthlyOnDay" Width="75px" Checked="true" CssClass="RadioCss" runat="server" Text="Day" meta:resourcekey="rdoMonthlyOnDay" GroupName="Monthly" />
                                    </td>
                                    <td class="controlWidth">
                                        <table style="width: 100%" cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td style="width: 64%">
                                                    <telerik:RadNumericTextBox ID="txtDaysOfMonth" CssClass="Right" Value="1" MinValue="1" Type="Number" ShowSpinButtons="true" MaxValue="31" Width="100%" runat="server">
                                                        <NumberFormat AllowRounding="False" DecimalDigits="0" NegativePattern="n"
                                                            PositivePattern="n" />
                                                    </telerik:RadNumericTextBox>
                                                </td>
                                                <td style="width: 75px; padding-left:8px">
                                                    <asp:Label ID="lblMonth" runat="server" meta:resourcekey="lblMonth" Text="of the month"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:RadioButton ID="rdoMonthlyOnThe" Width="75px" CssClass="RadioCss" meta:resourcekey="rdoMonthlyOnThe" runat="server" Text="The" GroupName="Monthly" />
                                    </td>
                                    <td class="controlWidth">
                                        <table class="TableNoSpacingNoBorder">
                                            <tr>
                                                <td style="width:64%">
                                                    <table style="width: 100%" cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td style="width: 50%; padding-right:5px">
                                                                <telerik:RadComboBox ID="ddlWeekDayPart" Width="100%" Skin="Default" runat="server">
                                                                </telerik:RadComboBox>
                                                            </td>
                                                            <td style="width: 50%; padding-left: 5px">
                                                                <telerik:RadComboBox ID="ddlWeekDay" Width="100%" Skin="Default" runat="server"></telerik:RadComboBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="width: 75px;padding-left:8px" >
                                                    <asp:Label ID="lblMonth2" runat="server" meta:resourcekey="lblMonth" Text="of the month"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblEvery2" runat="server" meta:resourcekey="lblEvery" Text="Every" Width="75px"></asp:Label>
                                    </td>
                                    <td class="controlWidth">
                                        <table style="width: 100%" cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td style="width: 64%">
                                                    <telerik:RadNumericTextBox ID="txtEveryMonth" CssClass="Right" Value="1" MinValue="1" Type="Number" ShowSpinButtons="true" Width="100%" runat="server">
                                                        <NumberFormat DecimalDigits="0" />
                                                    </telerik:RadNumericTextBox>
                                                </td>
                                                <td style="width: 75px;padding-left:8px">
                                                    <asp:Label ID="lblMonthOn" runat="server" meta:resourcekey="lblMonthOn" Text="Month(s) on"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="labelWidth">
                                        <asp:Label ID="lblEndDate3" runat="server" meta:resourcekey="lblEndDate" Text="End Date*"></asp:Label>
                                    </td>
                                    <td class="controlWidth" >
                                        <telerik:RadDatePicker ID="dtpMonthlyEndDate" runat="server" Skin="Default"></telerik:RadDatePicker>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ControlToValidate="dtpMonthlyEndDate" ValidationGroup="Schedule" Display="Dynamic"
                                            runat="server" ForeColor="" CssClass="Validator" ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>"></asp:RequiredFieldValidator>
                                        <asp:CompareValidator ID="CompareValidator2" runat="server" ValidationGroup="Schedule" ControlToCompare="dtpMonthlyStartDate"
                                            ControlToValidate="dtpMonthlyEndDate" Operator="GreaterThan" Display="Dynamic" meta:resourceKey="cpvStartDateEndDate" ErrorMessage="End Date must be greater Than Start Date"></asp:CompareValidator>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Button ID="btnSave" runat="server" meta:resourcekey="btnSave" Text="Save" Width="100%" ValidationGroup="Schedule" />
                                </td>
                                <td class="controlWidth"></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>
<asp:PlaceHolder ID="sharedCalendarPlaceHolder" runat="server" />




