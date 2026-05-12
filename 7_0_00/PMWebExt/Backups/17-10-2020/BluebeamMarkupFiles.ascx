<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="BluebeamMarkupFiles.ascx.vb" Inherits="Website.BluebeamMarkupFiles" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadDatePicker ID="RadDatePicker1" Style="display: none;" MinDate="01/01/1901"
    MaxDate="12/31/2100" runat="server" Skin="Default">
    <ClientEvents OnDateSelected="dateSelected" />
</telerik:RadDatePicker>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgMarkupFiles">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgMarkupFiles" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel ID="ldpMarkupFiles" runat="server" Skin="Default" />

<telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">

    <script type="text/javascript">
        function ConfirmDisconnect(FileId) {
            OpenPOPUp("BluebeamDeactivatePDFFile.aspx?FileId=" + FileId, 610, 360, true, 'rdgMarkupFiles');
        }



    </script>
</telerik:RadScriptBlock>
<div class="PMHeader">
    <div class="row">
        <div class="col-12">
            <telerik:RadGrid ID="rdgMarkupFiles" runat="server" CssClass="WithoutTopBorder" AutoGenerateColumns="False" ShowStatusBar="True" HeaderStyle-Font-Size="8" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true" AppendMenus="true"
                PageSize="25" AllowPaging="True" ShowFooter="True" ShowGroupPanel="False" AllowSorting="True" ItemStyle-Height="20px" GridLines="None">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="Id" CommandItemDisplay="Top" Width="100%" ShowFooter="true"
                    TableLayout="Fixed" UseAllDataFields="true">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Active11" UniqueName="IsActive" ItemStyle-HorizontalAlign="Center" SortExpression="IsActive"
                            Groupable="false" DataField="IsActive" AllowFiltering="false">
                            <ItemTemplate>
                                <asp:LinkButton ID="lbtActive" runat="server" CommandName="DisconnectSessionFile" Visible="true">
                        <span class="Icon"></span>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <HeaderStyle Width="60px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Line #" UniqueName="LineNumber" ItemStyle-HorizontalAlign="Right" SortExpression="LineNumber"
                            Groupable="false" DataField="LineNumber" AllowFiltering="false">
                            <ItemTemplate>
                                <span><%#Container.DataItem("LineNumber").ToString%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="60px"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="PDF File Name" DataField="FileName" Groupable="true" UniqueName="FileName" SortExpression="FileName">
                            <ItemTemplate>
                                <span><%#If(Container.DataItem("FileName").ToString = String.Empty, "&nbsp;", Container.DataItem("FileName").ToString)%></span>
                            </ItemTemplate>
                            <HeaderStyle Width="200px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="AddedDate" DataField="AddedDate" UniqueName="AddedDate" SortExpression="AddedDate" Groupable="False">
                            <ItemTemplate>
                                <span><%# If(Container.DataItem("AddedDate") Is DBNull.Value, "", FormatDateTime(Container.DataItem("AddedDate")))%>&nbsp;</span>
                            </ItemTemplate>
                            <HeaderStyle Width="150px" />
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Disconnected" DataField="DisconnectedDate" UniqueName="DisconnectedDate" SortExpression="DisconnectedDate" Groupable="False">
                            <ItemTemplate>
                                <span><%# If(Container.DataItem("DisconnectedDate") Is DBNull.Value, "", FormatDateTime(Container.DataItem("DisconnectedDate")))%>&nbsp;</span>
                            </ItemTemplate>
                            <HeaderStyle Width="150px" />
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Removed" DataField="RemovedDate" UniqueName="RemovedDate" SortExpression="RemovedDate" Groupable="False">
                            <ItemTemplate>
                                <span><%# If(Container.DataItem("RemovedDate") Is DBNull.Value, "", FormatDateTime(Container.DataItem("RemovedDate")))%>&nbsp;</span>
                            </ItemTemplate>
                            <HeaderStyle Width="150px" />
                            <ItemStyle HorizontalAlign="Right"></ItemStyle>
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="PMWeb Location" DataField="SessionOrigin" Groupable="true" UniqueName="SessionOrigin" SortExpression="SessionOrigin" ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate>
                                <a runat="server" id="hypPMWebLocation" href='<%# Eval("SessionOriginMainPage").ToString%>'><%#Eval("TranslatedSessionOrigin").ToString%> </a>
                            </ItemTemplate>
                            <HeaderStyle Width="300px"></HeaderStyle>
                        </telerik:GridTemplateColumn>

                    </Columns>

                    <ItemStyle Wrap="false" />
                    <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                    <FooterStyle CssClass="GridFooter" />
                    <CommandItemTemplate>
                        <div style="padding: 2px">
                            <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" CommandName="RebindGrid"
                                Visible="<%# rdgMarkupFiles.EditIndexes.Count = 0 And (Not rdgMarkupFiles.MasterTableView.IsItemInserted)%>" Enabled="<%# Me.PM.BluebeamMarkupsInfo.IsInSession = True AndAlso Me.PM.BluebeamMarkupsInfo.ValidToken%>">
                                <span class="Icon"></span>
                                <asp:Label runat="server" ID="lblRefresh" CssClass="rtbText"></asp:Label>&nbsp;&nbsp;
                            </asp:LinkButton>
                        </div>
                    </CommandItemTemplate>
                </MasterTableView>
                <ClientSettings AllowDragToGroup="false" Resizing-AllowColumnResize="true" Resizing-ResizeGridOnColumnResize="true" Resizing-ClipCellContentOnResize="true"
                    AllowColumnsReorder="true" ColumnsReorderMethod="Reorder">
                    <Selecting AllowRowSelect="False" EnableDragToSelectRows="False" />
                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>
</div>
