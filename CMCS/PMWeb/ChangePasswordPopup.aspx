<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ChangePasswordPopup.aspx.vb" Inherits="Website.ChangePasswordPopup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Change Password</title>
     <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <script type="text/javascript">

        function CloseChangePasswordPopup() {
            let curWindow = window.opener || window.parent;
            var btn = curWindow.$("[id$=btnLoginAfterPassChange]");
            if (btn != null) {
                btn.click();
                return ClosePopup();
            }
             
        }

        function ClosePopupAndLogin() {
            let curWindow = window.opener || window.parent;
            var btn = curWindow.$("[id$=btnRemindLogin]");
            if (btn != null) {
                btn.click();
                return ClosePopup();
            }

        }

        function ClosePopup() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            oWindow.close();
        }
    </script>
    <%--<link href="CSS/PMCss.css" rel="stylesheet" type="text/css" />--%>
</head>
<body>
    <form id="form1" runat="server">
    <style type="text/css">
       body {background-color: #F3F3F3 !important; background-image: none !important;overflow:hidden;font-family: "Roboto", sans-serif !important;}
       .lblInfo{
           padding:15px;
           display:flex; 
           line-height:normal;
           margin-top:10px;
           margin-left:-10px;
           font-size: 18px;
           color: rgba(127, 127, 127);
       }
       
        .headerContainer {
            height: 8%;
            min-height: 50px;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            background-color: /*1*/#00568F/*1*/;
        }

       div#SVGArrow {
            position: relative;
            right: 125px;
            height: 23px;
        }

        .header {
            display: flex;
            justify-content: center;
            align-items: center;
            padding-left: 20px;
        }

        .title {
            color: #FFFFFF;
            font-family: 'Roboto', sans-serif;
            font-size: 16px;
            margin-left: 18px;
        }

           .BtnOK {
            border-width: 0px !important;
            width: 42px !important;
            height: 50px !important;
            box-sizing: border-box;
            border: none !important;
            color: #000000 !important;
            text-align: center !important;
            text-transform: none !important;
            font-size: 16px !important;
            background-color: transparent !important;
        }

            .BtnOK:hover {
                box-sizing: border-box !important;
                font-weight: bold !important;
            }

            .BtnOK:checked {
                box-sizing: border-box !important;
                font-weight: bold !important;
            }


            .BtnOK:disabled {
                box-sizing: border-box !important;
                color: #aaaaaa !important;
            }

            
        .BtnCancel {
            width: 69px !important;
            height: 50px !important;
            background-color: rgba(242, 242, 242, 0) !important;
            box-sizing: border-box !important;
            font-family: "Roboto", sans-serif !important;
            font-weight: bold !important;
            color: #000000 !important;
            text-align: center !important;
            line-height: normal !important;
            border: none !important;
            text-transform: none !important;
            font-size: 16px !important;
        }

            .BtnCancel:hover {
                box-sizing: border-box !important;
                font-weight: bold !important;
            }

            .BtnCancel:checked {
                box-sizing: border-box !important;
                font-weight: bold !important;
            }

            input#txtOldPassword,
            input#txtPassword,
            input#txtConfirmPassword{
            border: none;
            border-bottom: 1px solid #7f7f7f;
            width: 90vw;
            height: 38px;
            outline: none;
            padding: 2px 16px 2px 16px;
            background-color: #ffffff;
            box-sizing: border-box;
            font-family: Roboto, sans-serif;
            color: #000000;
            text-align: left;
            font-size: 16px;
        }
          
        .spans {
            background-color: rgba(242, 242, 242, 0);
            box-sizing: border-box;
            font-family: Roboto, sans-serif;
            color: rgba(127, 127, 127);
            text-align: left;
            line-height: normal;
            display: block;
        }

        .lblComplexity {
            display: flex;
            line-height: normal;
            margin-top: 10px;
            margin-left: 2px;
            font-size: 17px;
            color: rgba(127, 127, 127);
        }
       </style>
        <div class="headerContainer">
                <div class="header">

                    <asp:Label ID="lblTitle" runat="server" Text="Change Password" CssClass="title" ></asp:Label>
                </div>
                <div id="SVGArrow">
                    <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#F3F3F3 " style="cursor: hand; position: relative; left: 105px;" onclick="ClosePopup()">
                        <path d="m256-200-56-56 224-224-224-224 56-56 224 224 224-224 56 56-224 224 224 224-56 56-224-224-224 224Z" />
                    </svg>
                </div>


            </div>
     <table>
     <tr>
     <td valign="top" style="padding-right:10px">
          <asp:LinkButton ID="btnCheck" runat="server" CausesValidation="False"  CssClass="CheckButton" >
                    <span class="Icon"></span>    
                </asp:LinkButton> 
     </td>
     <td valign="baseline" class="lblInfo" >
     Fill in all three fields below and then click OK.
    <br />
     </td>
     </tr>
     </table><br />
        <table style="margin: 16px; margin-top: -12px;">
            <tr>
                <td>
                    <div>
                        <span class="spans">Current Password*</span>
                    </div>

                    <div style="display: inline">
                        <asp:TextBox ID="txtOldPassword" MaxLength="128" runat="server"
                            TextMode="Password" CssClass="AngularTxtBox"></asp:TextBox>
                        <div>
                            <asp:Label Text="Invalid Password." CssClass="Validator" meta:resourcekey="lblInvalidPassword" ID="lblInvalidPassword" Visible="false" runat="server"></asp:Label>
                        </div>
                    </div>
                </td>
            </tr>
          
            <tr>
                <td>
                    <div>
                        <span class="spans">New Password*</span>
                    </div>

                    <div style="display: inline">
                        <asp:TextBox ID="txtPassword" MaxLength="128" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:Label Text="Enter New Password." CssClass="Validator" ID="lblEnterNewPassword" Visible="false" runat="server"></asp:Label>
                    </div>
                </td>
            </tr>

            <tr>
                <td>
                    <div>
                        <span class="spans">Confirm Password*</span>
                    </div>
                    <div style="display: inline">
                        <asp:TextBox ID="txtConfirmPassword" MaxLength="128" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:CompareValidator runat="server" Display="Dynamic" ValidationGroup="Save" CssClass="Validator" ID="cmp1" ControlToValidate="txtPassword" ControlToCompare="txtConfirmPassword" ErrorMessage="New Password Not Confirmed."></asp:CompareValidator>
                    </div>
                </td>
            </tr>
        </table>

        <table style="margin: 16px; margin-top: -12px;">
            <tr runat="server" id="trPasswordRules">
                <td colspan="2">           
                    <div>
                        <table style="margin-left: -3px;">
                            <tr>

                                <td>
                                    <asp:Label runat="server" ID="lblComplexityText" CssClass="lblComplexity"></asp:Label>
                                   <br />
                                    <asp:Label runat="server" ID="lblInfo2" CssClass="lblComplexity">You may not use any of your last 3 passwords.</asp:Label>
                                </td>
                            </tr>
                            
                        </table>
                    </div>
                </td>
            </tr>
  

        <table style="margin: 245px; margin-top: 100px;">
            <tr>
                <td>
                    <asp:Button runat="server" CssClass="BtnOK" ID="btnSave" ValidationGroup="Save" Width="75px" Text="OK" />
                </td>
                <td align="right" colspan="2" rowspan="5">
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" Width="75px" CssClass="BtnCancel" OnClientClick="return ClosePopup();" />
                </td>
            </tr>
        </table>

        <asp:Label CssClass="Validator" ID="lblComplexityError" Visible="false" runat="server"></asp:Label>

    </form>
</body>
</html>
