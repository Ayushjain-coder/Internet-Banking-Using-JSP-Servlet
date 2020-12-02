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

@WebServlet(urlPatterns = {"/RegisterServlet"})

public class RegisterServlet extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        
        try(PrintWriter out = response.getWriter())
        {
        String name = request.getParameter("Name");
        String user = request.getParameter("UserID");
        String pass = request.getParameter("Password");
        String number = request.getParameter("PhoneNumber");
        String address = request.getParameter("Address");
        String idproof = request.getParameter("IDProofNumber");
        String type = request.getParameter("Type");
        
        HttpSession session = request.getSession();
        
        try
        {
                if(user != null && pass != null)
                {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/Customer?zeroDateTimeBehavior=convertToNull","root","");
                           
                    PreparedStatement ps=con.prepareStatement("select * from CustomerDetails where UserID = ? and Password = ?");
                    ps.setString(1,user);
                    ps.setString(2,pass);
                    ResultSet resultSet=ps.executeQuery();
                    
                    if(resultSet.next())
                    {
                        session.setAttribute("check","1");
                        session.setAttribute("message", "Incorrect Details");
                        response.sendRedirect("Register.jsp");
                    }                    
                    else
                    {
                        PreparedStatement ps1=con.prepareStatement("insert into CustomerDetails(Name,UserID,Password,PhoneNumber,Address,IDProofNumber,Type) values(?,?,?,?,?,?,?)");
                                ps1.setString(1,name);
                                ps1.setString(2,user);
                                ps1.setString(3,pass);
                                ps1.setString(4,number);
                                ps1.setString(5,address);
                                ps1.setString(6,idproof);
                                ps1.setString(7,type);
                                
                                ps1.executeUpdate();
                                
                                if(type.equals("Employee"))
                                {
                                    PreparedStatement ps2=con.prepareStatement("update CustomerDetails set EmployeeRequest = ? where UserID = ?");
                                    ps2.setString(1,"Request");
                                    ps2.setString(2,user);
                                    
                                    ps2.executeUpdate();
                                    session.setAttribute("check","1");
                                    session.setAttribute("message", "Employee Request Send to the Admin Successfully");        
   
                                }
                                else{
                                    session.setAttribute("check","1");
                                    session.setAttribute("message", "Registered Successfully");        
                                }
                                response.sendRedirect("Login.jsp");
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