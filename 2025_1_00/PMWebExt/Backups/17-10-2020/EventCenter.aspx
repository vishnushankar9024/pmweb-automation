<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="EventCenter.aspx.vb" Inherits="Website.EventCenter" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">
    <script type="text/javascript">

        function OpenDeletePopup(totalNumberofSelectedLines) {
            if (totalNumberofSelectedLines > 0) {
                OpenPOPUp("EventCenterDeleteConfirmPopup.aspx?TotalNumber=" + totalNumberofSelectedLines, 400, 150, false);
            }


            return false;
        }
        function TryOpenDeletPopup() {
            var btnOpenDeletePopup = $("[id$=btnOpenDeletePopup]");
            btnOpenDeletePopup.click();
            return false;

        }
        function OpenSnoozePopup(TotalNumber, SystemType, EventUserId) {
            if (TotalNumber == 1) {
                OpenPOPUp("SnoozePopup.aspx?TotalNumber=" + TotalNumber + "&Id=" + EventUserId + "&SystemType=" + SystemType, 400, 150, false);
                return false;
            }
            if (TotalNumber > 1) {
                OpenPOPUp("SnoozePopup.aspx?TotalNumber=" + TotalNumber, 400, 150, false);
            }
            return false;
        }
        function TryOpenSnoozePopup() {
            var btnOpenSnoozePopup = $("[id$=btnOpenSnoozePopup]");
            btnOpenSnoozePopup.click();
            return false;
        }
        function sldDate_Changed(sender, args) {
            var hdnMaxdate = $("[id$=hdnMaxdate]")[0];
            var hdnDateFormat = $("[id$=hdnDateFormat]");
            var dateParts = hdnMaxdate.value.split("-");
            var dtFrom = new Date(dateParts[0], dateParts[1] - 1, dateParts[2]);
            var dtTo = new Date(dateParts[0], dateParts[1] - 1, dateParts[2]);
            dtFrom.setDate(dtFrom.getDate() + sender.get_selectionStart());
            dtTo.setDate(dtTo.getDate() + sender.get_selectionEnd());
            $("span[id$='lblFromDate']").html(dtFrom.format(hdnDateFormat[0].value));
            $("span[id$='lblToDate']").html(dtTo.format(hdnDateFormat[0].value));
        }
    </script>
    <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rdgEvents">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgEvents" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="btndeleteSelectedLines" />
                    <telerik:AjaxUpdatedControl ControlID="sldDate" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btndeleteSelectedLines">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgEvents" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="btndeleteSelectedLines" />
                    <telerik:AjaxUpdatedControl ControlID="sldDate" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnOpenSnoozePopup">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnOpenSnoozePopup" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnOpenDeletePopup">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnOpenDeletePopup" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="sldDate">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdgEvents" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="btndeleteSelectedLines" />
                    <telerik:AjaxUpdatedControl ControlID="sldDate" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <table width="100%" cellpadding="0" cellspacing="0">
        <tr class="ToolBar">
            <td style="width: 300px" class="ToolbarTd">
                <table style="width: 300px; padding: 2px" cellpadding="0" cellspacing="0">
                    <tr class="ToolBarTd">
                        <td style="width: 100px;padding-right:10px;">
                            <asp:Label ID="lblFromDate" runat="server"></asp:Label>
                        </td>
                        <td style="width: 180px">
                            <telerik:RadSlider runat="server" ID="sldDate" IsSelectionRangeEnabled="true" Width="180px" LargeChange="1"
                                SmallChange="1" AutoPostBack="true" Skin="Default" OnClientValueChange="sldDate_Changed"
                                ShowDecreaseHandle="false" ShowIncreaseHandle="false" ShowDragHandle="true" />
                        </td>
                        <td style="width: 100px;padding-left:10px;" align="right">
                            <asp:Label ID="lblToDate" runat="server"></asp:Label>
                        </td>

                    </tr>
                </table>
            </td>
            <td>
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                    <Items>
                    </Items>
                </telerik:RadToolBar>
            </td>
        </tr>
    </table>

    <asp:HiddenField runat="server" ID="hdnDateFormat"></asp:HiddenField>
    <telerik:RadGrid ID="rdgEvents" runat="server"  CssClass="documentSinglePage"
        AutoGenerateColumns="False" ShowStatusBar="false" ShowFooter="False"
        Font-Size="8px" PageSize="20" AllowPaging="True" ShowGroupPanel="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
        AllowMultiRowEdit="true" AllowMultiRowSelection="True" AllowSorting="True" GridLines="None" AllowFilteringByColumn="true">
        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
            DataKeyNames="Id" CommandItemDisplay="Top" InsertItemDisplay="Top" TableLayout="Fixed"
            Width="100%" UseAllDataFields="true" InsertItemPageIndexAction="ShowItemOnFirstPage" ClientDataKeyNames="EventUserId,SystemType"
            EditMode="InPlace" EnableHeaderContextMenu="true" ShowGroupFooter="false" GroupLoadMode="Client">
            <Columns>
                <telerik:GridClientSelectColumn HeaderStyle-Width="30px" Groupable="false" UniqueName="Select" Reorderable="true"></telerik:GridClientSelectColumn>
                <telerik:GridTemplateColumn HeaderText="System ID" UniqueName="SystemID" ItemStyle-HorizontalAlign="Right"
                    SortExpression="SystemID" GroupByExpression="SystemID [GridColumn_SystemID] Group By SystemID ASC"
                    Reorderable="true" DataField="SystemID" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <span>
                            <%#Container.DataItem("SystemID")%></span>

                    </ItemTemplate>
                    <HeaderStyle Width="90px"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Right" Wrap="false"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Event Type" UniqueName="EventType" SortExpression="EventType" DataField="EventType"
                    ItemStyle-HorizontalAlign="Right" GroupByExpression="EventType [GridColumn_EventType] Group By EventType ASC"
                    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("EventType") = String.Empty, "&nbsp;", Container.DataItem("EventType"))%></span>
                    </ItemTemplate>
                    <HeaderStyle Width="80px"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Subject" UniqueName="Subject" SortExpression="Subject"
                    GroupByExpression="Subject [GridColumn_Subject] Group By Subject" DataField="Subject" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("Subject") = String.Empty, "&nbsp;", Container.DataItem("Subject"))%></span>
                    </ItemTemplate>
                    <HeaderStyle Width="150px" Wrap="false"></HeaderStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Event Date" SortExpression="EventDate"
                    UniqueName="EventDate" DataField="EventDate" GroupByExpression="EventDate [GridColumn_EventDate] Group By EventDate ASC"
                    CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <span><%# FormatDate(Container.DataItem("EventDate"))%>&nbsp;</span>
                    </ItemTemplate>
                    <HeaderStyle Width="125px"></HeaderStyle>
                    <ItemStyle Wrap="false" HorizontalAlign="Right" />

                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Event Time" GroupByExpression="EventTime [GridColumn_EventTime] Group By EventTime ASC"
                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" DataField="EventTime" DataType="System.String" FilterListOptions="VaryByDataType"
                    ItemStyle-HorizontalAlign="Right" SortExpression="EventTime" UniqueName="EventTime">
                    <ItemTemplate>
                        <span><%# CultureFormatTime(Container.DataItem("EventTime"))%>&nbsp;</span>
                    </ItemTemplate>
                    <HeaderStyle Width="90px" />
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Snooze Date" UniqueName="SnoozeDate" SortExpression="SnoozeDate"
                    GroupByExpression="SnoozeDate [GridColumn_SnoozeDate] Group By SnoozeDate ASC" DataField="SnoozeDate" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <span>
                            <%# FormatDate(Container.DataItem("SnoozeDate"))%></span>&nbsp;
                    </ItemTemplate>
                    <HeaderStyle Width="100px"></HeaderStyle>
                    <ItemStyle Wrap="false" HorizontalAlign="Right" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Trigger" UniqueName="Trigger" ItemStyle-HorizontalAlign="Right"
                    GroupByExpression="Trigger [GridColumn_Trigger] Group By Trigger ASC" SortExpression="Trigger" DataField="Trigger"
                    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <span><%#IIf(Container.DataItem("Trigger") = String.Empty, "&nbsp;", Container.DataItem("Trigger"))%></span>
                    </ItemTemplate>
                    <HeaderStyle Width="100px"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Project" UniqueName="Project" GroupByExpression="Project [GridColumn_Project] Group By Project ASC"
                    SortExpression="Project" DataField="Project"
                    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <span><%#IIf(Container.DataItem("Project") = String.Empty, "&nbsp;", Container.DataItem("Project"))%></span>
                    </ItemTemplate>
                    <HeaderStyle Width="110px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Location" UniqueName="Location" ItemStyle-HorizontalAlign="Left"
                    SortExpression="Location" GroupByExpression="Location [GridColumn_Location] Group By Location ASC" DataField="Location"
                    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <span><%#IIf(Container.DataItem("Location") = String.Empty, "&nbsp;", Container.DataItem("Location"))%></span>
                    </ItemTemplate>
                    <HeaderStyle Width="110px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Record" GroupByExpression="Record [GridColumn_Record] Group By Record ASC" DataField="Record" SortExpression="Record"
                    UniqueName="Record" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <asp:HyperLink ID="hliRecord" runat="server" CssClass="Link NoWrap" Style="white-space: nowrap; display: inline-block;"
                            Text='<%#Eval("Record").ToString%>' NavigateUrl='<%#Eval("Link").ToString%>'></asp:HyperLink>
                    </ItemTemplate>
                    <HeaderStyle Width="110px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Record Type" UniqueName="RecordType" DataField="RecordType" GroupByExpression="RecordType [GridColumn_RecordType] Group By RecordType ASC"
                    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("RecordType") = String.Empty, "&nbsp;", Container.DataItem("RecordType"))%></span>
                    </ItemTemplate>
                    <HeaderStyle Width="100px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Field" UniqueName="Field" SortExpression="Field"
                    GroupByExpression="Field [GridColumn_Field] Group By Field ASC" DataField="Field" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("Field") = String.Empty, "&nbsp;", Container.DataItem("Field"))%></span>
                    </ItemTemplate>
                    <HeaderStyle Width="90px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="User ID" SortExpression="UserID" UniqueName="UserID"
                    GroupByExpression="UserID [GridColumn_UserID] Group By UserID ASC"
                    DataField="UserID" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("UserID") = String.Empty, "&nbsp;", Container.DataItem("UserID"))%></span>
                    </ItemTemplate>
                    <HeaderStyle Width="200px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="User" GroupByExpression="User [GridColumn_User] Group By User ASC"
                    SortExpression="User" UniqueName="User" DataField="User" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("User") = String.Empty, "&nbsp;", Container.DataItem("User"))%></span>
                    </ItemTemplate>
                    <HeaderStyle Width="100px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Message" GroupByExpression="Message [GridColumn_Message] Group By Message ASC"
                    SortExpression="Message" UniqueName="Message" DataField="Message" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("Message") = String.Empty, "&nbsp;", Container.DataItem("Message"))%></span>
                    </ItemTemplate>
                    <HeaderStyle Width="100px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Initiative" UniqueName="IsInitiative" ItemStyle-HorizontalAlign="Right"
                    GroupByExpression="IsInitiative [GridColumn_IsInitiative] Group By IsInitiative ASC" SortExpression="IsInitiative" DataField="IsInitiative"
                    CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <img src="Images/Global/<%#CStr(IIF(Cbool(Eval("IsInitiative"))=Cbool(1),"checked.png" , "unchecked.png"))%>" alt="" />
                    </ItemTemplate>
                    <HeaderStyle Width="50px"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Left" Wrap="false"></ItemStyle>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Created By" GroupByExpression="CreatedBy [GridColumn_CreatedBy] Group By CreatedBy ASC"
                    SortExpression="CreatedBy" UniqueName="CreatedBy" DataField="CreatedBy" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("CreatedBy") = String.Empty, "&nbsp;", Container.DataItem("CreatedBy"))%></span>
                    </ItemTemplate>
                    <HeaderStyle Width="100px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Event ID" Groupable="false"
                    SortExpression="EventUserId" UniqueName="Id" DataField="EventUserId" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <span>
                            <%#Container.DataItem("EventUserId")%></span>
                    </ItemTemplate>
                    <HeaderStyle Width="90px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Program" GroupByExpression="Program [GridColumn_Program] Group By Program ASC"
                    SortExpression="Program" UniqueName="Program" DataField="Program" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("Program") = String.Empty, "&nbsp;", Container.DataItem("Program"))%></span>
                    </ItemTemplate>
                    <HeaderStyle Width="100px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Dismissed By" GroupByExpression="DismissedBy [GridColumn_DismissedBy] Group By DismissedBy ASC"
                    SortExpression="DismissedBy" UniqueName="DismissedBy" DataField="DismissedBy" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <span>
                            <%#IIf(Container.DataItem("DismissedBy") = String.Empty, "&nbsp;", Container.DataItem("DismissedBy"))%></span>
                    </ItemTemplate>
                    <HeaderStyle Width="100px"></HeaderStyle>
                    <ItemStyle Wrap="false" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Dismissed Date" GroupByExpression="DismissedDate [GridColumn_DismissedDate] Group By DismissedDate ASC"
                    SortExpression="DismissedDate" UniqueName="DismissedDate" DataField="DismissedDate" CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                    <ItemTemplate>
                        <span>
                            <%# FormatDate(Container.DataItem("DismissedDate"))%></span>&nbsp;
                    </ItemTemplate>
                    <HeaderStyle Width="160px"></HeaderStyle>
                    <ItemStyle Wrap="false" HorizontalAlign="Right" />
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn HeaderText="Dismissed Time" Groupable="false"
                    SortExpression="DismissedTime" UniqueName="DismissedTime" DataField="DismissedTime" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true" DataType="System.String">
                    <ItemTemplate>
                        <span>
                            <%# CultureFormatTime(Container.DataItem("DismissedTime"))%></span>&nbsp;
                    </ItemTemplate>
                    <HeaderStyle Width="160px"></HeaderStyle>
                    <ItemStyle Wrap="false" HorizontalAlign="Right" />
                </telerik:GridTemplateColumn>
            </Columns>
            <ItemStyle Wrap="false" />
            <HeaderStyle Wrap="false" HorizontalAlign="Left" />
            <FooterStyle CssClass="GridFooter" />
            <CommandItemTemplate>
                <div style="padding: 2px">
                    <asp:LinkButton ID="btnSnooze" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Edit" CommandName="Snooze" CssClass="GridCmdSnooze"
                        OnClientClick="javascript:return TryOpenSnoozePopup();">
                        <span class="Icon"></span>
                        <asp:Label ID="Labelsnooze" runat="server" Text="AutoApply11"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnDismiss" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Edit" CommandName="Dismiss" CssClass="GridCmdDismiss">
                        <span class="Icon"></span>
                        <asp:Label ID="Label3" runat="server" Text="AutoApply11"></asp:Label>&nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="javascript:return TryOpenDeletPopup();" CssClass="GridCmdDeleteRows"
                        SecurityButtonType="ItemMode_Delete" Visible='<%# rdgEvents.EditIndexes.Count = 0 AND (Not rdgEvents.MasterTableView.IsItemInserted) %>'
                        runat="server" CommandName="DeleteRows" meta:resourcekey="btnDeleteResource1">
                        <span class="Icon"></span>
                        <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines"
                            meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                        SecurityButtonType="ItemMode"
                        Visible='<%# rdgEvents.EditIndexes.Count = 0 AND (Not rdgEvents.MasterTableView.IsItemInserted) %>'
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
                    <asp:LinkButton ID="btnCopyToExcel" CommandName="CopyToExcel" runat="server" CausesValidation="False" CssClass="GridCmdCopyToExcel">
                        <span class="Icon"></span>
                        <asp:Label ID="lblCopyToExcel" meta:resourcekey="lblCopyToExcel" runat="server" Text="Copy To Excel"></asp:Label>
                        &nbsp;&nbsp;
                    </asp:LinkButton>

                </div>
            </CommandItemTemplate>
        </MasterTableView>
        <ClientSettings AllowColumnHide="true" AllowColumnsReorder="true" AllowDragToGroup="true">
            <Selecting AllowRowSelect="true" EnableDragToSelectRows="true" />
            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                AllowColumnResize="True" />
            <%--<Scrolling AllowScroll="True" UseStaticHeaders="true" SaveScrollPosition="true" FrozenColumnsCount="1" />--%>
        </ClientSettings>
    </telerik:RadGrid>
    <asp:Button runat="server" ID="btndeleteSelectedLines" CssClass="Hide" />
    <asp:Button runat="server" ID="btnSnooze" CssClass="Hide" />
    <asp:Button runat="server" ID="btnOpenSnoozePopup" CssClass="Hide" />
    <asp:Button runat="server" ID="btnOpenDeletePopup" CssClass="Hide" />
    <asp:HiddenField runat="server" ID="hdnMaxdate"></asp:HiddenField>
</asp:Content>
