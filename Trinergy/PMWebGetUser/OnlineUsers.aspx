<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OnlineUsers.aspx.cs" Inherits="PMWebConsumer.OnlineUsers" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Online Users List</title>
    <script type="text/javascript">
        // Function to call the WebMethod and get online users list from external URL
        function getOnlineUsers() {
            // URL of the external WebMethod
            var serviceUrl = "https://cmcs.pmweb.com/pmweb/custom/pmwebhelper_test.aspx/GetOnlineUsers";

            // Call the WebMethod using jQuery AJAX
            $.ajax({
                type: "GET",
                url: serviceUrl,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    // Parse the JSON response and populate the table
                    var onlineUsers = response.d; // response.d contains the data
                    var tableBody = $("#usersTable tbody");
                    tableBody.empty(); // Clear any existing rows

                    onlineUsers.forEach(function (user) {
                        // Create table row for each user
                        var row = "<tr>" +
                            "<td>" + user.SessionId + "</td>" +
                            "<td>" + user.DatabaseId + "</td>" +
                            "<td>" + user.Username + "</td>" +
                            "<td>" + user.LoginDate + "</td>" +
                            "<td>" + user.LastActivityDate + "</td>" +
                            "<td>" + user.LicenseType + "</td>" +
                            "<td>" + (user.IsAuthenticated ? "Yes" : "No") + "</td>" +
                            "<td>" + user.LastRequestUrl + "</td>" +
                            "<td>" + user.IPAddress + "</td>" +
                            "<td>" + (user.IsDeleted ? "Yes" : "No") + "</td>" +
                            "<td>" + (user.IsNamedLic ? "Yes" : "No") + "</td>" +
                            "</tr>";

                        // Append the row to the table body
                        tableBody.append(row);
                    });
                },
                error: function (xhr, status, error) {
                    alert("Error fetching data: " + error);
                }
            });
        }

        // Call the function when the page is ready
        $(document).ready(function () {
            getOnlineUsers(); // Fetch online users as soon as the page loads
        });
    </script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Online Users List</h2>
            <table id="usersTable" border="1" cellpadding="5" cellspacing="0">
                <thead>
                    <tr>
                        <th>SessionId</th>
                        <th>DatabaseId</th>
                        <th>Username</th>
                        <th>Login Date</th>
                        <th>Last Activity</th>
                        <th>License Type</th>
                        <th>Authenticated</th>
                        <th>Last Request URL</th>
                        <th>IP Address</th>
                        <th>Is Deleted</th>
                        <th>Is Named Lic</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Data will be populated here by JavaScript -->
                </tbody>
            </table>
        </div>
    </form>
</body>
</html>
