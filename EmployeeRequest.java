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
@WebServlet(urlPatterns = {"/EmployeeRequest"})
public class EmployeeRequest extends HttpServlet {

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
        
        String Emp1 = request.getParameter("emp1");
        String Emp2 = request.getParameter("emp2");
        
         HttpSession session = request.getSession();
        
        try
        {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/Customer?zeroDateTimeBehavior=convertToNull","root","");
                
                    PreparedStatement ps1=con.prepareStatement("update CustomerDetails set EmployeeRequest = ? where UserID = ?");
                    
                    if(Emp1 == null)
                    {
                        ps1.setString(1,"No");
                        ps1.setString(2,Emp2);
                        ps1.executeUpdate();
                        
                        session.setAttribute("check","1");
                        session.setAttribute("message", "Rejected");
                        response.sendRedirect("WelcomeAdmin.jsp");
                    }
                    else
                    {
                        ps1.setString(1,"Yes");
                        ps1.setString(2,Emp1);
                        ps1.executeUpdate();
                        
                        session.setAttribute("check","1");
                        session.setAttribute("message", "Accepted");
                        response.sendRedirect("WelcomeAdmin.jsp");
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