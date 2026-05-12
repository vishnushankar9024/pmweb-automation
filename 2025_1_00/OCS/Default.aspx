<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SyosysWap.Default" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<!-- Apple devices fullscreen -->
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<!-- Apple devices fullscreen -->
	<meta names="apple-mobile-web-app-status-bar-style" content="black-translucent" />

	<title>OCS Management - Login</title>

	<!-- Bootstrap -->
	<link rel="stylesheet" href="App_Themes/Site/css/bootstrap.min.css">
	<!-- icheck -->
	<link rel="stylesheet" href="App_Themes/Site/css/plugins/icheck/all.css">
	<!-- Theme CSS -->
	<link rel="stylesheet" href="App_Themes/Site/css/style.css">
	<!-- Color CSS -->
	<link rel="stylesheet" href="App_Themes/Site/css/themes.css">


	<!-- jQuery -->
	<script src="App_Themes/Site/js/jquery.min.js"></script>

	<!-- Nice Scroll -->
	<script src="App_Themes/Site/js/plugins/nicescroll/jquery.nicescroll.min.js"></script>
	<!-- Validation -->
	<script src="App_Themes/Site/js/plugins/validation/jquery.validate.min.js"></script>
	<script src="App_Themes/Site/js/plugins/validation/additional-methods.min.js"></script>
	<!-- icheck -->
	<script src="App_Themes/Site/js/plugins/icheck/jquery.icheck.min.js"></script>
	<!-- Bootstrap -->
	<script src="App_Themes/Site/js/bootstrap.min.js"></script>
	<script src="App_Themes/Site/js/eakroko.js"></script>
    <link rel="apple-touch-icon-precomposed" href="App_Themes/Site/img/apple-touch-icon-precomposed.png" />

</head>
<body class='login'>
<form id="form1" runat="server">
	<div class="wrapper" style="border-width: 1px;border-style: solid;border-color: cadetblue;">
        <h1>
			<a href="Default.aspx">
				&nbsp;&nbsp;<img src="App_Themes/Site/HomeTheme/images/hmc_logo124.png" alt="" class='retina-ready'></a>
		</h1>
		<div class="login-body">
            		
			<h2>SIGN IN</h2>
			<div class='form-validate' id="test">
            
             <div class="col-sm-12 ">
                <div class="form-group ">
					<div class="email controls">

                    <asp:TextBox ID="txtUserName" CssClass="form-control" placeholder="User Name" runat="server"></asp:TextBox>
						<asp:RequiredFieldValidator ID="rfvUserName" runat="server" ErrorMessage="Required Field"
                                    ControlToValidate="txtUserName" ValidationGroup="Login" CssClass="absolute_login"></asp:RequiredFieldValidator>
					</div>
				</div>
				<div class="form-group">
					<div class="pw controls">
                    <asp:TextBox ID="txtPassword" CssClass="form-control" placeholder="Password" TextMode="Password" runat="server"></asp:TextBox>
						<asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="Required Field"
                                    ControlToValidate="txtPassword" ValidationGroup="Login" CssClass="absolute_login"></asp:RequiredFieldValidator>
					</div>
				</div></div>
                
				<div class="submit send_btn" style="font-family: cursive;">
                    <asp:Button ID="btnLogin" Text="Sign me in" CssClass="btn btn-primary" runat="server" ValidationGroup="Login" OnClick="btnSubmit_Click"/>
				</div>
                <div class="loginbuttad" style="color: #F44336;font-weight: bold;">
              <asp:Literal ID="litMsg" runat="server"></asp:Literal>
		</div>
			</div><br /><br />
			<div class="forget">
			</div>
            
        </div>
	</div>
    </form>
</body>
</html>
