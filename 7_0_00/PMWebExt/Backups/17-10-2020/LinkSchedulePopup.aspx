<%@ Page Language="vb" Title="Link Schedule" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="LinkSchedulePopup.aspx.vb" Inherits="Website.LinkSchedulePopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<style>
    a {
        text-decoration: none !important;
    }
</style>
<script>
    window.onload = function () {
        var tds = document.querySelectorAll('.controlWidth');
        var arrTd = Array.prototype.slice.call(tds);
        for (var i = 0; i < arrTd.length; i++) {
            if (arrTd[i].innerHTML.trim() === "")
                arrTd[i].parentElement.style.display = 'none';
        }

    };
</script>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadAjaxManager ID="RadAjax1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdglinkedRecords">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdglinkedRecords" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" Skin="Default" />

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" Width="100%" runat="server" Skin="Default" AutoPostBack="true">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" CommandName="Save" AccessKey="s" Value="Save">
                            </telerik:RadToolBarButton>

                            <telerik:RadToolBarButton ValidationGroup="SaveAndExit" EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>

                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>


        <div class="PMMainPage PMPopupMainPage documentSinglePage">
            <div class="row">
                <div class="col-4 col-4-left">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblApplication" meta:resourcekey="lblApplication" runat="server" Text="Application"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlApplication" AutoPostBack="True" Width="100%" runat="server"></telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblDatabase" meta:resourcekey="lblDatabase" runat="server" Text="Database"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlDatabase" AutoPostBack="True" Width="100%" runat="server"></telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblProject" meta:resourcekey="lblProject" runat="server" Text="Project"></asp:Label>
                                <asp:Label ID="lblXmlFile" meta:resourcekey="lblXmlFile" Visible="false" runat="server" Text="Xml file"></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <telerik:RadComboBox ID="ddlProjects" runat="server" Width="100%"
                                    Skin="Default" CloseDropDownOnBlur="true" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                    NoWrap="True" AllowCustomText="true" AutoPostBack="true" EnableItemCaching="false"
                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                    OnItemsRequested="ddl_ItemsRequested"
                                    Style="font-size: 11px" Height="250px">
                                </telerik:RadComboBox>
                                <asp:Panel ID="pnlMsProject" runat="server" Visible="false">
                                    <table cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td>
                                                <asp:FileUpload ID="FileToUpload" runat="server"></asp:FileUpload>
                                            </td>
                                            <td style="padding-left: 10px">
                                                <asp:Button ID="btnUpload" meta:resourcekey="btnUpload" runat="server" Text="Upload" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:HyperLink ID="btnDownloadEdit" runat="server" CausesValidation="false" Style="text-decoration: underline; cursor: Pointer;"
                                                    Text='' ToolTip="<%$ Resources:PMWeb, Download %>"></asp:HyperLink>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>

                            </td>
                        </tr>
                        <tr>
                            <td class="labelWidth"></td>
                            <td class="controlWidth">
                                <asp:Label ID="lblError" meta:resourcekey="lblError" CssClass="Validator" runat="server" Visible="false" Text="Web Service Connection Error"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-4 col-4-right">
                    <table class="colTable" border="0">
                        <tr>
                            <td>
                                <asp:CheckBox ID="chkLockSchedule" Checked="true" AutoPostBack="true" meta:resourcekey="chkLockSchedule"
                                    runat="server" Text="Lock schedule to prevent recalculation" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:CheckBox ID="chkImportWBS" meta:resourcekey="chkImportWBSCodes"
                                    runat="server" Text="Import WBS codes1111" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:CheckBox ID="chkupdateLinkedTasks" meta:resourcekey="chkupdateLinkedTasks"
                                    runat="server" Text="Update previously linked tasks1111111" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="ResponsiveMargin col-12">
                    <telerik:RadGrid ID="rdglinkedRecords" runat="server" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" FitPageHeightOffset="24"
                        AutoGenerateColumns="False" ShowStatusBar="true" HeaderStyle-Font-Size="8" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                        PageSize="10" AllowPaging="true" ShowFooter="false" ShowGroupPanel="false" Width="100%"
                        AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowSorting="true" ItemStyle-Height="20px">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                        <GroupPanel Text="Group by"></GroupPanel>
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" InsertItemDisplay="Top"
                            InsertItemPageIndexAction="ShowItemOnFirstPage" TableLayout="Fixed" UseAllDataFields="true"
                            EditMode="InPlace" EnableHeaderContextMenu="false">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="UID" GroupByExpression="Id [GridColumn_Id] Group By Id ASC"
                                    HeaderStyle-Width="75px" SortExpression="Id" UniqueName="Id">
                                    <ItemTemplate>
                                        <span>
                                            <%#Container.DataItem("Id").ToString%>&nbsp;</span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Parent UID" GroupByExpression="ParentId [GridColumn_ParentId] Group By ParentId ASC"
                                    HeaderStyle-Width="75px" SortExpression="ParentId" UniqueName="ParentId">
                                    <ItemTemplate>
                                        <span>
                                            <%#Container.DataItem("ParentId").ToString%>&nbsp;</span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Summary" GroupByExpression="IsSummary [GridColumn_IsSummary] Group By IsSummary ASC"
                                    HeaderStyle-Width="75px" SortExpression="IsSummary" UniqueName="IsSummary">
                                    <ItemTemplate>
                                        <img alt="" src='Images/Global/<%# CStr(IIf(Eval("IsSummary"), "checked.png", "unchecked.png")) %>' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                    <HeaderStyle Width="75px" />
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Code" UniqueName="Code" Groupable="false"
                                    Reorderable="false" SortExpression="Code">
                                    <ItemTemplate>
                                        <span>
                                            <%#IIf(CStr(Eval("Code")) = String.Empty, "&nbsp;", Eval("Code"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="90px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Name" SortExpression="Name" UniqueName="Name"
                                    GroupByExpression="Name [GridColumn_Name] Group By Name ASC">
                                    <ItemTemplate>
                                        <span>
                                            <%#IIf(Container.DataItem("Name") = String.Empty, "&nbsp;", Container.DataItem("Name"))%></span>
                                    </ItemTemplate>
                                    <HeaderStyle Width="238px"></HeaderStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Start"
                                    HeaderStyle-Width="80px" GroupByExpression="Start [GridColumn_Start] Group By Start ASC" SortExpression="Start" UniqueName="Start">
                                    <ItemTemplate>
                                        <span>
                                            <%#FormatDate(Container.DataItem("Start"))%>&nbsp;</span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Finish" GroupByExpression="Finish [GridColumn_Finish] Group By Finish ASC"
                                    HeaderStyle-Width="80px" SortExpression="Finish" UniqueName="Finish">
                                    <ItemTemplate>
                                        <span>
                                            <%#FormatDate(Container.DataItem("Finish"))%>&nbsp;</span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Duration Days" GroupByExpression="Duration [GridColumn_Duration] Group By Duration ASC"
                                    HeaderStyle-Width="132px" SortExpression="Duration" UniqueName="Duration">
                                    <ItemTemplate>
                                        <span>
                                            <%#FormatNumber(Container.DataItem("Duration"))%>&nbsp;</span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Actual Start"
                                    HeaderStyle-Width="80px" GroupByExpression="ActualStart [GridColumn_ActualStart] Group By ActualStart ASC" SortExpression="ActualStart" UniqueName="ActualStart">
                                    <ItemTemplate>
                                        <span>
                                            <%#FormatDate(Container.DataItem("ActualStart"))%>&nbsp;</span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Actual Finish" GroupByExpression="ActualFinish [GridColumn_ActualFinish] Group By ActualFinish ASC"
                                    HeaderStyle-Width="80px" SortExpression="ActualFinish" UniqueName="ActualFinish">
                                    <ItemTemplate>
                                        <span>
                                            <%#FormatDate(Container.DataItem("ActualFinish"))%>&nbsp;</span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Actual Duration Days" GroupByExpression="ActualDuration [GridColumn_ActualDuration] Group By ActualDuration ASC"
                                    HeaderStyle-Width="132px" SortExpression="ActualDuration" UniqueName="ActualDuration">
                                    <ItemTemplate>
                                        <span>
                                            <%#FormatNumber(Container.DataItem("ActualDuration"))%>&nbsp;</span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Remaining Duration Hours" GroupByExpression="RemainingDurationHours [GridColumn_RemainingDurationHours] Group By RemainingDurationHours ASC"
                                    HeaderStyle-Width="132px" SortExpression="RemainingDurationHours" UniqueName="RemainingDurationHours">
                                    <ItemTemplate>
                                        <span>
                                            <%#FormatNumber(Container.DataItem("RemainingDurationHours"))%>&nbsp;</span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Remaining Duration Days" GroupByExpression="RemainingDurationDays [GridColumn_RemainingDurationDays] Group By RemainingDurationDays ASC"
                                    HeaderStyle-Width="132px" SortExpression="RemainingDurationDays" UniqueName="RemainingDurationDays">
                                    <ItemTemplate>
                                        <span>
                                            <%#FormatNumber(Container.DataItem("RemainingDurationDays"))%>&nbsp;</span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Complete" GroupByExpression="PctComplete [GridColumn_PctComplete] Group By PctComplete ASC"
                                    HeaderStyle-Width="70px" SortExpression="PctComplete" UniqueName="PctComplete">
                                    <ItemTemplate>
                                        <span><%#FormatPercent(Container.DataItem("PctComplete"))%></span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Total Float" GroupByExpression="TotalFloat [GridColumn_TotalFloat] Group By TotalFloat ASC"
                                    HeaderStyle-Width="70px" SortExpression="TotalFloat" UniqueName="TotalFloat">
                                    <ItemTemplate>
                                        <span><%# Container.DataItem("TotalFloat")%></span>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="WBSCode" GroupByExpression="WBSCode [GridColumn_WBSCode] Group By WBSCode ASC"
                                    HeaderStyle-Width="70px" SortExpression="WBSCode" UniqueName="WBSCode">
                                    <ItemTemplate>
                                        <span>
                                            <%#IIf(CStr(Eval("WBSCode")) = String.Empty, "&nbsp;", Eval("WBSCode"))%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="WBSDescription" GroupByExpression="WBSDescription [GridColumn_WBSDescription] Group By WBSDescription ASC"
                                    HeaderStyle-Width="150px" SortExpression="WBSDescription" UniqueName="WBSDescription">
                                    <ItemTemplate>
                                        <span>
                                            <%#IIf(CStr(Eval("WBSDescription")) = String.Empty, "&nbsp;", Eval("WBSDescription"))%></span>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <CommandItemTemplate>

                                <table style="padding: 0px; height: 20px;" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td id="tblDropdown" style="padding-left: 5px;" runat="server">
                                            <table style="padding: 0px; border: 0px transparent none; height: 30px;" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td style="padding-left: 5px;">
                                                        <b>
                                                            <asp:Label ID="lblWorkingHours" meta:resourcekey="lblWorkingHours" runat="server" Text="Working Hours"></asp:Label></b>
                                                    </td>
                                                    <td style="padding-left: 5px;">
                                                        <asp:TextBox ID="txtWorkingDays" MinNumber="1" MaxLength="9" Width="50px" CssClass="PositiveDouble" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td style="padding-left: 5px;">
                                                        <b>
                                                            <asp:Label ID="lblPctComplete" meta:resourcekey="lblPctComplete" runat="server" Text="Percent Complete Method"></asp:Label></b>
                                                    </td>
                                                    <td style="padding-left: 5px;">
                                                        <telerik:RadComboBox ID="ddlPctComplete" Width="150px" runat="server"></telerik:RadComboBox>
                                                    </td>
                                                    <%--         <td style="padding-left:5px;">
                                                                            <b><asp:label id="lblCalendar" meta:resourcekey="lblCalendar"  runat="server" text="Calendar"></asp:label></b>  
                                                                         </td>--%>
                                                    <%--         <td style="padding-left:5px;">
                                                                           <asp:DropDownList ID="ddlCalendars"  width="150px" runat="server" ></asp:DropDownList>
                                                                        </td>--%>
                                                </tr>
                                            </table>
                                        </td>

                                        <td style="padding-left: 5px;">
                                            <asp:LinkButton ID="btnRefresh" runat="server" SecurityButtonType="ItemMode" CausesValidation="false" CommandName="RebindGrid" CssClass="GridCmdRebindGrid">
                                                <span class="Icon"></span>
                                                <asp:Label runat="server" ID="lblRefresh" Text="Refresh"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                        </td>
                                    </tr>
                                </table>
                            </CommandItemTemplate>
                            <ItemStyle Wrap="false" />
                            <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                            <FooterStyle CssClass="GridFooter" />
                        </MasterTableView>
                        <ClientSettings
                            AllowDragToGroup="false">
                            <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                AllowColumnResize="True" />
                        </ClientSettings>
                        <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="PerformInsert,UpdateEdited" />
                    </telerik:RadGrid>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
