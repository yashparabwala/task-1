<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, java.sql.SQLException, java.sql.DriverManager" %>
<html>
<head>
    <title>Train List</title>
    <style>
        /* CSS styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .card {
            background-color: #fff;
            border: 1px solid #ddd;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 400px;
        }
        h2 {
            color: #333;
            margin-top: 0;
        }
        ul {
            list-style-type: none;
            padding: 0;
        }
        li {
            margin-bottom: 10px;
        }
        /* Style for the input field */
        input[type="text"] {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 3px;
            margin-bottom: 10px;
            width: 100%;
        }
        /* Style for the button */
        .button {
            padding: 10px 20px;
            background-color: #4caf50;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            text-align: center;
            display: block;
            margin: 20px auto 0;
            text-decoration: none;
        }
        .button:hover {
            background-color: #45a049;
        }
        .note {
    background-color: #f3f3f3; /* Light gray background color */
    border: 1px solid #ccc; /* Gray border */
    padding: 8px; /* Padding around the content */
    border-radius: 5px; /* Rounded corners */
    font-size: 12px; /* Small font size */
    color: #555; /* Text color */
    margin-bottom: 10px; /* Bottom margin */
}
    </style>
</head>
<body>
    <div class="card">
        <h2>Your Train Info </h2> 
        <ul>
            <% 
                String pnr = request.getParameter("pnr");
                String DB_URL = "jdbc:mysql://localhost:3306/intern";
                String DB_USER = "root";
                String DB_PASSWORD = "Yash@2004";
                String query = "SELECT * FROM intern.booking WHERE pnr=?";
                try (java.sql.Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                     java.sql.PreparedStatement statement = connection.prepareStatement(query)) {
                    statement.setString(1, pnr);
                    try (ResultSet resultSet = statement.executeQuery()) {
                        while (resultSet.next()) {
            %>
                            <li>
                                Train Number: <%= resultSet.getString("train_number") %><br>
                                Source: <%= resultSet.getString("from_station") %><br>
                                Destination: <%= resultSet.getString("to_station") %><br>
                                PNR: <%= resultSet.getString("pnr") %>
                            </li>
            <%
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace(); 
                }
            %>
        </ul>
        <div class = note>
        Note :- Remember your PNR
        </div>
        <!-- Button to go back to main.jsp page -->
        <a href="main.jsp" class="button">Go back to main page</a>
    </div>
</body>
</html>
