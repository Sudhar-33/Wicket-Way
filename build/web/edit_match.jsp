<%-- 
    Document   : edit_match
    Created on : 27 Dec 2025, 12:37:50 pm
    Author     : ADMIN
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
int id = Integer.parseInt(request.getParameter("id"));
Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/wicketway","root","Sudhar@123");

PreparedStatement ps = con.prepareStatement(
"SELECT * FROM matches WHERE id=?");
ps.setInt(1, id);
ResultSet rs = ps.executeQuery();
rs.next();
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Match</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">

<h3>Edit Match</h3>

<form method="post">
    <input class="form-control mb-2" type="text" name="team1"
           value="<%=rs.getString("team1")%>" required>

    <input class="form-control mb-2" type="text" name="team2"
           value="<%=rs.getString("team2")%>" required>

    <input class="form-control mb-2" type="date" name="match_date"
           value="<%=rs.getDate("match_date")%>" required>

    <input class="form-control mb-2" type="time" name="match_time"
           value="<%=rs.getString("match_time")%>" required>

    <input class="form-control mb-2" type="number" name="price"
           value="<%=rs.getInt("price")%>" required>

    <input class="form-control mb-3" type="text" name="banner"
           value="<%=rs.getString("banner")%>">

    <button class="btn btn-warning">Update</button>
</form>

<%
if(request.getMethod().equalsIgnoreCase("POST")){
    PreparedStatement ups = con.prepareStatement(
    "UPDATE matches SET team1=?, team2=?, match_date=?, match_time=?, price=?, banner=? WHERE id=?");

    ups.setString(1, request.getParameter("team1"));
    ups.setString(2, request.getParameter("team2"));
    ups.setDate(3, Date.valueOf(request.getParameter("match_date")));
    ups.setString(4, request.getParameter("match_time"));
    ups.setInt(5, Integer.parseInt(request.getParameter("price")));
    ups.setString(6, request.getParameter("banner"));
    ups.setInt(7, id);

    ups.executeUpdate();
    response.sendRedirect("admin_dashboard.jsp");
}
%>

</div>
</body>
</html>
