<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GetOnlineUsers.aspx.cs" Inherits="PMWebConsumer.GetOnlineUsers" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Users List</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
    </style>
</head>
<body>

    <h1>Online Users List</h1>

    <table id="usersTable">
        <thead>
            <tr>
                <th>Username</th>
                <th>DatabaseId</th>
                <th>IPAddress</th>
                <th>IsAuthenticated</th>
                <th>IsDeleted</th>
                <th>IsNamedLic</th>
                <th>LastActivityDate</th>
                <th>LastRequestUrl</th>
                <th>LicenseType</th>
                <th>LoginDate</th>
                <th>SessionId</th>
                <th>UserId</th>
            </tr>
        </thead>
        <tbody>
            <!-- Data will be populated here via JavaScript -->
        </tbody>
    </table>

    <script>
        // Function to fetch online users from the external WebMethod URL
        function getOnlineUsers() {
            $.ajax({
                url: 'https://cmcs.pmweb.com/pmweb/custom/pmwebhelper_test.aspx/GetOnlineUsers', // External WebMethod URL
                type: 'POST',
                data: JSON.stringify({}),
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (response) {
                    var onlineUsers = response.d; // Data from the WebMethod response
                    var tableBody = $('#usersTable tbody');
                    tableBody.empty(); // Clear any existing rows

                    // Iterate over the response and create rows for the table
                    $.each(onlineUsers, function (index, user) {
                        var row = '<tr>';
                        row += '<td>' + user.Username + '</td>';
                        row += '<td>' + user.DatabaseId + '</td>';
                        row += '<td>' + user.IPAddress + '</td>';
                        row += '<td>' + user.IsAuthenticated + '</td>';
                        row += '<td>' + user.IsDeleted + '</td>';
                        row += '<td>' + user.IsNamedLic + '</td>';
                        row += '<td>' + user.LastActivityDate + '</td>';
                        row += '<td>' + user.LastRequestUrl + '</td>';
                        row += '<td>' + user.LicenseType + '</td>';
                        row += '<td>' + user.LoginDate + '</td>';
                        row += '<td>' + user.SessionId + '</td>';
                        row += '<td>' + user.UserId + '</td>';
                        row += '</tr>';

                        tableBody.append(row); // Append the row to the table body
                    });
                },
                error: function (xhr, status, error) {
                    alert('Error: ' + error); // Handle any errors
                }
            });
        }

        // Call the function to load the online users when the page is loaded
        $(document).ready(function () {
            getOnlineUsers();
        });
    </script>

</body>
</html>
