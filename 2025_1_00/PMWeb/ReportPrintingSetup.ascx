<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ReportPrintingSetup.ascx.vb" Inherits="Website.ReportPrintingSetup" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <%--    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnSave">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="tblReportPrinting" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>--%>
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="ddlObjectTypes">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ddlObjectTypes" />
                <telerik:AjaxUpdatedControl ControlID="rdgParameters" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>

</telerik:RadAjaxManagerProxy>
<telerik:RadStyleSheetManager ID="rdstylemanager1" runat="server">
    <StyleSheets>
        <telerik:StyleSheetReference Assembly="Telerik.web.UI" Name="Telerik.Web.UI.Skins.Office2007.Calendar.Office2007.css" />

    </StyleSheets>

</telerik:RadStyleSheetManager>
<div class="PMMainPage JustifyContent">
    <div class="row">
        <div class="col-4 col-4-left">
            <table class="colTable">
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblReportName" Text="Report" runat="server" meta:resourcekey="lblReportName"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtReport" Width="100%" runat="server" ReadOnly="true"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblRecordType" Text="Associate With Record Type11" runat="server" meta:resourcekey="lblRecordType" ToolTip="Associate With Record Type"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <telerik:RadComboBox ID="ddlObjectTypes" runat="server" Filter="Contains" MarkFirstMatch="true" AllowCustomText="true"
                            LoadingMessage="<%$ Resources:PMWeb, Loading %>" Height="250px" Width="100%" AutoPostBack="True" NoWrap="True"
                            CloseDropDownOnBlur="true" EnableItemCaching="false" EnableVirtualScrolling="true"
                            EnableLoadOnDemand="True" ShowMoreResultsBox="true" OnItemsRequested="ddl_ItemsRequested">
                        </telerik:RadComboBox>
                        <asp:CompareValidator ID="rfvObjectTypes" runat="server"
                            ControlToValidate="ddlObjectTypes" CssClass="Validator"
                            meta:resourcekey="csvRecordType" Display="Dynamic" ForeColor="" Operator="NotEqual" ValueToCompare="0">
                        </asp:CompareValidator>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" width="100%">
                        <table class="colTable">
                            <tr>
                                <td width="95%" style="color: #666666;">
                                    <asp:Label ID="lblDefault" runat="server" Text="Default Report11" meta:resourcekey="chkDefault"></asp:Label>
                                </td>
                                <td>
                                    <asp:CheckBox ID="chkDefault" runat="server" Style="float: right"/>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <fieldset>
                            <legend>
                                <asp:Label ID="lblParam" runat="server" Text="Report Parameters" meta:Resourcekey="lblParam"></asp:Label>
                            </legend>
                            <telerik:RadGrid ID="rdgParameters" Width="100%" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                AutoGenerateColumns="False" ShowStatusBar="True" Font-Size="8px" GridLines="None" FitParentContainer="true">
                                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>
                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                    CommandItemDisplay="None" DataKeyNames="Id" EditMode="InPlace" InsertItemPageIndexAction="ShowItemOnFirstPage">
                                    <Columns>
                                        <telerik:GridTemplateColumn HeaderText="Name"
                                            UniqueName="Name">
                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%#Container.DataItem("ParamName")%>' CssClass="NoWrap" ID="lblParamName"></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle Width="100px" />
                                            <ItemStyle Wrap="false " />
                                        </telerik:GridTemplateColumn>


                                        <telerik:GridTemplateColumn HeaderText="PMWeb Field"
                                            UniqueName="Field">
                                            <ItemTemplate>
                                                <telerik:RadComboBox ID="ddlFields" runat="server"
                                                    Width="165px">
                                                </telerik:RadComboBox>
                                            </ItemTemplate>
                                            <HeaderStyle Width="175px" />
                                            <ItemStyle HorizontalAlign="Left" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderText="Default"
                                            UniqueName="Default">
                                            <ItemTemplate>
                                                <asp:TextBox Width="100px" runat="server" Text='<%#Container.DataItem("Default")%>' ID="txtDefault"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle Width="120px" />
                                            <ItemStyle />
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <EditFormSettings>
                                        <EditColumn CancelImageUrl="Cancel.gif" EditImageUrl="Edit.gif" InsertImageUrl="Update.gif"
                                            UpdateImageUrl="Update.gif">
                                        </EditColumn>
                                    </EditFormSettings>
                                    <CommandItemTemplate>
                                    </CommandItemTemplate>
                                </MasterTableView>
                                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                <HeaderContextMenu EnableViewState="false">
                                </HeaderContextMenu>
                                <ValidationSettings ValidationGroup="ObjectImport" EnableValidation="true" CommandsToValidate="SaveChanges" />
                            </telerik:RadGrid>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <br />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center">
                        <asp:Button ID="btnSave" runat="server" meta:resourcekey="btnSave" Text="Save" Style="margin-right: 10px; max-width: 200px;" ValidationGroup="Save" />
                    </td>
                </tr>
            </table>
        </div>
        <div class="col-4 col-4-middle">
            <table class="colTable">
                <tr>
                    <td style="width: 100%">
                        <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%"
                            ClientEvents-OnResponseEnd="ScheduleResponseEnd" ClientEvents-OnRequestStart="ScheduleRequestStart">
                            <fieldset>
                                <legend>
                                    <asp:Label ID="lblSchedule" runat="server" Text="Schedule11" meta:Resourcekey="lblSchedule"></asp:Label>
                                </legend>
                                <table style="width: 100%" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label ID="lblReportSchedule" runat="server" meta:resourcekey="lblReportSchedule" Text="Schedule This Report11"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <telerik:RadComboBox ID="ddlSchedule" runat="server" AutoPostBack="true" CausesValidation="False"
                                                NoWrap="true" Skin="Default" Width="100%">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="<%$ Resources:Asset ,ListItem_Never%>" Value="Never" />
                                                    <telerik:RadComboBoxItem Text="<%$ Resources:Asset ,ListItem_Daily%>" Value="Daily" />
                                                    <telerik:RadComboBoxItem Text="<%$ Resources:Asset ,ListItem_Monthly%>" Value="Monthly" />
                                                    <telerik:RadComboBoxItem Text="<%$ Resources:Asset ,ListItem_Weekly%>" Value="Weekly" />
                                                </Items>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 100%" colspan="2">
                                            <asp:Panel runat="server" ID="pnlScheduleDetails">
                                                <table style="width: 100%; margin-top: 8px;" cellspacing="0" cellpadding="0" class="colTable">
                                                    <tr>
                                                        <td>
                                                            <asp:Panel ID="pnlWeekly" runat="server">
                                                                <table class="colTable">
                                                                    <tr>
                                                                        <td class="labelWidth">
                                                                            <asp:Label ID="lblWeekDays" runat="server" Text="Day(s) of the Week11" meta:resourcekey="lblWeekDays"></asp:Label>
                                                                        </td>
                                                                        <td class="controlWidth">
                                                                            <telerik:RadComboBox ID="ddlWeekDays" runat="server" AutoPostBack="False" CausesValidation="False"
                                                                                CloseDropDownOnBlur="true" NoWrap="true" Skin="Default" Width="100%" CheckBoxes="true" CheckedItemsTexts="DisplayAllInInput">
                                                                                <Items>
                                                                                </Items>
                                                                            </telerik:RadComboBox>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table style="width: 100%; margin-top: 8px;" cellspacing="0" cellpadding="0" class="colTable">
                                                    <tr>
                                                        <td colspan="2">
                                                            <asp:Panel ID="pnlMonthly" runat="server">
                                                                <table class="colTable">
                                                                    <tr>
                                                                        <td class="labelWidth">
                                                                            <asp:RadioButton ID="rdoMonthlyOnDay" Checked="true" AutoPostBack="true" runat="server" CssClass="RadioCss" Text="Day11" meta:resourcekey="rdoMonthlyOnDay" GroupName="Monthly" />
                                                                        </td>
                                                                        <td class="controlWidth">
                                                                            <telerik:RadNumericTextBox ID="txtDaysOfMonth" CssClass="Right" Value="1" MinValue="1" Type="Number" ShowSpinButtons="true" MaxValue="31" Width="100%" runat="server">
                                                                                <NumberFormat AllowRounding="False" DecimalDigits="0" NegativePattern="n"
                                                                                    PositivePattern="n" />
                                                                            </telerik:RadNumericTextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="labelWidth">
                                                                            <asp:RadioButton ID="rdoMonthlyOnThe" AutoPostBack="true" meta:resourcekey="rdoMonthlyOnThe" CssClass="RadioCss" runat="server" Text="The11" GroupName="Monthly" />
                                                                        </td>
                                                                        <td class="controlWidth">
                                                                            <table style="width: 100%" cellspacing="0" cellpadding="0">
                                                                                <tr>
                                                                                    <td style="width: 50%;">
                                                                                        <telerik:RadComboBox ID="ddlWeekDayPart" Width="116px" Skin="Default" runat="server"></telerik:RadComboBox>
                                                                                    </td>
                                                                                    <td style="width: 50%; padding-left: 8px;">
                                                                                        <telerik:RadComboBox ID="ddlMonthWeekDays" Width="116px" Skin="Default" runat="server"></telerik:RadComboBox>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblFrom" runat="server" meta:resourcekey="lblFrom" Text="From11"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <telerik:RadDatePicker ID="dtpFromDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                                Width="100%" Skin="Default" EnableTyping="True">
                                                                <DateInput ID="DateInput2" Skin="Default" runat="server"></DateInput>
                                                            </telerik:RadDatePicker>
                                                            <asp:RequiredFieldValidator ID="rfvDFromDate" ControlToValidate="dtpFromDate"
                                                                runat="server" CssClass="Validator" Display="Dynamic"
                                                                ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                            </asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblTo" runat="server" meta:resourcekey="lblTo" Text="To11"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <telerik:RadDatePicker ID="dtpToDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                                Width="100%" Skin="Default" EnableTyping="True">
                                                                <DateInput ID="DateInput1" Skin="Default" runat="server"></DateInput>
                                                            </telerik:RadDatePicker>
                                                            <asp:RequiredFieldValidator ID="rfvToDate" ControlToValidate="dtpToDate"
                                                                runat="server" CssClass="Validator" Display="Dynamic"
                                                                ValidationGroup="Save" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                            </asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblReportFormat" runat="server" meta:resourcekey="lblReportFormat" Text="Report Format"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <telerik:RadComboBox ID="ddlFormat" runat="server" CausesValidation="False"
                                                                NoWrap="true" Skin="Default" Width="100%">
                                                                <Items>
                                                                    <telerik:RadComboBoxItem Text="PDF" Value="PDF" />
                                                                    <telerik:RadComboBoxItem Text="XML" Value="XML" />
                                                                    <telerik:RadComboBoxItem Text="CSV" Value="CSV" />
                                                                    <telerik:RadComboBoxItem Text="MHTML" Value="MHTML" />
                                                                    <telerik:RadComboBoxItem Text="Excel" Value="EXCEL" />
                                                                    <telerik:RadComboBoxItem Text="TIFF" Value="TIFF" />
                                                                    <telerik:RadComboBoxItem Text="Word" Value="Word" />
                                                                </Items>
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <div style="float: left;">
                                                                <asp:Label ID="lblUsers" Text="User(s)11" meta:resourcekey="lblUsers" runat="server"></asp:Label>
                                                            </div>
                                                            <div style="float: right; padding-top: 8px;">
                                                                <asp:LinkButton runat="server" ID="imgbtnfilterUsers" CssClass="SearchButton"
                                                                    OnClientClick="return OpenSelectUserPopup()">
                                                                                            <span class="Icon"></span>
                                                                </asp:LinkButton>
                                                            </div>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <div style="width: 100%; height: 82px; max-height: 82px; overflow: auto; box-sizing: border-box; float: left"
                                                                class="AllLightBlueBorder scroll-pane" id="dvUser">
                                                                <span id="spnToUser" runat="server" style="white-space: nowrap;"></span>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <div style="float: left;">
                                                                <asp:Label ID="lblContacts" Text="Contact(s)11" meta:resourcekey="lblContacts" runat="server"></asp:Label>
                                                            </div>
                                                            <div style="float: right; padding-top: 8px;">
                                                                <asp:LinkButton runat="server" ID="imgbtnfilterContacts" CssClass="SearchButton"
                                                                    OnClientClick="return OpenReminderMultipleCompanyFilterPopup(this.id.replace('imgbtnfilterContacts','spnToContacts'),this.id.replace('imgbtnfilterContacts','spnToContacts'),this.id.replace('imgbtnfilterContacts','NotExistIds'),'Contacts','Report')">
                                                                                            <span class="Icon"></span>
                                                                </asp:LinkButton>
                                                            </div>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <div style="width: 100%; height: 82px; max-height: 82px; overflow: auto; box-sizing: border-box; float: left"
                                                                class="AllLightBlueBorder scroll-pane" id="dvContact">
                                                                <span id="spnToContacts" runat="server" style="white-space: nowrap;"></span>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblCCs" Text="CC(s)11" meta:resourcekey="lblCCs" runat="server"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <asp:TextBox ID="txtCCs" runat="server" Height="50px" Width="100%" TextMode="MultiLine"></asp:TextBox>
                                                            <asp:CustomValidator runat="server" ID="cvEmails" ControlToValidate="txtCCs" CssClass="Validator" ErrorMessage="Wrong Emails" ClientValidationFunction="CheckMails" meta:resourcekey="cvCCEmails" Display="Dynamic" ValidationGroup="Save" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblSubject" Text="Subject11" meta:resourcekey="lblSubject" runat="server"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <asp:TextBox ID="txtSubject" runat="server" Width="100%"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="labelWidth">
                                                            <asp:Label ID="lblMessage" Text="Message11" meta:resourcekey="lblMessage" runat="server"></asp:Label>
                                                        </td>
                                                        <td class="controlWidth">
                                                            <asp:TextBox ID="txtMessage" runat="server" Height="50px" Width="100%" TextMode="MultiLine"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                            <asp:Button runat="server" ID="btnAddUsers" CssClass="Hide" CausesValidation="false" />
                            <asp:Button runat="server" ID="btnRemoveUsers" CssClass="Hide" CausesValidation="false" />
                            <asp:HiddenField ID="hfdeletedUser" runat="server" Value="0" />
                            <asp:HiddenField ID="hfdeletedContact" runat="server" Value="0" />
                            <asp:Button runat="server" ID="btnRemoveContact" CssClass="Hide" CausesValidation="false" />
                            <asp:HiddenField ID="HiddenField1" runat="server" Value="0" />
                            <asp:Button runat="server" ID="btnAddContacts" CssClass="Hide" CausesValidation="false" />
                        </telerik:RadAjaxPanel>
                    </td>
                </tr>
            </table>
        </div>
        <div class="col-4 col-4-right"></div>
    </div>
</div>
