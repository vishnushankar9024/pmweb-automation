<%@ Page Language="vb" meta:resourcekey="Page" Title="Generate Change Event" AutoEventWireup="false" CodeBehind="DocumentRisksGeneratePopup.aspx.vb" Inherits="Website.DocumentRisksGeneratePopup" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>

<body>
     <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">

        <script language="javascript" type="text/javascript">

            function closeAndRedirectParent(CEId) {
                var id = CEId
                console.log("CEId : ", CEId);
                var CEurl = "ChangeEvents.aspx?Id=" +id + "&ModuleId=3&PageId=109";
                console.log("Url is:", CEurl);
                CloseDocumentRisksPopup();

                window.parent.location.href = CEurl;
            }

            function CloseDocumentRisksPopup() {
                self.close();
                window.parent.document.body.focus();
            }

        </script>

        <style type="text/css">
            body {
                font-family:Arial, sans-serif;
                margin:0;
                padding:0;
                background-color:#f5f7fa;
            }

            .popup-header {
                background-color:#8eaec9;
                color:white;
                padding:10px;
                font-size:16px;
                font-weight:bold;
                justify-content: space-between;
            }
            .popup-body{
                padding-top:70px;
                padding-left:20px;
                font-size: 14px;
            }

            button{
                padding:8px 12px;
                margin-left:10px;
                border:none;
                border-radius:4px;
                cursor:pointer;
            }

        </style>

    </telerik:RadCodeBlock>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>
        <div>
        <table width="100%" cellpadding="0" cellspacing="0" class="ToolBar">
            <tr>
                <td valign="middle" align="left" class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" Width="180px" CssClass="popup-toolbar">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSave" ValidationGroup="Save"
                                CommandName="Save">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel">
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>
            </div>
       
            <div class="popup-body">
                <div> If you continue, a Change Event will be created linked to this record.</div>
                <div>Link these lines to the Change Event</div>
                <div style="padding-top:10px;">
                    
                    <input id="rdbAllLines" runat="server" type="radio" text="All Lines" name="linesOption" value="allLines" meta:resourcekey="rdbAllLines" checked />
                    <lable for="rdbAllLines" meta:resourcekey="rdbAllLines"> All Lines </lable>
                   
                    <br />
                    <input id="rdbNoLines" runat="server" type="radio"  name="linesOption" value="noLines" meta:resourcekey="rdbNoLines" />
                    <lable for="rdbNoLines" meta:resourcekey="rdbNoLines"> No Lines </lable>
                    
                    <br />
                    <input id="rdbSelectedlines" runat="server" type="radio" name="linesOption" value="selectedLines" meta:resourcekey="rdbSelectedlines" />
                    <lable for="rdbSelectedlines" meta:resourcekey="rdbSelectedlines"> Selected Lines Only </lable>
                </div>
             </div>
            </div>
    </form>
</body>
</html>
