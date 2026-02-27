<%-- 
    Document   : add_stadium_process
    Created on : 26 Dec 2025, 5:18:39 pm
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
if(session.getAttribute("admin") == null) {
    response.sendRedirect("adminlogin.jsp");
    return;
}

String name = request.getParameter("name");
String city = request.getParameter("city");
int capacity = Integer.parseInt(request.getParameter("capacity"));
String imageurl = request.getParameter("image");

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/wicketway","root","Sudhar@123");
    PreparedStatement ps = con.prepareStatement("INSERT INTO stadiums (name, city, capacity, image_url) VALUES (?,?,?,?)");
    ps.setString(1, name);
    ps.setString(2, city);
    ps.setInt(3, capacity);
    ps.setString(4, imageurl);
    ps.executeUpdate();

    ps.close();
    con.close();
    response.sendRedirect("admin_dashboard.jsp");
} catch(Exception e) {
    out.println(e);
}
%>

