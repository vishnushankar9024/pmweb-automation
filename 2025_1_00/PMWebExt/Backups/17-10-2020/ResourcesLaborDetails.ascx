<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ResourcesLaborDetails.ascx.vb" Inherits="Website.ResourcesLaborDetails" %>
<%@ Register src="DocumentSpecifications.ascx" tagname="DocumentSpecifications" tagprefix="uc1" %>

<style  type="text/css">
    /*.RadUpload .ruFileWrap 
    {
        display:inline;
    }*/
    .RadUpload_Office2007 .ruButton
    {
        color: rgb(13, 13, 14);
       
    }
    .RadUpload .ruButton.hover
    {
       background-position: -284px -45px !important;
    }
    .RadUpload .ruButton
    {
        background-position: 0 -45px !important;
        text-align: left;
    }
    .RadUpload_Office2007, .RadUpload_Office2007 a, .RadUpload_Office2007 input 
    {
        font: normal 12px/11px "Segoe UI",Arial,sans-serif;
    }
    .RadUpload .ruBrowse 
    {
        width: 150px;
        padding-left: 27px !important;
    }
    .RadUpload 
    {
        width: 200px;
    }
    .RadUpload .ruInputs li 
    {
        margin: 0 0 0px;
    }
</style>


<table style="margin-top: 3px;" runat="server" id="tblLaborsDetails">
    <tr>
        <td>
            <table style="padding-left: 10px;">
                <tr style="">
                    <td>
                        <asp:Label ID="lblHireDate" meta:Resourcekey="lblHireDate" runat="server" ></asp:Label>
                    </td>
                    <td>
                        <telerik:RadDatePicker ID="dtpHireDate" runat="server" MinDate="1901-01-01" DateInput-EnabledStyle-HorizontalAlign="Right"
                            MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>' Width="130px" Skin="Default" Culture="English (United States)">
                            <DateInput ID="DateInput3" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                            <Calendar ID="Calendar3" Skin="Default" runat="server"></Calendar>
                        </telerik:RadDatePicker>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblTerminationDate" meta:Resourcekey="lblTerminationDate" runat="server" Width="130"></asp:Label>
                    </td>
                    <td>
                        <telerik:RadDatePicker ID="dtpTerminatonDate" runat="server" MinDate="1901-01-01" DateInput-EnabledStyle-HorizontalAlign="Right"
                            MaxDate="2100-01-01" SelectedDate='<%# Date.Today %>' Width="130px" Skin="Default" Culture="English (United States)">
                            <DateInput ID="DateInput1" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                            <Calendar ID="Calendar1" Skin="Default" runat="server"></Calendar>
                        </telerik:RadDatePicker>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblPhone" meta:Resourcekey="lblPhone" runat="server"></asp:Label>
                    </td>

                    <td>
                        <asp:TextBox ID="txtPhone" runat="server" Width="158px"></asp:TextBox>
                        &nbsp;&nbsp;&nbsp;
                   <asp:TextBox ID="txtExt" runat="server" Width="58px"></asp:TextBox>
                    </td>

                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblCell" meta:Resourcekey="lblCell" runat="server" ></asp:Label>
                    </td>

                    <td>
                        <asp:TextBox ID="txtCell" runat="server" Width="158px"></asp:TextBox>
                    </td>

                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblAltPhone" meta:Resourcekey="lblAltPhone" runat="server" ></asp:Label>
                    </td>

                    <td>
                        <asp:TextBox ID="txtAltPhone" runat="server" Width="158px"></asp:TextBox>
                    </td>

                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblEmail" meta:Resourcekey="lblEmail" runat="server"></asp:Label>
                    </td>

                    <td>
                        <asp:TextBox ID="txtEmail" runat="server" Width="235px"></asp:TextBox>
                    </td>

                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblAddress1" meta:Resourcekey="lblAddress1" runat="server" ></asp:Label>
                    </td>

                    <td>
                        <asp:TextBox ID="txtAddress1" runat="server" Width="235px"></asp:TextBox>
                    </td>

                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblAddress2" meta:Resourcekey="lblAddress2" runat="server" ></asp:Label>
                    </td>

                    <td>
                        <asp:TextBox ID="txtAddress2" runat="server" Width="235px"></asp:TextBox>
                    </td>

                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblCity" meta:Resourcekey="lblCity" runat="server" ></asp:Label>
                    </td>

                    <td>
                        <asp:TextBox ID="txtCity" runat="server" Width="235px"></asp:TextBox>
                    </td>

                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblState" meta:Resourcekey="lblState" runat="server" ></asp:Label>
                    </td>
                    <td>
                        <telerik:RadComboBox ID="ddlStates" runat="server" Height="400px"
                            meta:Resourcekey="ddlState" Skin="Default" AllowCustomText="true"
                            EmptyMessage="Select State..." Width="130px" AutoPostBack="False"
                            DropDownWidth="130px" CausesValidation="False">
                        </telerik:RadComboBox>
                        &nbsp;&nbsp;&nbsp;
                    <asp:Label ID="lblZip" meta:Resourcekey="lblZip" runat="server" ></asp:Label>
                        &nbsp;&nbsp;
                    <asp:TextBox ID="txtZip" runat="server" Width="58px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblCountry" meta:Resourcekey="lblCountry" runat="server"></asp:Label>
                    </td>
                    <td>
                        <telerik:RadComboBox ID="ddlCountry" runat="server" Height="400px"
                            meta:Resourcekey="ddlCountry" Skin="Default" AllowCustomText="true"
                            EmptyMessage="Select Country..." Width="240px" AutoPostBack="False"
                            DropDownWidth="240px" CausesValidation="False">
                        </telerik:RadComboBox>

                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblEmergencyContact" meta:Resourcekey="lblEmergencyContact" runat="server" ></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtEmergencyContact" runat="server" Width="235px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblEmergencyContactNbr" meta:Resourcekey="lblEmergencyContactNbr" runat="server" ></asp:Label>
                    </td>
                    <td>

                        <asp:TextBox ID="txtEmergencyContactNbr" runat="server" Width="235px"></asp:TextBox>
                    </td>

                </tr>
                <tr>
                      <td style="margin: 0px; padding-left: 0px;">
                                        <telerik:RadAsyncUpload runat="server" ID="rauUserImage" Skin="Default" OnClientFileUploadFailed="onDocFileUploadFailed"
                                            OnClientFileSelected="onDocFileSelected" OnClientFileUploaded="onDocFileUploaded" OnFileUploaded="onFileUploaded"
                                            MultipleFileSelection="Disabled" OnClientValidationFailed="ClientDocFileValidationFailed" HideFileInput="true"
                                            Width="80px">
                                            <Localization Select="<%$ Resources:PMWeb, btn_SelectImage %>" />
                                        </telerik:RadAsyncUpload>
                                         <asp:Button ID="btnRefreshUserImage" runat="server" CssClass="Hide"/>
                                         <asp:Button ID="btnClearImage" runat="server" Text="Clear Image" width="115px"/>
                                    </td>
                          <td >
                                        <img id="imgLaborImage" runat="server"  src="Images/Global/WhiteDot.gif" />
                       </td>
                     
                </tr>
            </table>
        </td>
        <td style="vertical-align: top; padding-left: 13px;">
            <fieldset>
                <legend>
                    <asp:Label ID="lblSpecifications" meta:Resourcekey="lblSpecifications" runat="server" ></asp:Label>
                </legend>
                <uc1:DocumentSpecifications ID="DocumentSpecifications" runat="server" />
            </fieldset>
        </td>
    </tr>
</table>

