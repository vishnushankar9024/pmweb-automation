<%@ Page Language="vb" AutoEventWireup="false" meta:resourcekey="Page" CodeBehind="PMWebViewerNotePopup.aspx.vb" Inherits="Website.PMWebViewerNotePopup" %>

<!DOCTYPE html>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
</head>
<body>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">

            var isBold;
            var isItalic;
            var fontSize = '11px';
            var NoteId = '';

            function Fill() {
                var txtNotes = document.getElementById('<%=txtNotes.ClientID%>');
                var txtTitle = document.getElementById('<%=txtTitle.ClientID%>');
                var hdnNotes = $(window.parent.document).find("[id$=hdnNotes]");
                if (hdnNotes.val() != '') {
                    var Notes = hdnNotes.val().split('~!@');
                    // hdnNotes.val('');
                    NoteId = Notes[0];
                    txtTitle.value = Notes[1];
                    txtNotes.value = Notes[2];
                    txtTitle.style.fontWeight = Notes[4];
                    txtNotes.style.fontWeight = Notes[4];
                    txtTitle.style.fontStyle = Notes[5];
                    txtNotes.style.fontStyle = Notes[5];
                    txtNotes.style.fontSize = Notes[3];
                    fontSize = Notes[3];

                }
            }

            function changeSize(sender, args) {
                var txt = document.getElementById('<%=txtNotes.ClientID%>');
                txt.style.fontSize = sender.get_value();
                fontSize = sender.get_value();
            }

            function toolbarLoad(sender, args) {
                var txt = document.getElementById('<%=txtNotes.ClientID%>');
                var BoldButton = sender.findItemByValue("Bold");
                var ItalicButton = sender.findItemByValue("Italic");
                isBold = txt.style.fontWeight == "normal" || txt.style.fontWeight == "" ? false : true;
                isItalic = txt.style.fontStyle == "normal" || txt.style.fontStyle == "" ? false : true;



                if (isBold) {
                    BoldButton._linkElement.className = BoldButton._linkElement.className + ' rtbItemFocused';
                }
                else {
                    BoldButton._linkElement.className = BoldButton._linkElement.className.toString().replace(' rtbItemFocused', '');
                }

                if (isItalic) {
                    ItalicButton._linkElement.className = ItalicButton._linkElement.className + ' rtbItemFocused';
                }
                else {
                    ItalicButton._linkElement.className = ItalicButton._linkElement.className.toString().replace(' rtbItemFocused', '');
                }
                //BoldButton._setChecked(isBold);
                //ItalicButton._setChecked(isItalic);



                //$('[id$=ddlSize]').val('18px');
                //$('[id$=ddlSize]').text('18px');

                //$.find('mainToolBar_i2_ddlSize_Input').value = '18px';
                //$.find('mainToolBar_i2_ddlSize_Input').text = '18px';

                //$("input[id$=ddlSize]").value = '18px';
                //$("input[id$=ddlSize]").text = '18px';

                //var a = $("select[id=ddlSize]").find("option:selected").val();

                //$.find('ddlSize').set_text = '19px';
                //$.find('ddlSize').set_value = '19px';

                //$('mainToolBar$i2$ddlSize').value = '18px';


                //$('mainToolBar_i2_ddlSize_Input').value = '18px';

            }
            function OnddlSizeClientLoad(sender, args) {
                sender.set_value(fontSize);
                sender.set_text(fontSize);
            }

            function toolbarclicked(sender, args) {
                var hdnNotes = $(window.parent.document).find("[id$=hdnNotes]");
                switch (args.get_item().get_commandName()) {
                    case 'Cancel':
                        hdnNotes.val('');
                        setTimeout("var oWnd = GetRadWindow();oWnd.close();", 500);
                        break;
                    case 'Save':
                        hdnNotes.val('');
                        var txt = document.getElementById('<%= txtNotes.ClientID%>');
                        var title = document.getElementById('<%=txtTitle.ClientID%>');
                        var NoteTitle = title.value;
                        var NoteDesc = txt.value;
                        var fontWeight;
                        var fontStyle;
                        isBold = txt.style.fontWeight == "normal" || txt.style.fontWeight == "" ? false : true;
                        isItalic = txt.style.fontStyle == "normal" || txt.style.fontStyle == "" ? false : true;
                        if (isBold)
                        { fontWeight = "Bold"; }
                        else { fontWeight = "Normal"; }
                        if (isItalic)
                        { fontStyle = "Italic" }
                        else
                        { fontStyle = "Normal" }
                        var NoteFont = fontSize + ';' + fontWeight + ';' + fontStyle;
                        var src = '<%= QueryStringSource %>'
                        if (src == 'Menu')
                        { window.parent.AddNoteFromMenu(NoteId, NoteTitle, NoteDesc, NoteFont); }
                        else
                        {
                            window.parent.NoteClicked(NoteId, NoteTitle, NoteDesc, NoteFont);
                        }
                        setTimeout("var oWnd = GetRadWindow();oWnd.close();", 500);
                        break;
                    case 'Bold':
                        isBold = !isBold;
                        var txt = document.getElementById('<%= txtNotes.ClientID%>')
                var title = document.getElementById('<%=txtTitle.ClientID%>');
                if (isBold) {
                    txt.style.fontWeight = "bold";
                    title.style.fontWeight = "bold";
                    args.get_item()._linkElement.className = args.get_item()._linkElement.className + ' rtbItemFocused';
                }
                else {
                    txt.style.fontWeight = "";
                    title.style.fontWeight = "";
                    args.get_item()._linkElement.className = args.get_item()._linkElement.className.toString().replace(' rtbItemFocused', '');
                }
                args.get_item().blur();


                break;
            case 'Italic':
                var txt = document.getElementById('<%= txtNotes.ClientID%>');
                var title = document.getElementById('<%=txtTitle.ClientID%>');
                isItalic = !isItalic;
                if (isItalic) {
                    txt.style.fontStyle = "italic";
                    title.style.fontStyle = "italic";
                    args.get_item()._linkElement.className = args.get_item()._linkElement.className + ' rtbItemFocused';

                }
                else {
                    txt.style.fontStyle = "";
                    title.style.fontStyle = "";
                    args.get_item()._linkElement.className = args.get_item()._linkElement.className.toString().replace(' rtbItemFocused', '');

                }
                args.get_item().blur();
                break;
        }
    }

    function GetRadWindow() {
        var oWindow = null;
        if (window.radWindow) oWindow = window.radWindow;
        else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow;
        return oWindow;
    }


        </script>

    </telerik:RadCodeBlock>
    <form id="form1" runat="server">
        <table class="ToolBar" style="width: 100%;" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table style="width: 100%;" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="ToolbarTd">
                                <telerik:RadToolBar ID="mainToolBar" runat="server" Skin="Default" OnClientLoad="toolbarLoad" OnClientButtonClicked="toolbarclicked" AutoPostBack="true" Width="100%">
                                    <Items>
                                        <telerik:RadToolBarButton CommandName="Save" EnableImageSprite="true" PostBack="false" CssClass="ToolbarSaveAndExit" Value="Save"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CommandName="Cancel" EnableImageSprite="true" PostBack="false" CssClass="ToolbarCancel"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton>
                                            <ItemTemplate>
                                                <telerik:RadComboBox runat="server" OnClientSelectedIndexChanged="changeSize" Width="120px" OnClientLoad="OnddlSizeClientLoad" ID="ddlSize" AutoPostBack="false" style="margin-left:24px;margin-right:21px">
                                                </telerik:RadComboBox>
                                            </ItemTemplate>
                                        </telerik:RadToolBarButton>

                                        <telerik:RadToolBarButton CommandName="Bold" EnableImageSprite="true" PostBack="false" Value="Bold" CssClass="ToolbarBold"></telerik:RadToolBarButton>
                                        <telerik:RadToolBarButton CommandName="Italic" EnableImageSprite="true" PostBack="false" Value="Italic" CssClass="ToolbarItalic"></telerik:RadToolBarButton>
                                    </Items>
                                </telerik:RadToolBar>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>

        <table style="width: 100%;" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>
                        <div class="PMMainPage PMPopupMainPage documentSinglePage" style="margin-bottom:0">
                            <div class="row" style="min-width:100px !important">
                            <div class="col-12">
                                <table class="colTable" border="0" style="padding-right: 24px;padding-left: 24px;">
                                    <tr>
                                        <td class="labelWidth">
                                            <asp:Label runat="server" meta:resourcekey="lblTitle" Text="Title1"></asp:Label>
                                        </td>
                                        <td class="controlWidth">
                                            <input type="text" runat="server" id="txtTitle"/>
                                        </td>
                                    </tr>  
                                    <tr>
                                        <td colspan="2">
                                            <textarea id="txtNotes" runat="server"> </textarea>
                                                <asp:Label ID="lblMsg" runat="server" meta:Resourcekey="lblMsg" style="margin-top: 24px;display: block;color: #666666;"> </asp:Label>
                                        </td>
                                    </tr> 
                                </table>
                            </div>
                           </div>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
