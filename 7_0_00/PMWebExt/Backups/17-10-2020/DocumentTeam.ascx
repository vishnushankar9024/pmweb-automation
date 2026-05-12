<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DocumentTeam.ascx.vb" Inherits="Website.DocumentTeam" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnSave">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="btnSave" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rdgTeamInput">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgTeamInput" LoadingPanelID="ldpPM" />
                <telerik:AjaxUpdatedControl ControlID="rdgTeamLog" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rdgTeamLog">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgTeamLog" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rdbComment">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ddlResponse" />
                <telerik:AjaxUpdatedControl ControlID="lblResponse" />
                <telerik:AjaxUpdatedControl ControlID="rdbReviewComplete" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rdbReviewComplete">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ddlResponse" />
                <telerik:AjaxUpdatedControl ControlID="lblResponse" />
                <telerik:AjaxUpdatedControl ControlID="rdbComment" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<style type="text/css">
    .PMHeader .row .col-12 {
        flex: 0 0 98%;
        max-width: 95%;
        float: left;
        margin-left: 24px;
    }
</style>

<telerik:RadScriptBlock ID="rsbDocument" runat="server">
    <script language="javascript" type="text/javascript">

        var IsTeamActionsExpanded = '<%= PM.HomeInfo.IsTeamActionsExpanded%>';
        var IsTeamlogsExpanded = '<%= PM.HomeInfo.IsTeamlogsExpanded%>';
        var IsTeamInputExpanded = '<%= PM.HomeInfo.IsTeamInputExpanded%>';

        $(document).ready(function () {
            SetTeamSection('tblTeamActions', IsTeamActionsExpanded);
            SetTeamSection('tblLog', IsTeamlogsExpanded);
            SetTeamSection('tblTeamInput', IsTeamInputExpanded);
        });


    </script>
    <script language="javascript" type="text/javascript" src="JS/TeamInput/TeamInput.js?version=<%= PM.Security.LicenseInfo.PMWebVersion %>"></script>
</telerik:RadScriptBlock>
<div class="PMMainPage">
    <div class="row">
        <div class="col-12">
            <table class="TableNoSpacingNoBorder" style="width:100%;table-layout:fixed;">
                <tr>
                    <td valign="middle" style="padding: 5px 0px 5px 5px; margin-bottom: 5px; overflow-x: hidden !important;">
                        <img id="tblTeamActionsimg" alt="" src="Images/Workflow/MinusWorkflow.png" onclick="return ToggleTeamSection(this,'tblTeamActions');" height="12" style="cursor:pointer !important;" />
                        <span style="color: #999999; text-transform: uppercase;">
                            <asp:Label ID="lblTeamActions" runat="server" meta:resourcekey="lblTeamActions"></asp:Label></span>
                        <%--<img alt="" src="Images/Workflow/wSperator.png" />--%>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>
