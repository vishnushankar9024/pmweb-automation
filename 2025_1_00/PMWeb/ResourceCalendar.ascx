<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ResourceCalendar.ascx.vb" Inherits="Website.ResourceCalendar1" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="calDaysOff">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgDaysOff" />
                <telerik:AjaxUpdatedControl ControlID="calDaysOff" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rdgDaysOff">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgDaysOff" />
                <telerik:AjaxUpdatedControl ControlID="calDaysOff" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<%--<table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
        <tr class="ToolBar">--%>
<%--<td style="width: 100px; padding: 5px">
                <b>
                    <asp:Label ID="lblCalendars" meta:resourcekey="lblCalendars" runat="server" Text="Calendars"></asp:Label></b>
            </td>
            <td colspan="2" style="width: 250px;" class="NoWrap">&nbsp;&nbsp;&nbsp;
                            <telerik:RadComboBox ID="ddlCalendars" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                                Skin="Default" Width="200px" AutoPostBack="True" NoWrap="True" AllowCustomText="True"
                                CausesValidation="False" Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                meta:resourcekey="ddlCalendars" DropDownWidth="350px"
                                ShowMoreResultsBox="True" EnableLoadOnDemand="true" CheckForDirt="True"
                                EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                            </telerik:RadComboBox>
            </td>--%>
<%--            <td style="width: 100%;">&nbsp;&nbsp;&nbsp;
              <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" >
                  <Items>
                      <telerik:RadToolBarButton SecurityButtonType="Add" ImageUrl="Images/ToolBar/NewDoc.png" CommandName="New" AccessKey="n" ToolTip="New (Alt+n)" CausesValidation="false"></telerik:RadToolBarButton>
                      <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png" CausesValidation="true" ValidationGroup="Save" CommandName="Save" AccessKey="s" ToolTip="Save (Alt+s)"></telerik:RadToolBarButton>
                      <telerik:RadToolBarButton SecurityButtonType="Delete" ImageUrl="Images/ToolBar/DeleteDoc.png" CausesValidation="false"
                          CommandName="Delete" AccessKey="d" ToolTip="Delete (Alt+d)" Value="Delete">
                      </telerik:RadToolBarButton>
                      <telerik:RadToolBarButton IsSeparator="true"></telerik:RadToolBarButton>
                       <telerik:RadToolBarButton SecurityButtonType="Copy" PostBack="false" CommandName="Copy" Value="CopyRecord" ImageUrl="Images/ToolBar/CopyRecord.png"> </telerik:RadToolBarButton>
            <telerik:RadToolBarButton SecurityButtonType="Read" ImageUrl="Images/ToolBar/Printer.png" ToolTip="Print" CommandName="Print"></telerik:RadToolBarButton>
                      <telerik:RadToolBarButton ImageUrl="Images/Toolbar/Help.png" ToolTip="<%$ Resources:PMWeb, RadToolBarButton_help %>" CausesValidation="false" Target="_blank" NavigateUrl="Help/PMWebUserManual_Scheduling.htm#ProjectCalendarDays"></telerik:RadToolBarButton>
                  </Items>
              </telerik:RadToolBar>
            </td>
        </tr>
    </table>--%>

    <div class="PMMainPage">
        <div class="row">
            <div class="col-4 col-4-left">
                <table class="colTable" style="margin-bottom:10px;">
                    <%--class="AllLightBlueBorder"--%>
                    <%--          <tr>
                                            <td style="width: 100px">
                                                <asp:Label ID="lblResource" meta:Resourcekey="lblResource" runat="server" Text="Resource"></asp:Label>
                                            </td>
                                            <td style="padding-left: 10px;">
                                               <telerik:RadComboBox ID="ddlResource" runat="server" EmptyMessage="Select a Resource..." 
                                                        Skin="Default" Width="200px"  NoWrap="True" AllowCustomText="True"
                                                        DropDownWidth="300px"  Height="400px" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                                        ShowMoreResultsBox="True" EnableLoadOnDemand="true" 
                                                        EnableVirtualScrolling="True" OnItemsRequested="ddl_ItemsRequested">
                                                        <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                    </telerik:RadComboBox>
                                                   <asp:RequiredFieldValidator ID="rfvResource" runat="server" ControlToValidate="ddlResource" ValidationGroup="Save"
                                                   CssClass="Validator" InitialValue="" meta:resourcekey="rfvResource" ErrorMessage="Select a resource."
                                                    Display="Dynamic" ForeColor=""></asp:RequiredFieldValidator>
                                                    <asp:CustomValidator ID="csvResource" runat="server" ControlToValidate="ddlResource" ValidationGroup="Save"
                                                   ClientValidationFunction="ValidateCombo" Display="Dynamic"  meta:resourcekey="csvResource" ErrorMessage="Select a resource."          
                                                   CssClass="Validator" >
                                                                </asp:CustomValidator> 
                                            </td>
                                        </tr>--%>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblRegularDaysOff" runat="server" Text="Regular Days Off" />
                        </td>
                        <td class="controlWidth">
                            <table style="width: 100%;" cellpadding="0" cellspacing="0">
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
                        <td style="padding-top:5px;" >
                            <asp:LinkButton runat="server" ID="btnApplyRegularDaysOff" CssClass="lnkButton" ValidationGroup="Submit" style="width:240px;padding-top:0;line-height:32px;font-size:12px !important;" >
                                <span runat="server" class="Icon btnApplyRegularDayOff"></span>
                                <span runat="server">
                                    <asp:Label runat="server" ID="lblApplyRegularDaysOff" meta:resourcekey="btnApplyRegularDaysOff" Text="Apply Regular Days Off"></asp:Label>
                                </span>
                            </asp:LinkButton>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" width="100%" style="padding-top:10px;">
                            <telerik:RadCalendar ID="calDaysOff" runat="server" Width="100%" Height="300px" EnableMultiSelect="false"
                                EnableNavigationAnimation="true" ShowOtherMonthsDays="false" AutoPostBack="true" CssClass="calDaysOff"
                                Skin="Default">
                            </telerik:RadCalendar>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="col-4  col-4-right">
                <telerik:RadGrid Width="100%" runat="server" ID="rdgDaysOff" AutoGenerateColumns="False" ShowStatusBar="True" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
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
                                    <telerik:RadDatePicker Width="145px" ID="rdpDate" Style="display: inline" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01" Calendar-ShowOtherMonthsDays="false" OnPreRender="rdpDate_PreRender" Calendar-AutoPostBack="true"
                                        EnableTyping="True">
                                    </telerik:RadDatePicker>
                                    <asp:RequiredFieldValidator ID="rfvDate" runat="server" ControlToValidate="rdpDate"
                                        CssClass="Validator" Display="Dynamic" ForeColor="" ErrorMessage="Enter a date.">
                                    </asp:RequiredFieldValidator>
                                </EditItemTemplate>
                                <HeaderStyle Width="130px" />
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
                                <HeaderStyle Width="130px" />
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

                                <HeaderStyle Width="130px" />
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

                                <asp:LinkButton ID="btnSave" runat="server" CommandName="PerformInsert" CssClass="GridCmdPerformInsert"
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
            </div>
        </div>
    </div>



