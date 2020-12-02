<%-- 
    Document   : Register
    Created on : 29 Nov, 2020, 10:07:57 PM
    Author     : Ayush Jain
--%>

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
        
        <title>Internet Banking</title>
        
        <style type="text/css">
                  
            body{
                    background-image: url("back.jpg");
                    background-position: center;
                    background-repeat: no-repeat;
                    background-size: cover;
                }
      
            .wrapper{
                     margin: 4%;
                }
      
            .form-signin{
                    max-width: 600px;
                    margin: 0 auto;
                    background-color: #fff;
                    padding: 10px 20px 30px;
                    border: 1px solid #e5e5e5;
                    border-radius: 10px;
                }
      
            .form-signin, .form-signin-heading{
                    margin-bottom: 25px;
                }
      
            .form-signin input[type="text"], .form-signin input[type="password"]{
                  margin-bottom: 10px;
                }
      
            .form-signin .form-control{
                  padding: 7px;
      }
        </style>
    </head>
    <body>
        <%
            out.println("<script type=\"text/javascript\">");
            out.println("$(document).ready(function(){");
            if(session.getAttribute("check") == "1")
            {    
                out.println("alert('" + session.getAttribute("message") + "');");
                session.setAttribute("check","0");
            }
            out.println("})");
            out.println("</script>");         
        %>        
        
        <div class="wrapper">
            <form class="form-signin" action="RegisterServlet" method="post">
    
                <h2 class="form-signin-heading text-center">Internet Banking</h2>
                
                <div class="form-group row">
                    <div class="col-6">  
                        <label for="name">Name</label>
                        <input type="text" class="form-control" id="fname" placeholder="Name" name="Name" required>
                    </div>
                    <div class="col-6"> 
                        <label for="exampleInputUsername">User ID</label>
                        <input type="text" class="form-control" id="userid" placeholder="User ID" name="UserID" required>
                    </div>
                </div>
                
               <div class="form-group row">
                    <div class="col-6">
                    <label for="exampleInputPassword1">Password</label>
                    <input type="password" class="form-control" id="pass" placeholder="Password" name="Password" required>
                </div>
                <div class="col-6"> 
                    <label for="number">Phone Number</label>
                    <input type="text" class="form-control" id="phone" placeholder="Phone Number" name="PhoneNumber" required>
                </div>
               </div>
                
                <div class="form-group row">
                    <div class="col-6">
                    <label for="idproof">ID Proof Number</label>
                    <input type="text" class="form-control" id="idproof" placeholder="ID Proof Number" name="IDProofNumber">
                </div>
                <div class="col-6"> 
                    <label for="inputType">Type</label>
                    <select id="inputType" class="form-control" name="Type">
                            <option value="Customer" selected>Customer</option>
                            <option value="Employee">Employee</option>
                        </select>
                </div>
                </div>
                
                <div class="form-group row">
                    <div class="col-12">
                    <label for="address">Address</label>
                    <textarea class="form-control" id="address" placeholder="Address" name="Address" rows="3" required></textarea>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="ab">Do you have account? <a href="Login.jsp" style="text-decoration: none;">Login</a></label>
                </div>
                
                <button class="btn btn-md btn-primary btn-block" type="submit">Register</button> 
            </form>    
        </div>
    </body>
</html>
