<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CommentDialogPopup.aspx.vb" Inherits="Website.CommentDialogPopup"
    meta:resourcekey="Page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <style type="text/css">

        .reLeftVerticalSide, .reRightVerticalSide {
            display:none;
         }
        .reLayoutWrapper td.reContentCell iframe {
            height: 324px !important;
        }

       .edtComments{
           margin-top:5px;
            height: 355px !important;

       }

       .edtCommentsDisabled{
           overflow: auto;
           background-color: #EDEDED;
           border: 1px solid #666;
           padding: 4px;
           width: calc(100% - 10px)!important;
           height: calc(100vh - 155px)!important;
       }
       .Default.RadEditor td.reContentCell {
            height: 324px !important;
        }

       .col-4 .RadEditor .reLayoutWrapper {
            background-color: white;
        }
       .Default.reWrapper {
            border: none !important;
        }
       .reEditorModes{
           display:none !important;
       }

       .RadEditor .reToolZone{
            height: 5px;
            font-size: 5px;
       }
        .errorMessage{
            color:red;
        }
        .reToolbar:first-child li:nth-of-type(3) a {
            width:24px !important;
        }
  /*.reToolbar:first-child .reToolLastItem{
            margin-left:0px !important;
        }

        .reToolbar:first-child li:nth-of-type(3){
            margin-left:0px !important;
        }*/
    </style>
</head>
<body>
    <script type="text/javascript">
        function OnClientLoad(editor, args) {
            var toolAdapter = editor.get_toolAdapter();
            toolAdapter.enableContextMenus(false);
        }
    </script>
    <form id="form1" runat="server">
        <div id="ProfileTitle" class="ProfileTitle" runat="server">
            
             <asp:label runat="server" ID="TitleUser"></asp:label>
    <asp:LinkButton runat="server" CssClass="closepopup closesize" ID="btnCloseProfilePopup" OnClientClick="window.close()">
        <div class="CloseProfilePopup closesize">
                                                                                 &nbsp;
                                                                            </div></asp:LinkButton>
    </div>
        <div>
            <table class="ToolBar NewStylePopupToolbar" style="width: 100%;" cellpadding="0" cellspacing="0" runat="server" id="ToolBar">
                <tr>
                    <td>
                        <table style="width: 100%;" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="ToolbarTd">
                                    <telerik:RadToolBar ID="mainToolBar" Width="100%" runat="server" Skin="Default" AutoPostBack="true">
                                        <Items>
                                            <telerik:RadToolBarButton ValidationGroup="SaveAndExit" CommandName="SaveAndExit"  EnableImageSprite="true" CssClass="ToolbarSaveAndExit"
                                                Value="SaveAndExit" ToolTip="Save & Exit">
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton  CommandName="Close" EnableImageSprite="true" CssClass="ToolbarCancel"
                                                Value="Close" ToolTip="Close">  
                                            </telerik:RadToolBarButton>
                                            <telerik:RadToolBarButton SecurityButtonType="Delete" CommandName="Delete" EnableImageSprite="true" CssClass="ToolbarDelete"
                                                Value="Delete" ToolTip="Delete">
                                            </telerik:RadToolBarButton>
                                        </Items>
                                    </telerik:RadToolBar>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <div class="PMMainPage PMPopupMainPage documentSinglePage R24SidePadding TitleToolbarTop" runat="server" id="divComment">

                <div class="row">

                    <div class="col-4">
                        <asp:Label runat="server" ID="lblErrorMessage" CssClass="errorMessage"/>
                        <telerik:RadEditor ID="edtComments" Skin="Default" runat="server" Width="100%" CssClass="edtComments" OnClientLoad="OnClientLoad" ToolsFile="~/ToolsFile_Comments.xml" DialogsScriptFile="~/JS/RadEditorDialog.js" DialogsCssFile="CSS/ControlsCSS/FormDecoratorLite.css" >
                            <Content></Content>
                        </telerik:RadEditor>
                    </div>
                </div>
            </div>

        </div>
    </form>
</body>
</html>
