<%@ Page meta:resourcekey="Page" Language="vb" AutoEventWireup="false" CodeBehind="WorkflowUserActivities.aspx.vb" Inherits="Website.WorkflowUserActivities" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">


    <style type="text/css">
        body {
            background: none !important;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 11px;
            color: #000000 !important;
            padding: 10px;
        }
    </style>

    <%-- <script language="javascript" type="text/javascript">
        function InformWorkflowUserActivities(message) {
            $("#message").html(message);
        }
    </script>--%>
</head>
<body>
    <form id="form1" runat="server">
        <div class="PMHeader">
            <div class="row">
                <div class="col-4">
                    <table class="colTable">
                        <tr>
                            <td>
                                <div id="message">
                                    <asp:Label ID="lblMessage" runat="server"></asp:Label>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
