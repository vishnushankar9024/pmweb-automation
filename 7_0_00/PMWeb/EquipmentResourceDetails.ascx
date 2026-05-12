<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EquipmentResourceDetails.ascx.vb" Inherits="Website.EquipmentResourceDetails" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="DocumentSpecifications.ascx" TagName="DocumentSpecifications" TagPrefix="uc1" %>

<telerik:RadAjaxManagerProxy ID="RadAjaxManager1" runat="server">
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnRefreshUserImage">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="fldsetTags" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="btnClearImage">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="imgUserImage" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        <telerik:AjaxSetting AjaxControlID="rauUserImage">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="imgUserImage" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<style type="text/css">
    /*.RadUpload .ruFileWrap 
    {
        display:inline;
    }*/
    .RadUpload_Office2007 .ruButton {
        color: rgb(13, 13, 14);
    }

    .RadUpload .ruButton.hover {
        background-position: -284px -45px !important;
    }

    .RadUpload .ruButton {
        background-position: 0 -45px !important;
        text-align: left;
    }

    .RadUpload_Office2007, .RadUpload_Office2007 a, .RadUpload_Office2007 input {
        font: normal 12px/11px "Segoe UI",Arial,sans-serif;
    }

    .RadUpload .ruBrowse {
        width: 150px;
        padding-left: 27px !important;
    }

    .RadUpload {
        width: 200px;
    }

        .RadUpload .ruInputs li {
            margin: 0 0 0px;
        }
</style>


