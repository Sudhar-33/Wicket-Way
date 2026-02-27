<%-- 
    Document   : delete_match
    Created on : 27 Dec 2025, 12:38:22 pm
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
int id = Integer.parseInt(request.getParameter("id"));

Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/wicketway","root","Sudhar@123");

PreparedStatement ps =
con.prepareStatement("DELETE FROM matches WHERE id=?");
ps.setInt(1, id);
ps.executeUpdate();

response.sendRedirect("admin_dashboard.jsp");
%>

