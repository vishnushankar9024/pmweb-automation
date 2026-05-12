<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/PmMaster.Master" ValidateRequest="false"
    CodeBehind="LoginPage.aspx.vb" Inherits="Website.LoginPage" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/VendorApprovalDatabases.ascx" TagName="VendorApprovalDatabases" TagPrefix="uc1" %>
<%--<%@ Register Src="~/LoginPageSettings.ascx" TagName="LoginPageSettings" TagPrefix="uc2" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Button runat="server" ID="btnSave" Text="Save" Style="display: none" OnClick="btnSave_Click" />
    <style>
        .lnkButton1 {
            border: 1px solid #666666;
            text-transform: uppercase;
            color: #666666;
            border-radius: 5px;
            background-color: #FFFFFF;
            text-decoration: none;
            display: block;
            line-height: 30px;
            height: 30px;
            width: 150px;
            text-align: center;
        }


        fieldset {
            width: 100% !important;
            border: 0;
            border-top: 1px solid #999999;
            margin: 0;
            padding: 0;
            min-width: 1px;
        }

        input[type=text], input[type=password] {
            width: 100%;
            font-family: inherit;
            height: 24px;
            line-height: 24px;
            color: #000000;
            background: #FFFFFF;
            border: 1px solid #666;
            border-radius: 0px;
            box-sizing: border-box;
        }
        .labelmask{
            position:absolute;
            top:8px;
            left:0;
            padding-left:3px;
            color:#666;
           
        }
    </style>
    <script type="text/javascript">
        function pageLoad() {
           
            $("[id$=txtDefaultPassword]").focus(function () {
                passwordfocus('lblDefaultPasswordmask');
            });
            $("[id$=txtDefaultPassword]").blur(function () {
                passwordblur('lblDefaultPasswordmask', 'txtDefaultPassword');
            });
        }
        function passwordfocus(lblId) {            
            var lbl = $('"[id$=' + lblId + ']"');
              if (!lbl.hasClass('Hide'))
              lbl.addClass('Hide');
        }
        function passwordblur(lblId, txtId) {
            var txt = $('"[id$=' + txtId + ']"');
            var lbl = $('"[id$=' + lblId + ']"');
            if (txt.val().length == 0)
                lbl.removeClass('Hide');
        }
        function onlblPasswordfocus(lblId, txtId) {
            var txt = $('"[id$=' + txtId + ']"');
            var lbl = $('"[id$=' + lblId + ']"');
            lbl.removeClass('Hide');
            txt.focus();
        }

        function cleanErrorMessage() {
            if ($("#ErrorMessage")[0] !== undefined) {
                if ($("#ErrorMessage")[0].innerText != "")
                    $("#ErrorMessage")[0].outerText = "";
            }
        }
    </script>
    <div class="PMMainPage">
        <div class="row">
            <div class="col-4 col-4-left">
                <table class="colTable" style="border-collapse: collapse;">
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblCompanyName" Text="Company Name" runat="server"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox runat="server" ID="txtCompanyName"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <div style="float: left">
                                <asp:Label ID="lblLoginPageImage" Text="Login Page Image" runat="server"></asp:Label>
                            </div>
                            <div style="float: right">
                                <asp:LinkButton ID="lnkUpload" OnClientClick="return TriggerUpload();" runat="server" CssClass="SearchButton1">
                                     <span class="Icon"></span>     
                                </asp:LinkButton>
                            </div>
                        </td>
                        <td class="controlWidth">
                            <asp:FileUpload ID="fileImageUpload" runat="server" ClientIDMode="Static" Width="99%" Style="display: none;" CssClass="SearchButton1" />
                            <asp:TextBox runat="server" ReadOnly="true" ID="txtFileName" ClientIDMode="Static"></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td class="labelWidth" valign="top" style="padding-top: 3px;">
                            <asp:LinkButton ID="btnUseDefault" runat="server" CssClass="lnkButton1" OnClick="btnUseDefault_Click">
                                <span runat="server"></span>
                                <asp:Label ID="lblUseDefault" Text="Use Default" runat="server"></asp:Label>
                                &nbsp;&nbsp;
                            </asp:LinkButton>
                        </td>
                        <td class="controlWidth">
                            <asp:Image ID="imgLoginPageImage" ClientIDMode="Static" Style="min-height: 15em; min-width: 100%; width: 100%;margin-bottom:20px;" runat="server" alt="" />
                        </td>
                    </tr>

                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblShowUsersList" Text="Show Users List" runat="server"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <%--<label class="switch">
                                <input id="chkShowUsersList" runat="server" type="checkbox" />
                                <span class="slider round"></span>
                            </label>--%>
                            <asp:CheckBox runat="server" ID="chkShowUsersList" />
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblDefaultPassword" Text="Default Password" runat="server"></asp:Label>
                        </td>
                        <td class="controlWidth" style="position:relative">
                            <asp:TextBox ID="txtDefaultPassword" MaxLength="128" runat="server" Width="100%" TextMode="Password" onkeypress="cleanErrorMessage();"></asp:TextBox>
                            <asp:Label runat="server" ID="lblDefaultPasswordmask" CssClass="labelmask" onclick="onlblPasswordfocus('lblDefaultPasswordmask','txtDefaultPassword');"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblLockoutTimeInMinutes" Text="Lockout Time in Minutes" runat="server"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox runat="server" ID="txtLockoutTimeInMinutes" CssClass="Integer"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="labelWidth">
                            <asp:Label ID="lblMaximumInvalidAttempts" Text="Maximum Invalid Attempts" runat="server"></asp:Label>
                        </td>
                        <td class="controlWidth">
                            <asp:TextBox runat="server" ID="txtMaximumInvalidAttempts" class="Integer"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="padding-top: 30px;">
                            <fieldset style="width: 100%">
                                <legend>VENDOR APPROVER DATABASES</legend>
                                <uc1:VendorApprovalDatabases Id="VendorApprovalDatabases1" runat="server" />
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function TriggerUpload() {
            $("#fileImageUpload").click()
            return false;
        }

        $(document).ready(function () {
            $("#fileImageUpload").change(function () {
                var uploadFile = $(this);
                $("#txtFileName").val(uploadFile.val().replace(/^.*\\/, ""));
                var reader = new FileReader();
                reader.onloadend = function () {
                    $("#imgLoginPageImage").attr("src", reader.result);
                }
                debugger;
                var file = document.querySelector('input[type=file]').files[0]
                if (file) {
                    reader.readAsDataURL(file);
                }
                //else {
                //    $("#imgLoginPageImage").attr("src", "");
                //}


            });

        })
    </script>
</asp:Content>
