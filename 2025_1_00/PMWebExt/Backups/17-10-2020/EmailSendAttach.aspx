<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EmailSendAttach.aspx.vb" Inherits="Website.EmailSendAttach" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <style>
            .RadUpload .ruFileWrap{
                width:90%!important;
                height: 30px !important;
            }
            .RadUpload_Default .ruFakeInput{
                width: 99% !important;
                border: 1px solid #666 !important;
                height:24px !important;
            }
            .RadUpload:hover{background-color:white !important;}
           .RadUpload .ruRemove{margin-left: 17px;
    margin-top: 8px !important;
     border: 1px solid #999999 !important;
   
            }
           .RadUpload .ruActions .ruButton.ruAdd{
               float: left;
    margin-left: 17px !important;
    border: 1px solid #999999 !important;
        margin-top: 0px !important;
           }
           .RadUpload .ruActions .ruButton.ruDelete{border: 1px solid #999999 !important;
            }
           .RadUpload .ruInputs li.ruActions{margin-bottom:3px !important;}
        </style>
        <telerik:RadScriptManager ID="PMScriptManager" runat="server"
            EnableTheming="True">
        </telerik:RadScriptManager>
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" Style="width: 100%" runat="server" Skin="Default" AutoPostBack="true">
                                    <Items>
                                        <telerik:RadToolBarButton CommandName="Upload" EnableImageSprite="true" CssClass="ToolbarUpload"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div class="PMMainPage">
            <div class="row">
                <div  style="margin-top:50px;width:100%">
                    <table class="colTable">
                        <tr>
                            <td>
                                <telerik:RadUpload ID="FileUpload1" runat="server" Visible="true" Width="99%" Skin="Default" MaxFileInputsCount="10">
                                    <Localization Add="<%$ Resources:PMWeb, RadUploadAdd %>" Clear="<%$ Resources:PMWeb, RadUploadClear %>"
                                        Delete="<%$ Resources:PMWeb, RadUploadDelete %>" Remove="<%$ Resources:PMWeb, RadUploadRemove %>"
                                        Select="<%$ Resources:PMWeb, RadUploadSelect %>" />
                                </telerik:RadUpload>
                            </td>
                        </tr>
                    <%--    <tr>
                            <td style="float: right;">
                                <asp:Button ID="btnUpload" runat="server" Text="Upload" />
                            </td>
                        </tr>--%>
                    </table>
                </div>
                <div class="col-4"></div>
                <div class="col-4"></div>
            </div>
        </div>
    </form>
</body>
</html>
