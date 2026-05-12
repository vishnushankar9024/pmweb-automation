<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PMWebConsumer.Default" %>


<!DOCTYPE html>
<html>
<head runat="server">
    <title>PMWeb API Consumer</title>
</head>
<body>
    <form id="form1" runat="server">
        <h2>PMWeb API Consumer</h2>
        <button type="button" id="btnGetUser" onclick="getUser()">Get User Info</button>
        <div id="result"></div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script>
            function getUser() {
                $.ajax({
                    url: "https://cmcs.pmweb.com/7_0_00/pmweb/custom/pmwebhelper.aspx/GetAllUsersInSession",
                    method: "GET",
                    dataType: "json",
                    success: function (response) {
                        $("#result").html(`
                            <p><b>User ID:</b> ${response.Id}</p>
                            <p><b>Email:</b> ${response.Email}</p>
                            <p><b>Username:</b> ${response.Username}</p>
                        `);
                    },
                    error: function (error) {
                        console.error("Error:", error);
                        alert("Failed to retrieve user information.");
                    }
                });
            }
        </script>
    </form>
</body>
</html>
