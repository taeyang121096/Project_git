<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<link href="./resources/css/login.css" rel="stylesheet"
   id="bootstrap-css">
<script
   src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

<div class="sidenav">
   <div class="login-main-text">
      <h2>Login Page</h2>
      <p>Login or register from here to start.</p>
   </div>
</div>
<div class="main">

   <div class="login-form">
      <form class="form-signin" action="j_security_check" method="post">
         <div class="form-group">
         <%
         String error= request.getParameter("error");
         if(error!=null){
            out.println("<div class='alert alert-danger'>");
            out.println("아이디와 비밀번호를 확인해주세");
            out.println("</div>");
         }
         %>
            <h1>
               <label>User Name</label> <input type="text" class="form-control"
                  placeholder="User Name" name="j_username" required autofocus>
            </h1>
         </div>
         <div class="form-group">
            <h1>
               <label>Password</label> <input type="password" class="form-control"
                  placeholder="Password" name="j_password" required>
            </h1>
         </div>
         <h2>

            <button type="submit" class="btn btn-black">Login</button>
            </a>
         </h2>
         <h2>

            <button type="submit" class="btn btn-secondary">Register</button>
            </a>
         </h2>
      </form>
   </div>
</div>