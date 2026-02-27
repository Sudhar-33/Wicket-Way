<%-- 
    Document   : add_match
    Created on : 27 Dec 2025, 12:37:13 pm
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page session="true"%>

<%
if (session.getAttribute("admin") == null) {
    response.sendRedirect("adminlogin.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Add Match</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">

<h3>Add New Match</h3>

<form method="post">
    <input class="form-control mb-2" type="text" name="team1" placeholder="Team 1" required>
    <input class="form-control mb-2" type="text" name="team2" placeholder="Team 2" required>

    <input class="form-control mb-2" type="date" name="match_date" required>
    <input class="form-control mb-2" type="time" name="match_time" required>

    <select class="form-control mb-2" name="stadium_id" required>
        <option value="">Select Stadium</option>
        <%
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/wicketway","root","Sudhar@123");
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT id, name FROM stadiums");
        while(rs.next()){
        %>
        <option value="<%=rs.getInt("id")%>">
            <%=rs.getString("name")%>
        </option>
        <% } %>
    </select>

    <input class="form-control mb-2" type="number" name="price" placeholder="Ticket Price" required>
    <input class="form-control mb-3" type="text" name="banner" placeholder="Banner Image URL">

    <button class="btn btn-success">Add Match</button>
    <a href="admin_dashboard.jsp" class="btn btn-secondary">Back</a>
</form>

<%
if(request.getMethod().equalsIgnoreCase("POST")){
    PreparedStatement ps = con.prepareStatement(
    "INSERT INTO matches(team1, team2, stadium_id, match_date, match_time, price, banner) VALUES (?,?,?,?,?,?,?)");
    ps.setString(1, request.getParameter("team1"));
    ps.setString(2, request.getParameter("team2"));
    ps.setInt(3, Integer.parseInt(request.getParameter("stadium_id")));
    ps.setDate(4, Date.valueOf(request.getParameter("match_date")));
    ps.setString(5, request.getParameter("match_time"));
    ps.setInt(6, Integer.parseInt(request.getParameter("price")));
    ps.setString(7, request.getParameter("banner"));
    ps.executeUpdate();

    response.sendRedirect("admin_dashboard.jsp");
}
%>

</div>
</body>
</html>
