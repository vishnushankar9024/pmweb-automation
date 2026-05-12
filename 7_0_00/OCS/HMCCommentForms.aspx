<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HMCCommentForms.aspx.cs" Inherits="SyosysWap.HMCCommentForms" %>

<html>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="form-group" id="divTitle" runat="server">
                <label for="recipient-name" class="col-form-label">Title:</label>
                <asp:TextBox ID="txtTitle" runat="server" Style="width: 100%" CssClass="form-control" onchange="TitleChange(this)"></asp:TextBox>
            </div>
            <div class="form-group" id="divConsultantComments" runat="server">
                <label for="message-text" class="col-form-label"> Consultants Comments:</label>
                <asp:TextBox ID="txtConsultantComments" runat="server" TextMode="MultiLine" Style="width: 100%; height: 150px;" CssClass="form-control" onchange="CommentChange(this)"></asp:TextBox>
            </div>
            <div class="form-group" id="divComments" runat="server">
                <label for="message-text" class="col-form-label">Comments:</label>
                <asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" Style="width: 100%; height: 80px;" CssClass="form-control" onchange="HMCCommentChange(this)"></asp:TextBox>
            </div>
             <p>
                <asp:Label ID="lblComments" runat="server" Text=""></asp:Label>
            </p>
        </div>
    </form>
</body>
</html>
