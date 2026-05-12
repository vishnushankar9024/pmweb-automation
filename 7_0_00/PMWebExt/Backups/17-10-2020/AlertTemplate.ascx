<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AlertTemplate.ascx.vb"
    Inherits="Website.AlertTemplate" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgAttachToEmail">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgAttachToEmail" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<style>
    div#ctl00_CPH1_AlertTemplate1_RadEditor1 {
        height: 100% !important;
    }
</style>

<table style="width: 100%;" cellpadding="0" cellspacing="0">
    <tr class="ToolBar MsgTemplateToolbarHomePage">
        <%-- <td  class="HideOnMobileToolbar" style="background-color: transparent; height: 37px;width:20%;color:#666666">
                                    <asp:Label runat="server" ID="lblAlert" Text="Alert"  meta:resourcekey="lblAlert"></asp:Label>
                                </td>--%>
        <td style="width: 240px;" class="ToolbarTd">
            <telerik:RadComboBox ID="ddlAlerts" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                Width="100%" AutoPostBack="True" NoWrap="True" AllowCustomText="True" CausesValidation="False"
                Filter="Contains" Skin="Default">
                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
            </telerik:RadComboBox>

        </td>
        <td style="vertical-align: middle;" class="ToolbarTd">
            <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True">
                <Items>
                    <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                        CommandName="Save" ValidationGroup="Save" CausesValidation="true" AccessKey="s">
                    </telerik:RadToolBarButton>
                </Items>
            </telerik:RadToolBar>
        </td>
        <td>
            <asp:Panel runat="server" ID="pnlSlider">
                <table>
                    <tr>
                        <td class="NoWrap" style="padding-left: 10px; padding-right: 10px;">
                            <asp:Label ID="lblSMSLength" runat="server" meta:resourcekey="lblSMSLength" Text="Text (SMS) Characters: ">
                            </asp:Label>
                            <asp:Label ID="lblSMSLengthSubject" runat="server" meta:resourcekey="lblSMSLengthSubject"
                                Text="[Subject] "></asp:Label>
                            <span id="lblFromLength"></span>
                        </td>
                        <td>
                            <telerik:RadSlider runat="server" ID="sldSMSLength" OnClientLoad="sldSMSLength_Changed"
                                Width="200px" SmallChange="1" Skin="Default" OnClientValueChange="sldSMSLength_Changed"
                                ShowIncreaseHandle="false" ShowDecreaseHandle="false" MinimumValue="0" MaximumValue="155" />
                        </td>
                        <td style="padding-left: 10px; padding-right: 10px; width: 100%">
                            <asp:Label ID="lblSMSLengthMessage" runat="server" meta:resourcekey="lblSMSLengthMessage"
                                Text=" [Message]"></asp:Label>
                            <span id="lblToLength"></span>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </td>
    </tr>
</table>

<div class="PMMainPage">
    <div class="row" style="max-width:800px; width:100%">
        <div>
            <table class="colTable">
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblRecordType" runat="server" meta:resourcekey="lblRecordType" Text="Record Type"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtRecordType" runat="server" MaxLength="500" ReadOnly="true" disabled="disabled"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="labelWidth">
                        <asp:Label ID="lblSubject" runat="server" meta:resourcekey="lblSubject" Text="Subject"></asp:Label>
                    </td>
                    <td class="controlWidth">
                        <asp:TextBox ID="txtSubject" runat="server" MaxLength="500"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <div class="row JustifyContent R3Cols row-4-5-4">
        <div class="col-4 col-4-left">
            <fieldset>
                <legend>
                    <asp:Label ID="lblFields" runat="server" meta:resourcekey="lblFields" Text="Fields"></asp:Label>
                </legend>
                <telerik:RadTreeView ID="tree" Height="518px" Width="100%" runat="server"
                    OnClientNodeClicked="AlertOnClientItemDoubleClicked" ShowLineImages="false">
                </telerik:RadTreeView>
            </fieldset>
        </div>
        <div class="col-4 col-4-middle">
            <fieldset>
                <legend>
                    <asp:Label ID="lblEditor" runat="server" meta:resourcekey="lblEditor" Text="Editor"></asp:Label>
                </legend>
                <asp:Panel ID="pnlEditor" runat="server" Width="100%">
                    <telerik:RadEditor ID="RadEditor1" runat="server" Height="510px" Width="100%" DialogsScriptFile="~/JS/RadEditorDialog.js"
                        OnClientLoad="AlertOnClientLoad" Skin="Default" ToolsFile="~/ToolsFile.xml" DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css">
                        <ImageManager DeletePaths="~/Images/Shared" MaxUploadFileSize="204000000" SearchPatterns="*.*"
                            UploadPaths="~/Images/Shared" ViewPaths="~/Images/Shared" />
                    </telerik:RadEditor>
                </asp:Panel>
            </fieldset>
        </div>
        <div class="col-4 col-4-right">
            <fieldset>
                <legend>
                    <asp:Label ID="lblAttachToEmail" runat="server" meta:resourcekey="lblAttachToEmail"
                        Text="Select To Attach To Email" Style="margin-left: 5px;"></asp:Label></legend>
                <telerik:RadGrid ID="rdgAttachToEmail" runat="server" SetWidth="true" ClientSettings-Scrolling-AllowScroll="true"
                    Height="100%" AllowPaging="true" PageSize="10" Width="100%" AutoGenerateColumns="False"
                    HeaderStyle-Font-Size="8" AllowMultiRowEdit="false" AllowMultiRowSelection="false"
                    ShowGroupPanel="false" AllowSorting="false" GroupingEnabled="false" AllowFilteringByColumn="false">
                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                    <HeaderContextMenu EnableViewState="false">
                    </HeaderContextMenu>
                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                        DataKeyNames="Id" CommandItemDisplay="None" Width="100%" TableLayout="Fixed"
                        InsertItemDisplay="Top" InsertItemPageIndexAction="ShowItemOnFirstPage" UseAllDataFields="true"
                        EnableHeaderContextMenu="true" EditMode="InPlace">
                        <Columns>
                            <telerik:GridTemplateColumn Reorderable="false" UniqueName="TemplateColumn" Groupable="False"
                                AllowFiltering="false" HeaderStyle-Width="48px">
                                <HeaderTemplate>
                                    <asp:CheckBox ID="chkAll" onClick="AllAlertCheckClicked(this)" runat="server" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSelect" onClick="SelectAlertParent(this)" runat="server" />
                                </ItemTemplate>
                                <HeaderStyle Height="20px" />
                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderStyle-Width="150px" ItemStyle-Wrap="false" HeaderText="Type" Groupable="False"
                                UniqueName="Type">
                                <ItemTemplate>
                                    <%# Eval("TranslatedType").ToString%>&nbsp;
                                </ItemTemplate>
                                <HeaderStyle Width="150px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn HeaderStyle-Width="200px" ItemStyle-Wrap="false" HeaderText="Description" Groupable="False"
                                UniqueName="Description">
                                <ItemTemplate>
                                    <%# Eval("TranslatedDescription").ToString%>&nbsp;
                                </ItemTemplate>
                                <HeaderStyle Width="200px"></HeaderStyle>
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <ItemStyle Wrap="false" />
                        <HeaderStyle Wrap="false" HorizontalAlign="Left" />
                    </MasterTableView>
                </telerik:RadGrid>
            </fieldset>
        </div>
    </div>

</div>





