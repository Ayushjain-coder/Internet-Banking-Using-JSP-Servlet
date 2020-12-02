<%-- 
    Document   : newjsp
    Created on : 29 Nov, 2020, 1:26:48 AM
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
                     margin: 8%;
                }
      
            .form-signin{
                    max-width: 380px;
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
                  margin-bottom: 15px;
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
            <form class="form-signin" action="LoginServlet" method="post">
    
                <h2 class="form-signin-heading text-center">Internet Banking</h2>
                
                <div class="form-group">
                    <label for="exampleInputUsername">Username</label>
                    <input type="text" class="form-control" id="exampleInputEmail1" placeholder="Username" name="username">
                </div>
                
                <div class="form-group">
                    <label for="exampleInputPassword1">Password</label>
                    <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password" name="password">
                </div>
                
                <div class="form-group">
                    <label for="inputType">Type</label>
                    <select id="inputType" class="form-control" name="type">
                            <option value="Customer" selected>Customer</option>
                            <option value="Employee">Employee</option>
                        </select>
                </div>
                
                <div class="form-group">
                    <label class="ab">Do you not have account? <a href="Register.jsp" style="text-decoration: none;">Register</a></label>
                </div>
                
                <button class="btn btn-md btn-primary btn-block" type="submit">Login</button> 
            </form>    
        </div>
    </body>
</html>
