<%-- 
    Document   : delete_stadium.jsp
    Created on : 26 Dec 2025, 5:57:21 pm
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

int id = Integer.parseInt(request.getParameter("id"));

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/wicketway","root","Sudhar@123");
    PreparedStatement ps = con.prepareStatement("DELETE FROM stadiums WHERE id=?");
    ps.setInt(1, id);
    ps.executeUpdate();

    ps.close();
    con.close();
    response.sendRedirect("admin_dashboard.jsp");
} catch(Exception e) {
    out.println(e);
}
%>

