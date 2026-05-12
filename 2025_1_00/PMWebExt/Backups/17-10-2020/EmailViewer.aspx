<%@ Page Language="vb" AutoEventWireup="false" meta:resourcekey="Page" CodeBehind="EmailViewer.aspx.vb" Inherits="Website.EmailViewer" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <link href="CSS/EmailHome.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="PMHeader">
            <div class="row documentSinglePage">
                <div class="col-12">
                    <table class="colTable">
                        <asp:DetailsView runat="server" ID="EmailDetailsView" AutoGenerateRows="false" CssClass="message-viewPopup"
                            GridLines="None" EnableViewState="false" Style="padding-top: 0px">
                            <Fields>
                                <asp:TemplateField ShowHeader="false">
                                    <ItemTemplate>
                                        <table style="background-color: #E3EFFF; border: none; width: 100%">

                                            <tr>
                                                <td style="width: 75px">
                                                    <asp:Label runat="server" ID="lblFrom" Text="From: " meta:resourcekey="lblFrom"></asp:Label>
                                                </td>
                                                <td><span id="from"><%# Eval("EmailFrom") %></span></td>
                                                <td style="text-align: right" class="NoWrap">
                                                    <asp:Label runat="server" ID="lblDate" Text="Sent: " meta:resourcekey="lblDate"></asp:Label>
                                                    &nbsp;<span id="sent"> <%#Eval("DeliveryDate")%></span></td>

                                            </tr>
                                            <td>
                                                <asp:Label runat="server" ID="lblTo" Text="To: " meta:resourcekey="lblTo"></asp:Label></td>
                                            <td><span id="To"><%# Eval("EmailTo") %></span> </td>
                                            <td>&nbsp;</td>
                                            <tr>
                                                <td valign="top">
                                                    <asp:Label runat="server" ID="lblSubject" Text="Subject: " meta:resourcekey="lblSubject">
                                                    </asp:Label></td>
                                                <td colspan="2">
                                                    <span style="font-weight: bold; font-size: 105%">
                                                        <%# Eval("Subject") %></span></td>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td style="vertical-align: top">
                                                    <asp:Label runat="server" ID="lblAttachments" Text="Attachments:" meta:resourcekey="lblAttachments"></asp:Label>&nbsp;</td>
                                                <td colspan="2">
                                                    <asp:Repeater ID="rptEmailAttachments" runat="server">
                                                        <ItemTemplate>
                                                            <a id="lkDownload" runat="server" href="#" onclick='<%# Me.GetUrlLinkForDownload(Eval("FullFileName"), false) %>'>
                                                                <%#Eval("FileWithExtension")%></a>&nbsp;&nbsp; 
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </td>
                                            </tr>

                                        </table>

                                        <div id="message-body" style="border: solid 1px #6593CF;">
                                            <div style="background: URL('Images/Email/BodyMessageBg.png') repeat-x; padding: 10px"><%#Eval("Body").ToString().Replace("\n", "<br />")%> </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Fields>
                        </asp:DetailsView>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
