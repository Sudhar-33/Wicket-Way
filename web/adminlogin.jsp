<%-- 
    Document   : adminlogin
    Created on : 26 Dec 2025, 5:16:22 pm
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Login | WicketWay</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            background:
                linear-gradient(rgba(0,0,0,0.75), rgba(0,0,0,0.85)),
                url("https://i.pinimg.com/1200x/96/ae/30/96ae30d50b1063522b5b36282ddc6535.jpg");
            background-size: cover;
            background-position: center;
        }

        .admin-card {
            width: 420px;
            backdrop-filter: blur(12px);
            background: rgba(255, 255, 255, 0.1);
            border-radius: 18px;
            border: 1px solid rgba(255,255,255,0.2);
            box-shadow: 0 20px 40px rgba(0,0,0,0.6);
            animation: fadeIn 0.8s ease-in-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .admin-title {
            font-weight: 600;
            letter-spacing: 1px;
            color: #ffffff;
        }

        .subtitle {
            font-size: 14px;
            color: #cfcfcf;
        }

        label {
            color: #e0e0e0;
            font-size: 14px;
        }

        .form-control {
            background: rgba(255,255,255,0.15);
            border: none;
            color: #fff;
        }

        .form-control::placeholder {
            color: #ccc;
        }

        .form-control:focus {
            background: rgba(255,255,255,0.2);
            box-shadow: none;
            color: #fff;
        }

        .login-btn {
            background: linear-gradient(135deg, #00c853, #64dd17);
            border: none;
            font-weight: 600;
            letter-spacing: 1px;
        }

        .login-btn:hover {
            background: linear-gradient(135deg, #64dd17, #00c853);
            transform: translateY(-1px);
        }

        .admin-badge {
            display: inline-block;
            background: rgba(0,0,0,0.6);
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 12px;
            color: #9effa8;
            margin-bottom: 10px;
        }
    </style>
</head>

<body>

<div class="container d-flex justify-content-center align-items-center min-vh-100">
    <div class="admin-card p-4">

        <div class="text-center mb-4">
            <div class="admin-badge">ADMIN ACCESS</div>
            <h3 class="admin-title">WicketWay</h3>
            <p class="subtitle">Administrator Login Panel</p>
        </div>

        <% String error = request.getParameter("error");
           if(error != null) { %>
            <div class="alert alert-danger text-center">
                <%= error %>
            </div>
        <% } %>

        <form action="adminloginprocess.jsp" method="post">
            <div class="mb-3">
                <label>Username</label>
                <input type="text" name="username" class="form-control" placeholder="Enter admin username" required>
            </div>

            <div class="mb-3">
                <label>Password</label>
                <input type="password" name="password" class="form-control" placeholder="Enter admin password" required>
            </div>

            <button class="btn login-btn w-100 py-2 mt-2">
                LOGIN
            </button>
        </form>

    </div>
</div>

</body>
</html>


