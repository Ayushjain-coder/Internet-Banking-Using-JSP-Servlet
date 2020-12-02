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

@WebServlet(urlPatterns = {"/LoginServlet"})

public class LoginServlet extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        
        try(PrintWriter out = response.getWriter())
        {
        
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        String type = request.getParameter("type");
        
        HttpSession session = request.getSession();
        
        try
        {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/Customer?zeroDateTimeBehavior=convertToNull","root","");
                           
                    PreparedStatement ps=con.prepareStatement("select * from CustomerDetails where UserID = ? and Password = ?");
                    ps.setString(1,user);
                    ps.setString(2,pass);
                    ResultSet resultSet=ps.executeQuery();
                    
                    if(resultSet.next())
                    {
                       session.setAttribute("name", resultSet.getString(2));
                       if(resultSet.getString("Type").equals("Employee") && resultSet.getString("EmployeeRequest").equals("Yes") && resultSet.getString("Admin").equals("Yes")) 
                       { 
                            session.setAttribute("username", user);
                        
                            session.setAttribute("check","1");  
                            session.setAttribute("message", "Login Successfully");

                            response.sendRedirect("WelcomeAdmin.jsp");
                       }
                       else if(resultSet.getString("Type").equals("Customer") && resultSet.getString("EmployeeRequest").equals("No"))
                       {
                            session.setAttribute("username", user);
                        
                            session.setAttribute("check","1");  
                            session.setAttribute("message", "Login Successfully");

                            response.sendRedirect("Welcome.jsp");
                       }
                       else if(resultSet.getString("Type").equals("Employee") && resultSet.getString("EmployeeRequest").equals("Yes"))
                       {
                           session.setAttribute("username", user);
                        
                            session.setAttribute("check","1");  
                            session.setAttribute("message", "Login Successfully");

                            response.sendRedirect("WelcomeEmployee.jsp");
                       }
                       else
                       {
                            session.setAttribute("check","1");
                            session.setAttribute("message", "Incorrect Username or Password");
                            response.sendRedirect("Login.jsp");
                        } 
                    
                    }
                    else
                    {
                        session.setAttribute("name", resultSet.getString(2));
                        session.setAttribute("check","1");
                        session.setAttribute("message", "Incorrect Username or Password");
                        response.sendRedirect("Login.jsp");
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