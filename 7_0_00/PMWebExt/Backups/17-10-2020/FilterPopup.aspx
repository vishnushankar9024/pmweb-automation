<%@ Page Language="vb" AutoEventWireup="false" meta:resourcekey="Page" CodeBehind="FilterPopup.aspx.vb" Inherits="Website.FilterPopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <%--<telerik:RadAjaxManager ID="PMAjaxManager" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="lblFilterSave">
                <UpdatedControls>
                      <telerik:AjaxUpdatedControl ControlID="lblFilterSave" />
                      <telerik:AjaxUpdatedControl ControlID="pnlFilterName" />
                        <telerik:AjaxUpdatedControl ControlID="pnlFilter" />
                         <telerik:AjaxUpdatedControl ControlID="lblTitle" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            </AjaxSettings>
            <AjaxSettings>
                     <telerik:AjaxSetting AjaxControlID="lbtSave">
                <UpdatedControls>
                      <telerik:AjaxUpdatedControl ControlID="lbtSave" />
                      <telerik:AjaxUpdatedControl ControlID="pnlFilterName" />
                        <telerik:AjaxUpdatedControl ControlID="pnlFilter" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            
            </AjaxSettings>
    </telerik:RadAjaxManager>--%>
        <div class="PMHeader">
            <div class="row">
                <div class="col-4">
                    <asp:Panel runat="server" ID="pnlFilter">
                        <table class="colTable">
                            <tr>
                                <td>
                                    <telerik:RadFilter Skin="Default" runat="server" ShowApplyButton="false" ID="Radfilter1">
                                        <FieldEditors>
                                            <telerik:RadFilterTextFieldEditor FieldName="Asset_Equipments.Code" DisplayName="<%$Resources: FilterItem_RecordNumber %>" />
                                            <telerik:RadFilterTextFieldEditor FieldName="Asset_Equipments.Name" DisplayName="<%$Resources: FilterItem_Description %>" />
                                            <telerik:RadFilterTextFieldEditor FieldName="Asset_EquipmentTypes.Type" DisplayName="<%$Resources: FilterItem_Type %>" />
                                            <telerik:RadFilterTextFieldEditor FieldName="Asset_EquipmentOwnerships.Ownership" DisplayName="<%$Resources: FilterItem_Ownership %>" />
                                            <telerik:RadFilterTextFieldEditor FieldName="Asset_EquipmentFunctionSatus.FunctionStatus" DisplayName="<%$Resources: FilterItem_FunctionStatus %>" />
                                            <telerik:RadFilterTextFieldEditor FieldName="Asset_Properties.Name" DisplayName="<%$Resources: FilterItem_Location %>" />
                                            <telerik:RadFilterTextFieldEditor FieldName="Asset_Buildings.Name" DisplayName="<%$Resources: FilterItem_Building %>" />
                                            <telerik:RadFilterTextFieldEditor FieldName="Asset_Floors.Name" DisplayName="<%$Resources: FilterItem_Floor %>" />
                                            <telerik:RadFilterTextFieldEditor FieldName="Asset_Spaces.Name" DisplayName="<%$Resources: FilterItem_Space %>" />
                                            <telerik:RadFilterTextFieldEditor FieldName="Asset_Equipments.[Begin]" DisplayName="<%$Resources: FilterItem_Begin %>" />
                                            <telerik:RadFilterTextFieldEditor FieldName="Asset_Equipments.[End]" DisplayName="<%$Resources: FilterItem_End %>" />
                                            <telerik:RadFilterTextFieldEditor FieldName="Asset_Equipments.Length" DisplayName="<%$Resources: FilterItem_Length %>" />
                                            <telerik:RadFilterTextFieldEditor FieldName="BeginDirections.Direction" DisplayName="<%$Resources: FilterItem_BeginDirection %>" />
                                            <telerik:RadFilterTextFieldEditor FieldName="EndDirections.Direction" DisplayName="<%$Resources: FilterItem_EndDirection %>" />
                                            <telerik:RadFilterTextFieldEditor FieldName="UOM.UOM" DisplayName="<%$Resources: FilterItem_LengthUOM %>" />
                                            <telerik:RadFilterTextFieldEditor FieldName="Asset_Equipments.IsActive" DisplayName="<%$Resources: FilterItem_Inactive %>" />
                                        </FieldEditors>
                                    </telerik:RadFilter>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:LinkButton ID="lbtApply" meta:resourcekey="lbtApply" CausesValidation="true" ValidationGroup="Save" runat="server" Text="Apply Expressions"></asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:LinkButton ID="lbtSave" meta:resourcekey="lbtSave" runat="server" Text="Save Filter" OnClientClick="OpenDialogPopup()"></asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:LinkButton ID="lbtDelete" meta:resourcekey="lbtDelete" runat="server"></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </div>
                <div class="col-4">
                    <asp:Panel runat="server" ID="pnlFilterName" Visible="false">
                        <table class="colTable">
                            <tr>
                                <td class="labelWidth">
                                    <asp:Label ID="lblFilterName" runat="server" meta:resourcekey="lblFilterName" Text="Filter Name"></asp:Label>
                                </td>
                                <td class="controlWidth">
                                    <asp:TextBox runat="server" ID="txtFilterName" Width="99%" MaxLength="250"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvFilterName" runat="server" ErrorMessage="Required."
                                        ControlToValidate="txtFilterName" CssClass="Validator" ValidationGroup="Save"
                                        meta:resourcekey="rfvFilterName" Display="Dynamic" ForeColor="">
                                    </asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" colspan="2">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="lblFilterSave" runat="server" ValidationGroup="Save" Text="<%$ Resources:PMWeb, Save %>"></asp:LinkButton>
                                            </td>
                                            <td>
                                                <asp:LinkButton ID="lblCancel" runat="server" Text="<%$ Resources:PMWeb, Cancel %>"></asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
