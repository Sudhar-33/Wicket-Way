<%-- 
    Document   : matchespage
    Created on : 26 Dec 2025, 12:47:10 pm
    Author     : ADMIN
--%>


<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="db.DBConnection" %>

<%
    String username = (String) session.getAttribute("username");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>WicketWay | Upcoming Matches</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="Home.css">

    <style>
        body { background-color: #f0f2f5; }
        .match-card { border-radius: 12px; overflow: hidden; transition: .3s; box-shadow: 0 5px 15px rgba(0,0,0,.1); }
        .match-card:hover { transform: translateY(-5px); }
        .match-banner { height: 220px; object-fit: cover; }
        .price-tag { position: absolute; top: 10px; left: 10px; background: #198754; color: #fff; padding: 5px 10px; border-radius: 20px; font-size: .9rem; }
        
    </style>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top shadow">
    <div class="container">
        <a class="navbar-brand fw-bold" href="<%= request.getContextPath() %>/index.jsp">
            🏏 WicketWay
        </a>

        <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#menu">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="menu">

            <!-- SEARCH (SMALL WIDTH) -->
            <form class="d-flex mx-auto my-2 my-lg-0 search-box">
                <input class="form-control form-control-sm me-2"
                       type="search"
                       id="searchInput"
                       placeholder="Search"
                >
                <button class="btn btn-success btn-sm" type="submit" disabled>
                    Search
                </button>
            </form>

            <!-- NAV LINKS -->
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-lg-center">
                <li class="nav-item">
                    <a class="nav-link active" href="<%= request.getContextPath() %>/index.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/matchespage.jsp">Matches</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/Grounds.jsp">Stadiums</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/mybooking.jsp">My Bookings</a>
                </li>

                <% if (username == null) { %>
                    <li class="nav-item">
                        <a class="btn btn-outline-light btn-sm me-2" href="<%= request.getContextPath() %>/login.jsp">
                            Login
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="btn btn-success btn-sm" href="<%= request.getContextPath() %>/register.jsp">
                            Register
                        </a>
                    </li>
                <% } else { %>
                    <li class="nav-item">
                        <span class="navbar-text text-white username-text me-3">
                            👤 <%= username %>
                        </span>
                    </li>
                    <li class="nav-item">
                        <a class="btn btn-danger btn-sm" href="<%= request.getContextPath() %>/logout.jsp">
                            Logout
                        </a>
                    </li>
                <% } %>
            </ul>

        </div>
    </div>
</nav>


<div class="container mt-5 pt-4">
    <h3 class="fw-bold mb-4">🏏 Upcoming Matches</h3>
    <div class="row g-4">

<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        con = DBConnection.getConnection();
        ps = con.prepareStatement(
            "SELECT m.id, m.team1, m.team2, m.match_date, m.match_time, m.price, m.banner, s.name AS stadium " +
            "FROM matches m JOIN stadiums s ON m.stadium_id = s.id"
        );
        rs = ps.executeQuery();

        while(rs.next()) {
            int matchId = rs.getInt("id");
            String stadium = rs.getString("stadium");
%>

        <div class="col-md-4">
            <div class="card match-card">
                <div class="position-relative">
                    <img src="<%= rs.getString("banner") %>" class="match-banner w-100">
                    <span class="price-tag">₹<%= rs.getInt("price") %></span>
                </div>
                <div class="card-body">
                    <h6 class="fw-bold"><%= rs.getString("team1") %> vs <%= rs.getString("team2") %></h6>
                    <p class="mb-1">📍 <%= stadium %></p>
                    <p class="mb-1">🗓 <%= rs.getDate("match_date") %> • <%= rs.getString("match_time") %></p>

                    <a href="seats.jsp?matchId=<%= matchId %>" class="btn btn-success w-100 mt-2">
                        <%= (username == null) ? "Login to Book" : "Book Now" %>
                    </a>
                </div>
            </div>
        </div>

<%
        }
    } catch(Exception e) {
%>
        <div class="alert alert-danger text-center">Error loading matches: <%= e.getMessage() %></div>
<%
    } finally {
        if(rs != null) try { rs.close(); } catch(Exception ignored){}
        if(ps != null) try { ps.close(); } catch(Exception ignored){}
        if(con != null) try { con.close(); } catch(Exception ignored){}
    }
%>

    </div>
</div>

<!-- ================= FOOTER ================= -->
<footer class="bg-dark text-white pt-5 pb-3">
    <div class="container">
        <div class="row">

            <!-- ABOUT -->
            <div class="col-md-4 mb-3">
                <h5 class="fw-bold">🏏 About WicketWay</h5>
                <p>
                    WicketWay is India’s trusted cricket ticket booking platform.
                    Book stadium tickets for IPL, international and domestic matches
                    with fast, secure and hassle-free experience.
                </p>
            </div>

            <!-- CUSTOMER SUPPORT -->
            <div class="col-md-4 mb-3">
                <h5 class="fw-bold">📞 Customer Support</h5>
                <ul class="list-unstyled">
                    <li>Email: support@wicketway.com</li>
                    <li>Phone: +91 98765 43210</li>
                    <li>Support Hours: 9 AM – 9 PM</li>
                </ul>
            </div>

            <!-- QUICK LINKS -->
            <div class="col-md-4 mb-3">
                <h5 class="fw-bold">🔗 Quick Links</h5>
                <ul class="list-unstyled">
                    <li><a href="index.jsp" class="text-white text-decoration-none">Home</a></li>
                    <li><a href="Grounds.jsp" class="text-white text-decoration-none">Stadiums</a></li>
                    <li><a href="mybooking.jsp" class="text-white text-decoration-none">My Bookings</a></li>
                    <li><a href="#" class="text-white text-decoration-none">Privacy Policy</a></li>
                </ul>
            </div>

        </div>

        <hr class="border-secondary">

        <p class="footer-text text-center mb-0">
    © 2025 WicketWay | 
    <span class="admin-text" onclick="window.location.href='adminlogin.jsp'">
        Admin
    </span>
</p>

    </div>
</footer>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>




