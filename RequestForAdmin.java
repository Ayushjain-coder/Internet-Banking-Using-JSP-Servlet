/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Ayush Jain
 */
@WebServlet(urlPatterns = {"/RequestForAdmin"})
public class RequestForAdmin extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
   protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try(PrintWriter out = response.getWriter())
        {
        
        String name = request.getParameter("Name");     
        String user = request.getParameter("UserID");
        String pass = request.getParameter("Password");
        String idproof = request.getParameter("IDProofNumber");
        String number = request.getParameter("Phone Number");
        
        HttpSession session = request.getSession();
        
        try
        {
                if(pass != null)
                {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/Customer?zeroDateTimeBehavior=convertToNull","root","");
                           
                    PreparedStatement ps=con.prepareStatement("select * from CustomerDetails where Password = ? and UserID = ? and Name = ? and Type = ?");                   
                    ps.setString(1,pass);
                    ps.setString(2,user);
                    ps.setString(3,name);
                    ps.setString(4,"Employee");
                    
                    ResultSet resultSet=ps.executeQuery();
                    
                    if(resultSet.next())
                    {
                       PreparedStatement ps1=con.prepareStatement("update CustomerDetails set Admin = ? where UserID = ? and Type = ? and  EmployeeRequest = ?");
                                ps1.setString(1,"Employee Request for Admin");
                                ps1.setString(2,user);
                                ps1.setString(3,"Employee");
                                ps1.setString(4,"Yes");
                                
                               int p = ps1.executeUpdate();
                        
                        if(p == 1)
                        {        
                        session.setAttribute("check","1");        
                        session.setAttribute("message", "Employee Request to Admin Successfully");
                        response.sendRedirect("WelcomeEmployee.jsp");
                        }
                        else
                        {
                        session.setAttribute("check","1");
                        session.setAttribute("message", "Incorrect Details");
                        response.sendRedirect("WelcomeEmployee.jsp");
                        }
                    }
                    else
                    {
                        session.setAttribute("check","1");
                        session.setAttribute("message", "Incorrect Details");
                        response.sendRedirect("WelcomeEmployee.jsp");
                    }
                }
        }
        catch(Exception ex)
        {
            out.println("Exception :"+ex.getMessage());
        }               
        }
    }


// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}