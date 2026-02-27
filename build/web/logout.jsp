<%-- 
    Document   : logout
    Created on : 26 Dec 2025, 8:39:35 pm
    Author     : ADMIN
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
    // Destroy the session
    session.invalidate();

    // Redirect to home or login page
    response.sendRedirect("index.jsp");
%>

