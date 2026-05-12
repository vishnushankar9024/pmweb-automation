<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" CodeBehind="Licenses.aspx.vb" Inherits="Website.Licenses" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        @media screen and (min-width:1050px) {
            .lnkBtnSndEmail {
                top: 128px;
                margin-left: 5px;
                display: inline-block;
            }

            .SendEmail {
                display: none;
            }
        }

        @media screen and (max-width:1050px) and (min-width:880px) {
            .lnkBtnSndEmail {
                margin-left: 16px;
                top: 0;
                display: none !important;
            }

            .SendEmail {
                display: block;
            }
        }

        @media screen and (max-width: 880px) and (min-width: 320px) {
            .PMHeader .row .col-6 {
                flex: 0 0 100% !important;
                width: calc(100% - 48px);
            }

            .lnkBtnSndEmail {
                margin-left: 24px;
                top: 0;
                display: none !important;
            }

            .SendEmail {
                display: block;
            }
        }


        span {
            box-sizing: border-box;
        }

        .TableNoSpacingNoBorder {
            border-spacing: 0;
        }

            .TableNoSpacingNoBorder > tbody > tr > td {
                padding: 0;
            }
    </style>
    <div class="PMHeader">
        <div class="row">
            <div class="col-6" style="max-width: 650px !important;">
                <table class="colTable">
                    <tr>
                        <td class="labelWidth" style="vertical-align: top;padding-top:4px;">
                            <table class="TableNoSpacingNoBorder">
                                <tr>
                                    <td>
                                      
                                            <asp:Label ID="lblLicenseFile" runat="server" Text="License"></asp:Label>
                                      </td>
                                    <td>
                                        
                                            <asp:LinkButton ID="lnkUpload" OnClientClick="return TriggerUpload();" style="float:right" runat="server" CssClass="SearchButton1">
                                     <span class="Icon"></span>     
                                            </asp:LinkButton>
                                        
                                    </td>
                                </tr>
                                <tr></tr>
                            </table>
                        </td>
                        <td class="controlWidth">
                            <table class="TableNoSpacingNoBorder">
                                <tr>
                                    <td style="width: 69%; padding-right: 13%; padding-left: 0">
                                        <div class="FileName">
                                            <asp:FileUpload ID="fluLicense" runat="server" ClientIDMode="Static" Style="display: none;" />

                                            <asp:TextBox runat="server" ID="txtFileName" ClientIDMode="Static"></asp:TextBox>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="upload">
                                            <asp:LinkButton ID="btnUpload" runat="server" Style="height: 30px; line-height: 30px; max-height: 30px; padding: 0; max-width: none !important; width: 100%; white-space: nowrap; text-overflow: ellipsis; overflow: hidden;"
                                                CssClass="lnkButton btnupload" ValidationGroup="Upload">
                                                <span runat="server"></span>
                                                <asp:Label ID="lblUpdateLicense" Text="Update License data" runat="server"></asp:Label>
                                                &nbsp;&nbsp;
                                            </asp:LinkButton>
                                        </div>
                                    </td>


                                </tr>
                                <tr>
                                    <td>
                                        <asp:RequiredFieldValidator ID="rfvLicense" runat="server" ControlToValidate="fluLicense"
                                            CssClass="Validator" ErrorMessage="Enter the license file" Display="Dynamic" ForeColor=""
                                            ValidationGroup="Upload"></asp:RequiredFieldValidator>
                                    </td>
                                    <td>

                                        <table cellpadding="2" cellspacing="2">
                                            <tr>
                                                <td colspan="2" align="right"></td>
                                                <td>
                                                    <asp:Label ID="lblUploadSuccees" runat="server" Text="Succeeded" CssClass="Success" Visible="false"></asp:Label>
                                                    <asp:Label ID="lblUploadFalied" runat="server" Text="Failed" CssClass="Failure" Visible="false"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>


                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblCompany" runat="server" Text="Company"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtCompany" runat="server" Width="100%"
                                ValidationGroup="Email"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvCustomer" runat="server" ControlToValidate="txtCompany"
                                CssClass="Validator" ErrorMessage="Required" Display="Dynamic" ForeColor=""
                                ValidationGroup="Email"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblAppPath" runat="server" Text="App. Physical Path"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtAppPath" runat="server" Width="100%" ValidationGroup="Email"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvAppPath" runat="server" ControlToValidate="txtAppPath"
                                CssClass="Validator" ErrorMessage="Required" Display="Dynamic" ForeColor=""
                                ValidationGroup="Email"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblAppURL" runat="server" Text="App. Physical URL"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtAppURL" runat="server" Width="100%"
                                ValidationGroup="Email"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvKeyCode" runat="server" ControlToValidate="txtAppURL"
                                CssClass="Validator" ErrorMessage="Required" Display="Dynamic" ForeColor=""
                                ValidationGroup="Email"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblEmail" runat="server" Text="E-mail"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtEmail" runat="server" Width="100%" ValidationGroup="Email"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                                CssClass="Validator" ErrorMessage="Required" Display="Dynamic" ForeColor=""
                                ValidationGroup="Email"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="rgvEmail" runat="server" ControlToValidate="txtEmail"
                                CssClass="Validator" ErrorMessage="<br>Invalid email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                ValidationGroup="Email" Display="Dynamic"></asp:RegularExpressionValidator>
                        </td>

                    </tr>
                    <tr class="SendEmail">
                        <td class="labelWidth"></td>
                        <td class="controlWidth">
                            <asp:LinkButton ID="lnkBtnSendEmail" runat="server" CssClass="lnkButton btnSendEmail" Style="position: relative; line-height: 20px; max-height: 20px;"
                                ValidationGroup="Email">
                                <span runat="server"></span>
                                <asp:Label ID="Label1" Text="Send Email To PMWeb" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblPMWebAdminHostname" Text="PMWeb Admin Hostname" runat="server" Width="100%"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox ID="txtPMWebAdminHostname" runat="server" Width="100%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td style="float: right;"></td>
                        <td>
                            <table cellpadding="2" cellspacing="2">
                                <tr>
                                    <td colspan="2" align="right"></td>
                                    <td>
                                        <asp:Label ID="lblEmailSucceed" runat="server" Text="Succeeded" CssClass="Success" Visible="false"></asp:Label>
                                        <asp:Label ID="lblEmailFailed" runat="server" Text="Failed" CssClass="Failure" Visible="false"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                 <asp:Button runat="server" ID="btnSave" Text="Save" style="display:none" OnClick="btnSave_Click"/>
            </div>
            <asp:LinkButton ID="btnSendEmail" runat="server" CssClass="lnkButton btnSendEmail lnkBtnSndEmail" Style="display: inline-block; position: relative; line-height: 20px; max-height: 20px;"
                ValidationGroup="Email">
                <span runat="server"></span>
                <asp:Label ID="lblSendEmailToPMWeb" Text="Send Email To PMWeb" runat="server"></asp:Label>
                &nbsp;&nbsp;
            </asp:LinkButton>
            <%--<div style="display: inline-block; width: 30%;height:160px;">
            
            </div>--%>
        </div>
    </div>
    <script type="text/javascript">
        function TriggerUpload() {
            $("#fluLicense").click()
            return false;
        }

        $(document).ready(function () {
            $("#fluLicense").change(function () {
                var uploadFile = $(this);
                $("#txtFileName").val(uploadFile.val().replace(/^.*\\/, ""));
            });

        })
    </script>
</asp:Content>
