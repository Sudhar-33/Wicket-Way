<%-- 
    Document   : adminloginprocess
    Created on : 26 Dec 2025, 5:16:59 pm
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
String username = request.getParameter("username");
String password = request.getParameter("password");

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/wicketway", "root", "Sudhar@123");
    PreparedStatement ps = con.prepareStatement("SELECT * FROM admin WHERE username=? AND password=?");
    ps.setString(1, username);
    ps.setString(2, password);
    ResultSet rs = ps.executeQuery();

    if(rs.next()) {
        session.setAttribute("admin", username);
        response.sendRedirect("admin_dashboard.jsp");
    } else {
        response.sendRedirect("adminlogin.jsp?error=Invalid+Credentials");
    }

    rs.close();
    ps.close();
    con.close();
} catch(Exception e) {
    out.println("Error: " + e.getMessage());
}
%>

