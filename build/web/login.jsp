<%-- 
    Document   : login
    Created on : 24 Dec 2025, 10:27:08 am
    Author     : ADMIN
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.security.MessageDigest, java.math.BigInteger" %>
<%@ page import="db.DBConnection" %>

<%
String email = request.getParameter("email");
String password = request.getParameter("password");

if (email != null && password != null) {
    email = email.trim();
    password = password.trim();

    try {
        // Hash the input password
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] hash = md.digest(password.getBytes("UTF-8"));
        BigInteger number = new BigInteger(1, hash);
        String hashedPassword = number.toString(16);
        while (hashedPassword.length() < 64) {
            hashedPassword = "0" + hashedPassword;
        }

        // JDBC login check
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                 "SELECT username FROM users WHERE email=? AND password=?"
             )) {

            ps.setString(1, email);
            ps.setString(2, hashedPassword);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    session.setAttribute("username", rs.getString("username"));
                    session.setAttribute("email", email);
                    response.sendRedirect("index.jsp");
                } else {
                    out.println("<script>alert('Invalid Email or Password');</script>");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<script>alert('Database error!');</script>");
        }

    } catch (Exception e) { // Handles MessageDigest & Encoding exceptions
        e.printStackTrace();
        out.println("<script>alert('Internal error!');</script>");
    }
}
%>



<!DOCTYPE html>
<html lang="en">
<head>
    <title>WicketWay | Login </title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="loginStyle.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/loginStyle.css">

</head>
<body>



<div class="overlay">
    <div class="container d-flex justify-content-center align-items-center min-vh-100">
        <div class="login-card shadow-lg">
            <h2 class="text-center mb-4">🏏 Wicket Way</h2>
            <h2 class="text-center mb-4">Login</h2>

           <form action="login.jsp" method="post" onsubmit="return validateLogin()">

    <div class="mb-3">
        <label class="form-label">Email</label>
        <input type="email" name="email"
               class="form-control" placeholder="Enter your email" required>
    </div>

    <div class="mb-3">
        <label class="form-label">Password</label>
        <input type="password" name="password"
               class="form-control" placeholder="Enter your password" required>
    </div>

    <button type="submit" class="btn btn-success w-100">
        Login
    </button>

    <!-- REGISTER LINK -->
    <p class="text-center mt-3 mb-0">
        New user?
        <a href="register.jsp" class="fw-bold text-decoration-none">
            Register here
        </a>
    </p>

</form>


        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- External JS -->
<script src="ScriptLogin.js"></script>


</html>