<table style="width: 100%;" cellpadding="0" cellspacing="0">
    <tr id="trTbsDetails" runat="server">
        <td>
            <table width="100%">
                <tr>
                    <td>
                        <div class="PMHeader">
                            <div class="row">
                                <div class="col-3">
                                    <table style="width: 100%; padding-left: 24px;" border="0">

                                        <tr>
                                            <td class="labelwidth">
                                                <asp:Label ID="lblInServiceDate" runat="server" Text="In Service Date" meta:Resourcekey="lblInServiceDate"></asp:Label>
                                            </td>
                                            <td class="controlwidth">
                                                <telerik:RadDatePicker ID="rdpInServiceDate" runat="server" MinDate="1901-01-01" DateInput-EnabledStyle-HorizontalAlign="Right"
                                                    MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default">
                                                    <DateInput ID="DateInput3" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                                    <Calendar ID="Calendar3" Skin="Default" runat="server"></Calendar>
                                                </telerik:RadDatePicker>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelwidth">
                                                <asp:Label ID="lblReceivedDate" runat="server" Text="Received Date" meta:Resourcekey="lblReceivedDate"></asp:Label>
                                            </td>
                                            <td class="controlwidth">
                                                <telerik:RadDatePicker ID="rdpReceivedDate" runat="server" MinDate="1901-01-01" DateInput-EnabledStyle-HorizontalAlign="Right"
                                                    MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default">
                                                    <DateInput ID="DateInput1" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                                    <Calendar ID="Calendar1" Skin="Default" runat="server"></Calendar>
                                                </telerik:RadDatePicker>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelwidth">
                                                <asp:Label ID="lblVendor" runat="server" Text="Vendor" meta:Resourcekey="lblVendor"></asp:Label>
                                            </td>
                                            <td class="controlwidth">
                                                <telerik:RadComboBox ID="ddlVendor" runat="server" Width="100%" Skin="Default" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                                    OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged1" Height="300px" EmptyMessage="Select Vendor..."
                                                    OnClientDropDownClosed="dllcompClientClosed1" EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                    OnItemsRequested="ddl_ItemsRequested" meta:Resourcekey="ddlVendor">
                                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                                </telerik:RadComboBox>
                                                <asp:HiddenField ID="HiddenField2" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelwidth">
                                                <asp:Label ID="lblManufacturer" runat="server" Text="Manufacturer" meta:Resourcekey="lblManufacturer"></asp:Label>
                                            </td>
                                            <td class="controlwidth">
                                                <telerik:RadComboBox ID="ddlManufacturer" runat="server" Width="100%" Skin="Default" LoadingMessage="<%$ Resources:PMWeb, Loading %>"
                                                    OnClientSelectedIndexChanged="dllcompClientSelectedIndexChanged" Height="300px" meta:Resourcekey="ddlManufacturer"
                                                    OnClientDropDownClosed="dllcompClientClosed" EmptyMessage="Select Manufacturer..."
                                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                    OnItemsRequested="ddl_ItemsRequested">
                                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                                </telerik:RadComboBox>
                                                <asp:HiddenField ID="HiddenField1" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelwidth">
                                                <asp:Label ID="lblMfrNumber" runat="server" Text="Mfr. #" meta:Resourcekey="lblMfrNumber"></asp:Label>
                                            </td>
                                            <td class="controlwidth">
                                                <asp:TextBox ID="txtMfrNumber" runat="server" Width="99%"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelwidth">
                                                <asp:Label ID="lblSerialNumber" runat="server" Text="Serial #" meta:Resourcekey="lblSerialNumber"></asp:Label>
                                            </td>
                                            <td class="controlwidth">
                                                <asp:TextBox ID="txtSerialNumber" runat="server" Width="99%"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelwidth">
                                                <asp:Label ID="lblLotNumber" runat="server" Text="Lot #" meta:Resourcekey="lblLotNumber"></asp:Label>
                                            </td>
                                            <td class="controlwidth">
                                                <asp:TextBox ID="txtLotNumber" runat="server" Width="99%"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelwidth">
                                                <asp:Label ID="lblItem" runat="server" Text="Item" meta:Resourcekey="lblItem"></asp:Label>
                                            </td>
                                            <td class="controlwidth">
                                                <telerik:RadComboBox ID="ddlItem" runat="server" Width="100%"
                                                    Skin="Default" LoadingMessage="<%$ Resources:PMWeb, Loading %>" Height="300px"
                                                    EnableLoadOnDemand="True" ShowMoreResultsBox="true" EnableVirtualScrolling="true"
                                                    OnItemsRequested="ddl_ItemsRequested" EmptyMessage="Select Item..." meta:Resourcekey="ddlItem">
                                                    <CollapseAnimation Duration="200" Type="OutQuint" />
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelwidth">
                                                <asp:Label ID="lblPrice" runat="server" Text="Price" meta:Resourcekey="lblPrice"></asp:Label>
                                            </td>
                                            <td class="controlwidth">
                                                <asp:TextBox ID="txtPrice" CssClass="Currency" runat="server" Width="100%"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelwidth">
                                                <asp:Label ID="lblWarrantyExpires" runat="server" Text="Warranty Expires" meta:Resourcekey="lblWarrantyExpires"></asp:Label>
                                            </td>
                                            <td class="controlwidth">
                                                <telerik:RadDatePicker ID="rdpWarrantyExpires" runat="server" MinDate="1901-01-01" DateInput-EnabledStyle-HorizontalAlign="Right"
                                                    MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default">
                                                    <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                                    <Calendar ID="Calendar2" Skin="Default" runat="server"></Calendar>
                                                </telerik:RadDatePicker>
                                            </td>
                                        </tr>


                                        <tr>
                                            <td colspan="4">
                                                <fieldset runat="server" id="fldsetTags">
                                                    <legend>
                                                        <asp:Label ID="lblTags" meta:resourcekey="lblTags" runat="server" Text="Tags"></asp:Label>
                                                    </legend>
                                                </fieldset>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td class="NoWrap labelwidth">
                                                <asp:LinkButton runat="server" ID="btnGoogleAddress" meta:resourcekey="lblGoogleAddress" OnClientClick="return OpenGoogleEquipmentResourcesAddressesPicker();" Text="Google Address"></asp:LinkButton>
                                            </td>
                                            <td class="controlwidth">
                                                <asp:TextBox ID="txtGoogleAddress" MaxLength="100" runat="server" Width="100%"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="labelwidth">
                                                <div style="float: left">
                                                    <asp:Label ID="lblBarcode" runat="server" meta:resourcekey="lblBarcodes" Text="Barcode"></asp:Label>
                                                </div>
                                                <div style="float: right;">
                                                    <img id="imgPMbarcode" runat="server" src="Images/Asset/Barcode.jpg" style="vertical-align: middle; cursor: pointer"
                                                        alt="" onclick="return OpenEquipmentResourceBarCodePopup();" />

                                                </div>
                                            </td>
                                            <td class="controlwidth">
                                                <div class="NoWrap">
                                                    <asp:TextBox ID="txtBarcode" runat="Server" Width="100%" Style="vertical-align: middle; height: 16px;" MaxLength="255"></asp:TextBox>
                                                    <asp:HiddenField ID="htnBarcodeFormat" runat="server" />
                                                    <asp:Label runat="server" ID="lblBarCodeUnique" CssClass="Validator" Text="<%$ Resources:PMWeb, BarCodeUniqueMsg %>"></asp:Label>
                                                </div>
                                            </td>
                                        </tr>

                                    </table>
                                    <table style="width: 100%; padding-left: 24px;" border="0">
                                        <tr>
                                            <td class="labelwidth">
                                                <telerik:RadAsyncUpload runat="server" ID="rauUserImage" Skin="Default" OnClientFileUploadFailed="onDocFileUploadFailed"
                                                    OnClientFileSelected="onDocFileSelected" OnClientFileUploaded="onDocFileUploaded" OnFileUploaded="onFileUploaded"
                                                    MultipleFileSelection="Disabled" OnClientValidationFailed="ClientDocFileValidationFailed" HideFileInput="true" Width="60%">
                                                    <Localization Select="<%$ Resources:PMWeb, btn_SelectImage %>" />
                                                </telerik:RadAsyncUpload>
                                            </td>
                                            <td class="controlwidth"></td>
                                        </tr>
                                        <tr>
                                            <td class="labelwidth">
                                                <asp:Button ID="btnClearImage" runat="server" Width="115px" Text="Clear Image" />
                                            </td>
                                            <td class="controlwidth"></td>
                                        </tr>
                                        <tr>
                                            <td class="labelwidth">

                                                <asp:Button ID="btnRefreshUserImage" runat="server" CssClass="Hide" />
                                            </td>
                                            <td class="controlwidth"></td>
                                        </tr>
                                        <tr>
                                            <td class="labelwidth">
                                                <img id="imgUserImage" runat="server" src="Images/Global/WhiteDot.gif" />
                                            </td>
                                            <td class="controlwidth"></td>
                                        </tr>


                                    </table>





                                </div>
                                <div class="col-3">
                                    <table  style="width: 100%; padding-left: 24px;" border="1"> 
                                        <tr>
                                            <td>
                                                <uc1:DocumentSpecifications ID="DocumentSpecifications" runat="server" />
                                            </td>
                                        </tr>

                                    </table>
                                </div>



                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

