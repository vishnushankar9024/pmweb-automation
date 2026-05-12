<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SystemEventTemplate.ascx.vb"
    Inherits="Website.SystemEventTemplate" %>
<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rdgAttachEventToEmail">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rdgAttachEventToEmail" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<style>
    div#ctl00_CPH1_SystemEventTemplate1_RadEditor1 {
        height: 100% !important;
    }
</style>

<table style="width: 100%;" cellpadding="0" cellspacing="0" class="ToolBar MsgTemplateToolbarHomePage">
    <tr>
        <%-- <td class="HideOnMobileToolbar" style="background-color: transparent; height: 37px;width:20%;color:#666666" >
                                    <asp:Label runat="server" ID="lblSystemEvent" Text="System Event"
                                        meta:resourcekey="lblSystemEvent"></asp:Label>
                                </td>--%>
        <td style="width: 240px;" class="ToolbarTd">
            <telerik:RadComboBox ID="ddlSystemEvents" runat="server" OnClientTextChange="LOD_DropDownTextChange"
                Width="100%" AutoPostBack="True" NoWrap="True" AllowCustomText="True" CausesValidation="False"
                Filter="Contains" Skin="Default">
                <CollapseAnimation Type="OutQuint" Duration="150"></CollapseAnimation>
            </telerik:RadComboBox>
        </td>
        <td class="ToolbarTd">
            <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="True">
                <Items>
                    <telerik:RadToolBarButton SecurityButtonType="Edit" ImageUrl="Images/ToolBar/Save.png"
                        meta:resourcekey="RadToolBarButton_Save" CommandName="Save" ValidationGroup="Save"
                        ToolTip="Save (Alt+s)" CausesValidation="true" AccessKey="s">
                    </telerik:RadToolBarButton>
                </Items>
            </telerik:RadToolBar>
        </td>
        <td>
            <asp:Panel runat="server" ID="pnlSlider">
                <table>
                    <tr>
                        <td class="NoWrap" style="padding-left: 10px; padding-right: 10px;">
                            <div style="width: 190px">
                                <asp:Label ID="lblSMSLength" runat="server" meta:resourcekey="lblSMSLength" Text="Text (SMS) Characters: "></asp:Label>
                                <asp:Label ID="lblSMSLengthSubject" runat="server" meta:resourcekey="lblSMSLengthSubject"
                                    Text="[Subject] "></asp:Label>
                                <span id="lblFromLength"></span>
                            </div>
                        </td>
                        <td>
                            <telerik:RadSlider runat="server" ID="sldSMSLength" OnClientLoad="sldSMSLength_Changed"
                                Width="200px" SmallChange="1" Skin="Default" OnClientValueChange="sldSMSLength_Changed"
                                ShowIncreaseHandle="false" ShowDecreaseHandle="false" MinimumValue="0" MaximumValue="155" />
                        </td>
                        <td style="padding-left: 10px; padding-right: 10px; width: 100%">
                            <div style="width: 100px">
                                <asp:Label ID="lblSMSLengthMessage" runat="server" meta:resourcekey="lblSMSLengthMessage"
                                    Text=" [Message]"></asp:Label>
                                <span id="lblToLength"></span>
                            </div>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </td>

    </tr>
</table>


<div class="PMMainPage">
    <div class="row" style="max-width:800px;width:100%">
        <div>
            <table class="colTable">
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

    <div class="row JustifyContent row-4-5-4">
        <asp:Panel runat="server" ID="pnlFields">
            <div  class="col-4">
                <fieldset>
                    <legend>
                        <asp:Label ID="lblFields" runat="server" meta:resourcekey="lblFields" Text="Fields"></asp:Label>
                    </legend>
                    <telerik:RadTreeView ID="tree" Height="518px" Width="100%" runat="server"
                        OnClientNodeClicked="OnSysClientItemDoubleClicked" ShowLineImages="false">
                    </telerik:RadTreeView>
                </fieldset>
            </div>
        </asp:Panel>
        <div class="col-4 col-4-middle">
            <fieldset>
                <legend>
                    <asp:Label ID="lblEditor" runat="server" meta:resourcekey="lblEditor" Text="Editor"></asp:Label>
                </legend>
                <asp:Panel ID="pnlEditor" runat="server" Width="100%">
                    <telerik:RadEditor ID="RadEditor1" DialogsScriptFile="~/JS/RadEditorDialog.js" runat="server" Height="510px" Width="100%"
                        OnClientLoad="OnClientSysLoad" Skin="Default" ToolsFile="~/ToolsFile.xml" DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css">
                        <ImageManager DeletePaths="~/Images/Shared" MaxUploadFileSize="204000000" SearchPatterns="*.*"
                            UploadPaths="~/Images/Shared" ViewPaths="~/Images/Shared" />
                    </telerik:RadEditor>
                </asp:Panel>
            </fieldset>
        </div>
    </div>

</div>



