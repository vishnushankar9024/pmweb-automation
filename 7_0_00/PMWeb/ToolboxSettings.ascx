<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ToolboxSettings.ascx.vb" Inherits="Website.ToolboxSettings" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="RDGT">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="RDGT" LoadingPanelID="ldpPM" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>
<style type="text/css">
    @media screen and (max-width: 843px) and (min-width: 320px) {
        .ToolBar{
            top:41px !important
        }
    }
</style>
<table class="ToolBar ToolboxSettingsHomePage" cellpadding="0" cellspacing="0" width="100%" style="top: 71px">
    <tr valign="top">
        <td valign="top">
            <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td class="ToolbarTd">
                        <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                            <Items>
                                <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" SecurityButtonType="Edit" ValidationGroup="SaveInfo" CommandName="Save"></telerik:RadToolBarButton>
                            </Items>
                        </telerik:RadToolBar>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<div class="PMMainPage documentMultiPages">
    <div class="row">
        <div class="col-6">
            <telerik:RadGrid ID="RDGT" runat="server" Skin="Default" HeaderStyle-Font-Size="8" SetWidth="true"
                AutoGenerateColumns="False" ShowStatusBar="true" Width="100%" AllowPaging="false" FitPageHeightOffset="24"
                AllowMultiRowEdit="false" AllowFilteringByColumn="false" ShowGroupPanel="false" AllowMultiRowSelection="false">
                <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                    DataKeyNames="Id" Width="100%" TableLayout="Fixed" InsertItemDisplay="Top"
                    InsertItemPageIndexAction="ShowItemOnFirstPage" AllowSorting="true" EditMode="InPlace">
                    <Columns>
                        <telerik:GridTemplateColumn HeaderText="Toolbox Page1" Groupable="false" UniqueName="Toolbox">
                            <ItemTemplate>
                                <asp:Label ID="lblPageName" runat="server"></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Width="180px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn HeaderText="Module1" Groupable="false" UniqueName="Module">
                            <ItemTemplate>
                                <telerik:RadComboBox ID="ddlModules" runat="server" Height="150px" AllowCustomText="true" Filter="Contains" MarkFirstMatch="true"
                                    Skin="Default" CloseDropDownOnBlur="true" Width="100%" NoWrap="true" ShowToggleImage="true">
                                </telerik:RadComboBox>
                            </ItemTemplate>
                            <HeaderStyle Width="180px" />
                        </telerik:GridTemplateColumn>

                    </Columns>
                    <SortExpressions>
                    </SortExpressions>
                </MasterTableView>
                <ClientSettings EnableRowHoverStyle="false" AllowDragToGroup="false" AllowRowsDragDrop="false">
                    <Selecting AllowRowSelect="false" EnableDragToSelectRows="false" />
                    <Resizing EnableRealTimeResize="false" ResizeGridOnColumnResize="false" ClipCellContentOnResize="false"
                        AllowColumnResize="false"></Resizing>
                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>
</div>
