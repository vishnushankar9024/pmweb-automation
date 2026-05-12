<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserList.aspx.cs" Inherits="PMWebConsumer.UserList" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Get All Users in Session</title>
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

    <h2>Users in Session</h2>
    <table id="usersTable">
        <thead>
            <tr>
                <th>Id</th>
                <th>Email</th>
                <th>Username</th>
                <th>Status</th>
                <th>Status Message</th>
            </tr>
        </thead>
        <tbody>
            <!-- Data will be populated here -->
        </tbody>
    </table>

    <script>
        // URL of the WebMethod
        const url = "https://cmcs.pmweb.com/pmweb/custom/pmwebhelper_test.aspx/GetUserListFromSession";

        // Function to fetch data from the web service
        function fetchUsersInSession() {
            fetch(url, {
                method: 'POST', // WebMethods require POST requests
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({}) // Empty body as no parameters are needed
            })
                .then(response => response.json())
                .then(result => {
                    const data = result.d; // Extract the 'd' property for WebMethods response
                    if (Array.isArray(data) && data.length > 0) {
                        populateTable(data);
                    } else {
                        populateErrorRow(); // Add a row for error
                    }
                })
                .catch(error => {
                    console.error('Error fetching data:', error);
                    populateErrorRow(); // Add a row for error
                });
        }

        // Function to populate the table with user data
        function populateTable(users) {
            const tableBody = document.getElementById('usersTable').getElementsByTagName('tbody')[0];
            tableBody.innerHTML = ''; // Clear any existing rows

            users.forEach(user => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${user.Id}</td>
                    <td>${user.Email}</td>
                    <td>${user.Username}</td>
                    <td>${user.Status}</td>
                    <td>${user.StatusMessage}</td>
                `;
                tableBody.appendChild(row);
            });
        }

        // Function to populate the table with an error row
        function populateErrorRow() {
            const tableBody = document.getElementById('usersTable').getElementsByTagName('tbody')[0];
            tableBody.innerHTML = ''; // Clear any existing rows

            const row = document.createElement('tr');
            row.innerHTML = `
                <td>0</td>
                <td>-----</td>
                <td>-----</td>
                <td>Error</td>
                <td>Error</td>
            `;
            tableBody.appendChild(row);
        }

        // Call the function to fetch users when the page loads
        fetchUsersInSession();
    </script>
</body>
</html>
