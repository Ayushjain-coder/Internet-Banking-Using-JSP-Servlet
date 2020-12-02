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
@WebServlet(urlPatterns = {"/MoneyTransfer"})
public class MoneyTransfer extends HttpServlet {

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
        String bname = request.getParameter("BName");
        String baccnumber = request.getParameter("BAccountNumber");
        String pass = request.getParameter("Password");
        String acctype = request.getParameter("AccountType");
        String amount = request.getParameter("Amount");
        int old1 = 0,old2 = 0;
        String newnum1 = null,newnum2 = null;
        
        HttpSession session = request.getSession();
        String user = (String)session.getAttribute("username");
        
        HttpSession session1 = request.getSession();
        
        try
        {
                if(pass != null)
                {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/Customer?zeroDateTimeBehavior=convertToNull","root","");
                           
                    PreparedStatement ps=con.prepareStatement("select * from CustomerDetails where Password = ? and UserID = ? and Name = ?");
                    PreparedStatement ps2=con.prepareStatement("select * from AccountInfo where UserID = ? && AccountNumber = ? && AccountType = ?");              
                    PreparedStatement ps3=con.prepareStatement("select * from AccountInfo where AccountNumber = ?");               
                    ps.setString(1,pass);
                    ps.setString(2,user);
                    ps.setString(3,name);
                    
                    ps2.setString(1, user);
                    ps2.setString(2, accnumber);
                    ps2.setString(3, acctype);
                    ResultSet resultSet=ps.executeQuery();
                    
                    ResultSet resultSet1=ps2.executeQuery();
                    
                    ps3.setString(1, baccnumber);
                    ResultSet resultSet2=ps3.executeQuery();
                    
                    if(resultSet.next() && resultSet1.next() && resultSet2.next())
                    {
                       old1 = Integer.parseInt(resultSet1.getString(6));
                       old2 = Integer.parseInt(resultSet2.getString(6));
                       newnum1 = Integer.toString(old1 - Integer.parseInt(amount));
                       newnum2 = Integer.toString(old2 + Integer.parseInt(amount));
                    
                    if(Integer.parseInt(amount) <= old1)
                    {
                       PreparedStatement ps1=con.prepareStatement("update AccountInfo set Amount = ? where AccountNumber = ?");
                                ps1.setString(1,newnum1);
                                ps1.setString(2,accnumber);
                                ps1.executeUpdate();
                                
                                ps1.setString(1, newnum2);
                                ps1.setString(2,baccnumber);
                                ps1.executeUpdate();
                                
                        PreparedStatement ps4=con.prepareStatement("insert into TransactionDetails(AccountNumber,Amount,Type) values(?,?,?)");
                                ps4.setString(1,accnumber);
                                ps4.setString(2,amount);
                                ps4.setString(3,"To Transfer Acc - "+baccnumber);
                                
                                ps4.executeUpdate(); 
                                
                                ps4.setString(1,baccnumber);
                                ps4.setString(2,amount);
                                ps4.setString(3,"By Transfer Acc - "+accnumber);
                                
                                ps4.executeUpdate();
                        session.setAttribute("check","1");        
                        session.setAttribute("message", "Money Transfer Successfully");        
                        response.sendRedirect("Welcome.jsp");  
                    }
                    else
                    {
                        session.setAttribute("check","1");
                        session.setAttribute("message", "Incorrect Details");
                        response.sendRedirect("Welcome.jsp");
                    }
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