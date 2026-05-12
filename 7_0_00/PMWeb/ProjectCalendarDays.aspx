<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="ProjectCalendarDays.aspx.vb" Inherits="Website.ProjectCalendarDays" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">

    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <style type="text/css">
        .RadCalendar_Default .rcRow td, .RadCalendar_Default .rcWeek th {
            text-align: center;
        }

        .chkButton {
            border: 1px solid #666666;
            text-align: center;
            text-transform: uppercase;
            color: #666666;
            line-height: 32px;
            border-radius: 4px;
            background-color: #FFFFFF;
            vertical-align: central;
            text-decoration: none;
            width: 100%;
            display: inline-block;
            cursor: pointer;
        }

            .chkButton:before {
                width: 16px;
                height: 16px;
                display: inline-block;
                background-image: url('CSS/Images/ResponsiveIcons/16Enabled.png');
                background-position: -336px;
                margin-right: 5px;
                content: "";
                position: relative;
                display: inline-block;
                top: 3px;
            }

        @media screen and (max-width: 843px) and (min-width: 320px) {
            .documentSinglePage {
                margin-top: 20px;
                margin-bottom: 60px;
            }
        }
    </style>
    <script type="text/javascript">
        function CustomClientButtonClicking(sender, args) {
            if (args.get_item().get_value() == 'CopyRecord') {
                return CopyCalendarPopup();

            }
        }

        function CopyCalendarPopup() {
            var wnd = window.radopen('ProjectCalendarsLookup.aspx');
            wnd.setSize(465, 570);
            wnd.add_close(RefreshCalendar);
            wnd.Center();
            return false;
        }

        function RefreshCalendar() {
            __doPostBack("ddlCalendars", 'CopyCalendar');
        }


        function DateSelected(sender, eventArgs) {
            //var newDate = eventArgs.get_newDate();
            //newDate.getMonth() + 1, // month values are 0-based
            //newDate.getDate(),
            //newDate.getFullYear();
        }

    </script>

    <%--    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgDaysOff">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgDaysOff" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="calDaysOff"  LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="calDaysOff">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgDaysOff" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="calDaysOff"  LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
             <telerik:AjaxSetting AjaxControlID="btnApplyRegularDaysOff">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="calDaysOff"  LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="rdgDaysOff" LoadingPanelID="ldpPM" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>--%>

    <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td>
                <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td class="ToolbarTd HideOnMobileToolbar">
                            <asp:Label ID="lblCalendars" meta:resourcekey="lblCalendars" runat="server" Text="Calendars" />
                        </td>
                        <td style="width: 240px !important;" class="ToolbarTd">
                            <telerik:RadComboBox ID="ddlCalendars" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                                Skin="Default" Width="100%" AutoPostBack="True" NoWrap="True" AllowCustomText="True"
                                CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                meta:resourcekey="ddlCalendars"
                                ShowMoreResultsBox="True" EnableLoadOnDemand="true" CheckForDirt="True"
                                EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested" DropDownCssClass="ToolbarDropdown">
                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                            </telerik:RadComboBox>
                        </td>
                        <td valign="middle" style="vertical-align: middle;" class="ToolbarTd">
                            <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" OnClientButtonClicking="CustomClientButtonClicking">
                                <Items>
                                    <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CommandName="Save"
                                        AccessKey="s" ToolTip="Save (Alt+s)">
                                    </telerik:RadToolBarButton>

                                    <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                                        SecurityButtonType="Add" EnableDefaultButton="false" PostBack="true">
                                        <Buttons>
                                            <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New"
                                                AccessKey="n" ToolTip="New (Alt+n)" CausesValidation="false">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton SecurityButtonType="Copy" PostBack="false" CommandName="Copy"
                                                Value="CopyRecord" ImageUrl="Images/ToolBar/CopyRecord.png" ValidationGroup="Save">
                                            </telerik:RadToolBarButton>
                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>

                                    <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CausesValidation="false"
                                        CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete">
                                    </telerik:RadToolBarButton>

                                    <%--      <telerik:RadToolBarButton IsSeparator="true" CssClass="HideOnMobileToolbar">
                                    </telerik:RadToolBarButton>--%>

                                    <%--  <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print"
                                        SecurityButtonType="Read" EnableDefaultButton="false" PostBack="false" OuterCssClass="HideOnMobileToolbar" CssClass="ToolbarPrint">
                                        <Buttons>
                                            <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Printer.png" ToolTip="Print" CommandName="Print">
                                            </telerik:RadToolBarButton>
                                        </Buttons>
                                    </telerik:RadToolBarSplitButton>--%>

                                    <%--  <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" Value="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                                        <ItemTemplate>
                                            <telerik:RadMenu runat="server" ID="MobileRadmen" CssClass="MoreMenu" ClickToOpen="true" OnClientItemClicked="MoreMenuClicked">
                                                <Items>
                                                    <telerik:RadMenuItem CssClass="menuMore">
                                                        <Items>
                                                            <telerik:RadMenuItem EnableImageSprite="true" Text="Print" Value="Print" CssClass="Print">
                                                                <Items>
                                                                    <telerik:RadMenuItem Text="BI Reporting" Value="ViewReports"></telerik:RadMenuItem>
                                                                </Items>
                                                            </telerik:RadMenuItem>
                                                        </Items>
                                                    </telerik:RadMenuItem>
                                                </Items>
                                            </telerik:RadMenu>
                                        </ItemTemplate>
                                    </telerik:RadToolBarButton>--%>

                                    <telerik:RadToolBarButton ImageUrl="Images/Toolbar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_Scheduling.htm#ProjectCalendarDays"></telerik:RadToolBarButton>
                                </Items>
                            </telerik:RadToolBar>
                        </td>
                        <td></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

    <telerik:RadAjaxPanel ID="pnlDetailPane" runat="server" Width="100%" LoadingPanelID="ldpPM">

        <div class="PMMainPage documentSinglePage">
            <div class="row">
                <div class="col-4 col-4-left">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDescription" runat="server" Text="Description*" meta:resourcekey="lblDescription"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtDescription" MaxLength="200" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription"
                                    CssClass="Validator" Display="Dynamic" ForeColor="" meta:resourcekey="rfvDescription" ErrorMessage="Required"></asp:RequiredFieldValidator>
                                <asp:Label ID="lblMessage" runat="server" CssClass="Validator"></asp:Label>
                            </td>
                        </tr>

                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblRegularDaysOff" runat="server" Text="Regular Days Off" />
                            </td>
                            <td class="controlWidth">
                                <table width="100%" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <asp:Label runat="server" Style="margin-left: 4px;" ID="lblSunday" meta:resourcekey="lblSunday" Text="Su" />
                                        </td>

                                        <td>
                                            <asp:Label runat="server" Style="margin-left: 5px;" ID="lblMonday" meta:resourcekey="lblMonday" Text="M" />
                                        </td>

                                        <td>
                                            <asp:Label runat="server" Style="margin-left: 4px;" ID="lblTuesday" meta:resourcekey="lblTuesday" Text="Tu" />
                                        </td>

                                        <td>
                                            <asp:Label runat="server" Style="margin-left: 4px;" ID="lblWednesday" meta:resourcekey="lblWednesday" Text="W" />
                                        </td>

                                        <td>
                                            <asp:Label runat="server" Style="margin-left: 3px;" ID="lblThursday" meta:resourcekey="lblThursday" Text="Th" />
                                        </td>

                                        <td>
                                            <asp:Label runat="server" Style="margin-left: 8px;" ID="lblFriday" meta:resourcekey="lblFriday" Text="F" />
                                        </td>

                                        <td>
                                            <asp:Label runat="server" Style="margin-left: 7px;" ID="lblSaturday" meta:resourcekey="lblSaturday" Text="Sa" />
                                        </td>

                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:CheckBox ID="chkSunday" runat="server" />
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="chkMonday" runat="server" />
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="chkTuesday" runat="server" />
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="chkWednesday" runat="server" />
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="chkThursday" runat="server" />
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="chkFriday" runat="server" />
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="chkSaturday" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <asp:LinkButton runat="server" Width="100%" Style="height: 32px;" CssClass="chkButton" ID="btnApplyRegularDaysOff" Text="Apply Regular Days Off" meta:resourcekey="btnApplyRegularDaysOff">

                                </asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <%-- <td>
                                        <asp:Label ID="lblCalendar" runat="server" Text="Calendar" meta:resourcekey="lblCalendar"></asp:Label>
                                    </td>--%>
                            <td colspan="2" style="padding-top: 20px">
                                <telerik:RadCalendar ID="calDaysOff" runat="server" Width="100%" Height="300px" EnableViewState="false" EnableMultiSelect="false"
                                    EnableNavigationAnimation="true" ShowOtherMonthsDays="false" AutoPostBack="true"
                                    Skin="Default">
                                    <ClientEvents OnDateSelected="DateSelected" />
                                </telerik:RadCalendar>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-4 col-4-right">
                    <fieldset>
                        <legend>
                            <asp:Label runat="server" ID="lblDaysOff" Text="Days Off"></asp:Label>
                        </legend>
                        <telerik:RadGrid runat="server" ID="rdgDaysOff" AutoGenerateColumns="False" ShowStatusBar="True" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" CssClass="LightWeight" PageSize="10" AllowPaging="true"
                            Font-Size="8px" ShowGroupPanel="False" AllowMultiRowEdit="True" AllowMultiRowSelection="True" AllowSorting="False" GridLines="None">
                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" Width="100%"
                                CommandItemDisplay="Top" TableLayout="Fixed"
                                UseAllDataFields="true"
                                EditMode="InPlace" EnableHeaderContextMenu="False">
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="Date" ItemStyle-Wrap="false" UniqueName="Day" DataField="Day"
                                        SortExpression="Day" Groupable="false">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblDay" Text='<%#FormatDate(CDate(Container.DataItem("Day")))%>' />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <telerik:RadDatePicker Width="100%" ID="rdpDate" Style="display: inline" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Calendar-ShowOtherMonthsDays="false" OnPreRender="rdpDate_PreRender" Calendar-AutoPostBack="true"
                                                EnableTyping="True">
                                            </telerik:RadDatePicker>
                                            <asp:RequiredFieldValidator ID="rfvDate" runat="server" ControlToValidate="rdpDate"
                                                CssClass="Validator" Display="Dynamic" ForeColor="" ErrorMessage="Enter a date.">
                                            </asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="100px" />
                                        <ItemStyle HorizontalAlign="Right" />
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="Description" ItemStyle-Wrap="false" UniqueName="Description" DataField="Description"
                                        SortExpression="Description" Groupable="false">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblDescription" Text='<%#Eval("Description")%>' />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox runat="server" ID="txtDescription" Text='<%#Eval("Description")%>' />
                                        </EditItemTemplate>
                                        <HeaderStyle Width="200px" />
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="Type" ItemStyle-Wrap="false" UniqueName="Type" DataField="Type"
                                        SortExpression="Type" Groupable="false">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblType" Text='<%#IIf(CStr(Eval("Type")) = 1, "Off", "Exception")%>' />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:Label ID="lblEditType" runat="server" Text='<%#IIf(CStr(Eval("Type")) = 1, "Off", "Exception")%>' />
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:Label ID="lblEditType" runat="server" Text="Off" />
                                        </InsertItemTemplate>

                                        <HeaderStyle Width="90px" />
                                    </telerik:GridTemplateColumn>
                                </Columns>

                                <CommandItemTemplate>
                                    <div style="padding: 2px">
                                        <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Edit" CssClass="GridCmdEditRows"
                                            CommandName="EditRows" Visible='<%# rdgDaysOff.EditIndexes.Count = 0 And (Not rdgDaysOff.MasterTableView.IsItemInserted)%>'>
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblEditSelectedLines" runat="server" meta:resourcekey="lblEditSelectedLines" Text="Edit Selected Lines"></asp:Label>&nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" CssClass="GridCmdUpdateEdited"
                                            CommandName="UpdateEdited" Visible='<%# rdgDaysOff.EditIndexes.Count > 0%>'>
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblUpdateRecords" runat="server" meta:resourcekey="lblUpdateRecords" Text="Update"></asp:Label>&nbsp;&nbsp;
                                        </asp:LinkButton>

                                        <asp:LinkButton ID="btnSave" runat="server" CausesValidation="False" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
                                            SecurityButtonType="AddEditMode_Add"
                                            Visible='<%# rdgDaysOff.MasterTableView.IsItemInserted%>' meta:resourcekey="btnSaveResource1">
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblSave" runat="server" Text="Save" meta:resourcekey="lblSave"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>

                                        <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode" CssClass="GridCmdCancelAll"
                                            CommandName="CancelAll" Visible='<%# rdgDaysOff.EditIndexes.Count > 0 Or rdgDaysOff.MasterTableView.IsItemInserted%>'>
                                            <span class="Icon"></span>
                                            <asp:Label ID="lblCancel" runat="server" meta:resourcekey="lblCancel" Text="Cancel"></asp:Label>&nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false"
                                            SecurityButtonType="ItemMode_Add" CssClass="GridCmdInitNewRow"
                                            CommandName="InitNewRow" Visible='<%# rdgDaysOff.EditIndexes.Count = 0 And (Not rdgDaysOff.MasterTableView.IsItemInserted)%>'>
                                            <span class="Icon"></span>
                                            <asp:Label Text="Add" runat="server" ID="lblAdd" meta:resourcekey="lblAdd"></asp:Label>&nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" CausesValidation="false" OnClientClick="javascript:return ConfirmDelete();"
                                            SecurityButtonType="ItemMode_Delete" CssClass="GridCmdDeleteRows"
                                            Visible='<%# rdgDaysOff.EditIndexes.Count = 0 And (Not rdgDaysOff.MasterTableView.IsItemInserted)%>'
                                            runat="server" CommandName="DeleteRows">
                                            <span class="Icon"></span>
                                            <asp:Label runat="server" Text="Delete selected lines" ID="lblDelete" meta:resourcekey="lblDelete"></asp:Label>&nbsp;&nbsp;
                                        </asp:LinkButton>
                                    </div>
                                </CommandItemTemplate>
                            </MasterTableView>
                            <ClientSettings ClientEvents-OnRowDblClick="RowDblClick">
                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                            </ClientSettings>
                        </telerik:RadGrid>
                    </fieldset>
                </div>
            </div>
        </div>

    </telerik:RadAjaxPanel>



</asp:Content>
