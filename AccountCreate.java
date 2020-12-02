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
@WebServlet(urlPatterns = {"/AccountCreate"})
public class AccountCreate extends HttpServlet {

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
        
        String accnumber = request.getParameter("AccountNumber");
        String name = request.getParameter("Name");     
        String pass = request.getParameter("Password");
        String number = request.getParameter("PhoneNumber");
        String acctype = request.getParameter("AccountType");
        String amount = request.getParameter("Amount");
        
        HttpSession session = request.getSession();
        String user = (String)session.getAttribute("username");
        
        try
        {
                if(pass != null)
                {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/Customer?zeroDateTimeBehavior=convertToNull","root","");
                           
                    PreparedStatement ps=con.prepareStatement("select * from CustomerDetails where Password = ? and UserID = ? and PhoneNumber = ? and Name = ?");
                    PreparedStatement ps2=con.prepareStatement("select * from AccountInfo where UserID = ? && AccountNumber = ? && AccountType = ?");                   
                    ps.setString(1,pass);
                    ps.setString(2,user);
                    ps.setString(3,number);
                    ps.setString(4,name);
                    
                    ps2.setString(1, user);
                    ps2.setString(2, accnumber);
                    ps2.setString(3, acctype);  
                    ResultSet resultSet=ps.executeQuery();
                    ResultSet resultSet1=ps2.executeQuery();
                    
                    if(!resultSet1.next())
                    {
                        PreparedStatement ps1=con.prepareStatement("insert into AccountInfo(AccountNumber,AccountHolderName,UserID,AccountType,Amount) values(?,?,?,?,?)");
                        ps1.setString(1,accnumber);
                        ps1.setString(2,name);
                        ps1.setString(3,user);
                        ps1.setString(4,acctype);
                        ps1.setString(5,amount);
                        
                        ps1.executeUpdate();
                        session.setAttribute("check","1");
                        session.setAttribute("message", "Account Created Successfully");
                        response.sendRedirect("Welcome.jsp");
                    }
                    else
                    {
                        session.setAttribute("check","1");
                        session.setAttribute("message", "Incorrect Details");
                        response.sendRedirect("Welcome.jsp");
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