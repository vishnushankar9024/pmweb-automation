<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SnapshotCompletePopup.aspx.vb" Inherits="Website.SnapshotCompletePopup" meta:resourcekey="Page" Title="Snapshot Complete!1" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server">
        </asp:ScriptManager>

   <table class="ToolBar" style="width: 100%; z-index: 999" cellpadding="0" cellspacing="0">
            <tr>
                <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" AutoPostBack="true" CssClass="popup-toolbar">
                                    <Items>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCheck" CommandName="OK"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton EnableImageSprite="true" CssClass="ToolbarCancel" CommandName="Cancel"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
            </tr>
        </table>

  <div class="PMMainPage">
                        <div class="row documentSinglePage">
                            <div class="col-4">
                                <table class="colTable">
                                    <tr>
                                        <td colspan="2">
                                            <asp:Label runat="server" ID="lblSnapshotComplete" Text="Your Snapshot is Complete" meta:resourcekey="lblSnapshotComplete"> </asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:Label runat="server" ID="lblToDo" Text="What would you like to do?" meta:resourcekey="lblToDo"> </asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                       <td colspan="2">
                                            <telerik:RadButton ID="rdbAttachToCurrentRecord" runat="server" ButtonType="ToggleButton" Text="Attach to the current record"
                                                GroupName="Snapshot" ToggleType="Radio" AutoPostBack="false" meta:resourcekey="rdbAttachToCurrentRecord" Checked="True">
                                            </telerik:RadButton>
                                            <br />
                                            <telerik:RadButton ID="rdbAttachToDifferentRecord" runat="server" ButtonType="ToggleButton"
                                                Text="Attached to a different record" GroupName="Snapshot" ToggleType="Radio" AutoPostBack="false" meta:resourcekey="rdbAttachToDifferentRecord">
                                            </telerik:RadButton>
                                            <br />
                                            <%--<telerik:RadButton  style="margin-left:40px;" ID="rdbCreateNew" runat="server" ButtonType="ToggleButton"
                                                Text="Create a new..." GroupName="Snapshot" ToggleType="Radio" AutoPostBack="false" meta:resourcekey="CreateNew"></telerik:RadButton><br />
                                           <telerik:RadComboBox runat="server" ID="ddlNewRecord" style="margin-left:80px;"  meta:resourcekey="NewRecord"></telerik:RadComboBox><br />--%>
                                            <telerik:RadButton ID="rdbCreateEmail" runat="server" ButtonType="ToggleButton"
                                                Text="Create an email" GroupName="Snapshot" ToggleType="Radio" AutoPostBack="false" meta:resourcekey="rdbCreateEmail">
                                            </telerik:RadButton>
                                            <br />
                                            <telerik:RadButton ID="rdbPrint" runat="server" ButtonType="ToggleButton"
                                                Text="Print" GroupName="Snapshot" ToggleType="Radio" AutoPostBack="false" meta:resourcekey="rdbPrint">
                                            </telerik:RadButton>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:Image runat="server" ID="imgScreenShot" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" ID="lblDescripion" meta:resourcekey="lblDescripion"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <asp:TextBox runat="server" ID="txtDescription" style="visibility: visible !important;"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>

        <div>
            <telerik:RadWindowManager ID="PMWindowManager" runat="server"  VisibleStatusbar="False" EnableEmbeddedSkins="false" EnableAjaxSkinRendering="false" EnableEmbeddedBaseStylesheet="false" EnableEmbeddedScripts="false"
                ReloadOnShow="True" Modal="True" KeepInScreenBounds="True" Behavior="Default"
                IconUrl="Images/Global/favicon.ico" InitialBehavior="None" Left="" Style="display: none;"
                Top="">
            </telerik:RadWindowManager>
        </div>
    </form>
</body>
</html>
