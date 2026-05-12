<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master"
    CodeBehind="DocumentIntegrator.aspx.vb" Inherits="Website.DocumentIntegrator" %>

<%@ Register Src="~/DocumentIntegratorSharePoint.ascx" TagName="DocumentIntegratorSharePoint"
    TagPrefix="uc1" %>
<%@ Register Src="~/DocumentIntegratorAconex.ascx" TagName="DocumentIntegratorAconex"
    TagPrefix="uc2" %>
<asp:Content ID="C1" ContentPlaceHolderID="CPH1" runat="server">
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="tbsDocumentIntegrator">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpDocumentIntegrator" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocumentIntegrator" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="mlpDocumentIntegrator">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpDocumentIntegrator" LoadingPanelID="ldpPM" />
                    <telerik:AjaxUpdatedControl ControlID="tbsDocumentIntegrator" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>
    <telerik:RadAjaxLoadingPanel ID="ldpDocumentIntegrator" runat="server" EnableSkinTransparency="true"
        BackgroundPosition="Center" Skin="Default" />
    <telerik:RadCodeBlock ID="CodeBlock" runat="server">
        <script type="text/javascript">

            //            function click_handler(sender, args) {
            //                var HasMergeTemplate = '<%= PM.BIM.BIMCOBieManagerInfo.HasMergeTemplate%>';
            //                var HasReports = '<%= PM.BIM.BIMCOBieManagerInfo.HasReports%>';
            //                var RecordDescription = '<%=JSEscape(PM.BIM.BIMCOBieManagerInfo.RecordDescription)%>';
            //                var Description = '<%=JSEscape(PM.BIM.BIMCOBieManagerInfo.Description)%>';
            //                var Id = '<%= PM.BIM.BIMCOBieManagerInfo.Id%>';
            //                var HasPMWebReports = '<%= PM.QueryBuilderPermissionController.HasReports("BIMCOBieManager")%>';
            //                switch (args.get_item().get_commandName()) {
            //                    case 'ViewTemplates':
            //                        if (HasMergeTemplate == 'True') {
            //                            var left = (screen.width - 910) / 2;
            //                            var top = (screen.height - 380) / 2;
            //                            window.open("MergeTemplatePopup.aspx?ObjectType=BIMCOBieManager&Id=" +
            //                            '<%= PM.BIM.BIMCOBieManagerInfo.Id%>' + "&Description="
            //                            + Description
            //                            + "&RecordDescription=" + RecordDescription
            //                            + "&EntityId=" + '<%=PM.BIM.BIMCOBieManagerInfo.ProjectId%>' + "&EntityType=0",
            //                            'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=910,height=380,top=' + top + ',left=' + left);
            //                        }
            //                        break;
            //                    case "WordMerge":
            //                        if (HasMergeTemplate == 'True') {
            //                            var Search = "?ObjectType=BIMCOBieManager&Id=" +
            //                            '<%= PM.BIM.BIMCOBieManagerInfo.Id%>' + "&Description="
            //                            + Description + "&OfficeType=DOC" + '&TemplateId=0'
            //                            + "&RecordDescription=" + RecordDescription
            //                            + "&EntityId=" + '<%=PM.BIM.BIMCOBieManagerInfo.ProjectId%>' + "&EntityType=0"
            //                            window.open('MergeProcessing.aspx' + Search,
            //                           'welcome', 'menubar=yes,status=yes,location=yes,toolbar=yes,scrollbars=yes');
            //                        }
            //                        break;
            //                    case 'ViewReports':
            //                        if (HasReports == 'True') {
            //                            var left = (screen.width - 890) / 2;
            //                            var top = (screen.height - 430) / 2;
            //                            window.open("ReportsPreviewPopup.aspx?ObjectType=BIMCOBieManager&Id=" +
            //                            '<%= PM.BIM.BIMCOBieManagerInfo.Id%>'
            //                            + "&RecordDescription=" + RecordDescription
            //                            + "&EntityId=" + '<%=PM.BIM.BIMCOBieManagerInfo.ProjectId%>' + "&EntityType=0",
            //                            'welcome', 'location=0,status=0,menubar=0,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
            //                        }
            //                        break;

            //                    case 'ViewPMWebReports':
            //                        var left = (screen.width - 900) / 2;
            //                        var top = (screen.height - 500) / 2;
            //                        if (HasPMWebReports == 'True' && Id > 0) {
            //                            window.open("PMWebReports.aspx?ObjectType=BIMCOBieManager&Id=" + Id
            //                    + "&EntityId=" + '<%=PM.BIM.BIMCOBieManagerInfo.ProjectId%>' + "&EntityType=0",
            //                    'welcome', 'location=0,status=0,menubar=1,addressbar=0,resizable=1,scrollbars=1,width=890,height=430,top=' + top + ',left=' + left);
            //                        }
            //                        break;
            //                    default:
            //                        //                        eventArgs.set_cancel(false);
            //                        break;
            //                }
            //            }

        </script>
    </telerik:RadCodeBlock>
    <style>
        #ctl00_CPH1_DocumentIntegratorAconex1_lblAconexHostname{
            width:140px !important;
        }
    </style>
    <table class="ToolBar" style="width: 100%; margin: -2px;">
        <tr>
            <td style="border: none; height: 50px; vertical-align: middle; padding-left: 21px;">
                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true">
                    <Items>
                        <telerik:RadToolBarButton ImageUrl="Images/Global/Save.png" CommandName="Save" ValidationGroup="Save" meta:resourcekey="RadToolBarButton_Save"></telerik:RadToolBarButton>
                    </Items>
                </telerik:RadToolBar>
            </td>
        </tr>
    </table>
    <%--<telerik:RadToolBarButton IsSeparator="true">
                                                </telerik:RadToolBarButton>
                                                <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Office-icon.png" CommandName="WordMerge"
                                                    SecurityButtonType="Read" EnableDefaultButton="false" PostBack="false">
                                                    <Buttons>
                                                        <telerik:RadToolBarButton PostBack="false" CommandName="ViewTemplates">
                                                        </telerik:RadToolBarButton>
                                                    </Buttons>
                                                </telerik:RadToolBarSplitButton>
                                                <telerik:RadToolBarSplitButton ImageUrl="Images/ToolBar/Printer.png" CommandName="Print"
                                                    SecurityButtonType="Read" EnableDefaultButton="false" PostBack="false">
                                                    <Buttons>
                                                        <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif"
                                                            CommandName="ViewReports">
                                                        </telerik:RadToolBarButton>
                                                        <telerik:RadToolBarButton PostBack="false" Width="150px" ImageUrl="Images/ToolBar/PMWebW.gif"
                                                            CommandName="ViewPMWebReports">
                                                        </telerik:RadToolBarButton>
                                                    </Buttons>
                                                </telerik:RadToolBarSplitButton>--%>
    <table style="width: 100%; padding: 0px;" cellpadding="0" cellspacing="0">
        <tr>
            <td valign="top">
                <telerik:RadTabStrip ID="tbsDocumentIntegrator" SelectedIndex="0" OnClientTabSelecting="onTabSelecting"
                    runat="server" MultiPageID="mlpDocumentIntegrator" Skin="Default" OnTabClick="tbsDocumentIntegrator_TabClick"
                    Width="100%" EnableViewState="False" CausesValidation="False" CssClass="documentTabs" >
                    <Tabs>
                        <telerik:RadTab Text="SharePoint" meta:resourcekey="tab_SharePoint" Value="SharePoint"
                            Selected="True" Width="100%"/>
                        <%--<telerik:RadTab Text="Aconex" meta:resourcekey="tab_Aconex" Value="Aconex" Width="49%"/>--%>
                    </Tabs>
                </telerik:RadTabStrip>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadMultiPage ID="mlpDocumentIntegrator" runat="server" SelectedIndex="0"
                    Width="100%" RenderSelectedPageOnly="true" CssClass="documentMultiPages">
                    <telerik:RadPageView ID="pvSharePoint" runat="server">
                        <uc1:DocumentIntegratorSharePoint ID="DocumentIntegratorSharePoint1" runat="server" />
                    </telerik:RadPageView>
                    <telerik:RadPageView ID="pvAconex" runat="server">
                        <uc2:DocumentIntegratorAconex ID="DocumentIntegratorAconex1" runat="server" />
                    </telerik:RadPageView>
                </telerik:RadMultiPage>
            </td>
        </tr>
    </table>
</asp:Content>
