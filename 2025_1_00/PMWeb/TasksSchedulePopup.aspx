<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="TasksSchedulePopup.aspx.vb" Inherits="Website.TasksSchedulePopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager2" runat="server"></asp:ScriptManager>
        <telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgSchedules">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgSchedules" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManagerProxy>

        <div class="PMHeader">
            <div class="row">
                <div class="col-12">
                    <telerik:RadGrid ID="rdgSchedules" runat="server" HeaderStyle-Font-Size="8" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                        Width="100%" AutoGenerateColumns="False" ShowHeader="true" PageSize="250"
                        AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true"></PagerStyle>

                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id">

                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Code" UniqueName="TaskSheetCode" DataType="System.String"
                                    CurrentFilterFunction="Contains" DataField="TaskSheetCode" AutoPostBackOnFilter="true" SortExpression="TaskSheetCode">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lbtSchedule" runat="server" Text='<%# Eval("TaskSheetCode") %>' CommandName="ScheduleClick" CommandArgument='<%# Eval("Id")%>'></asp:LinkButton>
                                    </ItemTemplate>
                                    <HeaderStyle Width="167px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Project" UniqueName="Project" DataType="System.String"
                                    CurrentFilterFunction="Contains" DataField="Project" AutoPostBackOnFilter="true" SortExpression="Project">
                                    <ItemTemplate>
                                        <span><%# Eval("Project") %></span>&nbsp
                                    </ItemTemplate>
                                    <HeaderStyle Width="300px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Description" UniqueName="Description" DataType="System.String"
                                    CurrentFilterFunction="Contains" DataField="TaskSheet" AutoPostBackOnFilter="true" SortExpression="TaskSheet">
                                    <ItemTemplate>
                                        <span><%# Eval("TaskSheet") %></span>&nbsp
                                    </ItemTemplate>
                                    <HeaderStyle Width="300px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn ItemStyle-Wrap="false" HeaderText="Status" UniqueName="Status" DataType="System.String"
                                    CurrentFilterFunction="Contains" DataField="Status" AutoPostBackOnFilter="true" SortExpression="Status">
                                    <ItemTemplate>
                                        <span><%# Eval("Status")%></span>&nbsp
                                    </ItemTemplate>
                                    <HeaderStyle Width="300px" />
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn ItemStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" HeaderText="Is Project Schedule" UniqueName="IsProjectSchedule" DataType="System.Boolean"
                                    CurrentFilterFunction="Contains" DataField="IsProjectSchedule" AutoPostBackOnFilter="true" SortExpression="IsProjectSchedule">
                                    <ItemTemplate>
                                        <asp:Image ID="imgIsProjectSchedule" runat="server" />&nbsp
                                    </ItemTemplate>
                                    <HeaderStyle Width="300px" />
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>

                        <ClientSettings EnableRowHoverStyle="true"></ClientSettings>
                    </telerik:RadGrid>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
