<%-- 
    Document   : admin_dashboard
    Created on : 26 Dec 2025, 5:17:32 pm
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>

<%
if (session.getAttribute("admin") == null) {
    response.sendRedirect("adminlogin.jsp");
    return;
}

response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard | WicketWay</title>
    <meta charset="UTF-8">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f5f6fa;
        }

        .dashboard-box {
            background: #ffffff;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }

        h3, h4 {
            font-weight: 600;
        }

        .table th {
            background-color: #212529;
            color: #ffffff;
            text-align: center;
        }

        .table td {
            vertical-align: middle;
            text-align: center;
        }

        img {
            border-radius: 5px;
        }
    </style>
</head>

<body>

<div class="container my-5">
<div class="dashboard-box">

    <!-- HEADER -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>Welcome, <%= session.getAttribute("admin") %></h3>
        <a href="logout.jsp" class="btn btn-danger btn-sm">Logout</a>
    </div>

    <!-- ACTION BUTTONS -->
    <div class="mb-4">
        <a href="add_stadium.jsp" class="btn btn-primary btn-sm me-2">Add Stadium</a>
        <a href="add_match.jsp" class="btn btn-success btn-sm">Add Match</a>
    </div>

    <!-- ================= STADIUM SECTION ================= -->
    <h4 class="mb-3">Stadium Management</h4>

    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th>ID</th>
                <th>Stadium Name</th>
                <th>City</th>
                <th>Capacity</th>
                <th>Image</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/wicketway",
                "root",
                "Sudhar@123"
            );

            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(
                "SELECT id, name, city, capacity, image_url FROM stadiums"
            );

            while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("city") %></td>
                <td><%= rs.getInt("capacity") %></td>
                <td>
                    <img src="<%= rs.getString("image_url") %>" width="100" height="60">
                </td>
                <td>
                    <a href="edit_stadium.jsp?id=<%= rs.getInt("id") %>"
                       class="btn btn-warning btn-sm">Edit</a>
                    <a href="delete_stadium.jsp?id=<%= rs.getInt("id") %>"
                       class="btn btn-danger btn-sm"
                       onclick="return confirm('Delete this stadium?');">
                       Delete
                    </a>
                </td>
            </tr>
        <%
            }
            rs.close();
            st.close();
            con.close();
        } catch (Exception e) {
            out.println("<tr><td colspan='6' class='text-danger'>" + e + "</td></tr>");
        }
        %>
        </tbody>
    </table>

    <!-- ================= MATCHES SECTION ================= -->
    <h4 class="mt-5 mb-3">Match Management</h4>

    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th>ID</th>
                <th>Teams</th>
                <th>Date</th>
                <th>Time</th>
                <th>Stadium</th>
                <th>Price</th>
                <th>Banner</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
        try {
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/wicketway",
                "root",
                "Sudhar@123"
            );

            String sql =
                "SELECT m.*, s.name AS stadium_name " +
                "FROM matches m JOIN stadiums s ON m.stadium_id = s.id";

            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);

            while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("team1") %> vs <%= rs.getString("team2") %></td>
                <td><%= rs.getDate("match_date") %></td>
                <td><%= rs.getString("match_time") %></td>
                <td><%= rs.getString("stadium_name") %></td>
                <td>₹<%= rs.getInt("price") %></td>
                <td>
                    <img src="<%= rs.getString("banner") %>" width="100" height="55">
                </td>
                <td>
                    <a href="edit_match.jsp?id=<%= rs.getInt("id") %>"
                       class="btn btn-warning btn-sm">Edit</a>
                    <a href="delete_match.jsp?id=<%= rs.getInt("id") %>"
                       class="btn btn-danger btn-sm"
                       onclick="return confirm('Delete this match?');">
                       Delete
                    </a>
                </td>
            </tr>
        <%
            }
            rs.close();
            st.close();
            con.close();
        } catch (Exception e) {
            out.println("<tr><td colspan='8' class='text-danger'>" + e + "</td></tr>");
        }
        %>
        </tbody>
    </table>

</div>
</div>

</body>
</html>





