<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Application_PMWebLogo.ascx.vb" Inherits="Website.Application_PMWebLogo" %>
<%@ Register Src="Message.ascx" TagName="Message" TagPrefix="uc1" %>

<style type="text/css">
    #main {
        float: left;
        width: 285px;
        border: 1px silver solid;
        -moz-border-radius: 5px;
        -webkit-border-radius: 5px;
        position: relative;
        background-color: #fff;
        margin-top: 10px;
        margin-left: 10px;
        padding-left: 10px;
    }

    #ClientBox {
        margin: auto;
        border: 1px #69ba33 solid;
        border-collapse: separate !important;
        -moz-border-radius: 4px;
        -webkit-border-radius: 4px;
        width: 180px;
        font-size: 11px;
        padding: 7px;
    }

    #login {
        margin-left: 80px;
        margin-top: 30px;
    }

    #out_links {
        margin-left: 80px;
        margin-top: 20px;
        line-height: 20px;
    }

    #copyright {
        bottom: 5px;
        position: absolute;
        width: 99%;
        text-align: left;
        margin-left: 5px;
        font-family: Arial, Helvetica, sans-serif;
        text-decoration: none;
        color: Gray;
        font-size: 8pt;
    }
</style>

<script type="text/javascript">
    $(document).ready(function (n) {
        var today = new Date();
        var year = today.getFullYear();                
        $('#copyrightLabel').html('© 2007-' + year + ' PMWeb, Inc. All rights reserved.');
    });
</script>


<table id="main" cellpadding="0" border="0" cellspacing="0" style="height: 100%">
    <tr>
        <td id="img_pmweb" style="height: 100px !important; vertical-align: top; height: 250px">
            <asp:Image ID="imgLogo" runat="server" ImageUrl="Images/Login/PMWeb.gif" Height="86px" Width="260px" onclick="javascript:return CheckDirtOnLogo();" Style="cursor: pointer;" />
        </td>
    </tr>
    <tr>
        <td style="height: 50px; vertical-align: top; padding-left: 10px; font-family: Arial, Helvetica, sans-serif; font-size: 13px; font-weight: bold; color: #999999;">
            <asp:Label ID="lblAccount" runat="server" Text=""></asp:Label>
        </td>
    </tr>
    <tr>
        <td style="height: 100px; height: 90px; vertical-align: top">
            <table cellpadding="0" cellspacing="0" id="ClientBox" style="height: 50px; width: 255px; margin-right: 11px;">
                <tr>
                    <td style="padding-left: 5px;">PMWeb Version:
                        <asp:Label runat="server" CssClass="bold" ID="lblVersionNumber" /></td>
                </tr>
                <tr>
                    <td style="padding-left: 5px;">Database Version:
                        <asp:Label ID="lblDBVersion" runat="server" CssClass="bold" /></td>
                </tr>
                <tr>
                    <td style="padding-left: 5px;">Client #:
                        <asp:Label runat="server" CssClass="bold" ID="lblClientNumber" Text="----" /></td>
                </tr>
                <tr>
                    <td style="padding-left: 5px;">Client Name: 
                        <asp:Label runat="server" CssClass="bold" ID="lblClientName" Text="------------" /></td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <uc1:Message ID="Message" runat="server" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td id="login" style="height: 60%">
            <table>
                <tr>
                    <td id="out_links" style="margin-left: 0px !important; position: absolute; bottom: 70px; left: 10px;">
                        <a href="http://pmweb.com" target="_blank">Visit PMWeb.com</a>
                    </td>
                </tr>
                <tr>
                    <td id="copyright" style="left: 7px;">
                        <label id="copyrightLabel"></label>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>




