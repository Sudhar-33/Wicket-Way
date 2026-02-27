<%-- 
    Document   : edit_stadium
    Created on : 26 Dec 2025, 5:23:35 pm
    Author     : ADMIN
--%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("adminlogin.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/wicketway","root","Sudhar@123");

    PreparedStatement ps = con.prepareStatement(
        "SELECT * FROM stadiums WHERE id=?");
    ps.setInt(1, id);

    ResultSet rs = ps.executeQuery();
    rs.next();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Stadium | Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow p-4 col-md-6 mx-auto">
        <h4 class="fw-bold mb-4">✏ Edit Stadium</h4>

        <form action="update_stadium_process.jsp" method="post">
            <input type="hidden" name="id" value="<%= rs.getInt("id") %>">

            <div class="mb-3">
                <label class="form-label">Stadium Name</label>
                <input type="text" name="name" class="form-control"
                       value="<%= rs.getString("name") %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">City</label>
                <input type="text" name="city" class="form-control"
                       value="<%= rs.getString("city") %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Capacity</label>
                <input type="number" name="capacity" class="form-control"
                       value="<%= rs.getInt("capacity") %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Image URL</label>
                <input type="text" name="image" class="form-control"
                       value="<%= rs.getString("image_url") %>" required>
            </div>

            <button class="btn btn-primary w-100">Update Stadium</button>
        </form>
    </div>
</div>

</body>
</html>

<%
con.close();
%>

