import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.Statement;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author hp
 */
@WebServlet("/can")
public class can extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       resp.setContentType("text/html");
        String pnr=req.getParameter("pnr");
        System.out.println(pnr);
        String q="DELETE FROM `intern`.`booking` WHERE (`pnr` = '"+pnr+"');";
        try{
                Class.forName("com.mysql.cj.jdbc.Driver");
                java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/intern","root","Yash@2004");
                Statement st=con.createStatement();
                int rs = st.executeUpdate(q);
                    System.out.println("hello");
                    System.out.println(rs);
                    
                if(rs == 1){  
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
