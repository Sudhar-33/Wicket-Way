<%-- 
    Document   : update_stadium_process
    Created on : 26 Dec 2025, 5:26:32 pm
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("adminlogin.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));
    String name = request.getParameter("name");
    String city = request.getParameter("city");
    int capacity = Integer.parseInt(request.getParameter("capacity"));
    String imageurl = request.getParameter("image");

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/wicketway","root","Sudhar@123");

    PreparedStatement ps = con.prepareStatement(
        "UPDATE stadiums SET name=?, city=?, capacity=?, image_url=? WHERE id=?");

    ps.setString(1, name);
    ps.setString(2, city);
    ps.setInt(3, capacity);
    ps.setString(4, imageurl);
    ps.setInt(5, id);

    ps.executeUpdate();
    con.close();

    response.sendRedirect("admin_dashboard.jsp");
%>

