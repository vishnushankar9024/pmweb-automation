<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Comments.ascx.vb" Inherits="Website.Comments" %>

<style type="text/css">
    .tblComments span.Icon {
        float: right !important;
    }

    .tblComments{
        width: 333px !important;
    }
    .divProfilePicture {
        display: inline-block;
        
    }

    .rapComments.RadAjaxPanel {
        vertical-align: top;
        display: inline-block !important;
    }

    .divInitials {
        height: 40px;
        width: 40px;
        line-height: 40px;
        text-align: center;
        text-transform: uppercase;
        border: 1px solid #666666;
        display: inline-block;
        border-radius: 50%;
    }

    .imgProfile {
        height: 40px;
        width: 40px;
        border-radius: 50%;
    }

    .lblLikes {
        /*padding-top: 5px;*/
        color: #666666;
        float: right;
        height:16px;
        line-height:16px;
    }

    .lblPostDate {
        vertical-align: text-bottom;
        color: #666666;
    }



    .trSpace {
        Height: 5px;
    }

    .tdLikesNb {
        width: 14px !important;
        float: right !important;
    }

    .tdLikesBtn {
        width: 16px;
    }

    .tdComments {
        width: 158px;
    }

    .commentStyle {
        line-height: 14px !important;
        text-decoration: none !important;
        color: #666666 !important;
    }
</style>


<div style="max-height: calc(100vh - 180px) !important; overflow: auto;">
    <asp:Repeater ID="rptComments" runat="server">
        <ItemTemplate>
            <div class="commentContainer">
                <div class="divProfilePicture" runat="server" style="float: left; margin-right: 8px;">
                    <div class="divInitials" id="divInitials" runat="server">
                        <asp:Label ID="lblInitials" runat="server"></asp:Label>
                    </div>
                    <asp:Image runat="server" CssClass="imgProfile" ID="imgProfile" />
                </div>
                <telerik:radajaxpanel runat="server" class="rapComments" style="float: right;" enableAjax="false">
                    <table id="tblComments" class="tblComments">
                        <tr style="vertical-align: middle">
                            <td style="width: 160px;">
                                <asp:Label runat="server" ID="lblMemberName"></asp:Label>
                            </td>
                            <td class="tdLikesNb">
                                <asp:Label runat="server" CssClass="lblLikes" ID="lblLikes"></asp:Label>
                            </td>

                            <td class="tdLikesBtn">
                                <asp:LinkButton runat="server" ID="btnLike" CssClass="SearchButton">
                              <span class="Icon"></span>
                                </asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdComments" colspan="3">
                                <asp:LinkButton runat="server" ID="lbtCommentText" CssClass="commentStyle">
                                </asp:LinkButton>
                            </td>
                        </tr>
                        <tr class="trSpace">
                        </tr>
                        <tr>
                            <td>
                                <asp:Label runat="server" CssClass="lblPostDate" ID="lblPostDate"></asp:Label>
                            </td>
                        </tr>

                        <asp:HiddenField runat="server" ID="hdfCommentId" />
                        <asp:HiddenField runat="server" ID="hdfIsLiked" />
                    </table>
                </telerik:radajaxpanel>
            </div>
            <div style="clear: both;"></div>
            <br />

        </ItemTemplate>
    </asp:Repeater>


</div>
