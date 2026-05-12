<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EmailDetailsFrame.aspx.vb" Inherits="Website.EmailDetailsFrame" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:DetailsView runat="server" ID="EmailDetailsView" AutoGenerateRows="false" CssClass="message-view"
                GridLines="None" EnableViewState="false">
                <Fields>
                    <asp:TemplateField ShowHeader="false">
                        <ItemTemplate>
                            <ul style="list-style-type: none">
                                <li>
                                    <h3 id="subject">
                                        <%# Eval("Subject") %></h3>
                                </li>
                                <li>
                                    <asp:Label runat="server" ID="lblFrom" Text="From: " meta:resourcekey="lblFrom"></asp:Label>
                                    <span id="from">
                                        <%# Eval("EmailFrom") %></span></li>
                                <li>
                                    <asp:Label runat="server" ID="lblTo" Text="To: " meta:resourcekey="lblTo"></asp:Label>
                                    <span id="To">
                                        <%# Eval("EmailTo") %></span></li>
                                <li>
                                    <asp:Label runat="server" ID="lblDate" Text="Sent: " meta:resourcekey="lblDate"></asp:Label>
                                    <span id="sent">
                                        <%# FormatDate(Eval("DeliveryDateTime")) + " " + FormatTime(Eval("DeliveryDateTime"))%></span></li>
                                <li>
                                    <div class="MaxWidth" style="display: inline-block">
                                        <div class="floatLeft">
                                            <asp:Label runat="server" ID="lblAttachments" Text="Attachments:" meta:resourcekey="lblAttachments"></asp:Label>&nbsp;
                                        </div>
                                        <asp:Repeater ID="rptEmailAttachments" runat="server">
                                            <ItemTemplate>
                                                <div class="floatLeft">
                                                    <a id="lkDownload" runat="server" href="#" onclick='<%# Me.GetUrlLinkForDownload(Eval("FullFileName"), False) %>'>
                                                        <%#Eval("FileWithExtension")%></a>&nbsp;
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                </li>
                            </ul>
                            <div id="message-body">
                                <%#Eval("Body").ToString().Replace("\n", "<br />")%>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Fields>
            </asp:DetailsView>

        </div>
    </form>
</body>
</html>
