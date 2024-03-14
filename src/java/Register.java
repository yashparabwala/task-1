/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.Statement;

/**
 *
 * @author hp
 */
@WebServlet(urlPatterns = {"/Register"})
public class Register extends HttpServlet {
 @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        String user=req.getParameter("user");
        String pass=req.getParameter("pass");        
        String q="INSERT INTO `intern`.`user` (`user`, `pass`) VALUES ('"+user+"', '"+pass+"');";
        try{
                Class.forName("com.mysql.cj.jdbc.Driver");
                java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/intern","root","Yash@2004");
                Statement st=con.createStatement();
                int m = st.executeUpdate(q);
                if (m==1){
                    st.close();
                    RequestDispatcher ds = req.getRequestDispatcher("main.jsp");
                    ds.include(req, resp);
                } else {
                }
            }
            catch (Exception e){
                System.out.println(e.getMessage());
            }
        // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }    
   
}
