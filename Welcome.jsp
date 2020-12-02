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
  height: 330px;
  overflow-y: auto;
}
        </style>
        
        <title>Internet Banking | Customer Panel</title>
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
                        <a class="navbar-brand" style="color: white;">Customer Panel</a>
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
                        <div class="table-wrap">
                        <div class="list-group" id="list-tab" role="tablist">
                            <a class="list-group-item list-group-item-action active rounded-0" id="list-account-list" data-toggle="list" href="#list-account" role="tab" aria-controls="account">Create New Account</a>
                            <a class="list-group-item list-group-item-action rounded-0" id="list-summary-list" data-toggle="list" href="#list-summary" role="tab" aria-controls="summary">Account Summary</a>
                            <a class="list-group-item list-group-item-action rounded-0" id="list-fund-list" data-toggle="list" href="#list-fund" role="tab" aria-controls="fund">Fund Transfer</a>
                            <a class="list-group-item list-group-item-action rounded-0" id="list-deposit-list" data-toggle="list" href="#list-deposit" role="tab" aria-controls="deposit">Deposit Money</a>
                            <a class="list-group-item list-group-item-action rounded-0" id="list-money-list" data-toggle="list" href="#list-money" role="tab" aria-controls="money">Money Withdrawal</a>
                            <a class="list-group-item list-group-item-action rounded-0" id="list-balance-list" data-toggle="list" href="#list-balance" role="tab" aria-controls="balance">Balance Enquiry</a>
                            <a class="list-group-item list-group-item-action rounded-0" id="list-loan-list" data-toggle="list" href="#list-loan" role="tab" aria-controls="loan">Loan Request</a>
                            <a class="list-group-item list-group-item-action rounded-0" id="list-close-list" data-toggle="list" href="#list-close" role="tab" aria-controls="close">Close Account</a>
                            <a class="list-group-item list-group-item-action rounded-0" id="list-profile-list" data-toggle="list" href="#list-profile" role="tab" aria-controls="profile">Update Profile</a>
                        </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-10">   
                    <div class="tab-content" id="nav-tabContent">
                        <div class="tab-pane fade show active" id="list-account" role="tabpanel" aria-labelledby="list-account-list">
                            <div class="card">
                                <h2 class="card-header text-center">Create New Account</h2>
                                <div class="card-body">
                                    <form class="container" action="AccountCreate" method="post">
                                     <div class="form-row justify-content-around">
                                        <div class="col-md-5 mb-3">
                                            <label for="Name">Account Holder Name</label>
                                            <input type="text" class="form-control" id="name" placeholder="Account Holder Name" name="Name" required>
                                        </div>      
                                        <div class="col-md-5 mb-3">
                                            <label for="accnumber">Account Number</label>
                                            <input type="number" class="form-control" id="accnumber" placeholder="Account Number (Length - 10)" minlength="10" maxlength="10" name="AccountNumber" required>
                                        </div>  
                                    </div>   
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-5 mb-3">
                                            <label for="Password">Password</label>
                                            <input type="text" class="form-control" id="password" placeholder="Password" name="Password" required>
                                        </div>
                                        <div class="col-md-5 mb-3">
                                            <label for="PhoneNumber">Phone Number</label>
                                            <input type="text" class="form-control" id="number" placeholder="Phone Number" name="PhoneNumber" minlength="10" maxlength="10" required>
                                        </div>                                                          
                                    </div>
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-5 mb-3">
                                            <label for="Lastname">Account Type</label>
                                            <select id="inputType" class="form-control"name="AccountType">
                                                <option value="Saving" selected>Saving</option>
                                                <option value="Current">Current</option>
                                            </select>
                                        </div>
                                        <div class="col-md-5 mb-3">
                                            <label for="amount">Initial Amount</label>
                                            <input type="text" class="form-control" id="amount" name="Amount" placeholder="Min RS 1000" min="1000" required>
                                        </div>                  
                                    </div>  
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-11 mb-3">
                                            <button class="btn btn-md btn-primary" type="submit">Create Account</button> 
                                        </div>                  
                                    </div>
                                   </form>    
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="list-summary" role="tabpanel" aria-labelledby="list-summary-list">
                            <div class="card">
                                <h2 class="card-header text-center">Account Summary</h2>
                                <div class="card-body">
                                    <div class="table-wrap">
                                    <table class="table table-bordered">
                                        <thead class="text-center">
                                            <tr>
                                                <th scope="col">No.</th>
                                                <th scope="col">Account Number</th>
                                                <th scope="col">Balance</th>
                                                <th scope="col">Account Type</th>
                                                <th scope="col">Loan Request</th>
                                                <th scope="col">Transaction Details</th>
                                                
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
                           
                    PreparedStatement ps=con.prepareStatement("select * from AccountInfo where UserID = ?");
                    ps.setString(1,user);
                    ResultSet resultSet=ps.executeQuery();
                    
                    int i=1;
                    
                    while(resultSet.next())
                    {
                       %><tr>
                            <td><%=i%></td>
                            <td><%=resultSet.getString("AccountNumber") %></td>
                            <td><%=resultSet.getString("Amount") %> RS</td>
                            <td><%=resultSet.getString("AccountType") %></td>
                            <td><%=resultSet.getString("LoanRequest") %></td>
                            <td><button class="btn btn-primary" data-toggle="modal" data-target="#list-<%=resultSet.getString("AccountNumber") %>">Check</button></td>
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
                        <div class="tab-pane fade" id="list-fund" role="tabpanel" aria-labelledby="list-fund-list">
                            <div class="card">
                                <h2 class="card-header text-center">Fund Transfer   </h2>
                                <div class="card-body">
                                    <form class="container" action="MoneyTransfer" method="post">
                                     <div class="form-row justify-content-around">
                                        <div class="col-md-5 mb-3">
                                            <label for="Name">Account Holder Name</label>
                                            <input type="text" class="form-control" id="name" name="Name" placeholder="Account Holder Name" required>
                                        </div>                  
                                        <div class="col-md-5 mb-3">
                                            <label for="Number">Account Number</label>
                                            <input type="text" class="form-control" id="number" name="AccountNumber" placeholder="Account Number" required>
                                        </div>                                                          
                                    </div>
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-5 mb-3">
                                            <label for="BName">Beneficiary Name</label>
                                            <input type="text" class="form-control" id="bname" name="Bname" placeholder="Beneficiary Name" required>
                                        </div>
                                        <div class="col-md-5 mb-3">
                                            <label for="BNumber">Beneficiary Account Number</label>
                                            <input type="text" class="form-control" id="bnumber" name="BAccountNumber" placeholder="Beneficiary Account Number" required>
                                        </div>                                                          
                                    </div>     
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-11 mb-3">
                                            <label for="Password">Password</label>
                                            <input type="text" class="form-control" id="password" name="Password" placeholder="Password" required>
                                        </div>                                                          
                                    </div>    
                                        
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-11 mb-3">
                                            <label for="Lastname">Account Type</label>
                                            <select id="inputType" class="form-control" name="AccountType">
                                                <option value="Saving" selected>Saving</option>
                                                <option value="Current">Current</option>
                                            </select>
                                        </div>                 
                                    </div>
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-11 mb-3">
                                            <label for="amount">Amount Transfer</label>
                                            <input class="form-control" type="text" id="amount" name="Amount" placeholder="Amount">
                                        </div>                  
                                    </div>    
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-11 mb-3">
                                            <button class="btn btn-md btn-primary" type="submit">Transfer</button> 
                                        </div>                  
                                    </div>
                                   </form>    
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="list-deposit" role="tabpanel" aria-labelledby="list-deposit-list">
                           <div class="card">
                                <h2 class="card-header text-center">Deposit Money</h2>
                                <div class="card-body">
                                    <form class="container" action="DepositMoney" method="post">
                                     <div class="form-row justify-content-around">
                                        <div class="col-md-10 mb-3">
                                            <label for="Name">Account Holder Name</label>
                                            <input type="text" class="form-control" id="name" placeholder="Account Holder Name" name="Name" required>
                                        </div>                  
                                    </div>   
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-10 mb-3">
                                            <label for="Number">Account Number</label>
                                            <input type="text" class="form-control" id="number" placeholder="Account Number" name="AccountNumber" required>
                                        </div>                                                          
                                    </div>
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-10 mb-3">
                                            <label for="Password">Password</label>
                                            <input type="text" class="form-control" id="password" placeholder="Password" name="Password" required>
                                        </div>                                                          
                                    </div>    
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-10 mb-3">
                                            <label for="Lastname">Account Type</label>
                                            <select id="inputType" class="form-control" name="AccountType">
                                                <option value="Saving" selected>Saving</option>
                                                <option value="Current">Current</option>
                                            </select>
                                        </div>                 
                                    </div>
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-10 mb-3">
                                            <label for="Address">Amount</label>
                                            <input class="form-control" type="text" id="amount" name="Amount" placeholder="Amount">
                                        </div>                  
                                    </div>    
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-10 mb-3">
                                            <button class="btn btn-md btn-primary" type="submit">Deposit</button> 
                                        </div>                  
                                    </div>
                                   </form>    
                                </div>
                            </div> 
                        </div>                    
                        <div class="tab-pane fade" id="list-money" role="tabpanel" aria-labelledby="list-money-list">
                           <div class="card">
                                <h2 class="card-header text-center">Money Withdrawal</h2>
                                <div class="card-body">
                                    <form class="container" action="AmountWthdraw" method="post">
                                     <div class="form-row justify-content-around">
                                        <div class="col-md-10 mb-3">
                                            <label for="Name">Account Holder Name</label>
                                            <input type="text" class="form-control" id="name" placeholder="Account Holder Name" name="Name" required>
                                        </div>                  
                                    </div>   
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-10 mb-3">
                                            <label for="Number">Account Number</label>
                                            <input type="text" class="form-control" id="number" placeholder="Account Number" name="AccountNumber" required>
                                        </div>                                                          
                                    </div>
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-10 mb-3">
                                            <label for="Password">Password</label>
                                            <input type="text" class="form-control" id="password" placeholder="Password" name="Password" required>
                                        </div>                                                          
                                    </div>    
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-10 mb-3">
                                            <label for="Lastname">Account Type</label>
                                            <select id="inputType" class="form-control" name="AccountType">
                                                <option value="Saving" selected>Saving</option>
                                                <option value="Current">Current</option>
                                            </select>
                                        </div>                 
                                    </div>
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-10 mb-3">
                                            <label for="Address">Amount</label>
                                            <input class="form-control" type="text" id="amount" name="Amount" placeholder="Amount">
                                        </div>                  
                                    </div>    
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-10 mb-3">
                                            <button class="btn btn-md btn-primary" type="submit">Withdraw</button> 
                                        </div>                  
                                    </div>
                                   </form>    
                                </div>
                            </div> 
                        </div>
                        <div class="tab-pane fade" id="list-balance" role="tabpanel" aria-labelledby="list-balance-list">
                            <div class="card">
                                <h2 class="card-header text-center">Balance Enquiry</h2>
                                <div class="card-body">
                                    <form class="container" action="BalanceEnquiry" method="post">
                                     <div class="form-row justify-content-around">
                                        <div class="col-md-10 mb-3">
                                            <label for="Name">Account Holder Name</label>
                                            <input type="text" class="form-control" name="Name" placeholder="Account Holder Name" required>
                                        </div>                  
                                    </div>   
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-10 mb-3">
                                            <label for="Number">Account Number</label>
                                            <input type="text" class="form-control" name="AccountNumber"  placeholder="Account Number" required>
                                        </div>                                                          
                                    </div>
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-10 mb-3">
                                            <label for="Password">Password</label>
                                            <input type="text" class="form-control" name="Password" placeholder="Password" required>
                                        </div>                                                          
                                    </div>    
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-10 mb-3">
                                            <label for="Lastname">Account Type</label>
                                            <select id="inputType" class="form-control" name="AccountType">
                                                <option value="Saving" selected>Saving</option>
                                                <option value="Current">Current</option>
                                            </select>
                                        </div>                 
                                    </div>  
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-10 mb-3">
                                            <button class="btn btn-md btn-primary" type="submit">Check Balance</button> 
                                        </div>                  
                                    </div>
                                   </form>    
                                </div>
                            </div> 
                        </div>
                        <div class="tab-pane fade" id="list-loan" role="tabpanel" aria-labelledby="list-loan-list">
                            <div class="card">
                                <h2 class="card-header text-center">Loan Request</h2>
                                <div class="card-body">
                                    <form class="container" action="LoanRequestForm" method="post">
                                     <div class="form-row justify-content-around">
                                        <div class="col-md-10 mb-3">
                                            <label for="Name">Account Holder Name</label>
                                            <input type="text" class="form-control" name="Name" placeholder="Account Holder Name" required>
                                        </div>                  
                                    </div>   
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-10 mb-3">
                                            <label for="Number">Account Number</label>
                                            <input type="text" class="form-control" name="AccountNumber"  placeholder="Account Number" required>
                                        </div>                                                          
                                    </div>
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-10 mb-3">
                                            <label for="Password">Password</label>
                                            <input type="text" class="form-control" name="Password" placeholder="Password" required>
                                        </div>                                                          
                                    </div> 
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-10 mb-3">
                                            <label for="Lastname">Account Type</label>
                                            <select id="inputType" class="form-control" name="AccountType">
                                                <option value="Saving" selected>Saving</option>
                                                <option value="Current">Current</option>
                                            </select>
                                        </div>                 
                                    </div>    
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-10 mb-3">
                                            <label for="Loan">Loan Amount</label>
                                            <input type="text" class="form-control" name="LoanAmount" placeholder="Loan Amount" required>
                                        </div>                 
                                    </div>    
                                    <div class="form-row justify-content-around">
                                        <div class="col-md-10 mb-3">
                                            <button class="btn btn-md btn-primary" type="submit">Loan Request</button> 
                                        </div>                  
                                    </div>
                                   </form>    
                                </div>
                            </div> 
                        </div>
                        <div class="tab-pane fade" id="list-close" role="tabpanel" aria-labelledby="list-close-list">
                            <div class="card">
                                <h2 class="card-header text-center">Close Account</h2>
                                <div class="card-body">
                                    <div class="table-wrap">
                                    <table class="table table-bordered">
                                        <thead class="text-center">
                                            <tr>
                                                <th scope="col">No.</th>
                                                <th scope="col">Account Number</th>
                                                <th scope="col">Balance</th>
                                                <th scope="col">Account Type</th>
                                                <th scope="col">Transaction Details</th>
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
                           
                    PreparedStatement ps=con.prepareStatement("select * from AccountInfo where UserID = ?");
                    ps.setString(1,user);
                    ResultSet resultSet=ps.executeQuery();
                    
                    int i=1;
                    
                    while(resultSet.next())
                    {
                       %><tr>
                            <td><%=i%></td>
                            <td><%=resultSet.getString("AccountNumber") %></td>
                            <td><%=resultSet.getString("Amount") %> RS</td>
                            <td><%=resultSet.getString("AccountType") %></td>
                            <td><form action="DeleteAccount" method="post"><button name="act" class="clickEvent btn btn-primary" value="<%=resultSet.getString("AccountNumber") %>" type="submit">Close</button></form></td>
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
                           
                    PreparedStatement ps=con.prepareStatement("select * from AccountInfo where UserID = ?");
                    ps.setString(1,user);
                    ResultSet resultSet=ps.executeQuery();
                    
                    int j,i=1;
                    
                    while(resultSet.next())
                    {
                       %>                                            
                        <div class="modal fade" id="list-<%=resultSet.getString("AccountNumber") %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
