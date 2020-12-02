<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        
        <style>
            .list-group-item {
    padding: 8px 8px
}

.table-wrap {
  height: 240px;
  overflow-y: auto;
}
        </style>
        
        <title>Internet Banking | Admin Panel</title>
    </head>
    <body>
        
        <%
            if(session.getAttribute("username") == null)
            {
                  response.sendRedirect("Login.jsp");
            }
            out.println("<script type=\"text/javascript\">");
            out.println("$(document).ready(function(){");
            if(session.getAttribute("check") == "1")
            {    
                out.println("alert('" + session.getAttribute("message") + "');");
                session.setAttribute("check","0");
                session.removeAttribute("message");
            }
            out.println("})");
            out.println("</script>");            
        %>
        
        <div class="container-fluid">
            <div class="card">
                <h1 class="card-header text-center bg-success font-weight-bold">Internet Banking</h1>
                <div class=""card-body">
                    <nav class="navbar navbar-light bg-secondary justify-content-between">
                        <a class="navbar-brand" style="color: white;">Welcome, ${username}</a>
                        <a class="navbar-brand" style="color: white;">Admin Panel</a>
                        <form class="form-inline"action="LogoutServlet">
                            <button class="btn btn-success" type="submit">Logout</button>
                        </form>
                    </nav>
                </div>
            </div>
              
            <div class="row">
                <div class="col-2">
                    <div class="card rounded-0">
                        <img class="card-img-top" src="ayush.jpg" alt="Card image cap" style="height: 12rem; padding: 5px 15px 5px 15px; ">
                        <div class="card-body">
                            <h5 class="card-title text-center">${name}</h5>
                        </div>
                        <div class="list-group" id="list-tab" role="tablist">
                            <a class="list-group-item list-group-item-action active rounded-0" id="list-admin-list" data-toggle="list" href="#list-admin" role="tab" aria-controls="admin">New Admin Request</a>
                            <a class="list-group-item list-group-item-action rounded-0" id="list-account-list" data-toggle="list" href="#list-account" role="tab" aria-controls="account">Account Details</a>
                            <a class="list-group-item list-group-item-action rounded-0" id="list-loan-list" data-toggle="list" href="#list-loan" role="tab" aria-controls="loan">Loan Requests</a>           
                            <a class="list-group-item list-group-item-action rounded-0" id="list-employee-list" data-toggle="list" href="#list-employee" role="tab" aria-controls="employee">Employees Requests</a>
                            <a class="list-group-item list-group-item-action rounded-0" id="list-delete-list" data-toggle="list" href="#list-delete" role="tab" aria-controls="delete">Delete Admin</a>
                            <a class="list-group-item list-group-item-action rounded-0" id="list-profile-list" data-toggle="list" href="#list-profile" role="tab" aria-controls="profile">Update Profile</a>
                        </div>
                    </div>
                </div>
                
                <div class="col-10">   
                    <div class="tab-content" id="nav-tabContent">
                        <div class="tab-pane fade show active" id="list-admin" role="tabpanel" aria-labelledby="list-admin-list">
                            <div class="card">
                                <h2 class="card-header text-center">New Admin Request</h2>
                                <div class="card-body">
                                    <div class="table-wrap">
                                    <table class="table table-bordered">
                                        <thead class="text-center">
                                            <tr>
                                                <th scope="col">No.</th>
                                                <th scope="col">Name</th>
                                                <th scope="col">User ID</th>
                                                <th scope="col">Phone Number</th>
                                                <th scope="col">ID Proof Number</th>
                                                <th scope="col">Admin Request Accept/Reject</th>
                                            </tr>
                                        </thead>
                                        <tbody class="text-center">
                                            <%
        String user = (String)session.getAttribute("username");                                         
        
        try
        {
                if(user != null)
                {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/Customer?zeroDateTimeBehavior=convertToNull","root","");
                           
                    PreparedStatement ps=con.prepareStatement("select * from CustomerDetails where Type = 'Employee' && EmployeeRequest = 'Yes' && Admin = 'Employee Request for Admin'");
                    ResultSet resultSet=ps.executeQuery();
                    
                    int i=1;
                    
                    while(resultSet.next())
                    {
                       %><tr>
                            <td><%=i%></td>
                            <td><%=resultSet.getString("Name") %></td>
                            <td><%=resultSet.getString("UserID") %></td>
                            <td><%=resultSet.getString("PhoneNumber") %></td>
                            <td><%=resultSet.getString("IDProofNumber") %></td>
                            <td>
                                <form action="AdminRequest" method="post">
                                <button class="btn btn-primary" value="<%=resultSet.getString("UserID") %>" name="adminrequest1">Accept</button>
                                <button class="btn btn-primary" value="<%=resultSet.getString("UserID") %>" name="adminrequest2">Reject</button>        
                                </form> 
                            </td>
                       </tr>
                      <% 
                      i++;    
                    }
                }
        }
        catch(Exception ex)
        {
            out.println("Exception :"+ex.getMessage());
        }   
                                            %>
                                         
                                        </tbody>
                                    </table>
                                   </div>       
                                </div>
                            </div>    
                        </div>  
                                            
                        <div class="tab-pane fade" id="list-account" role="tabpanel" aria-labelledby="list-account-list">
                            <div class="card">
                                <h2 class="card-header text-center">Account Details</h2>
                                <div class="card-body">
                                    <div class="table-wrap">
                                    <table class="table table-bordered">
                                        <thead class="text-center">
                                            <tr>
                                                <th scope="col">No.</th>
                                                <th scope="col">Account Holder Name</th>
                                                <th scope="col">Account Number</th>
                                                <th scope="col">Balance</th>
                                                <th scope="col">Account Type</th>
                                                <th scope="col">Transaction Details</th>
                                                <th scope="col">Delete Account</th>
                                            </tr>
                                        </thead>
                                        <tbody class="text-center">
                                            <%                                       
        
        try
        {
                if(user != null)
                {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/Customer?zeroDateTimeBehavior=convertToNull","root","");
                           
                    PreparedStatement ps=con.prepareStatement("select * from AccountInfo where UserID in (select UserID from CustomerDetails where Type = 'Customer')");
                    ResultSet resultSet=ps.executeQuery();
                    
                    int i=1;
                    
                    while(resultSet.next())
                    {
                       %><tr>
                            <td><%=i%></td>
                            <td><%=resultSet.getString("AccountHolderName") %></td>
                            <td><%=resultSet.getString("AccountNumber") %></td>
                            <td><%=resultSet.getString("Amount") %> RS</td>
                            <td><%=resultSet.getString("AccountType") %></td>
                            <td><button class="btn btn-primary" data-toggle="modal" data-target="#list-<%=resultSet.getString("AccountNumber") %>-list" >Check</button></td>
                            <td>
                                <form action="DeleteAccount" method="post"><button class="btn btn-primary" value="<%=resultSet.getString("AccountNumber") %>" name="act1">Delete</button></form>      
                            </td>
                       </tr>
                      <% 
                      i++;    
                    }
                }
        }
        catch(Exception ex)
        {
            out.println("Exception :"+ex.getMessage());
        }   
                                            %>
                                         
                                        </tbody>
                                    </table>
                                   </div>       
                                </div>
                            </div>    
                        </div>        
                                            
                        <div class="tab-pane fade" id="list-loan" role="tabpanel" aria-labelledby="list-loan-list">
                            <div class="card">
                                <h2 class="card-header text-center">Loan Requests</h2>
                                <div class="card-body">
                                    <div class="table-wrap">
                                    <table class="table table-bordered">
                                        <thead class="text-center">
                                            <tr>
                                                <th scope="col">No.</th>
                                                <th scope="col">Account Number</th>
                                                <th scope="col">Balance</th>
                                                <th scope="col">Account Type</th>
                                                <th scope="col">Loan Amount</th>
                                                <th scope="col">Loan Request Accept/Reject</th>
                                            </tr>
                                        </thead>
                                        <tbody class="text-center">
                                            <%                                       
        
        try
        {
                if(user != null)
                {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/Customer?zeroDateTimeBehavior=convertToNull","root","");
                           
                    PreparedStatement ps=con.prepareStatement("select * from AccountInfo where LoanRequest = 'Loan Request to Admin'");
                    ResultSet resultSet=ps.executeQuery();
                    
                    int i=1;
                    
                    while(resultSet.next())
                    {
                       %><tr>
                            <td><%=i%></td>
                            <td><%=resultSet.getString("AccountNumber") %></td>
                            <td><%=resultSet.getString("Amount") %> RS</td>
                            <td><%=resultSet.getString("AccountType") %></td>
                            <td><%=resultSet.getString("LoanAmount") %></td>
                            <td>
                                <form action="LoanRequest" method="post">
                                    <button class="btn btn-primary" value="<%=resultSet.getString("AccountNumber") %>" name="loan1">Accept</button>
                                <button class="btn btn-primary" value="<%=resultSet.getString("AccountNumber") %>" name="loan2">Reject</button>
                                </form>
                            </td>
                       </tr>
                      <% 
                      i++;    
                    }
                }
        }
        catch(Exception ex)
        {
            out.println("Exception :"+ex.getMessage());
        }   
                                            %>
                                         
                                        </tbody>
                                    </table>
                                   </div>       
                                </div>
                            </div>    
                        </div>    
                        <div class="tab-pane fade" id="list-employee" role="tabpanel" aria-labelledby="list-employee-list">
                            <div class="card">
                                <h2 class="card-header text-center">Employee Requests</h2>
                                <div class="card-body">
                                    <div class="table-wrap">
                                    <table class="table table-bordered">
                                        <thead class="text-center">
                                            <tr>
                                                <th scope="col">No.</th>
                                                <th scope="col">Name</th>
                                                <th scope="col">User ID</th>
                                                <th scope="col">Phone Number</th>
                                                <th scope="col">ID Proof Number</th>
                                                <th scope="col">Employee Request Accept/Reject</th>
                                            </tr>
                                        </thead>
                                        <tbody class="text-center">
                                            <%                                      
        
        try
        {
                if(user != null)
                {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/Customer?zeroDateTimeBehavior=convertToNull","root","");
                           
                    PreparedStatement ps=con.prepareStatement("select * from CustomerDetails where Type = 'Employee' && Admin = 'No' && EmployeeRequest = 'Request'");
                    ResultSet resultSet=ps.executeQuery();
                    
                    int i=1;
                    
                    while(resultSet.next())
                    {
                       %><tr>
                            <td><%=i%></td>
                            <td><%=resultSet.getString("Name") %></td>
                            <td><%=resultSet.getString("UserID") %></td>
                            <td><%=resultSet.getString("PhoneNumber") %></td>
                            <td><%=resultSet.getString("IDProofNumber") %></td>
                            <td>
                                <form action="EmployeeRequest" method="post">
                                    <button class="btn btn-primary" value="<%=resultSet.getString("UserID") %>" name="emp1">Accept</button>
                                <button class="btn btn-primary" value="<%=resultSet.getString("UserID") %>" name="emp2">Reject</button>
                                </form>      
                            </td>
                       </tr>
                      <% 
                      i++;    
                    }
                }
        }
        catch(Exception ex)
        {
            out.println("Exception :"+ex.getMessage());
        }   
                                            %>
                                         
                                        </tbody>
                                    </table>
                                   </div>       
                                </div>
                            </div>    
                        </div>
                        <div class="tab-pane fade" id="list-delete" role="tabpanel" aria-labelledby="list-delete-list">
                            <div class="card">
                                <h2 class="card-header text-center">Delete Admin</h2>
                                <div class="card-body">
                                    <div class="table-wrap">
                                    <table class="table table-bordered">
                                        <thead class="text-center">
                                            <tr>
                                                <th scope="col">No.</th>
                                                <th scope="col">Name</th>
                                                <th scope="col">User ID</th>
                                                <th scope="col">Phone Number</th>
                                                <th scope="col">ID Proof Number</th>
                                                <th scope="col">Delete Admin</th>
                                            </tr>
                                        </thead>
                                        <tbody class="text-center">
                                            <%                                      
        
        try
        {
                if(user != null)
                {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/Customer?zeroDateTimeBehavior=convertToNull","root","");
                           
                    PreparedStatement ps=con.prepareStatement("select * from CustomerDetails where Type = 'Employee' && Admin = 'Employee Request for Admin'");
                    ResultSet resultSet=ps.executeQuery();
                    
                    int i=1;
                    
                    while(resultSet.next())
                    {
                       %><tr>
                            <td><%=i%></td>
                            <td><%=resultSet.getString("Name") %></td>
                            <td><%=resultSet.getString("UserID") %></td>
                            <td><%=resultSet.getString("PhoneNumber") %></td>
                            <td><%=resultSet.getString("IDProofNumber") %></td>
                            <td>
                                <button class="btn btn-primary" data-target="#list">Delete</button>      
                            </td>
                       </tr>
                      <% 
                      i++;    
                    }
                }
        }
        catch(Exception ex)
        {
            out.println("Exception :"+ex.getMessage());
        }   
                                            %>
                                         
                                        </tbody>
                                    </table>
                                   </div>       
                                </div>
                            </div>    
                        </div> 
                        <div class="tab-pane fade" id="list-profile" role="tabpanel" aria-labelledby="list-profile-list">
                                            <%                                        
        try
        {
                if(user != null)
                {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/Customer?zeroDateTimeBehavior=convertToNull","root","");
                           
                    PreparedStatement ps=con.prepareStatement("select * from CustomerDetails where UserID = ?");
                    ps.setString(1,user);
                    ResultSet resultSet=ps.executeQuery();                    
                    
                    if(resultSet.next())
                    {
                       %>
                            <div class="card">
                                <h2 class="card-header text-center">Update Profile</h2>
                                <div class="card-body">
                                    <form class="container" action="UpdateDetails" method="post">
                                     <div class="form-row justify-content-around">
                                        <div class="col-md-11 mb-3">
                                            <label for="name">Name</label>
                                            <input type="text" class="form-control" name="Name" value="<%=resultSet.getString(2)%>" placeholder="Name" required>
                                        </div>                  
                                    </div>   
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-5 mb-3">
                                            <label for="Uname">User ID</label>
                                            <input type="text" class="form-control" name="UserID" value="<%=resultSet.getString(3)%>" placeholder="User ID" required>
                                        </div> 
                                        <div class="col-md-5 mb-3">
                                            <label for="Password">Password</label>
                                            <input type="text" class="form-control" name="Password" value="<%=resultSet.getString(4)%>" placeholder="Password" required>
                                        </div>                                                         
                                    </div>
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-5 mb-3">
                                            <label for="ID Proof Number">ID Proof Number</label>
                                            <input type="text" class="form-control" name="IDProofNumber" value="<%=resultSet.getString(7)%>" placeholder="ID Proof Number">
                                        </div>
                                        <div class="col-md-5 mb-3">
                                            <label for="PhoneNumber">Phone Number</label>
                                            <input type="text" class="form-control" name="PhoneNumber" value="<%=resultSet.getString(5)%>" placeholder="Phone Number" minlength="10" maxlength="10" required>
                                        </div>                 
                                    </div>
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-11 mb-3">
                                            <label for="Address">Address</label>
                                            <textarea class="form-control" id="Address" placeholder="Address" rows="3" name="Address" required><%=resultSet.getString(6)%></textarea>
                                        </div>                  
                                    </div>
                      <%  
                    }
                }
        }
        catch(Exception ex)
        {
            out.println("Exception :"+ex.getMessage());
        }   
                                   %>           
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-11 mb-3">
                                            <button class="btn btn-md btn-primary" type="submit">Update</button> 
                                        </div>                  
                                    </div>
                                   </form>    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>    
            </div>                      
        </div>                           
        <%                                        
        try
        {
                if(user != null)
                {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/Customer?zeroDateTimeBehavior=convertToNull","root","");
                           
                    PreparedStatement ps=con.prepareStatement("select * from AccountInfo");

                    ResultSet resultSet=ps.executeQuery();
                    
                    int j,i=1;
                    
                    while(resultSet.next())
                    {
                       %>                                            
                        <div class="modal fade" id="list-<%=resultSet.getString("AccountNumber")%>-list" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                          <div class="modal-dialog" role="document">
                            <div class="modal-content">
                              <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Transaction Details Account - <%=resultSet.getString("AccountNumber") %></h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                  <span aria-hidden="true">&times;</span>
                                </button>
                              </div>
                              <div class="modal-body">
                               
                               <table class="table table-bordered">
                                  <thead>
                                    <tr>
                                      <th scope="col">No.</th>
                                      <th scope="col">Transaction Date/Time</th>
                                      <th scope="col">Amount</th>
                                      <th scope="col">Type</th>
                                    </tr>
                                  </thead>
                                  <tbody>
                                 <%
                                    PreparedStatement ps1=con.prepareStatement("select * from TransactionDetails where AccountNumber = ?");
                                    ps1.setString(1,resultSet.getString("AccountNumber"));
                                    ResultSet resultSet1=ps1.executeQuery();
                                    
                                    j=1;
                                    
                                    while(resultSet1.next())
                                    {  
                                 %> 
                                 
                                    <tr>
                                        <td><%=j%></td>
                                        <td><%=resultSet1.getString("TransactionTimeDate") %></td>
                                        <td><%=resultSet1.getString("Amount") %> RS</td>
                                        <td><%=resultSet1.getString("Type") %></td>
                                    </tr>
   
                                 <%
                                     j++;
                                    }
                                 %>
                                 </tbody>
                               </table>
                                 
                              </div>
                              <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                              </div>
                            </div>
                          </div>
                        </div>                                    
                      <% 
                      i++;    
                    }
                }
        }
        catch(Exception ex)
        {
            out.println("Exception :"+ex.getMessage());
        }   
                                            %>                                           
    </body>
</html>