<div class="PMMainPage" id="tblTeamActions" runat="server">
    <div class="row row-8-4-fit8" style="padding-top: 0px;">
        <div class="col-4">
            <table class="TableNoSpacingNoBorder" style="width:100%;table-layout:fixed;">
                <tr>
                    <td>
                        <fieldset>
                            <legend>
                                <asp:Label ID="lblActions" runat="server" Text="Actions" meta:resourcekey="lblActions"></asp:Label>
                            </legend>
                            <table class="TableNoSpacingNoBorder" style="width:100%;table-layout:fixed;">
                                <tr>
                                    <td id="tdAction">
                                        <asp:CustomValidator ID="cvTeamAction" runat="server" CssClass="Validator" ClientValidationFunction="cvAction_validateTeamAction"
                                            ValidationGroup="SaveAction" ForeColor="" meta:resourcekey="cvTeamAction"></asp:CustomValidator>
                                        <div id="dvTeamInput" runat="server">
                                            <table  id="tblrdbActions" class="TableNoSpacingNoBorder" style="width:100%;table-layout:fixed;">
                                                <tr>
                                                    <td colspan="2" width="100%">
                                                        <asp:RadioButton ID="rdbComment" runat="server" GroupName="TeamInput" OnCheckedChanged="TeamInput_CheckedChanged"
                                                            meta:resourcekey="Action_Comment" AutoPostBack="true" CssClass="RadioCss" />
                                                        <br />

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" width="100%">
                                                        <asp:RadioButton ID="rdbReviewComplete" runat="server" GroupName="TeamInput" OnCheckedChanged="TeamInput_CheckedChanged"
                                                            meta:resourcekey="Action_ReviewComplete" AutoPostBack="true" CssClass="RadioCss" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="labelWidth">
                                                        <asp:Label ID="lblResponse" runat="server" Text="Response" meta:resourcekey="lblResponse"></asp:Label>
                                                    </td>
                                                    <td class="controlWidth">
                                                        <telerik:RadComboBox ID="ddlResponse" runat="server" Filter="Contains" MarkFirstMatch="True"
                                                            Width="100%" AutoPostBack="false" NoWrap="True" AllowCustomText="True"
                                                            CausesValidation="False" Height="100px" LoadingMessage="<%$ Resources:PMWeb, Loading %>">
                                                            <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <table class="TableNoSpacingNoBorder" style="width:100%;table-layout:fixed;">
                                            <tr>
                                                <td>
                                                    <asp:Panel runat="server">
                                                        <asp:Button ID="btnSave" runat="server" Width="140px" ValidationGroup="SaveAction" meta:resourcekey="btnSave" />
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
            </table>
        </div>
        <div class="col-8">
            <fieldset>
                <legend>
                    <asp:Label ID="lblComments" runat="server" Text="Comments" meta:resourcekey="lblComments"></asp:Label>
                </legend>
                <table class="TableNoSpacingNoBorder" style="width:100%;table-layout:fixed;">
                    <tr>
                        <td>
                            <asp:CustomValidator ID="cvComments" runat="server" CssClass="Validator" ClientValidationFunction="cvComments_validateTeamAction" ErrorMessage="Comments are required"
                                ValidationGroup="SaveAction" ForeColor="" meta:resourcekey="cvComments" Display="Dynamic"></asp:CustomValidator>
                            <telerik:RadTextBox ID="txtComments" runat="server" Width="100%"
                                InputType="Text" CausesValidation="True" Height="150px" TextMode="MultiLine">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-top:5px;">
                            <asp:Panel ID="pnlQuickFileUpload" runat="server">
                                <fieldset style="padding: 0px; border: 0px; width: 100%">
                                    <div id="TeamAttachmentContainer" runat="server">
                                        <table border="0" style="width: 100%" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td align="center">
                                                    <telerik:RadAsyncUpload ID="rauAttachments" Width="100%" runat="server" MultipleFileSelection="Automatic"
                                                        CssClass="ProjectCenterUpload" HideFileInput="true"
                                                        DropZones=".TeamDropZone" OnClientValidationFailed="ClientDocFileValidationFailed">
                                                        <Localization Select="<%$ Resources:PMWeb, ProjectCenterSelect %>" />
                                                    </telerik:RadAsyncUpload>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </fieldset>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
    </div>
