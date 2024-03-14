<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>TODO supply a title</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .card {
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin: 0 10px;
            width: 300px;
            height: 455px;
        }

        .card:nth-child(2) {
            margin-left: 20px; /* Add margin between cards */
        }

        ul {
            list-style: none;
            padding: 0;
        }
        li{
            margin: 10px;
        }

        label {
            color: #555;
        }

        input[type="text"],
        input[type="date"],
        select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 3px;
            box-sizing: border-box;
        }

        select {
            cursor: pointer;
        }

        .button {
            background-color: #4caf50;
            color: #fff;
            border: none;
            border-radius: 3px;
            padding: 10px 20px;
            cursor: pointer;
            width: 100%;
        }

        .button:hover {
            background-color: #45a049;
        }
        .scroll-view {
            height: 308px; /* Adjust height as needed */
            width: 310px;
            overflow: auto;
        }
        .button.c {
        padding: 2px 10px; /* Adjust padding to make the button smaller */
        font-size: 10px; /* Adjust font size to make the button smaller */
        background-color: #f44336; /* Red color */
        border: none;
        border-radius: 3px;
        color: white;
        cursor: pointer;        
        margin-left: 180px;        
        height: 15px;
        width: 120px;
        margin-top: 5px;    
    
    }

    /* Style for hover effect */
    .button.c:hover {
        background-color: #d32f2f; /* Darker red color */
    }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <form action="bookt" method="post">
                <ul>
                    <li class="fsize"> Train Number &emsp;<input type="text" name="trainNumber" placeholder="Number"> </li>
                    <li class="fsize"> From &emsp;<input type="text" name="fromStation" placeholder="From"> </li>
                    <li class="fsize"> To &emsp;<input type="text" name="toStation" placeholder="To"> </li>
                    <li class="fsize"> Date&emsp;<input type="date" name="date" placeholder="dd-mm-yy"> </li>
                </ul>
                <label for="user">Class:</label>
                <select id="class" name="class">
                    <option value="select">SELECT</option>
                    <option value="1AC">1AC</option>
                    <option value="2AC">2AC</option>
                    <option value="3AC">3AC</option>
                    <option value="Sleeper">Sleeper</option>
                    <option value="Chair">Chair</option>
                </select>
                <br>
                <button class="button" type="submit" >Book Trains</button>
            </form>
            <form action="cancelt.jsp" method="post"> 
                <button class="button c" type="submit">Cancel Ticket</button> <!-- Button to cancel ticket -->
            </form>
        </div>
        <div class="card">
            <form action="main.jsp" method="post">
                <label for="station">Station Name:</label>
                <input type="text" id="station" name="station" placeholder="Enter station name" value="<%= (request.getParameter("station") != null) ? request.getParameter("station") : "Ahmedabad JN" %>">

                <br>
                <label>Available Trains:</label>
                <div class="scroll-view">
                    <ul>
                    <% 
                        String sta = request.getParameter("station");
                        String DB_URL = "jdbc:mysql://localhost:3306/intern";
                        String DB_USER = "root";
                        String DB_PASSWORD = "Yash@2004";
                        String query = "SELECT * FROM intern.trains where source='" + sta + "'";

                        try (java.sql.Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                             java.sql.PreparedStatement statement = connection.prepareStatement(query);
                             java.sql.ResultSet resultSet = statement.executeQuery()) {
                
                        while (resultSet.next()) {
                    %>
                            <li>
                                <%out.print(resultSet.getString("train_number"));%>
                                <%out.print(" - "+resultSet.getString("train_name"));%>
                            </li>
                    <%
                        }
                    } catch (SQLException e) {
                        e.printStackTrace(); 
                    }
                    %>
                    </ul>
                </div>
                <br>
                <input class="button" type="submit" value="Submit">
            </form>
        </div>
    </div>
</body>
</html>