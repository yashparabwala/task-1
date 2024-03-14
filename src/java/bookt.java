
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.Random;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author hp
 */
@WebServlet("/bookt")
public class bookt extends HttpServlet{
    private String generatePNR() {
        Random rand = new Random();
        int pnr = rand.nextInt(900000) + 100000;
        return String.valueOf(pnr);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String trainNumber = req.getParameter("trainNumber"); // Replace "trainNumber" with the actual parameter name
        String fromStation = req.getParameter("fromStation"); // Replace "fromStation" with the actual parameter name
        String toStation = req.getParameter("toStation"); // Replace "toStation" with the actual parameter name
        String date = req.getParameter("date"); // Replace "date" with the actual parameter name
        String className = req.getParameter("class"); // Replace "class" with the actual parameter name
        String pnr = generatePNR();
        // Database connection and insertion
        String DB_URL = "jdbc:mysql://localhost:3306/intern";
        String DB_USER = "root";
        String DB_PASSWORD = "Yash@2004";
        String query = "INSERT INTO intern.booking (pnr, train_number, from_station, to_station, date, class) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (java.sql.Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            java.sql.PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, pnr);
            statement.setString(2, trainNumber);
            statement.setString(3, fromStation);
            statement.setString(4, toStation);
            statement.setString(5, date);
            statement.setString(6, className);

            int rowsInserted = statement.executeUpdate();
            if (rowsInserted > 0) {
                resp.sendRedirect("showt.jsp?pnr="+pnr);
            }
        } catch (SQLException e) {
            resp.getWriter().println("Error: " + e.getMessage());
        }
        // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }
    
}
