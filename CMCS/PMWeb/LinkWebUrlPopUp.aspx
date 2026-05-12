<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinkWebUrlPopUp.aspx.vb" Inherits="Website.LinkWebUrlPopUp" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
  <%--  <script type="text/javascript" src="JS/FileManager/FileManager.js"></script>--%>
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

          /*.ProfileTitle {
                color: #a5a5a5 !important;
                position: fixed;
                top: 0px;
                width: 100%;
                font-size: 15px !important;
                padding: 20px 0px 5px 16px;
                background-color: white;
                z-index: 1000;
            }

            .closepopup div {
                background-image: url('CSS/Images/ResponsiveIcons/CloseButton.png') !important;
                background-repeat: no-repeat;
                background-position: 0 0 !important;
                display: inline-block;
                position: absolute;
                right: 16px !important;
                bottom: 1px;
            }*/
            .CloseProfilePopup{
                margin-left:0px !important;
            }

            .ToolBar {
                border-bottom: 1px solid RGB(237,237,237);
            }
              .RadToolBar .rtbOuter {
                background-color: white !important;
            }

        /*    .documentSinglePage {
                margin-top: 100px !important;
            }*/
            
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
            function maintoolBar_Clicked(sender, args) {
                var hfWebUrl= $(window.parent.document).find("input[id$='hfWebUrl']");
                var DescriptionValue = $("[id$=txtDescription]").val();
                hfWebUrl.val(DescriptionValue);
                var urlParams = new URLSearchParams(window.location.search);
                if (urlParams.has('isSharePoint')) {
                    $(window.parent.document).find(".SaveSharePoint")[0].click();
                } else
                {
                    $(window.parent.document).find(".SaveUrl")[0].click();
                }
                var chk = $("[id$=chkNewTab]")[0];
                if (chk.checked) window.open(DescriptionValue, "_blank");
                window.close();
            }


        </script>
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
         <div class="ProfileTitle">
            <asp:Label runat="server" ID="TitleUser"></asp:Label>
            <asp:LinkButton runat="server" CssClass="closepopup" ID="btnCloseProfilePopup" OnClientClick="window.close();return false;">
        <div class="CloseProfilePopup">
                                                                                 &nbsp;
                                                                            </div></asp:LinkButton>
        </div>
        <table class="ToolBar"  style="width: 100%; margin-top: 50px; background-color: transparent !important" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" OnClientButtonClicked="maintoolBar_Clicked" runat="server" Skin="Default" AutoPostBack="false" Width="100%">
                        <Items>
                            <telerik:RadToolBarButton CommandName="SaveAndExit" EnableImageSprite="true" CssClass="ToolbarSaveAndExit"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
        <div class="PMMainPage documentSinglePage">
            <div class="row ">
                <div class="col-12">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblUrl" Text="URL" runat="server"  meta:resourcekey="lbUrl" ></asp:Label>
                            </td>
                            <td class="controlWidth">
                                <asp:TextBox ID="txtDescription" Text="http://" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr style="visibility:hidden">
                            <td class="labelWidth">
                                <asp:Label ID="lblOpenTab" Text="Open In New Tab" runat="server"></asp:Label>

                            </td>
                            <td class="controlWidth">
                                <label class="switch">
                                    <input id="chkNewTab" runat="server" type="checkbox"/>
                                    <span class="slider round"></span>
                                </label>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
