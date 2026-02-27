<%-- 
    Document   : register
    Created on : 24 Dec 2025, 11:02:02 am
    Author     : ADMIN
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.security.MessageDigest, java.nio.charset.StandardCharsets" %>
<%@ page import="db.DBConnection" %>

<%
String errorMsg = null;

if (request.getMethod().equalsIgnoreCase("POST")) {
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String mobile = request.getParameter("mobile");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirmPassword");

    if (name == null || email == null || mobile == null || password == null || confirmPassword == null ||
        name.isEmpty() || email.isEmpty() || mobile.isEmpty() || password.isEmpty() || confirmPassword.isEmpty()) {
        errorMsg = "All fields are required!";
    } else if (!password.equals(confirmPassword)) {
        errorMsg = "Passwords do not match!";
    } else if (!mobile.matches("\\d{10}")) {
        errorMsg = "Mobile number must be 10 digits!";
    } else {
        Connection con = null;
        PreparedStatement check = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();

            // Check if email already exists
            check = con.prepareStatement("SELECT id FROM users WHERE email=?");
            check.setString(1, email);
            rs = check.executeQuery();
            if (rs.next()) {
                errorMsg = "Email already registered!";
            } else {
                // Hash the password using SHA-256
                MessageDigest md = MessageDigest.getInstance("SHA-256");
                byte[] hash = md.digest(password.getBytes(StandardCharsets.UTF_8));
                // Convert byte array to hex string manually
                StringBuilder sb = new StringBuilder();
                for (byte b : hash) {
                   sb.append(String.format("%02x", b));  // Lowercase hex
                }
                String hashedPassword = sb.toString();


                // Insert user
                ps = con.prepareStatement("INSERT INTO users(username, email, mobile, password) VALUES (?,?,?,?)");
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, mobile);
                ps.setString(4, hashedPassword);
                ps.executeUpdate();

                response.sendRedirect("login.jsp");
                return;
            }

        } catch (Exception e) {
            errorMsg = "Error: " + e.getMessage();
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception ignored) {}
            if (check != null) try { check.close(); } catch (Exception ignored) {}
            if (ps != null) try { ps.close(); } catch (Exception ignored) {}
            if (con != null) try { con.close(); } catch (Exception ignored) {}
        }
    }
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>WicketWay | Register</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="Register.css">
</head>
<body>

<div class="overlay">
    <div class="register-card shadow-lg">
        <h2 class="text-center mb-4">🏏 WicketWay Register</h2>

        <% if (errorMsg != null) { %>
            <div class="alert alert-danger"><%= errorMsg %></div>
        <% } %>

        <form action="register.jsp" method="post">

            <div class="mb-3">
                <label class="form-label">Name</label>
                <input type="text" name="name" class="form-control" placeholder="Enter your name" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control" placeholder="example@gmail.com" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Mobile Number</label>
                <input type="text" name="mobile" class="form-control" placeholder="10-digit mobile number" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Create Password</label>
                <input type="password" name="password" class="form-control" placeholder="Create password" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Re-enter Password</label>
                <input type="password" name="confirmPassword" class="form-control" placeholder="Re-type password" required>
            </div>

            <button type="submit" class="btn btn-success w-100">Register</button>

            <p class="text-center mt-3">
                Already have an account? <a href="login.jsp">Login</a>
            </p>

        </form>
    </div>
</div>

</body>
</html>

