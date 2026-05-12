<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BluebeamMarkupDetails.ascx.vb" Inherits="Website.BluebeamMarkupDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgMarkupDetails">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgMarkupDetails" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnFilterActions">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgMarkupDetails" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnFilterTypes">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgMarkupDetails" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel ID="ldpMarkupDetails" runat="server" Skin="Default" />
<div class="PMHeader">
    <div class="row ResponsiveMargin">
        <div class="col-12">
            <telerik:RadGrid ID="rdgMarkupDetails" runat="server" CssClass="WithoutTopBorder" AutoGenerateColumns="False" ShowStatusBar="True" HeaderStyle-Font-Size="8"
                PageSize="250" AllowPaging="True" ShowFooter="True" ShowGroupPanel="True" FilterType="HeaderContext" AllowSorting="True"
                EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" ItemStyle-Height="20px" GridLines="None" AllowFilteringByColumn="true">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" ShowFooter="true"
                    TableLayout="Fixed" UseAllDataFields="true" EnableHeaderContextMenu="true">
                    <Columns>
                        <%--<telerik:GridTemplateColumn HeaderText="Keep" UniqueName="KeepChanges" Groupable="false" DataField="KeepChanges" AllowFiltering="false">
            <ItemTemplate>
                <aspCheckBox ID="chkKeepMarkup" runat="server" onclick="KeepSelectParent(this);"  />
            </ItemTemplate>
            <HeaderTemplate>
                <asp:Label ID="lblKeepMarkup" runat="server" Text="Keep" ></asp:Label>
                <asp:CheckBox ID="chkKeepAll" runat="server" TextAlign="Left" onclick="KeepSelectAll(this);"  />
            </HeaderTemplate>
            <HeaderStyle HorizontalAlign="Center" Width="110px"></HeaderStyle>
            <ItemStyle HorizontalAlign="Center"></ItemStyle>
        </telerik:GridTemplateColumn>

        <telerik:GridTemplateColumn HeaderText="Delete" UniqueName="DeleteChanges" Groupable="false" DataField="DeleteChanges" AllowFiltering="false">
            <ItemTemplate>
                <asp:CheckBox ID="chkDeleteMarkup" runat="server" onclick="DeleteSelectParent(this);"  />
            </ItemTemplate>
            <HeaderTemplate>
                <asp:Label ID="lblDeleteMarkup" runat="server" Text="Delete" ></asp:Label>
                <asp:CheckBox ID="chkDeleteAll" runat="server" TextAlign="Left" onclick="DeleteSelectAll(this);"  />
            </HeaderTemplate>
            <HeaderStyle HorizontalAlign="Center" Width="110px"></HeaderStyle>
            <ItemStyle HorizontalAlign="Center"></ItemStyle>
        </telerik:GridTemplateColumn>--%>

                        <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" ItemStyle-HorizontalAlign="Right" SortExpression="LineNumber"
                            Groupable="false" DataField="LineNumber" AllowFiltering="false">
                            <ItemTemplate>
                                <span><%#Container.DataItem("LineNumber").ToString%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="60px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="PDF File Name" DataField="FileName" Groupable="true" UniqueName="FileName" SortExpression="FileName"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                            GroupByExpression="FileName [GridColumn_FileName] Group By FileName ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("FileName").ToString = String.Empty, "&nbsp;", Container.DataItem("FileName").ToString)%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Author" DataField="Author" Groupable="true" UniqueName="Author" SortExpression="Author"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                            GroupByExpression="Author [GridColumn_Author] Group By Author ASC">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Author").ToString = String.Empty, "&nbsp;", Container.DataItem("Author").ToString)%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <%--  <telerik:GridTemplateColumn HeaderText="Date" DataField="Date" UniqueName="Date" SortExpression="Date"
                                    CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                                    GroupByExpression="Date [GridColumn_Date] Group By Date ASC">
            <ItemTemplate>
                <span><%# If(Container.DataItem("Date") Is DBNull.Value, "", FormatDate(Container.DataItem("Date")))%>&nbsp;</span>
            </ItemTemplate>
            <HeaderStyle Width="110px" />
            <ItemStyle HorizontalAlign="Right"></ItemStyle>
        </telerik:GridTemplateColumn>--%>

                        <telerik:GridTemplateColumn HeaderText="CreationDate" DataField="DateTime" UniqueName="DateTime" SortExpression="DateTime"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                            GroupByExpression="DateTime [GridColumn_DateTime] Group By DateTime ASC" Groupable="true">
                            <ItemTemplate>
                                <span><%# If(Container.DataItem("DateTime") Is DBNull.Value, "", Container.DataItem("DateTime"))%>&nbsp;</span>
                            </ItemTemplate>
                            <HeaderStyle Width="150px" />
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Action" DataField="Action" UniqueName="Action" SortExpression="Action"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                            GroupByExpression="Action [GridColumn_Action] Group By Action ASC" Groupable="true">
                            <ItemTemplate>
                                <span><%# If(Container.DataItem("Action") Is DBNull.Value, "", Container.DataItem("Action"))%>&nbsp;</span>
                            </ItemTemplate>
                            <HeaderStyle Width="150px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Type" DataField="Type" UniqueName="Type" SortExpression="Type"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                            GroupByExpression="Type [GridColumn_Type] Group By Type ASC" Groupable="true">
                            <ItemTemplate>
                                <span><%# If(Container.DataItem("Type") Is DBNull.Value, "", Container.DataItem("Type"))%>&nbsp;</span>
                            </ItemTemplate>
                            <HeaderStyle Width="150px" />
                        </telerik:GridTemplateColumn>


                        <telerik:GridTemplateColumn HeaderText="Message" DataField="Message" UniqueName="Message" SortExpression="Message"
                            CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true"
                            GroupByExpression="Message [GridColumn_Message] Group By Message ASC" Groupable="true">
                            <ItemTemplate>
                                <span><%#IIf(Container.DataItem("Message").ToString = String.Empty, "&nbsp;", Container.DataItem("Message").ToString)%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="500px"></HeaderStyle>
                        </telerik:GridTemplateColumn>



                    </Columns>

                    <ItemStyle Wrap="false" />
                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                    <FooterStyle CssClass="GridFooter" />
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" CommandName="RebindGrid"
                                Visible="<%# rdgMarkupDetails.EditIndexes.Count = 0 And (Not rdgMarkupDetails.MasterTableView.IsItemInserted) %>" Enabled="<%# Me.PM.BluebeamMarkupsInfo.IsInSession = True AndAlso Me.PM.BluebeamMarkupsInfo.ValidToken%>">
                                <span class="Icon"></span>
                                <asp:Label
                                    runat="server" ID="lblRefresh" CssClass="rtbText"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                            <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="AddEditMode_Edit" EnableRoundedCorners="true" EnableAutoScroll="true"
                                CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack" EnableShadows="true" CausesValidation="false" Visible="true">
                            </telerik:RadMenu>
                            <div style="display: inline-block; padding-right: 15px;">
                                <asp:Label ID="lblViewActions" Text="View Actions" runat="server" meta:ResourceKey="lblViewActions"></asp:Label></b>
                    <telerik:RadComboBox ID="ddlActionsFilter" Width="150px" runat="server" Height="250px" Style="font-size: 11px" Filter="Contains"
                        AllowCustomText="True" EnableLoadOnDemand="false" ShowMoreResultsBox="false" EnableVirtualScrolling="true"
                        MarkFirstMatch="true" CloseDropDownOnBlur="true" EnableItemCaching="true" OnClientDropDownClosed="FilterActions"
                        NoWrap="True">
                        <ItemTemplate>
                            <div onclick="StopPropagation(event)" class="combo-item-template">
                                <asp:CheckBox runat="server" ID="chkApply" class="mobile-switch" />
                                <asp:Label runat="server" ID="Label3" AssociatedControlID="chkApply"></asp:Label>
                                <%#DataBinder.Eval(Container, "Text")%>
                            </div>
                        </ItemTemplate>
                    </telerik:RadComboBox>
                            </div>
                            <div style="display: inline-block; padding-right: 15px;">
                                <asp:Label ID="lblViewTypes" Text="View Types" runat="server" meta:ResourceKey="lblViewTypes"></asp:Label></b>
                    <telerik:RadComboBox ID="ddlTypesFilter" Width="150px" runat="server" Height="250px" Style="font-size: 11px" Filter="Contains"
                        AllowCustomText="True" EnableLoadOnDemand="false" ShowMoreResultsBox="false" EnableVirtualScrolling="true"
                        MarkFirstMatch="true" CloseDropDownOnBlur="true" EnableItemCaching="true" OnClientDropDownClosed="FilterActions"
                        NoWrap="True">
                        <ItemTemplate>
                            <div onclick="StopPropagation(event)" class="combo-item-template">
                                <asp:CheckBox runat="server" ID="chkApply" class="mobile-switch" />
                                <asp:Label runat="server" ID="Label3" AssociatedControlID="chkApply"></asp:Label>
                                <%#DataBinder.Eval(Container, "Text")%>
                            </div>
                        </ItemTemplate>
                    </telerik:RadComboBox>
                            </div>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings AllowDragToGroup="True" Resizing-AllowColumnResize="true" Resizing-ResizeGridOnColumnResize="true" Resizing-ClipCellContentOnResize="true"
                    AllowColumnsReorder="true" ColumnsReorderMethod="Reorder">
                    <Selecting AllowRowSelect="False" EnableDragToSelectRows="False" />
                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>
</div>

<asp:HiddenField ID="hdnKeepCount" runat="server" Value="0" />
<asp:HiddenField ID="hdnDeleteCount" runat="server" Value="0" />
<asp:Button ID="btnFilterActions" CssClass="Hide" runat="server"></asp:Button>