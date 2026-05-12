<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="PMWebViewerSettings.aspx.vb" Inherits="Website.PMWebViewerSettings" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="PMWebViewerSettings.ascx" TagName="PMWebViewerSettings" TagPrefix="uc1" %>
<%@ Register Src="Stamps.ascx" TagName="PMWebViewerStamps" TagPrefix="uc2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CPH1" runat="server">
    <script type="text/javascript">
        var Grid;
        var btnDelete;
        function GridCreated(sender, args) {
            Grid = $find($("[id$=rdgPMWebViewerSettings]")[0].id);
            btnDelete = $($("a[id$=btnDelete]")[0]);

        }
        function rdgPMWebViewerSettings_OnRowSelecting(sender, eventArgs) {
            var CanDelete = $("#" + eventArgs.get_id())[0].getAttribute("CanDelete")
            if (btnDelete[0] == 'undefined' && btnDelete[0].id == null)
                return;

            if (Grid.get_masterTableView().get_selectedItems().length > 0) {
                if (btnDelete.is(":visible") == true) {
                    if (CanDelete == "false") { btnDelete.hide(); }
                }
            }
            else {
                if (CanDelete == "false") {
                    btnDelete.hide();
                } else {
                    btnDelete.show();
                }
            }
        }
        function OpenStampsTextPopup(LineId, hdnStampTextIds, IsInEditMode, Source) {
            return OpenPOPUp('PMWebViewerSettingsStampsTextPopup.aspx?LineId=' + LineId + '&hdnStampTextIds=' + hdnStampTextIds + '&IsInEditMode=' + IsInEditMode + '&Source=' + Source, 400, 300, true);
        }
        function OpenStampsImagesPopup(LineId, hdnStampImagesIds, IsInEditMode, Source) {
            return OpenPOPUp('AllowAccesTostampsPopUp.aspx?LineId=' + LineId + '&hdnStampImagesIds=' + hdnStampImagesIds + '&IsInEditMode=' + IsInEditMode + '&Source=' + Source, 400, 300, true);
        }
    </script>
    <telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="mlpPMWebViewerSettings">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="mlpPMWebViewerSettings" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>


    <telerik:RadTabStrip ID="tbsDocument" SelectedIndex="0" CssClass="EmailSetupTabs ViewerSettingsTabs"
        runat="server" MultiPageID="mlpPMWebViewerSettings" Width="100%" EnableViewState="True"
        CausesValidation="false">
        <Tabs>
            <telerik:RadTab Text="Defaults" Value="Defaults" Selected="true" Width="50%" />
            <telerik:RadTab Text="Stamps" Value="Stamps" Width="50%" />
        </Tabs>
    </telerik:RadTabStrip>
    <telerik:RadMultiPage ID="mlpPMWebViewerSettings" runat="server" SelectedIndex="0" Width="100%"
        RenderSelectedPageOnly="true">
        <telerik:RadPageView ID="pvDefaults" runat="server" Selected="true">
            <uc1:PMWebViewerSettings ID="PMWebViewerSettings1" runat="server" />
        </telerik:RadPageView>
        <telerik:RadPageView ID="pvStamps" runat="server">
            <uc2:PMWebViewerStamps ID="PMWebViewerStamps1" runat="server" />
        </telerik:RadPageView>
    </telerik:RadMultiPage>

</asp:Content>
