<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ActivityBoardAttachments.ascx.vb" Inherits="Website.ActivityBoardAttachments"
    meta:resourcekey="Page" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<telerik:radcodeblock id="CodeBlock" runat="server">
    <style>
        .initialsBox {
            border: 1px solid #666666;
            width: 28px;
            height: 23px;
            text-align: center;
            padding-top: 5px;
            display: inline-block;
        }

        .RecordTypeBtn {
            border: 1px solid #666666;
            text-align: center;
            color: #666666;
            line-height: 1.8;
            border-radius: 2px;
            background-color: #FFFFFF;
            vertical-align: central;
            min-height: 32px;
            height: auto;
            text-decoration: none;
            width: 100%;
            display: table-cell;
            cursor: pointer;
            border-radius: 5px;
            text-align: left;
        }

        .DownloadFiles {
            /*margin-bottom: 4px;*/
        }

        .DownloadFiles .Icon {
            background-image: url(CSS/Images/ResponsiveIcons/24Enabled.png) !important;
            background-position: -1393px 0px !important;
            display: inline-block !important;
            width: 24px !important;
            height: 24px !important;
            margin-right: 8px !important;
            margin-bottom: -8px;
            margin-left: 8px;
            margin-top: 3px;
        }

        .DocManager .Icon {
            background-image: url(CSS/Images/ResponsiveIcons/24Enabled.png) !important;
            background-position: 144px 0px !important;
            display: inline-block !important;
            width: 24px !important;
            height: 24px !important;
            margin-right: 8px !important;
            margin-bottom: -8px;
            margin-left: 8px;
            margin-top: 3px;
        }

        .PMRecord .Icon {
            background-image: url(CSS/Images/ResponsiveIcons/24Enabled.png) !important;
            background-position: -48px 0px !important;
            display: inline-block !important;
            width: 24px !important;
            height: 24px !important;
            margin-right: 8px !important;
            margin-bottom: -8px;
            margin-left: 8px;
            margin-top: 3px;
        }

        .URLIcon .Icon {
            background-image: url(CSS/Images/ResponsiveIcons/24Enabled.png) !important;
            background-position: -480px 0px !important;
            display: inline-block !important;
            width: 24px !important;
            height: 24px !important;
            margin-right: 8px !important;
            margin-bottom: -8px;
            margin-left: 8px;
            margin-top: 3px;
        }

        .imageBox {
            height: 190px;
            width: 270px;
            margin-bottom: 4px;
        }
    </style>
</telerik:radcodeblock>

<div style="max-height: calc(100vh - 180px) !important; overflow: auto; width: 400px;">
    <asp:Repeater ID="rptAttachments" runat="server">
        <ItemTemplate>
            <div style="margin-bottom: 24px;" id="eachDiv" runat="server">
                <table style="width: 100%;" class="colTable">
                    <tr>
                        <td style="width: 290px;">
                            <asp:Label runat="server" ID="lblAttachmentName" CssClass="lblAttachmentName"></asp:Label>
                        </td>
                        <td style="display: inline-block; float: right;">
                            <asp:Label ID="lblNumberOfLikes" runat="server"></asp:Label>
                            <asp:LinkButton runat="server" ID="btnLike" CssClass="SearchButton" Style="float: right; margin-left: 8px;">
                            <span class="Icon"></span>
                            </asp:LinkButton>
                            <asp:HiddenField runat="server" ID="hdfIsLiked" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Label runat="server" ID="lblFullName" CssClass="lblFullName"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Label runat="server" ID="lblPostDate" CssClass="lblPostDate"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Image ID="imgAttachment" runat="server" CssClass="imageBox" src="../CSS/Images/hsbPalette.jpg" ToolTip="Download" Visible="false" />
                            <asp:LinkButton ID="btnDownloadFiles" runat="server" CssClass="DownloadFiles RecordTypeBtn" Width="120px" Visible="false">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDownloadFiles" runat="server" meta:resourcekey="lblDownloadFiles"></asp:Label>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDocManager" runat="server" CssClass="DocManager RecordTypeBtn" Width="220px" Visible="false">
                                <span class="Icon"></span>
                                <asp:Label ID="lblDocManager" runat="server" meta:resourcekey="lblDocManager"></asp:Label>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnPMWebRecord" runat="server" CssClass="PMRecord RecordTypeBtn" Width="200px" Visible="false">
                                <span class="Icon"></span>
                                <asp:Label ID="lblPMWebRecord" runat="server" meta:resourcekey="lblPMWebRecord"></asp:Label>
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnUrl" runat="server" CssClass="URLIcon RecordTypeBtn" Width="150px" Visible="false">
                                <span class="Icon"></span>
                                <asp:Label ID="lblUrl" runat="server" meta:resourcekey="lblUrl"></asp:Label>
                            </asp:LinkButton>
                        </td>
                        <td style="position: relative;">
                            <div style="display: block; top: 0px; right:0px;">
                                <asp:Button ID="btnCover" runat="server" Text="Cover" Visible="false" Style="margin-bottom: 5px; width: 80px;"></asp:Button>
                                <asp:Button ID="btnNotCover" runat="server" Text="Not Cover" Visible="false" Style="margin-bottom: 5px; width: 80px;"></asp:Button>
                            </div>
                            <div style="display: block; bottom: 5px; right:0px;">
                                <asp:Button ID="btnDelete" runat="server" Text="Delete" Style="width: 80px;" OnClientClick="if(!ConfirmDelete()) return false;"></asp:Button>
                                <asp:HiddenField runat="server" ID="hdfIsCover" />
                                <asp:HiddenField runat="server" ID="hdfAttachmentId" />
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</div>










