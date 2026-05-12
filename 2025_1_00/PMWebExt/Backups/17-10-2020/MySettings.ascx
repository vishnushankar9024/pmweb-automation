<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="MySettings.ascx.vb" Inherits="Website.MySettings" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<%--<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">

    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="ddlSummarizeEvery">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="lblSummaryDay" />
                <telerik:AjaxUpdatedControl ControlID="ddlSummarizeEvery" />
                <telerik:AjaxUpdatedControl ControlID="ddlSummaryDay" />
            </UpdatedControls> 
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnRefreshUserImage">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="btnRefreshUserImage" />
                <telerik:AjaxUpdatedControl ControlID="imgUserImage" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy> --%>
<style>
    .lnkButton .Icon {
        background-image: url('CSS/Images/ResponsiveIcons/24Enabled.png');
        background-repeat: no-repeat;
        background-position: -504px 0;
        height: 24px;
        width: 24px;
    }

    .RadioCss label {
        color: #000000 !important;
        text-transform: unset !important;
    }
</style>



<telerik:RadAjaxPanel runat="server" ID="pnlajax" LoadingPanelID="ldpPM">
    <table style="width: 100%; padding-top: 41px; padding-left: 24px; background-color: #ededed" cellpadding="0" cellspacing="0">
        <tr>
            <td style="width: 160px; white-space: nowrap;">
                <asp:HiddenField ID="hdnGroupUserId" runat="server" />
                <asp:HiddenField ID="hdnGroupUserType" runat="server" />
                <asp:Button ID="btnLoadSettings" CssClass="Hide" runat="server" />
                <asp:Label ID="lblGroupUser" meta:resourcekey="lblGroupUser" runat="server" Text="Select Group/User123"></asp:Label>
            </td>
            <td style="width: 240px;">
                <telerik:RadComboBox ID="ddlGroupsUsers" runat="server" OnClientDropDownOpened="OnClientDropDownOpened"
                    CloseDropDownOnBlur="true" Width="100%" AutoPostBack="False" DropDownCssClass="ddlTreeviewTemplate"
                    Height="260px" CausesValidation="False" AllowCustomText="True">
                    <Items>
                        <telerik:RadComboBoxItem Text="" />
                    </Items>
                    <ItemTemplate>
                        <div onclick="StopPropagation(event)">
                            <telerik:RadTreeView ID="rdvGroupsUsers" runat="server" Height="250px" Width="100%"
                                MultipleSelect="false" ShowLineImages="true" OnNodeClick="rdvGroupsUsers_NodeClick" OnNodeDataBound="rdvGroupsUsers_NodeDataBound"
                                OnNodeExpand="rdvGroupsUsers_NodeExpand">
                            </telerik:RadTreeView>
                        </div>
                    </ItemTemplate>
                </telerik:RadComboBox>
            </td>
            <asp:Panel ID="pnlToolBar" runat="server">
                <td valign="middle" style="vertical-align: middle; padding-left: 24px;" class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" AutoPostBack="false" OnClientButtonClicked="click_handler">
                        <Items>
                            <telerik:RadToolBarSplitButton EnableDefaultButton="false" PostBack="true" Text="Load..." meta:resourcekey="ToolBarButton_Load" OuterCssClass="HideOnMobileToolbar">
                                <Buttons>
                                    <telerik:RadToolBarButton CommandName="LoadDeployed" PostBack="true" meta:resourcekey="ToolBarButton_LoadUserDeploy" Text="Load the selection's deployed settings" SecurityButtonType="Edit"></telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton CommandName="ViewGroups" meta:resourcekey="ToolBarButton_CopyFromGroup" Text="Copy from a group" SecurityButtonType="Edit"></telerik:RadToolBarButton>
                                    <telerik:RadToolBarButton CommandName="ViewUsers" meta:resourcekey="ToolBarButton_CopyFromUser" Text="Copy from a user" SecurityButtonType="Edit"></telerik:RadToolBarButton>
                                </Buttons>
                            </telerik:RadToolBarSplitButton>
                            <telerik:RadToolBarButton PostBack="false" CommandName="MobileMenu" ImageUrl="Images/ToolBar/PMWebW.gif">
                                <ItemTemplate>
                                    <telerik:RadMenu runat="server" CssClass="MoreMenu" ID="MobileRadmen" ClickToOpen="true" OnClientItemClicking="MoreMenuClickedMySettings">
                                        <Items>
                                            <telerik:RadMenuItem CssClass="menuMore">
                                                <Items>
                                                    <telerik:RadMenuItem Text="Load" Value="Load">
                                                        <Items>
                                                            <telerik:RadMenuItem Text="Load the selection's deployed settings1" Value="LoadDeployed"></telerik:RadMenuItem>
                                                            <telerik:RadMenuItem Text="Copy from a group1" Value="ViewGroups"></telerik:RadMenuItem>
                                                            <telerik:RadMenuItem Text="Copy from a user1" Value="ViewUsers"></telerik:RadMenuItem>
                                                        </Items>
                                                    </telerik:RadMenuItem>
                                                    <telerik:RadMenuItem Text="Save1" Value="Save"></telerik:RadMenuItem>
                                                    <telerik:RadMenuItem Text="Deploy Settings1" Value="DeploySettings"></telerik:RadMenuItem>
                                                </Items>
                                            </telerik:RadMenuItem>
                                        </Items>
                                    </telerik:RadMenu>
                                </ItemTemplate>
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
                <td style="width: 20px;" class="HideOnMobileToolbar">
                    <telerik:RadToolBar ID="SaveToolBar" CssClass="popup-toolbar" runat="server" Skin="Default" AutoPostBack="True">
                        <Items>
                            <telerik:RadToolBarButton SecurityButtonType="Edit" EnableImageSprite="true" ValidationGroup="Save"
                                CommandName="Save" CssClass="ToolbarSave" Value="Save">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
                <td class="HideOnMobileToolbar" style="width: 200px">
                    <asp:LinkButton ID="lnk" runat="server" CssClass="lnkButton" Style="text-decoration: none; height: 35px; line-height: 35px; white-space: nowrap; padding: 0; text-align: center; width: 200px;"
                        CausesValidation="true" ValidationGroup="Save" OnClientClick="return lnkClick();" value="DeploySettings">
                        <span class="Icon"></span>
                        <asp:Label style="text-transform:uppercase" runat="server">deploy settings</asp:Label>
                    </asp:LinkButton>
                    <asp:Button ID="btnDeploy" Style="display: none; visibility: hidden;" runat="server" CausesValidation="true" ValidationGroup="Save" OnClientClick="return OnClientDeployClick('MySettings');"
                        Text="Deploy Settings1" meta:resourcekey="btn_Deploy" value="DeploySettings" CssClass="btn" Width="140px" Height="35px" />
                    <asp:Button ID="btnDeploySettings" CssClass="Hide" runat="server" ValidationGroup="Save" CausesValidation="true" />
                </td>

            </asp:Panel>
            <td style="padding-left: 24px">
                <asp:Label ID="lblMessage" Text="SAVED SETTINGS NOT DEPLOYED1" runat="server" meta:resourcekey="lblMessage"></asp:Label>
            </td>
        </tr>
    </table>
    <div class="PMMainPage">
        <div class="row row-8-4-fit8">
            <div class="col-4">
                <table class="colTable">
                    <tr>
                        <td id="tdProfile">
                            <fieldset id="flsProfile" runat="server">
                                <legend>
                                    <asp:Label runat="server" Text="Profile" meta:Resourcekey="lblProfile" ID="lblProfile"></asp:Label></legend>
                                <table class="colTable">
                                    <tr>
                                        <td class="NoWrap labelWidth">
                                            <asp:Label Text="First Name*" ID="lblFirstName" meta:resourceKey="lblFirstName" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtFirstName" MaxLength="50" CausesValidation="true" runat="server"></asp:TextBox>
                                            <div>
                                                <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ControlToValidate="txtFirstName"
                                                    ValidationGroup="Save" meta:resourcekey="rfvFirstName"
                                                    ErrorMessage="Enter the First Name" Display="Dynamic"></asp:RequiredFieldValidator>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="NoWrap labelWidth">
                                            <asp:Label Text="Last Name" ID="lblLastName" meta:resourceKey="lblLastName" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtLastName" MaxLength="50" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="NoWrap labelWidth">
                                            <asp:Label Text="Email*" ID="lblEmail" runat="server" meta:resourceKey="lblEmail"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                                            <div>
                                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                                                    ValidationGroup="Save" ErrorMessage="Enter the Email" Display="Dynamic"
                                                    meta:resourcekey="rfvEmail"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                                                    CssClass="Validator" ErrorMessage="Not valid email" ValidationExpression="\w+([-+.']*\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                    ValidationGroup="Save" Display="Dynamic" meta:resourcekey="revEmail"></asp:RegularExpressionValidator>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="NoWrap labelWidth">
                                            <asp:Label Text="Cell" ID="lblCell" meta:resourceKey="lblMobile" runat="server"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox ID="txtCell" MaxLength="50" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr style="height: 10px;">
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <telerik:RadAsyncUpload runat="server" ID="rauUserImage" Skin="Default" OnClientFileUploadFailed="onDocFileUploadFailed" Style="display: none;"
                                                OnClientFileSelected="onDocFileSelected" OnClientFileUploaded="onDocFileUploaded"
                                                MultipleFileSelection="Disabled" OnClientValidationFailed="ClientDocFileValidationFailed" HideFileInput="true"
                                                Width="80px">
                                                <Localization Select="<%$ Resources:PMWeb, btn_Image %>" />
                                            </telerik:RadAsyncUpload>
                                            <asp:Button ID="btnRefreshUserImage" runat="server" CssClass="Hide" />
                                            <div style="float: left">
                                                <asp:Label runat="server" ID="lblImage" Text="Image"></asp:Label>
                                            </div>
                                            <div style="float: right">
                                                <asp:LinkButton runat="server" ID="btnuserimage" CssClass="SearchButton" OnClientClick="return RadAsyncUploadclcik()">
    					                                                    <span class="Icon"></span>                                                              
                                                </asp:LinkButton>


                                            </div>
                                            <div style="width: 16px; height: 16px; margin-right: 13px; margin-top: 25px; float: right">
                                                <asp:Button ID="btnClearImage" runat="server" CssClass="btnclearimage" Style="background-color: transparent !important;" />
                                            </div>

                                            <td class="controlWidth">
                                                <asp:Image ID="imgUserImage" runat="server" />
                                            </td>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <fieldset>
                                <legend>LOGOUT</legend>
                                <table style="width: 100%">
                                    <tr>
                                        <td class="labelColor">
                                            <asp:Label runat="server" Text="" meta:Resourcekey="lblLogoutInformation" ID="lblLogoutInformation"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="controlWidth">
                                            <asp:RadioButtonList ID="rblFrequency" AutoPostBack="false" runat="server" CssClass="RadioCss RadioPadding" Style="float: right" RepeatLayout="Table" RepeatColumns="1" RepeatDirection="Vertical">
                                                <asp:ListItem meta:resourcekey="rblFrequency_SaveCookie" Text="" Value="SaveCookie"> </asp:ListItem>
                                                <asp:ListItem meta:resourcekey="rblFrequency_DeleteCookie" Text="" Value="DeleteCookie"></asp:ListItem>
                                                <asp:ListItem meta:resourcekey="rblFrequency_Prompt" Text="Ask Me What I Want to Do" Value="Prompt"></asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <fieldset>
                                <legend>
                                    <asp:Label runat="server" Text="Promt To Save" meta:Resourcekey="lblOptions" ID="lblPromtToSave"></asp:Label></legend>
                                <table style="width: 100%">
                                    <tr>
                                        <td class="labelColor" style="width: 90% !important;">
                                            <asp:Label ID="lblPromptToSave" runat="server" Text="Prompt To Save" meta:resourcekey="chkPromptToSave"></asp:Label>
                                        </td>
                                        <td style="text-align: right; width: 10% !important;">
                                            <label class="switch">
                                                <input id="chkPromptToSave" runat="server" type="checkbox" />
                                                <span class="slider round"></span>
                                            </label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelColor" style="width: 90% !important;">
                                            <asp:Label ID="lblOpenWithMenuCollapsed" runat="server" Text="Open With Menu Collapsed" meta:resourcekey="chkOpenWithMenuCollapsed"></asp:Label>
                                        </td>
                                        <td style="text-align: right; width: 10% !important;">
                                            <label class="switch">
                                                <input id="chkOpenWithMenuCollapsed" runat="server" type="checkbox" />
                                                <span class="slider round"></span>
                                            </label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelColor" style="width: 90% !important;">
                                            <asp:Label ID="lblAdvancedGridFiltering" runat="server" Text="Advanced Grid Filters" meta:resourcekey="chkAdvancedGridFiltering"></asp:Label>
                                        </td>
                                        <td style="text-align: right; width: 10% !important;">
                                            <label class="switch">
                                                <input id="chkAdvancedGridFiltering" runat="server" type="checkbox" />
                                                <span class="slider round"></span>
                                            </label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelColor" style="white-space: nowrap; width: 90% !important;">
                                            <asp:Label ID="lblAllowUsertoEditMySettings" runat="server" Text="Allow User to Edit My Settings" meta:resourcekey="chkAllowUsertoEditMySettings"></asp:Label>
                                        </td>
                                        <td style="text-align: right; width: 10% !important;">
                                            <label class="switch">
                                                <input id="chkAllowUsertoEditMySettings" runat="server" type="checkbox" />
                                                <span class="slider round"></span>
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <fieldset style="height: 245px;">
                                <legend>
                                    <asp:Label runat="server" ID="lblEvents" meta:Resourcekey="lblEvents"></asp:Label>
                                </legend>
                                <table style="width: 100%">
                                    <tr>
                                        <td colspan="2">
                                            <telerik:RadGrid ID="rdgEvents" runat="server" SetWidth="true" FitParentContainer="true"
                                                HeaderStyle-Font-Size="8" Width="100%" AutoGenerateColumns="False" AllowMultiRowEdit="True"
                                                AllowMultiRowSelection="true" AllowSorting="true" ShowStatusBar="False" AllowPaging="False">
                                                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                                    DataKeyNames="Id" CommandItemDisplay="None" EditMode="InPlace" Width="100%">
                                                    <Columns>
                                                        <telerik:GridTemplateColumn HeaderText="Trigger" UniqueName="Trigger" HeaderStyle-Width="200px">
                                                            <ItemTemplate>
                                                                <%#IIf(Container.DataItem("Trigger") = String.Empty, "&nbsp;", Container.DataItem("Trigger"))%>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Summaries Only" UniqueName="Summaries" HeaderStyle-Width="200px" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chbSummaries" AutoPostBack="false"
                                                                    Checked='<%# CBool(IIf(Eval("Summaries") Is System.DBNull.Value, 0, Eval("Summaries")))%>'
                                                                    runat="server" />
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                    </Columns>
                                                </MasterTableView>
                                                <HeaderStyle Font-Size="8pt"></HeaderStyle>
                                                <ClientSettings Resizing-AllowColumnResize="true" Selecting-AllowRowSelect="true">
                                                </ClientSettings>
                                            </telerik:RadGrid>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth" style="width: 160px !important;">
                                            <asp:Label runat="server" ID="lblSummarizeEvery" Text="Summarize Every" meta:Resourcekey="lblSummarizeEvery"></asp:Label>
                                        </td>
                                        <td class="controlWidth" style="width: 240px !important;">
                                            <telerik:RadComboBox ID="ddlSummarizeEvery" runat="server" AutoPostBack="true" CausesValidation="False"
                                                CloseDropDownOnBlur="true" NoWrap="true" Skin="Default" Width="100%">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="Day" Value="Day" meta:resourcekey="ItemValue_Day" />
                                                    <telerik:RadComboBoxItem Text="Week" Value="Week" meta:resourcekey="ItemValue_Weeks" />
                                                </Items>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth" style="width: 160px !important;">
                                            <asp:Label runat="server" ID="lblSummaryDay" Text="Summary Day" meta:Resourcekey="lblSummaryDay"></asp:Label>
                                        </td>
                                        <td class="controlWidth" style="width: 240px !important;">
                                            <telerik:RadComboBox ID="ddlSummaryDay" runat="server" AutoPostBack="False" CausesValidation="False"
                                                CloseDropDownOnBlur="true" NoWrap="true" Skin="Default" Width="100%">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="Monday" Value="Monday" meta:resourcekey="ItemValue_Monday" />
                                                    <telerik:RadComboBoxItem Text="Tuesday" Value="Tuesday" meta:resourcekey="ItemValue_Tuesday" />
                                                    <telerik:RadComboBoxItem Text="Wednesday" Value="Wednesday" meta:resourcekey="ItemValue_Wednesday" />
                                                    <telerik:RadComboBoxItem Text="Thursday" Value="Thursday" meta:resourcekey="ItemValue_Thursday" />
                                                    <telerik:RadComboBoxItem Text="Friday" Value="Friday" meta:resourcekey="ItemValue_Friday" />
                                                    <telerik:RadComboBoxItem Text="Saturday" Value="Saturday" meta:resourcekey="ItemValue_Saturday" />
                                                    <telerik:RadComboBoxItem Text="Sunday" Value="Sunday" meta:resourcekey="ItemValue_Sunday" />
                                                </Items>
                                            </telerik:RadComboBox>
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
                        <asp:Label runat="server" ID="lblHomePageTabs" meta:Resourcekey="lblHomePageTabs"></asp:Label>
                    </legend>

                    <telerik:RadGrid ID="rdgTabs" AllowMultiRowSelection="true" runat="server" PageSize="250"
                        HeaderStyle-Font-Size="8" Width="100%" Height="99%" AutoGenerateColumns="False" SetWidth="true" FitParentContainer="true"
                        AllowSorting="true" AllowMultiRowEdit="true" ShowStatusBar="false" AllowPaging="True" UseEditFormInMobile="true">
                        <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                        <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                            Width="100%" DataKeyNames="Id" ClientDataKeyNames="Id" CommandItemDisplay="Top"
                            InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" EditMode="InPlace">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Show" UniqueName="visible"
                                    HeaderStyle-Width="50px" ItemStyle-Wrap="false"
                                    SortExpression="visible" ItemStyle-HorizontalAlign="Center" HeaderStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelect" runat="server" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:CheckBox ID="chbvisible" Checked='<%# CBool(IIf(Eval("visible") Is System.DBNull.Value, 0, Eval("visible")))%>' runat="server" />
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Order" UniqueName="TabNumber" HeaderStyle-Wrap="false" SortExpression="TabNumber"
                                    Groupable="false" Reorderable="false" AllowFiltering="false">
                                    <ItemTemplate>
                                        <span><%#Container.DataItem("TabNumber").ToString%></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <%#Eval("TabNumber").ToString%>
                                    </EditItemTemplate>
                                    <HeaderStyle Wrap="False" Width="50px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Tab Label*" UniqueName="TabName" HeaderStyle-Width="170px"
                                    SortExpression="TabName">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtShowTabName" MaxLength="500" Width="100%" runat="server" Text=' <%#Container.DataItem("TabName")%>'>
                                        </asp:TextBox>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtTabName" MaxLength="500" Width="100%" runat="server" Text='<%# Eval("TabName") %>'>
                                        </asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvTabName" ControlToValidate="txtTabName"
                                            ValidationGroup="TabSave" runat="server" ForeColor="" CssClass="Validator" Display="Dynamic"
                                            ErrorMessage="<%$Resources:PMWeb, WarningMsg_Required %>">
                                        </asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="Tab Type" UniqueName="TabType" HeaderStyle-Width="200px"
                                    SortExpression="TabType">
                                    <ItemTemplate>
                                        <telerik:RadComboBox ID="ddlTabType" AutoPostBack="true" OnSelectedIndexChanged="ddlTabType_OnSelectedIndexChanged" runat="server" Width="100%" Style="white-space: nowrap">
                                            <Items>
                                                <telerik:RadComboBoxItem Text="PDF" Value="PDF" />
                                                <telerik:RadComboBoxItem  Text="BI Report" Value="BIReport" Selected="True" />
                                                <telerik:RadComboBoxItem  Text="PMWeb Report" Value="PMWebReport" />
                                                <telerik:RadComboBoxItem  Text="Web Page" Value="WebPage" />
                                            </Items>
                                        </telerik:RadComboBox>

                                        <asp:Label runat="server" ID="lblTabType" Text='<%#Container.DataItem("TabType")%>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <%#Eval("TabType").ToString%>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn HeaderText="Configure" UniqueName="Configure" HeaderStyle-Width="190px"
                                    SortExpression="Configure">
                                    <ItemTemplate>
                                        <div style="width: 24px; float: left; margin-right: 24px;">
                                            <asp:LinkButton runat="server" ID="imgConfigure" class="SearchButton"
                                                CssClass="SearchButton">
                                                                                   <span class="Icon"></span>
                                            </asp:LinkButton>
                                        </div>
                                        <asp:Label runat="server" ID="lblConfigured"></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                            <FooterStyle CssClass="GridFooter" />
                            <CommandItemTemplate>
                                <div style="padding: 2px">
                                    <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="False" CommandName="InitNewRow" CssClass="GridCmdInitNewRow" SecurityButtonType="ItemMode_Add">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblAddLine" runat="server"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" CausesValidation="False" OnClientClick="return ConfirmDelete()" CssClass="GridCmdDeleteRows"
                                        runat="server" CommandName="DeleteRows" SecurityButtonType="ItemMode_Delete">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblDeleteSelectedLines" runat="server"></asp:Label>
                                        &nbsp;&nbsp;
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnRefresh" runat="server" CausesValidation="False" SecurityButtonType="ItemMode" CssClass="GridCmdRebindGrid"
                                        CommandName="RebindGrid" Visible='<%# rdgTabs.EditIndexes.Count = 0 And (Not rdgTabs.MasterTableView.IsItemInserted) %>'
                                        meta:resourcekey="btnRefreshResource1">
                                        <span class="Icon"></span>
                                        <asp:Label ID="lblRefresh" runat="server" Text="Refresh" meta:resourcekey="lblRefreshResource1">
                                        </asp:Label>
                                    </asp:LinkButton>
                                </div>
                            </CommandItemTemplate>
                        </MasterTableView>
                        <HeaderStyle Font-Size="8pt"></HeaderStyle>
                        <ClientSettings EnableRowHoverStyle="true" AllowDragToGroup="False" AllowRowsDragDrop="false"
                            Resizing-AllowColumnResize="False">
                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="true" />
                            <Resizing EnableRealTimeResize="True" ResizeGridOnColumnResize="false" ClipCellContentOnResize="true"
                                AllowColumnResize="True" />
                        </ClientSettings>
                        <ValidationSettings ValidationGroup="Save" EnableValidation="true" CommandsToValidate="UpdateEdited,PerformInsert" />
                    </telerik:RadGrid>


                    <asp:Button runat="server" CssClass="Hide" ID="btnRefreshGrid" />
                </fieldset>

            </div>
        </div>
    </div>

</telerik:RadAjaxPanel>






