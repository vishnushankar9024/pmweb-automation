<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Home_PDFViewer.aspx.vb" Inherits="Website.Home_PDFViewer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="CSS/ControlsCSS/Toolbar.css" rel="stylesheet" />
</head>
<body>
    
    <form id="form1" runat="server">
        <asp:ScriptManager ID="PMScriptManager" runat="server"></asp:ScriptManager>

                    <telerik:RadToolBar ID="mainToolBar"  Width="100%" runat="server" Skin="Default" AutoPostBack="true" CssClass="drawing-viewer-toolbar">
                        <Items>
                           <telerik:RadToolBarButton CommandName="Previous" CssClass="ToolbarPrevious" EnableImageSprite="true">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton CommandName="Next" CssClass="ToolbarNext" EnableImageSprite="true">
                            </telerik:RadToolBarButton>
                            <telerik:RadToolBarButton PostBack="false">
                                <ItemTemplate>
                                    <asp:TextBox runat="server" ID="txtPage" Width="35px" ValidationGroup="Paging" CausesValidation="true" CssClass="PositiveInteger" OnTextChanged="LoadPDFPage" AutoPostBack="true" Text="1">

                                    </asp:TextBox>
                                    <asp:RangeValidator ID="rgvalPages" runat="server" CssClass="validator" ErrorMessage="*" Type="Integer" ValidationGroup="Paging" MinimumValue="1" ControlToValidate="txtPage"></asp:RangeValidator>
                                    <asp:Label ID="Label1" runat="server" Text="of" meta:Resourcekey="lblOff"> </asp:Label><asp:Label runat="server" ID="lblPage" Style="margin-left: 5px;"></asp:Label>
                                </ItemTemplate>
                            </telerik:RadToolBarButton>
                        </Items>
                    </telerik:RadToolBar>
 
                    <div id="Canvas" style="cursor: default;top: 0px; left: 0px;">
                        <asp:Image ID="imgCanvas" runat="server" />
                    </div>


    </form>
</body>
</html>
