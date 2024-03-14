<%-- 
    Document   : cancelt
    Created on : 12-Mar-2024, 9:57:05 am
    Author     : hp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, java.sql.SQLException, java.sql.DriverManager" %>
<html>
<head>
    <title>Cancel Ticket</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        h2 {
            color: #333;
        }

        form {
            margin-bottom: 20px;
        }

        label {
            color: #555;
        }

        input[type="text"] {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }

        input[type="submit"] {
            padding: 8px 20px;
            background-color: #4caf50;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .scroll-view {
            height: 100px;
            width: 600px;
            overflow: auto;
            border: 1px solid #ccc;
            border-radius: 3px;
            padding: 10px;
            margin-bottom: 20px;
        }

        ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        li {
            margin-bottom: 5px;
        }

        .confirmation {
            padding: 10px;
        }
    </style>
</head>
<body>
    <h2>Cancel Ticket</h2>
    <form action="cancelt.jsp" method="post">
        Enter PNR Number: <input type="text" name="pnrNumber"  value="<%= (request.getParameter("pnrNumber") != null) ? request.getParameter("pnrNumber") : "000000" %>">
        <input type="submit" value="Submit">
    </form>   

    <label>Available Trains:</label>
    <div class="scroll-view">
        <ul>
            <% 
    String pnr = request.getParameter("pnrNumber");
    String DB_URL = "jdbc:mysql://localhost:3306/intern";
    String DB_USER = "root";
    String DB_PASSWORD = "Yash@2004";
    String query = "SELECT * FROM intern.booking WHERE pnr = ?";
    
    try (java.sql.Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
         java.sql.PreparedStatement statement = connection.prepareStatement(query)) {
        statement.setString(1, pnr);
        
        try (ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
%>
                <li>
                    <%= resultSet.getString("train_number") %>
                    - <%= resultSet.getString("from_station") %>
                    - <%= resultSet.getString("to_station") %>
                    - <%= resultSet.getString("date") %>
                </li>
<%
            }
        }
    } catch (SQLException e) {
        e.printStackTrace(); 
    }
%>

        </ul>
    </div>
    <div class="confirmation">
        <input type="hidden" name="pnr" value="<%= request.getParameter("pnrNumber") %>">
        <h3>Confirmation</h3>
        <p>Are you sure you want to cancel this ticket?</p>
        <form action="can" method="post">
            <input type="hidden" name="pnr" value="<%= request.getParameter("pnrNumber") %>">
            <input type="submit" value="Confirm Cancelation">
        </form>
    </div>
</body>
</html>
