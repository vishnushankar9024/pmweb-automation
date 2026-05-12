<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="VendorApprovalsCreateCompanyPopup.aspx.vb" Inherits="Website.VendorApprovalsCreateCompanyPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Confirm Create Company</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script type="text/javascript" language="javascript">
        function AutoCreateNextID() {
            var chbNextId = $("[id$=chbAutoCreateNextId]");
            var txtCompanyId = $("[id$=txtCompanyId]");
            if (chbNextId.is(":checked")) {
                txtCompanyId.set_enabled(false);
            }
            else {
                txtCompanyId.set_enabled(true);
                txtCompanyId.val("");
            }
        }

        function ReturnVendorApprovalsPage() {
            window.parent.location.href = "VendorApprovals.aspx";
            self.close();
        }

        function ReturnCompaniesListPage(Id) {
            window.parent.location.href = "CompaniesList.aspx?Id=" + Id;
            self.close();
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>

        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td valign="top">
                    <table style="width: 100% !important;" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="150px" CssClass="popup-toolbar">
                                        <Items>
                                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCheck" ValidationGroup="Save" CommandName="SaveExit"></telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                                        </Items>
                                    </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>

                </td>
            </tr>
        </table>
        <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
            <tr id="trTbsDetails" runat="server">
                <td>
                    <table width="100%" border="0">
                        <tr>
                            <td>
                                <div class="PMHeader">
                                    <div class="row documentSinglePage">
                                        <div class="col-4">
                                            <table class="colTable" border="0">


                                                <tr>
                                                    <td>
                                                        <table cellpadding="0" cellspacing="0" border="0" runat="server">
                                                            <tr>
                                                                <td style="width: 10%;">
                                                                    <div class="Warning">
                                                                        <span class="Icon"></span>
                                                                    </div>
                                                                </td>
                                                                <td style="width: 90%;">
                                                                    <asp:Label ID="lblHelpNote" runat="server" meta:resourcekey="lblHelpNote" Text=""></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr style="height: 15px;">
                                                                <td></td>
                                                            </tr>
                                                            <tr>
                                                                <td></td>
                                                                <td>
                                                                    <asp:Label ID="lblNote" runat="server" meta:resourcekey="lblNote" Text="This process cannot be undone" ></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr style="height: 15px;">
                                                                <td></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>


                                                <tr>
                                                    <td>
                                                        <fieldset style="width: 485px;">
                                                            <legend>
                                                                <asp:Label ID="lblVendorInformation" runat="server" meta:resourcekey="lblVendorInformation" Text="Vendor Information" Style="margin-left: 10px;"></asp:Label></legend>
                                                            <table cellpadding="0" cellspacing="0" border="0">
                                                                <tr>
                                                                    <td class="labelWidth">
                                                                        <asp:Label ID="lblCompanyId" runat="server" meta:resourcekey="lblCompanyId" Text="Company ID" Style="padding-left: 10px;"></asp:Label>
                                                                    </td>
                                                                    <td class="controlWidth">

                                                                        <table width="100%">
                                                                            <tr>
                                                                                <td width="40%">
                                                                                    <asp:TextBox ID="txtCompanyId" runat="server" meta:resourcekey="txtCompanyId" Text="" Style="width: 100%;"></asp:TextBox>
                                                                                </td>
                                                                                <td width="60%">
                                                                                    <asp:CheckBox ID="chbAutoCreateNextId" runat="server" meta:resourcekey="chbAutoCreateNextId" Text="Auto create the next ID" 
                                                                                        OnCheckedChanged="chbAutoCreateNext_Changed" AutoPostBack="true" class="mobile-switch" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                        </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                        <asp:Label ID="lblRequiredCompanyId" runat="server" meta:resourcekey="lblRequiredCompanyId" Text="Company ID is a required field. Enter a unique ID or select to Auto create one!" Visible="false" Style="padding-left: 10px; color: #C60000;"></asp:Label>
                                                                        <asp:Label ID="lblCompanyIdValid" runat="server" meta:resourcekey="lblCompanyIdValid" Text="Company ID already exists!" Visible="false" Style="padding-left: 10px; color: #C60000;"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="labelWidth">
                                                                        <asp:Label ID="lblCompanyName" runat="server" meta:resourcekey="lblCompanyName" Text="Company Name" Style="padding-left: 10px;"></asp:Label>
                                                                    </td>
                                                                    <td class="controlWidth">
                                                                        <asp:TextBox ID="txtCompanyName" runat="server" meta:resourcekey="txtCompanyName" Text="" Style="width: 99%;"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                        <asp:Label ID="lblRequiredCompanyName" runat="server" meta:resourcekey="lblRequiredCompanyName" Text="Enter Company Name" Visible="false" Style="padding-left: 10px; color: #C60000;"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="labelWidth">
                                                                        <asp:Label ID="lblApprovalStarts" runat="server" meta:resourcekey="lblApprovalStarts" Text="Approval Starts" Style="padding-left: 10px;"></asp:Label>
                                                                    </td>
                                                                    <td class="controlWidth">
                                                                        <telerik:RadDatePicker ID="dtpApprovalStarts" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                                            SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default" Culture="English (United States)" EnableTyping="True">
                                                                            <DateInput ID="DateInput2" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                                                            <Calendar ID="Calendar2" Skin="Default" runat="server"></Calendar>
                                                                        </telerik:RadDatePicker>
                                                                        <asp:RequiredFieldValidator ID="rfvApprovalStarts" ControlToValidate="dtpApprovalStarts"
                                                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                                            ValidationGroup="Submit" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                                        </asp:RequiredFieldValidator>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="labelWidth">
                                                                        <asp:Label ID="lblApprovalExpires" runat="server" meta:resourcekey="lblApprovalExpires" Text="Approval Expires" Style="padding-left: 10px;"></asp:Label>
                                                                    </td>
                                                                    <td class="controlWidth">
                                                                        <telerik:RadDatePicker ID="dtpApprovalExpires" runat="server" MinDate="1901-01-01" MaxDate="2100-01-01"
                                                                            SelectedDate='<%# Date.Today %>' Width="100%" Skin="Default" Culture="English (United States)" EnableTyping="True">
                                                                            <DateInput ID="DateInput3" LabelCssClass="radLabelCss_Office2007" Skin="Default" runat="server"></DateInput>
                                                                            <Calendar ID="Calendar3" Skin="Default" runat="server"></Calendar>
                                                                        </telerik:RadDatePicker>
                                                                        <asp:RequiredFieldValidator ID="rfvApprovalExpires" ControlToValidate="dtpApprovalExpires"
                                                                            runat="server" CssClass="Validator" Visible="false" Display="Dynamic"
                                                                            ValidationGroup="Submit" ErrorMessage="<%$ Resources:PMWeb, WarningMsg_RequiredFields%>">
                                                                        </asp:RequiredFieldValidator>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </fieldset>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table cellpadding="0" cellspacing="0" border="0" runat="server" style="485px;">
                                                            <tr style="height: 30px;">
                                                                <td style="width: 58%;"></td>
                                                                <td style="width: 40%;"></td>
                                                            </tr>
                                                            <tr>
                                                                <td></td>
                                                               <%-- <td>
                                                                    <asp:Button ID="btnOk" runat="server" meta:resourcekey="btnOk" ValidationGroup="Submit" Text="Ok" />
                                                                    <asp:Button ID="btnCancel" runat="server" meta:resourcekey="btnCancel" Text="Cancel" Style="padding-left: 10px;" />
                                                                </td>--%>
                                                            </tr>
                                                        </table>
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
    </form>
</body>
</html>
