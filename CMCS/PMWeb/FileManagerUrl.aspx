<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="FileManagerUrl.aspx.vb" Inherits="Website.FileManagerUrl" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        function SelectUrl() {
            document.getElementById('txtDescription').select();
        }
    </script>
    <style type="text/css">
        @media only screen and (min-width: 1281px) {
            .RadScheduler .rsYearView .rsYearMonthWrap {
                width: 16.66667%;
            }
        }

        @media only screen and (min-width: 1025px) and (max-width: 1280px) {
            #txtDescription {
                margin-left: 0;
                width: 100%;
            }
        }

        @media only screen and (min-width: 769px) and (max-width: 1024px) {
            #txtDescription {
                margin-left: 0;
                width: 100%;
            }
        }

        @media only screen and (min-width: 361px) and (max-width: 768px) {
            #txtDescription {
                margin-left: 0;
                width: 100%;
            }
        }




        .RadToolBar .rtbOuter {
            background-color: white !important;
        }

        .documentSinglePage {
            margin-top: 100px !important;
        }

        .ToolBar {
            border-bottom: 1px solid RGB(237,237,237);
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <script type="text/javascript">
            $(document).ready(function () {
                var ctrlDown = false;
                var ctrlKey = 17, ckey = 67;

                $(document).keydown(function (e) {
                    if (e.keyCode == ctrlKey) ctrlDown = true;
                }).keyup(function (e) {

                    if (e.keyCode == ctrlKey) ctrlDown = false;
                });
                $('#txtDescription').keydown(function (e) {
                    if (ctrlDown && (e.keyCode == ckey))
                    { setTimeout(function () { window.close(); }, 1); }
                });

            });
        </script>
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
         <div class="ProfileTitle">
            <asp:Label runat="server" ID="TitleUser" Text=""></asp:Label>
            <asp:LinkButton runat="server" CssClass="closepopup" ID="btnCloseProfilePopup" OnClientClick="window.close();return false;">
        <div class="CloseProfilePopup">
                                                                                 &nbsp;
                                                                            </div></asp:LinkButton>
        </div>
        <table class="ToolBar" style="width: 100%; margin-top: 50px; background-color: transparent !important" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="100%">
                        <Items>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage documentSinglePage TitleToolbarTop">
            <div class="row ">
                <div class="col-12">
                    <table class="colTable">
                        <tr>
                            <td>
                                <asp:Label CssClass="labelWidth" ID="lblURL" runat="server" Text="Use CTRL+C to copy the URL" meta:Resourcekey="lblCopyURL"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="txtDescription" runat="server" ReadOnly="true"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
