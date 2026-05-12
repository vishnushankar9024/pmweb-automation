<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DocumentIntegratorGoogleDrive.ascx.vb" Inherits="Website.DocumentIntegratorGoogleDrive" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgUsers">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="tblMain" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<telerik:RadAjaxLoadingPanel ID="ldpGoogleDrive" runat="server" EnableSkinTransparency="true"
    BackgroundPosition="Center" Skin="Default" />
<table style="width: 100%;" cellpadding="0" cellspacing="0">
    <tr class="ToolBar">
    </tr>
</table>
<div class="PMMainPage">
    <div class="row">
        <div class="col-4">
            <fieldset id="fldHeader" runat="server">
                <legend>
                    <asp:Label ID="lblGoogleDrive" meta:Resourcekey="lblGoogleDrive" CssClass="legend" runat="server" Text="GoogleDrive Integration"></asp:Label>
                </legend>
            </fieldset>
            <table class="colTable">
                <tr>
                    <td class="labelWidth">
                        <table class="TableNoSpacingNoBorder">
                            <tr>
                                <td style="width: 100%">
                                    <asp:Label ID="lblGoogleDriveHostname" meta:Resourcekey="lblGoogleDriveUrl" runat="server" Text="Hostname"></asp:Label>
                                </td>
                                <td style="padding-right: 10px;">
                                    <asp:LinkButton ID="imgHelp" runat="server" CausesValidation="False" CssClass="HelpButton"
                                        ToolTip=""> 
                                                    <span class="Icon"></span>    
                                    </asp:LinkButton>
                                    <telerik:RadToolTip ID="rtlHelp" runat="server" RelativeTo="Element" meta:resourcekey="rtlHelp"
                                        Text="Example: https://test.GoogleDrive.com" TargetControlID="imgHelp" IsClientID="true"
                                        Position="BottomCenter" EnableAriaSupport="true" EnableShadow="true" HideEvent="LeaveToolTip">
                                    </telerik:RadToolTip>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtGoogleDriveHostname" runat="server" MaxLength="250" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblDefaultUserName" meta:Resourcekey="lblDefaultUserName" runat="server" Text="Hostname11"></asp:Label>
                                    
                    </td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtDefaultUserName" runat="server" MaxLength="250" Width="100%"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                     <td class="labelWidth">
                        <asp:Label ID="lblDefaultPassword" meta:Resourcekey="lblDefaultPassword" runat="server" Text="Hostname12"></asp:Label>
                                    
                    </td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtDefaultPassword" TextMode="Password" runat="server" MaxLength="250" Width="100%"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <table class="colTable" id="tblMain" runat="server" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <fieldset id="fldUsers">
                            <legend>
                                <asp:Label ID="lblUsers" meta:Resourcekey="lblUsers" CssClass="legend" runat="server" Text="Users"></asp:Label>
                            </legend>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td>
                        <telerik:RadGrid ID="rdgUsers" runat="server" UseEditFormInMobile="true"
                            HeaderStyle-Font-Size="8" AutoGenerateColumns="False" ShowStatusBar="true" Width="100%" AppendMenus="true"
                            SetWidth="true" FitParentContainer="true" ClientSettings-Scrolling-AllowScroll="true"
                            PageSize="19" AllowPaging="True" AllowMultiRowEdit="True" AllowMultiRowSelection="true" AllowSorting="true">
                            <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                DataKeyNames="Id" Width="100%" TableLayout="Fixed" CommandItemDisplay="Top" InsertItemDisplay="Top"
                                InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                                <Columns>
                                    <telerik:GridTemplateColumn HeaderText="PMWeb User" UniqueName="PMWebUser" SortExpression="PMWebUser">
                                        <ItemTemplate>
                                            <%#Container.DataItem("PMWebUser")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <%#Container.DataItem("PMWebUser")%>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="350px" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="GoogleDrive Username" UniqueName="GoogleDriveUsername" SortExpression="GoogleDriveUsername">
                                        <ItemTemplate>
                                            <%# IIf(Container.DataItem("GoogleDriveUsername") = String.Empty, "&nbsp;", Container.DataItem("GoogleDriveUsername"))%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtGoogleDriveUsername" MaxLength="500" runat="server" Text='<%#Eval("GoogleDriveUsername")%>'
                                                Width="100%"></asp:TextBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="150px" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn HeaderText="GoogleDrive Password" UniqueName="GoogleDrivePassword" SortExpression="GoogleDrivePassword">
                                        <ItemTemplate>
                                            <%# IIf(Container.DataItem("GoogleDrivePassword").Length = 0, "&nbsp;", "***")%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtGoogleDrivePassword" TextMode="Password" MaxLength="500" runat="server"
                                                Text="***" Width="100%"></asp:TextBox>
                                        </EditItemTemplate>
                                        <HeaderStyle Width="150px" />
                                    </telerik:GridTemplateColumn>
                                </Columns>
                                <SortExpressions>
                                </SortExpressions>
                                <CommandItemTemplate>
                                    <div style="padding: 2px">
                                        <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="false" SecurityButtonType="ItemMode_Edit" CssClass="GridCmdEditRows"
                                            CommandName="EditRows" Visible='<%# rdgUsers.EditIndexes.Count = 0 And (Not rdgUsers.MasterTableView.IsItemInserted) %>'>
                                            <span class="Icon"></span>
                                            <asp:Label runat="server" ID="lblEdit" Text="Edit selected lines"></asp:Label>&nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnUpdateEdited" runat="server" CausesValidation="true" SecurityButtonType="AddEditMode_Edit" CssClass="GridCmdUpdateEdited"
                                            CommandName="UpdateEdited" Visible='<%# rdgUsers.EditIndexes.Count > 0 %>'>
                                            <span class="Icon"></span>
                                            <asp:Label Text="Update records" runat="server" ID="lblUpdateRecords"></asp:Label>&nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnSave" runat="server" CausesValidation="true" SecurityButtonType="AddEditMode_Add" CssClass="GridCmdPerformInsert"
                                            CommandName="PerformInsert" Visible='<%# rdgUsers.MasterTableView.IsItemInserted %>'>
                                            <span class="Icon"></span>
                                            <asp:Label Text="Save" runat="server" ID="lblSave"></asp:Label>&nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false" SecurityButtonType="AddEditMode" CssClass="GridCmdCancelAll"
                                            CommandName="CancelAll" Visible='<%# rdgUsers.EditIndexes.Count > 0 Or rdgUsers.MasterTableView.IsItemInserted %>'>
                                            <span class="Icon"></span>
                                            <asp:Label Text="Cancel" runat="server" ID="lblCancel"></asp:Label>
                                            &nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnClear" CausesValidation="false" SecurityButtonType="ItemMode_Delete" CssClass="GridCmdClearRows"
                                            Visible='<%# rdgUsers.EditIndexes.Count = 0 And (Not rdgUsers.MasterTableView.IsItemInserted) %>'
                                            runat="server" CommandName="ClearRows">
                                            <span class="Icon"></span>
                                            <asp:Label runat="server" Text="Clear selected lines" ID="lblClear" meta:resourcekey="lblClear"></asp:Label>&nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnCopyUsernames" CausesValidation="false" SecurityButtonType="ItemMode_Edit" CssClass="GridCmdCopyUsernames"
                                            Visible='<%# rdgUsers.EditIndexes.Count = 0 And (Not rdgUsers.MasterTableView.IsItemInserted) %>'
                                            runat="server" CommandName="CopyUsernames">
                                            <span class="Icon"></span>
                                            <asp:Label runat="server" Text="Copy Usernames" ID="lblCopyUsernames" meta:resourcekey="lblCopyUsernames"></asp:Label>&nbsp;&nbsp;
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="false" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                            Visible='<%# rdgUsers.EditIndexes.Count = 0 And (Not rdgUsers.MasterTableView.IsItemInserted) %>'>
                                            <span class="Icon"></span>
                                            <asp:Label runat="server" ID="lblRefresh" Text="Refresh"></asp:Label>
                                        </asp:LinkButton>
                                    </div>
                                </CommandItemTemplate>
                            </MasterTableView>
                            <ClientSettings EnableRowHoverStyle="true" AllowRowsDragDrop="False">
                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="true" ClipCellContentOnResize="true"
                                    AllowColumnResize="True"></Resizing>
                            </ClientSettings>
                        </telerik:RadGrid>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>