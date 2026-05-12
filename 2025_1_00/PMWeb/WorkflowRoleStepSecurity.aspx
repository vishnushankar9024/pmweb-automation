<%@ Page Language="vb" meta:resourcekey="Page" AutoEventWireup="false" CodeBehind="WorkflowRoleStepSecurity.aspx.vb" Inherits="Website.WorkflowRoleStepSecurity" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="rdgStepSecurity">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="rdgStepSecurity" LoadingPanelID="ldpItems" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpItems" runat="server" Skin="Default" />
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" ValidationGroup="Save"
                                            CommandName="Save" Text="Save" meta:resourcekey="RadToolBarButton_Save">
                                        </telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" ValidationGroup="Save"
                                            CommandName="SaveExit" Text="Save & Exit" meta:resourcekey="RadToolBarButton_SaveExit">
                                        </telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"
                                            meta:resourcekey="RadToolBarButton_Cancel" Text="Cancel">
                                        </telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div class="PMHeader">
            <div class="row documentSinglePage">
                <div class="col-4">
                    <table class="colTable">
                        <tr>
                            <td>
                                <asp:CheckBox ID="chkRoleStepSecurity" runat="server" Text="Enable role step security11" class="mobile-switch" meta:resourcekey="chkRoleStepSecurity" />
                            </td>
                        </tr>
                        <tr>
                            <td class="Padding7 Top">
                                <telerik:RadGrid ID="rdgStepSecurity" runat="server" AutoGenerateColumns="False"
                                    SetWidth="true" FitParentContainer="true" ClientSettings-Scrolling-AllowScroll="true" Width="100%"
                                    HeaderStyle-Font-Size="8" PageSize="250" AllowPaging="True">
                                    <PagerStyle Mode="NextPrevAndNumeric" AlwaysVisible="true" />
                                    <MasterTableView NoMasterRecordsText="<%$Resources:PMWeb, Grid_NoMasterRecordsText %>"
                                        DataKeyNames="FieldId,IsHeader,IsTab,TabId" EditMode="InPlace">
                                        <Columns>

                                            <telerik:GridTemplateColumn HeaderText="Section11" UniqueName="Section" DataField="Section">
                                                <ItemTemplate>
                                                    <span><%# Eval("Section")%></span>
                                                </ItemTemplate>
                                                <HeaderStyle Width="50px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn HeaderText="Field11" UniqueName="Field">
                                                <ItemTemplate>
                                                    <span><%# Eval("FieldFriendlyName")%></span>
                                                </ItemTemplate>
                                                <HeaderStyle Width="250px"></HeaderStyle>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn UniqueName="IsVisible" Groupable="False" HeaderText="View11" AllowFiltering="false" HeaderStyle-Width="50px">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkView" runat="server" class="mobile-switch" Checked='<%# CBool(IIf(Eval("IsVisible") Is System.DBNull.Value, 0, Eval("IsVisible")))%>' />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn UniqueName="IsEditable" Groupable="False" HeaderText="Edit11" AllowFiltering="false" HeaderStyle-Width="50px">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkEdit" class="mobile-switch" runat="server" Checked='<%# CBool(IIf(Eval("IsEditable") Is System.DBNull.Value, 0, Eval("IsEditable")))%>' />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
