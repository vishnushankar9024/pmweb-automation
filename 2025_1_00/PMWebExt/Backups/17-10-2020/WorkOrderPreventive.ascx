<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="WorkOrderPreventive.ascx.vb" Inherits="Website.WorkOrderPreventive" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="Message.ascx" TagName="Message" TagPrefix="uc1" %>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rblFrequency">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="pnlDaily" />
                <telerik:AjaxUpdatedControl ControlID="pnlWeekly" />
                <telerik:AjaxUpdatedControl ControlID="pnlMonthly" />
                <telerik:AjaxUpdatedControl ControlID="pnlInterval" />
                <telerik:AjaxUpdatedControl ControlID="pnlOnce" />
                <telerik:AjaxUpdatedControl ControlID="rblFrequency" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="lbtnCreateLinkedWorkOrders">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="pnlDaily" />
                <telerik:AjaxUpdatedControl ControlID="pnlWeekly" />
                <telerik:AjaxUpdatedControl ControlID="pnlMonthly" />
                <telerik:AjaxUpdatedControl ControlID="pnlInterval" />
                <telerik:AjaxUpdatedControl ControlID="pnlOnce" />
                <telerik:AjaxUpdatedControl ControlID="rblFrequency" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnCreate">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="pnlDaily" />
                <telerik:AjaxUpdatedControl ControlID="pnlWeekly" />
                <telerik:AjaxUpdatedControl ControlID="pnlMonthly" />
                <telerik:AjaxUpdatedControl ControlID="pnlInterval" />
                <telerik:AjaxUpdatedControl ControlID="pnlOnce" />
                <telerik:AjaxUpdatedControl ControlID="rblFrequency" />
                <telerik:AjaxUpdatedControl ControlID="pnlLinkedWorkOrders" LoadingPanelID="LdpPM" />
                <telerik:AjaxUpdatedControl ControlID="chkCopyRessource" />
                <telerik:AjaxUpdatedControl ControlID="lbtnCreateLinkedWorkOrders" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<asp:HiddenField ID="hdfStatus" runat="server" />
<uc1:Message ID="Message1" runat="server" />
<asp:Button ID="btnCreate" CssClass="Hide" Width="100px" Text="" runat="server" />

<style>
    input[type="radio"] + label {
        text-transform: uppercase;
    }

    .chkButton {
        border: 1px solid #666666;
        text-align: center;
        text-transform: uppercase;
        color: #666666;
        line-height: 32px;
        border-radius: 5px;
        background-color: #FFFFFF;
        vertical-align: central;
        text-decoration: none;
        width: 95%;
        display: inline-block;
    }

        .chkButton::before {
            width: 16px;
            height: 16px;
            display: inline-block;
            background-image: url('../CSS/Images/ResponsiveIcons/16Enabled.png');
            background-position: -336px;
            margin-right: 5px;
            content: "";
            position: relative;
            display: inline-block;
            top: 3px;
        }

        .chkButton:hover {
            background-color: #EDEDED !important;
        }

    @media screen and (min-width:1500px) {
        .row {
            padding-top: 0px !important;
        }

        .col-4 {
            padding: 24px 24px 0 0;
            border-right: 1px solid rgb(153, 153, 153);
            height: calc(100vh - 172px) !important;
        }

        .col-8 {
            padding-top: 24px;
        }
    }
</style>

