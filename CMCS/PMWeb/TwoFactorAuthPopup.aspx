<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TwoFactorAuthPopUp.aspx.vb" Inherits="Website.TwoFactorAuthPopUp"%>


<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE  html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>AUTHENTICATION</title>
    <link href="CSS/ControlsCSS/Combobox.css" rel="stylesheet" />
    <link href="CSS/MainCss.css?id=123" rel="stylesheet" type="text/css" />
    <link href="CSS/ControlsCSS/Button.css" rel="stylesheet" />

    <style type="text/css">
       
         .ErrorMessage{          
             color: RGB(255,36,0) !important;
             font-size: 13px !important;
             float: left;
             padding-left: 125px;
        }
      
       
     input.txtQrCodeOneTime:disabled, input.txtQrCodeOneTime{
             margin-left: 112px; 
             margin-bottom: 20px;
             width: 240px;
         }

      input.txtQrCodeManyTimes:disabled, input.txtQrCodeManyTimes{
             margin-left: 115px; 
             margin-top: -50px;
             width: 240px;
         }


         .lblQrCodeManyTimes{
             margin-left:auto;
             padding-left: 120px;
             padding-right: 80px;
             display:flex; 
             margin-top:-80px;

         }

         .lblQrCodeOneTime{
             margin-left:auto;
             padding-left: 55px;
             padding-right: 55px; 
             display:flex; 
             line-height:1.5;
             margin-top:-50px;
         }
        
         .RadBarcode svg{
             height: 100px !important;
         }
   
    </style>

    <script type="text/javascript">

        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow; 
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow; 

            return oWindow;
        }


        function ClosePopup(){
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow;
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
            oWindow.close();
        }
       
        function CloseMFAPopup() {
            var MFAWindow = GetRadWindow();
            var btn = MFAWindow.BrowserWindow.$("[id$=btnLoginAfterPassChange]")[0];
            if (btn != null) {
                btn.click();

            }
            MFAWindow.close();

        }

        function VerifybtnClick() {

            var textbox = document.getElementById('<%= txtBoxQrCode.ClientID %>');
            var hiddenButton = document.getElementById('<%= btn_verify.ClientID %>');

            if (textbox.value.length === 6) {          
                hiddenButton.click();
            }

        }
        
     
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="ScriptManager1" runat="server" />
          <telerik:radwindowmanager id="PMWindowManager" runat="server" visiblestatusbar="False"
            reloadonshow="True" modal="True" keepinscreenbounds="True" behavior="Default"
            iconurl="Images/Global/favicon.ico" initialbehavior="None" left="" style="display: none;"
            top="">
        </telerik:radwindowmanager>
        <div>
            <table width="96%" style="margin:110px 10px 10px 10px;">
                <tr>
            <telerik:RadBarcode runat="server" ID="RadBarCode" Type="QRCode" Width="10px" Height="25px" style="margin-left: 165px;" OnPreRender="RadBarCode_PreRender"> 
                <QRCodeSettings AutoIncreaseVersion="true" />
            </telerik:RadBarcode>
                </tr>
                <tr>
                    <td colspan="1" >
                        <br /> 
                        <asp:Label ID="lblInfoQrFirstTime" runat="server" CssClass="lblQrCodeOneTime" meta:Resourcekey ="lblInfoQrFirstTime" Visible="false" ></asp:Label>    
                             <asp:Label ID="lblInfoQrManyTimes" runat="server" CssClass="lblQrCodeManyTimes" meta:Resourcekey="lblInfoQrManyTimes" Visible ="false" ></asp:Label>    
                    </td>
                </tr>
                <tr>

                    <td colspan="1"> 
                         <br />                       
              <asp:TextBox ID="txtBoxQrCode" runat="server" placeholder="Enter Authenticator Code" MaxLength="6" oninput="VerifybtnClick();" ></asp:TextBox>
                        <br />
                  <asp:Label ID ="ErrorMessageLabel" runat="server" Visible ="false" CssClass="ErrorMessage" meta:Resourcekey="ErrorMessageLabel" ></asp:Label>
                   <asp:Label ID ="ACCOUNT_LOCKEDQRCodelbl" runat="server" Visible ="false" CssClass="ErrorMessage" ></asp:Label>
                          <br />                    
                    </td>
                </tr>
                <tr>
                    <td align="right"  colspan="2" rowspan="5">
                        <asp:Button ID="btnCancel" runat="server" Text="CANCEL" Width="70px" style ="padding-bottom:-60px;" OnClientClick="return ClosePopup();"/>
                    </td>

                     <td align="right"  colspan="2" rowspan="5">
                        <asp:Button ID="btn_verify" runat="server" OnClick="otpInput_TextChanged" style="display:none;"/>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