</div>
<div class="PMMainPage">
    <div class="row">
        <div class="col-12">
            <table class="TableNoSpacingNoBorder" style="width:100%;table-layout:fixed;">
                <tr>
                    <td style="padding-left: 100px">
                        <asp:Label ID="lblClosedTeamInput" meta:resourcekey="lblClosedCollaborate" runat="server" Visible="true" Text="Team Input is closed"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td valign="middle" style="padding: 5px 0px 5px 5px; margin-bottom: 5px; overflow-x: hidden !important;">
                        <img id="tblLogimg" alt="" src="Images/Workflow/MinusWorkflow.png" onclick="return ToggleTeamSection(this,'tblLog');" height="12" style="cursor:pointer !important;" />
                        <span style="color: #999999; text-transform: uppercase;">
                            <asp:Label ID="lblLog" runat="server" meta:resourcekey="lblLog"></asp:Label></span>
                        <%--<img alt="" src="Images/Workflow/wSperator.png" />--%>
                    </td>
                </tr>
                <tr>
                    <td id="tblLog">
                        <div>
                            <table class="TableNoSpacingNoBorder" style="width:100%;table-layout:fixed;">
                                <tr>
                                    <td>
                                        <telerik:RadGrid ID="rdgTeamLog" runat="server" CssClass="rdgLog" ItemStyle-HorizontalAlign="Left" AlternatingItemStyle-CssClass="Left"
                                            AutoGenerateColumns="False" HeaderStyle-Font-Size="8" AllowSorting="true" ShowStatusBar="true" Width="100%" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                                            OnFilterCheckListItemsRequested="CheckListItemsRequested" EnableViewState="true" ShowGroupPanel="True" Skin="Office2007"
                                            AllowFilteringByColumn="true" FilterType="HeaderContext" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
                                            <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>" DataKeyNames="ActionId" CommandItemDisplay="Top" ClientDataKeyNames="ActionId">
                                                <Columns>
                                                    <telerik:GridTemplateColumn UniqueName="HasEmail" HeaderText="Email" DataField="HasEmail" HeaderStyle-Width="40px"
                                                        SortExpression="HasEmail" GroupByExpression="HasEmail [GridColumn_HasEmail] Group By HasEmail ASC">
                                                        <ItemTemplate>
                                                            <asp:Image runat="server" ID="imgEmail" Visible='<%# Eval("HasEmail") %>' onmouseover="this.style.cursor='hand'" ImageUrl="~/Images/Global/SmallEmail.png"
                                                                Style="cursor: pointer !important;" />&nbsp;
                                                        </ItemTemplate>
                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn UniqueName="Image" HeaderStyle-Width="50px" AllowFiltering="false" Groupable="false" AllowSorting="false">
                                                        <ItemTemplate>
                                                            <asp:Image ID="imgUserImage" runat="server" />&nbsp;
                                                        </ItemTemplate>
                                                        <ItemStyle Wrap="false" HorizontalAlign="Center" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="User" UniqueName="ActionUser" HeaderStyle-Width="100px" DataField="ActionUser"
                                                        SortExpression="ActionUser" GroupByExpression="ActionUser [GridColumn_ActionUser] Group By ActionUser ASC">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblUserName" runat="server" Text=""></asp:Label>&nbsp;
                                                        </ItemTemplate>
                                                        <ItemStyle Wrap="false" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Comments" UniqueName="Comments" HeaderStyle-Width="270px" DataField="Comments"
                                                        SortExpression="Comments" GroupByExpression="Comments [GridColumn_Comments] Group By Comments ASC">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblComments" runat="server" Text='<%#Eval("Comments")%>' Width="260px"
                                                                Style="display: inline-block; white-space: pre-wrap !important; word-wrap: break-word !important;"></asp:Label>&nbsp;
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Attachments" UniqueName="AttachmentsCount" HeaderStyle-Width="80px" DataField="AttachmentsCount"
                                                        SortExpression="AttachmentsCount" GroupByExpression="AttachmentsCount [GridColumn_AttachmentsCount] Group By AttachmentsCount ASC">
                                                        <ItemTemplate>
                                                            <asp:HyperLink runat="server" CssClass="Link" ID="hplAttachments" Height="16px"></asp:HyperLink>
                                                        </ItemTemplate>
                                                        <ItemStyle Wrap="false" />
                                                        <ItemStyle HorizontalAlign="Right" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Action" UniqueName="ActionType" HeaderStyle-Width="110px" DataField="TranslatedActionType"
                                                        SortExpression="TranslatedActionType" GroupByExpression="TranslatedActionType [GridColumn_ActionType] Group By TranslatedActionType ASC">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblAction" runat="server"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Wrap="false" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Response" UniqueName="Response" HeaderStyle-Width="100px" DataField="Response"
                                                        SortExpression="Response" GroupByExpression="Response [GridColumn_Response] Group By Response ASC">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblResponse" runat="server" Text='<%# Eval("Response")%>'></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Wrap="false" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Signature" UniqueName="Signature" HeaderStyle-Width="120px" AllowFiltering="false" AllowSorting="false" Groupable="false">
                                                        <ItemTemplate>
                                                            <asp:Image ID="imgSignature" Height="22px" Width="120px" runat="server" />&nbsp;
                                                        </ItemTemplate>
                                                        <ItemStyle Wrap="false" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Action Date" UniqueName="ActionDate" HeaderStyle-Width="90px" DataField="ActionDate"
                                                        SortExpression="ActionDate" GroupByExpression="ActionDate [GridColumn_ActionDate] Group By ActionDate ASC"
                                                        CurrentFilterFunction="EqualTo" FilterListOptions="VaryByDataType" AutoPostBackOnFilter="true">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblActionDate" runat="server" Text='<%# FormatDate(Container.DataItem("ActionDate"))%>' />
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        <ItemStyle Wrap="false" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Action Time" UniqueName="ActionTime" HeaderStyle-Width="90px" DataField="ActionTime"
                                                        SortExpression="ActionTime" GroupByExpression="ActionTime [GridColumn_ActionTime] Group By ActionTime ASC"
                                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterListOptions="VaryByDataType" DataType="System.String">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblActionTime" runat="server" Text='<%# CDate(Eval("ActionTime")).ToString("hh:mm:ss tt") %>' />
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        <ItemStyle Wrap="false" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn HeaderText="Due Date" UniqueName="DueDate" HeaderStyle-Width="90px" DataField="DueDate"
                                                        SortExpression="DueDate" GroupByExpression="DueDate [GridColumn_DueDate] Group By DueDate ASC">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblDueDateLog" runat="server"
                                                                Text='<%# If(Library.Common.Utilities.GetDateFromDB(Eval("DueDate")) = "1970-01-01", "", FormatDate(Library.Common.Utilities.GetDateFromDB((Eval("DueDate")))))%>' />&nbsp;
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                        <ItemStyle Wrap="false" />
                                                    </telerik:GridTemplateColumn>
                                                    <%-- <telerik:GridTemplateColumn HeaderText="Due Time" UniqueName="DueTime" HeaderStyle-Width="100px">
                                                            <ItemTemplate>
                                                                <asp:label ID ="lblDueTimeLog" runat="server"
                                                                    Text='<%# If(Library.Common.Utilities.GetDateFromDB(Eval("DueDate")) = "1970-01-01", "", CDate(Library.Common.Utilities.GetDateFromDB(Eval("DueDate"))).ToString("hh:mm:ss tt"))%>' />
                                                            </ItemTemplate>
                                                            <ItemStyle Wrap="false" />
                                                        </telerik:GridTemplateColumn>--%>
                                                </Columns>
                                                <CommandItemTemplate>
                                                    <div style="padding: 4px">
                                                        <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CommandName="RebindGrid" CssClass="GridCmdRebindGrid"
                                                            Visible='<%# rdgTeamLog.EditIndexes.Count = 0 And (Not rdgTeamLog.MasterTableView.IsItemInserted)%>'>
                                                            <span class="Icon"></span>
                                                            <asp:Label ID="lblRefresh" runat="server"></asp:Label>
                                                        </asp:LinkButton>
                                                        <telerik:RadMenu ID="rdmLayouts" Style="float: none; display: inline-block; vertical-align: middle;" SecurityButtonType="ItemMode" EnableRoundedCorners="true"
                                                            EnableAutoScroll="true" CollapseAnimation-Type="None" OnItemClick="Grid_rdmLayouts_ItemClick" OnClientItemClicking="rdmLayouts_ItemClicking"
                                                            runat="server" EnableSelection="true" CssClass="trvContextMenu bringToBack" EnableShadows="true" CausesValidation="false" Visible="true">
                                                        </telerik:RadMenu>
                                                    </div>
                                                </CommandItemTemplate>
                                            </MasterTableView>
                                            <ClientSettings EnableRowHoverStyle="false" Selecting-AllowRowSelect="true"
                                                AllowColumnHide="true" AllowColumnsReorder="true" AllowDragToGroup="true">
                                                <Resizing EnableRealTimeResize="False" ResizeGridOnColumnResize="True" ClipCellContentOnResize="true"
                                                    AllowColumnResize="True" />
                                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                            </ClientSettings>
                                        </telerik:RadGrid>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <table class="TableNoSpacingNoBorder" style="width:100%;table-layout:fixed;">
                <tr>
                    <td valign="middle" style="padding: 5px 0px 5px 5px; margin-bottom: 5px; overflow-x: hidden !important;">
                        <img id="tblTeamInputimg" alt="" src="Images/Workflow/MinusWorkflow.png" onclick="return ToggleTeamSection(this,'tblTeamInput');" height="12" style="cursor:pointer !important;" />
                        <span style="color: #999999; text-transform: uppercase;">
                            <asp:Label ID="lblCollaborate" runat="server" meta:resourcekey="lblCollaborate"></asp:Label></span>
                        <%--<img alt="" src="Images/Workflow/wSperator.png" />--%>
                    </td>
                </tr>
                <tr>
                    <td id="tblTeamInput" runat="server">
                        <table class="TableNoSpacingNoBorder" style="width:100%;table-layout:fixed;">
                            <tr>
                                <td>
                                    <telerik:RadGrid ID="rdgTeamInput" runat="server" Skin="Office2007" SetWidth="true"
                                        ItemStyle-HorizontalAlign="Left" AlternatingItemStyle-CssClass="Left" ClientSettings-Scrolling-AllowScroll="true"
                                        AutoGenerateColumns="False" HeaderStyle-Font-Size="8" Width="100%"
                                        AllowSorting="true" ShowStatusBar="true" AllowMultiRowEdit="True"
                                        AllowMultiRowSelection="True" UseEditFormInMobile="true">
                                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                            DataKeyNames="MemberId,WasRemoved" ClientDataKeyNames="MemberId,WasRemoved"
                                            CommandItemDisplay="Top" EditMode="InPlace" UseAllDataFields="true">
                                            <Columns>
                                                <telerik:GridTemplateColumn HeaderText="Team Member" UniqueName="TeamMember" HeaderStyle-Width="260px">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTeamMember" runat="server" Text=""></asp:Label>&nbsp;
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <span><%#IIf(CStr(Eval("MemberUser")) = String.Empty, "&nbsp;", Eval("MemberUser"))%></span>
                                                    </EditItemTemplate>
                                                    <ItemStyle Wrap="false" />
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Progress" UniqueName="Progress" HeaderStyle-Width="120px">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblProgress" runat="server" Text='<%#Eval("LastActionType")%>'></asp:Label>&nbsp;
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:Label ID="lblEditProgress" runat="server"></asp:Label>&nbsp;
                                                    </EditItemTemplate>
                                                    <ItemStyle Wrap="false" />
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Due Date" UniqueName="DueDate" HeaderStyle-Width="120px">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDueDate" runat="server" Text='<%# FormatDate(Eval("DueDate"))%>' />&nbsp;
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                    <EditItemTemplate>
                                                        <telerik:RadDatePicker ID="dtpDueDate" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                            Width="100%" Skin="Office2007" Culture="English (United States)" SelectedDate='<%# CDate(Eval("DueDate"))%>'
                                                            EnableTyping="true" DatePopupButton-Visible="true">
                                                            <DateInput ID="DateInput2" ReadOnly="true" runat="server"></DateInput>
                                                        </telerik:RadDatePicker>
                                                    </EditItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Can Edit Record" UniqueName="CanEditRecord" HeaderStyle-Width="100px">
                                                    <ItemTemplate>
                                                        <img src="Images/Global/<%#CStr(IIf(CBool(Eval("CanEditRecord")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:CheckBox ID="chkCanEditRecord" Checked='<%# CBool(IIf(Eval("CanEditRecord") Is System.DBNull.Value, 0, Eval("CanEditRecord")))%>' runat="server" />
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Can Edit Notes" UniqueName="CanEditNotes" HeaderStyle-Width="100px">
                                                    <ItemTemplate>
                                                        <img src="Images/Global/<%#CStr(IIf(CBool(Eval("CanEditNotes")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:CheckBox ID="chkCanEditNotes" Checked='<%# CBool(IIf(Eval("CanEditNotes") Is System.DBNull.Value, 0, Eval("CanEditNotes")))%>' runat="server" />
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Can Edit Attachments" UniqueName="CanEditAttachments" HeaderStyle-Width="100px">
                                                    <ItemTemplate>
                                                        <img src="Images/Global/<%#CStr(IIf(CBool(Eval("CanEditAttachments")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:CheckBox ID="chkCanEditAttachments" Checked='<%# CBool(IIf(Eval("CanEditAttachments") Is System.DBNull.Value, 0, Eval("CanEditAttachments")))%>' runat="server" />
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Notify On Team Changes" UniqueName="NotifyOnTeamChanges" HeaderStyle-Width="100px">
                                                    <ItemTemplate>
                                                        <img src="Images/Global/<%#CStr(IIf(CBool(Eval("NotifyOnTeamChanges")) = CBool(1), "checked.png", "unchecked.png"))%>" alt="" />
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <asp:CheckBox ID="chkNotifyOnTeamChanges" Checked='<%# CBool(IIf(Eval("NotifyOnTeamChanges") Is System.DBNull.Value, 0, Eval("NotifyOnTeamChanges")))%>' runat="server" />
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Date Invited" UniqueName="DateInvited" HeaderStyle-Width="120px">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDateInvited" runat="server" Text='<%# FormatDate(Eval("DateInvited"))%>' />&nbsp;
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <span><%# IIf(Eval("DateInvited") Is DBNull.Value, "&nbsp;", FormatDate(Eval("DateInvited")))%></span>
                                                    </EditItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                    <ItemStyle Wrap="false" />
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn HeaderText="Time Invited" UniqueName="TimeInvited" HeaderStyle-Width="120px">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTimeInvited" runat="server" Text='<%# CDate(Eval("DateInvited")).ToString("hh:mm:ss tt")%>' />
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <span><%# IIf(Eval("DateInvited") Is DBNull.Value, "&nbsp;", CDate(Eval("DateInvited")).ToString("hh:mm:ss tt"))%></span>
                                                    </EditItemTemplate>
                                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                    <ItemStyle Wrap="false" />
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                            <CommandItemTemplate>
                                                <div style="padding: 4px">
                                                    <table cellpadding="0" cellspacing="0">
                                                        <tr>
                                                            <td>
                                                                <asp:LinkButton ID="btnEditSelected" runat="server" CausesValidation="False" CommandName="EditRows"
                                                                    SecurityButtonType="ItemMode_Edit" CssClass="GridCmdEditRows" Visible='<%# rdgTeamInput.EditIndexes.Count = 0 And (Not rdgTeamInput.MasterTableView.IsItemInserted)%>'>
                                                                    <span class="Icon"></span>
                                                                    <asp:Label ID="lblEditSelectedLines" runat="server" Text="Edit"></asp:Label>
                                                                    &nbsp;&nbsp;
                                                                </asp:LinkButton>
                                                            </td>
                                                            <td>
                                                                <asp:LinkButton ID="btnUpdateEdited" runat="server" SecurityButtonType="AddEditMode_Edit" CommandName="UpdateEdited" CssClass="GridCmdUpdateEdited"
                                                                    Visible='<%# rdgTeamInput.EditIndexes.Count > 0%>' meta:resourcekey="btnUpdateEditedResource1" CausesValidation="False">
                                                                    <span class="Icon"></span>
                                                                    <asp:Label ID="lblUpdateRecords" runat="server" Text="Update records" meta:resourcekey="lblUpdateRecordsResource1"></asp:Label>
                                                                    &nbsp;&nbsp;
                                                                </asp:LinkButton>
                                                            </td>
                                                            <td>
                                                                <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="False" SecurityButtonType="AddEditMode" CommandName="CancelAll" CssClass="GridCmdCancelAll"
                                                                    Visible='<%# rdgTeamInput.EditIndexes.Count > 0%>' meta:resourcekey="btnCancelResource1">
                                                                    <span class="Icon"></span>
                                                                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" meta:resourcekey="lblCancelResource1"></asp:Label>
                                                                    &nbsp;&nbsp;
                                                                </asp:LinkButton>
                                                            </td>
                                                            <td>
                                                                <asp:LinkButton ID="btnAddTeamInput1" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add"
                                                                    CommandName="AddTeamInput" CssClass="GridCmdInitNewRow" Visible='<%# rdgTeamInput.EditIndexes.Count = 0 And (Not rdgTeamInput.MasterTableView.IsItemInserted)%>'>
                                                                    <span class="Icon"></span>
                                                                    <asp:Label ID="lblAddLine" runat="server" Text="Add" meta:resourcekey="lblAddLineResource1"></asp:Label>
                                                                    &nbsp;&nbsp;
                                                                </asp:LinkButton>
                                                            </td>
                                                            <td>
                                                                <asp:LinkButton ID="btnCloseTeamInput" runat="server" CausesValidation="False" SecurityButtonType="ItemMode_Add"
                                                                    CommandName="CloseCollaborate" CssClass="GridCmdAutoApply"
                                                                    Visible='<%# rdgTeamInput.EditIndexes.Count = 0 AndAlso Me.PM.Team.DocumentTeamInfo.TeamId > 0 AndAlso Not Me.PM.Team.DocumentTeamInfo.IsDocumentTeamClosed%>'>
                                                                    <span class="Icon"></span>
                                                                    <asp:Label ID="lblCloseTeamInput" runat="server" Text="Close Team Input"></asp:Label>
                                                                    &nbsp;&nbsp;
                                                                </asp:LinkButton>
                                                            </td>
                                                            <td>
                                                                <asp:LinkButton ID="btnRemove1" CausesValidation="False" SecurityButtonType="ItemMode_Delete" OnClientClick="javascript:return ConfirmRemoveTeamMember();"
                                                                    Visible='<%# rdgTeamInput.EditIndexes.Count = 0 AndAlso Me.PM.Team.DocumentTeamInfo.TeamId > 0 AndAlso Not Me.PM.Team.DocumentTeamInfo.IsDocumentTeamClosed%>'
                                                                    runat="server" CommandName="RemoveMember" CssClass="GridCmdDeleteRows" meta:resourcekey="btnDeleteResource1">
                                                                    <span class="Icon"></span>
                                                                    <asp:Label ID="lblDeleteSelectedLines" runat="server" Text="Delete selected lines" meta:resourcekey="lblDeleteSelectedLinesResource1"></asp:Label>
                                                                    &nbsp;&nbsp;
                                                                </asp:LinkButton>
                                                            </td>
                                                            <td>
                                                                <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode"
                                                                    CommandName="RebindGrid" CssClass="GridCmdRebindGrid" Visible='<%# rdgTeamInput.EditIndexes.Count = 0%>'>
                                                                    <span class="Icon"></span>
                                                                    <asp:Label ID="lblRefresh" runat="server" Text="Refresh"></asp:Label>
                                                                </asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </CommandItemTemplate>
                                        </MasterTableView>
                                        <ClientSettings ClientEvents-OnRowDblClick="RowDblClick" ClientEvents-OnRowSelected="rdgTeamInput_RowSelected" Resizing-AllowColumnResize="true">
                                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                            <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                                        </ClientSettings>

                                    </telerik:RadGrid>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>

