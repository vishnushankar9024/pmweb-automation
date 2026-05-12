<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="AssignUserToTaskPopup.aspx.vb" Inherits="Website.AssignUserToTaskPopup"
    meta:resourcekey="Page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>
        <telerik:RadCodeBlock ID="CodeBlock" runat="server">
            <script src="JS/jQuery-v2.1.2.js" type="text/javascript"></script>
            <script src="JS/jQuery-migrate-1.1.1.js" type="text/javascript"></script>
            <script type="text/javascript">
                function AssignUserToTaskAndClose(TaskId, VisibleSection, AssignedToFullName) {
                    var RowEle = $(window.parent.document.getElementById('ABRow_' + TaskId));
                    if (!RowEle) return;
                    var AssignedToContainer = RowEle.find(".assignedToImg");
                    if (VisibleSection == "imgNoMember") {
                        if (RowEle.find(".EmptyImg").length == 0) {
                            AssignedToContainer.empty();
                            AssignedToContainer.append($('<div class="EmptyImg"></div>'));
                        }
                    } else if (VisibleSection == "divInitials") {
                        if (RowEle.find(".AssignedToInitials").length == 0) {
                            AssignedToContainer.empty();                         
                            AssignedToContainer.append($('<div class="AssignedToInitials">' + $('[id$=lblInitials]')[0].innerText + '<span class="Tooltip">' + AssignedToFullName + '</span></div>'));
                        } else {
                            AssignedToContainer.find('.AssignedToInitials').empty()
                            var initials= $('[id$=lblInitials]')[0].innerText;
                            AssignedToContainer.find('.AssignedToInitials').append($($('[id$=lblInitials]')[0].innerText + '<span class="Tooltip">' + AssignedToFullName + '</span>'));
                        }
                    } else {
                        if (RowEle.find(".imgAssignedTo").length == 0) {
                            AssignedToContainer.empty();                           
                            AssignedToContainer.append($('<div class="ToolTipDiv"><img src="' + $('.imageBox')[0].src + '" class="imgAssignedTo"  alt="" width="24px" height="24px"></img><span class="Tooltip">' + AssignedToFullName + '<span></div>'));
                        } else {
                            AssignedToContainer.find('.imgAssignedTo')[0].src = $('.imageBox')[0].src;
                        }
                    }
                    CloseRadWnd();
                }
            </script>
            <style>
                .initialsBox {
                    border: 1px solid #666666;
                    width: 238px;
                    height: 140px;
                    text-align: center;
                    padding-top: 98px;
                    display: inline-block;
                    font-size: 16pt;
                    border-radius: 50%;
                }

                .imageBox {
                    width: 240px;
                    height: 240px;
                    border-radius: 50%;
                }
            </style>
        </telerik:RadCodeBlock>
        <telerik:RadAjaxManager ID="PMAjaxManager" runat="server" EnablePageHeadUpdate="true">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="ddlAssignedTo">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="ddlAssignedTo" />
                        <telerik:AjaxUpdatedControl ControlID="divProfile" LoadingPanelID="ldpPM" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="ldpPM" runat="server" EnableSkinTransparency="true"
            BackgroundPosition="Center" Skin="Default" />
        <div class="ProfileTitle">
            
             <asp:label runat="server" ID="TitleUser"></asp:label>
    <asp:LinkButton runat="server" CssClass="closepopup closesize" ID="btnCloseProfilePopup" OnClientClick="window.close()">
        <div class="CloseProfilePopup closesize">
                                                                                 &nbsp;
                                                                            </div></asp:LinkButton>
    </div>
           
        <table class="ToolBar NewStylePopupToolbar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr valign="top">
                <td class="ToolbarTd">
                    <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                        <Items>
                            <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarSaveAndExit" CommandName="SaveAndExit"></telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
                </td>
            </tr>
        </table>

        <div class="PMMainPage PMPopupPage documentSinglePage TitleToolbarTop">
            <div class="row R24SidePadding">
                <div class="col-4">
                    <table class="colTable">
                        <tr>
                            <td class="labelWidth">
                                <asp:Label ID="lblAssignedTo" runat="server" Text="Assigned To" meta:resourcekey="lblAssignedTo"></asp:Label>
                            </td>
                            <td class="controlWidth" style="width: 240px !important;">
                                <telerik:RadComboBox ID="ddlAssignedTo" Filter="Contains" AllowCustomText="true"
                                    runat="server" Skin="Default" NoWrap="true" EnableLoadOnDemand="true" OnItemsRequested="ddl_ItemsRequested"
                                    ShowMoreResultsBox="True" AutoPostBack="true" EnableVirtualScrolling="True" Height="300px">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                    </table>
                    <div runat="server" id="divProfile" style="text-align: center; padding-top: 20px;">
                        <div id="divInitials" runat="server" class="initialsBox">
                            <asp:Label runat="server" ID="lblInitials"></asp:Label>
                        </div>

                        <asp:Image ID="imgNoMember" runat="server" CssClass="imageBox" src="CSS/Images/AssignUserNoMember.png" />

                        <asp:Image ID="imgMember" runat="server" CssClass="imageBox" />
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
