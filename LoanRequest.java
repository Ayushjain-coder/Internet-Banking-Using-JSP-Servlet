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
@WebServlet(urlPatterns = {"/LoanRequest"})
public class LoanRequest extends HttpServlet {

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
        
        String Loan1 = request.getParameter("loan1");
        String Loan2 = request.getParameter("loan2");
        String Loan3 = request.getParameter("loan3");
        String Loan4 = request.getParameter("loan4");
        
         HttpSession session = request.getSession();
        
        try
        {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/Customer?zeroDateTimeBehavior=convertToNull","root","");
                
                    PreparedStatement ps1=con.prepareStatement("update AccountInfo set LoanRequest = ? where AccountNumber = ?");
                    
                    if(Loan1 == null && Loan3 == null)
                    { 
                        ps1.setString(1,"Reject");
                        ps1.setString(2,Loan2);
                        ps1.executeUpdate();
                        
                        session.setAttribute("check","1");
                        session.setAttribute("message", "Rejected");
                        response.sendRedirect("WelcomeAdmin.jsp");
                    }
                    if(Loan2 == null && Loan4 == null)
                    { 
                        ps1.setString(1,"Accept");
                        ps1.setString(2,Loan1);
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