<div class="PMMainPage">
    <div class="row row-8-4">
        <div class="col-4">
            <table class="colTable">
                <tr style="height: 120px;">
                    <td class="labelWidth">
                        <asp:RadioButtonList ID="rblFrequency" AutoPostBack="true" CssClass="RadioCss RadioPadding"
                            runat="server" RepeatLayout="Table" RepeatColumns="1" RepeatDirection="Vertical">
                            <asp:ListItem Selected="True" Text="Once" Value="None" meta:resourcekey="rblFrequency_None"></asp:ListItem>
                            <asp:ListItem meta:resourcekey="rblFrequency_Daily" Text="Daily" Value="Daily">
                            </asp:ListItem>
                            <asp:ListItem meta:resourcekey="rblFrequency_Weekly" Text="Weekly" Value="Weekly"></asp:ListItem>
                            <asp:ListItem meta:resourcekey="rblFrequency_Monthly" Text="Monthly" Value="Monthly">
                            </asp:ListItem>
                            <asp:ListItem meta:resourcekey="rblFrequency_Interval" Text="Interval" Value="Interval"></asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                    <td class="controlWidth" style="vertical-align: top;">
                        <asp:LinkButton ID="lbtnCreateLinkedWorkOrders" OnClientClick="Javascript:return CreateLinkedWorkOrders_Click(this);" CssClass="chkButton"
                            meta:resourcekey="lbtnCreateLinkedWorkOrders" runat="server">
                        </asp:LinkButton>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td class="controlWidth">
                        <asp:CheckBox meta:resourcekey="chkCopyRessource" ID="chkCopyRessource" Text="Copy Assigned Resources" runat="server" class="mobile-switch" />
                        <%--<label class="switch">
                            <input id="chkCopyRessource" runat="server" type="checkbox" />
                            <span class="slider round"></span>
                        </label>--%>
                    </td>
                   <%-- <td>
                        <asp:Label ID="lblCopyResource" runat="server" Text="Copy Assigned Resources" style="color:#666666;"></asp:Label>
                    </td>--%>
                </tr>
            </table>

            <asp:Panel ID="pnlOnce" runat="server">
                <table class="colTable">
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblStartDate" runat="server" meta:resourcekey="lblStartDate" Text="Start Date">  </asp:Label></td>
                        <td style="width: 160px;">
                            <telerik:RadDatePicker ID="dtpOnceStartDate" runat="server" Skin="Default">
                            </telerik:RadDatePicker>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblTime" runat="server" meta:resourcekey="lblTime" Text="Time">  </asp:Label>
                        </td>
                        <td style="width: 160px;">
                            <telerik:RadTimePicker ID="dtpOnceTime" runat="server" Skin="Default"></telerik:RadTimePicker>
                        </td>
                        <td style="float: right;">
                            <asp:CheckBox ID="chkOnceTimeless" runat="server" meta:resourcekey="chkOnceTimeless" Text="Timeless" class="mobile-switch" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>

            <asp:Panel ID="pnlDaily" runat="server">
                <table class="colTable">
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblStartDate2" runat="server" meta:resourcekey="lblStartDate" Text="Start Date">  </asp:Label></td>
                        <td style="width: 160px;">
                            <telerik:RadDatePicker ID="dtpDailyStartDate" runat="server" Skin="Default">
                            </telerik:RadDatePicker>
                        </td>
                        <td></td>

                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblTime2" runat="server" meta:resourcekey="lblTime" Text="Time">  </asp:Label>
                        </td>
                        <td style="width: 160px;">
                            <telerik:RadTimePicker ID="tpDailyTime" runat="server" Skin="Default"></telerik:RadTimePicker>
                        </td>
                        <td style="float: right;">
                            <asp:CheckBox ID="chkDailyTimeless" runat="server" Text="Timeless" meta:resourcekey="chkDailyTimeless" class="mobile-switch" />
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblEndDate" runat="server" meta:resourcekey="lblEndDate" Text="End Date">  </asp:Label></td>
                        <td style="width: 160px;">
                            <telerik:RadDatePicker ID="dtpDailyEndDate" runat="server" Skin="Default">
                            </telerik:RadDatePicker>
                        </td>
                        <td></td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="pnlWeekly" runat="server">
                <table class="colTable">
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblTime3" runat="server" meta:resourcekey="lblTime" Text="Time">  </asp:Label></td>
                        <td style="width: 160px;">
                            <telerik:RadTimePicker ID="tpWeeklyTime" runat="server" Skin="Default"></telerik:RadTimePicker>
                        </td>
                        <td style="float: right;">
                            <asp:CheckBox ID="ChkWeeklyTimeless" runat="server" meta:resourcekey="ChkWeeklyTimeless" Text="Timeless" class="mobile-switch" />
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblEndDate2" runat="server" meta:resourcekey="lblEndDate" Text="End Date">  </asp:Label>
                        </td>
                        <td style="width: 160px;">
                            <telerik:RadDatePicker ID="dtpWeeklyEndDate" runat="server" Skin="Default">
                            </telerik:RadDatePicker>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblEvery" runat="server" meta:resourcekey="lblEvery" Text="Every">  </asp:Label></td>
                        <td style="width: 160px;">
                            <telerik:RadNumericTextBox ID="txtEveryWeek" Width="97%" CssClass="Right" Value="1" MinValue="1" Type="Number" ShowSpinButtons="true" runat="server">
                                <NumberFormat DecimalDigits="0" />
                            </telerik:RadNumericTextBox>
                        </td>
                        <td style="padding-left: 4px;">
                            <asp:Label ID="lblWeekOn" runat="server" meta:resourcekey="lblWeeksOn" Text="Weeks"></asp:Label>
                        </td>
                    </tr>

                </table>
                <table class="colTable">
                    <tr>
                        <td class="labelWidth">
                            <asp:Label runat="server" ID="lblOn" Text="On:"></asp:Label>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkMonday" meta:resourcekey="chkMonday" Text="Monday" runat="server" class="mobile-switch" />
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth"></td>
                        <td>
                            <asp:CheckBox ID="chkTuesday" meta:resourcekey="chkTuesday" Text="Tuesday" runat="server" class="mobile-switch" />
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth"></td>
                        <td>
                            <asp:CheckBox ID="chkWednesday" meta:resourcekey="chkWednesday" Text="Wednesday" runat="server" class="mobile-switch" />
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth"></td>
                        <td>
                            <asp:CheckBox ID="chkThursday" meta:resourcekey="chkThursday" Text="Thursday" runat="server" class="mobile-switch" />
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth"></td>
                        <td>
                            <asp:CheckBox ID="chkFriday" meta:resourcekey="chkFriday" Text="Friday" runat="server" class="mobile-switch" />
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth"></td>
                        <td>
                            <asp:CheckBox ID="chkSaturday" meta:resourcekey="chkSaturday" Text="Saturday" runat="server" class="mobile-switch" />
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth"></td>
                        <td>
                            <asp:CheckBox ID="chkSunday" meta:resourcekey="chkSunday" Text="Sunday" runat="server" class="mobile-switch" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="pnlMonthly" runat="server">
                <table class="colTable">
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblTime4" runat="server" meta:resourcekey="lblTime" Text="Time"></asp:Label>
                        </td>
                        <td style="width: 160px;">
                            <telerik:RadTimePicker ID="tpMonthlyTime" runat="server" Skin="Default"></telerik:RadTimePicker>
                        </td>
                        <td style="float: right;">
                            <asp:CheckBox ID="ChkMonthlyTimeless" meta:resourcekey="ChkMonthlyTimeless" runat="server" Text="Timeless" class="mobile-switch" />
                        </td>
                    </tr>

                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblEndDate3" runat="server" meta:resourcekey="lblEndDate" Text="End Date">  </asp:Label></td>
                        <td style="width: 160px;">
                            <telerik:RadDatePicker ID="dtpMonthlyEndDate" runat="server" Skin="Default">
                            </telerik:RadDatePicker>
                        </td>
                        <td></td>
                    </tr>

                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblEvery2" runat="server" meta:resourcekey="lblEvery" Text="Every"></asp:Label>
                        </td>
                        <td style="width: 160px;">
                            <telerik:RadNumericTextBox ID="txtEveryMonth" CssClass="Right" Value="1" MinValue="1" Type="Number" ShowSpinButtons="true" Width="40%" runat="server">
                                <NumberFormat DecimalDigits="0" />
                            </telerik:RadNumericTextBox>
                            <asp:Label ID="lblMonthOn" runat="server" meta:resourcekey="lblMonthsOn" Text="Months"></asp:Label>

                        </td>
                        <td></td>
                    </tr>

                    <tr>
                        <td class="labelWidth">

                            <asp:Label runat="server" ID="lblMonthlyOn" Text="On:"></asp:Label>
                            <span>
                                <asp:RadioButton ID="rdoMonthlyOnDay" Checked="true" runat="server" Text="Day" meta:resourcekey="rdoMonthlyOnDay" AutoPostBack="true" GroupName="Monthly" CssClass="RadioCss" />
                            </span>
                        </td>
                        <td style="width: 160px;vertical-align:bottom" id="tdDayOfTheMonth" runat="server">
                            <telerik:RadNumericTextBox ID="txtDaysOfMonth" CssClass="Right" Value="1" MinValue="1" Type="Number" ShowSpinButtons="true" MaxValue="31" Width="40%" runat="server">
                                <NumberFormat AllowRounding="False" DecimalDigits="0" NegativePattern="n"
                                    PositivePattern="n" />
                            </telerik:RadNumericTextBox>
                            <asp:Label ID="lblMonth" runat="server" meta:resourcekey="lblMonth" Text="of the month"></asp:Label>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="labelWidth" style="vertical-align:middle;">
                            <span>
                                <asp:RadioButton ID="rdoMonthlyOnThe" meta:resourcekey="rdoMonthlyOnThe" AutoPostBack="true" runat="server" Text="The" GroupName="Monthly" CssClass="RadioCss" />
                            </span>
                        </td>
                        <td id="tdTheOfTheMonth" runat="server" colspan="2" visible="false">
                            <telerik:RadComboBox ID="ddlWeekDayPart" Width="30%" Skin="Default"
                                runat="server">
                            </telerik:RadComboBox>
                            <telerik:RadComboBox ID="ddlWeekDay" Width="33%" Style="padding-left: 2px;" Skin="Default" runat="server">
                            </telerik:RadComboBox>
                            <asp:Label ID="lblMonth2" runat="server" meta:resourcekey="lblMonth" Text="of the month">  </asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel>

            <asp:Panel ID="pnlInterval" runat="server">
                <table class="colTable">
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblStartDate3" runat="server" meta:resourcekey="lblStartDate" Text="Start Date">  </asp:Label></td>
                        <td style="width: 160px;">
                            <telerik:RadDatePicker ID="dtpInterval" runat="server" Skin="Default">
                            </telerik:RadDatePicker>
                        </td>
                        <td></td>
                    </tr>
                    <tr class="labelWidth">
                        <td>
                            <asp:Label ID="lblTime5" runat="server" meta:resourcekey="lblTime" Text="Time">  </asp:Label></td>
                        <td style="width: 160px;">
                            <telerik:RadTimePicker ID="tpIntervalTime" runat="server" Skin="Default"></telerik:RadTimePicker>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkIntervalTimeless" runat="server" meta:resourcekey="chkIntervalTimeless" class="mobile-switch" Text="Timeless" />
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblEndDate4" runat="server" meta:resourcekey="lblEndDate" Text="End Date"></asp:Label></td>
                        <td style="width: 160px;">
                            <telerik:RadDatePicker Culture="English (United States)" ID="dtpIntervalEndDate" runat="server" Skin="Default">
                            </telerik:RadDatePicker>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblEvery4" runat="server" meta:resourcekey="lblEvery" Text="Every">  </asp:Label>
                        </td>
                        <td style="width: 160px;">
                            <telerik:RadNumericTextBox ID="txtInterval" CssClass="Right" Value="1" MinValue="1" Type="Number" ShowSpinButtons="true" Width="40%" runat="server">
                                <NumberFormat AllowRounding="False" DecimalDigits="0" NegativePattern="n"
                                    PositivePattern="n" />
                            </telerik:RadNumericTextBox>
                            <asp:Label ID="lblDays" runat="server" meta:resourcekey="lblDays" Text="days" Style="padding-left: 4px;">  </asp:Label></td>
                        <td></td>
                    </tr>

                </table>
            </asp:Panel>



        </div>
        <div class="col-8">
            <asp:Panel ID="pnlLinkedWorkOrders" runat="server">
                <telerik:RadGrid ID="rdgLinkedWorkOrders" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                    Width="100%" AutoGenerateColumns="False" AllowPaging="true" PageSize="10" AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowSorting="false" ShowStatusBar="true">
                    <PagerStyle Mode="NextPrevAndNumeric" PrevPagesToolTip="<%$Resources:PMWeb, Grid_PreviousPage %>" FirstPageToolTip="<%$Resources:PMWeb, Grid_FirstPage %>" LastPageToolTip="<%$Resources:PMWeb, Grid_LastPage %>" NextPageToolTip="<%$Resources:PMWeb, Grid_NextPages %>" PagerTextFormat="" AlwaysVisible="true" />
                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        DataKeyNames="Id" Width="100%" CommandItemDisplay="None" EditMode="InPlace"
                        InsertItemPageIndexAction="ShowItemOnFirstPage">
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="WO ID" HeaderStyle-Width="100px" UniqueName="Id" SortExpression="Id">
                                <ItemTemplate>
                                    <asp:HyperLink ID="hliId" runat="server" Text='<%# Eval("Id").ToString %>' NavigateUrl='<%# "WorkOrders.aspx?Id=" & CStr(Eval("Id"))%>'></asp:HyperLink>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Right" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderText="Scheduled" UniqueName="Scheduled" HeaderStyle-Width="150px" SortExpression="Scheduled">
                                <ItemTemplate>
                                    <asp:Label ID="lblScheduled" Text="&nbsp;" runat="server"></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn UniqueName="AssignedTo" HeaderText="Assigned To" HeaderStyle-Width="150px" SortExpression="AssignedTo">
                                <ItemTemplate>
                                    <span><%#IIf(Container.DataItem("AssignedTo") = String.Empty, "&nbsp;", Container.DataItem("AssignedTo"))%></span>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView><HeaderStyle Font-Size="8pt"></HeaderStyle>
                    <ClientSettings Resizing-AllowColumnResize="true">
                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="False" />
                    </ClientSettings>
                </telerik:RadGrid>
            </asp:Panel>
        </div>
    </div>
</div>


<asp:Button ID="btnUpdateDispatchBoard" CssClass="" Visible="false" Width="170px" Text="Create linked Work Orders" meta:resourcekey="btnUpdateDispatchBoard" runat="server" />

<asp:PlaceHolder ID="sharedCalendarPlaceHolder" runat="server" />

<asp:Button ID="btnSaveRecursAndContract" meta:resourcekey="btnSaveRecursAndContract" Visible="false" Width="100px" Text="Save" runat="server" />



