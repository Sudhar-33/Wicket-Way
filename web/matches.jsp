<%-- 
    Document   : matches
    Created on : 25 Dec 2025, 11:14:20 pm
    Author     : ADMIN
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="db.DBConnection" %>

<%
    // ---------- AUTH CHECK ----------
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // ---------- READ STADIUM ID ----------
    String stadiumIdStr = request.getParameter("stadiumId");
    if (stadiumIdStr == null || stadiumIdStr.isEmpty()) {
        response.sendRedirect("Grounds.jsp"); // Redirect if no stadium selected
        return;
    }
    int stadiumId = Integer.parseInt(stadiumIdStr);

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String stadiumName = "";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Matches | WicketWay</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body { background-color: #f0f2f5; }
        .match-card {
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,.1);
            transition: 0.3s;
            margin-bottom: 20px;
        }
        .match-card:hover { transform: translateY(-5px); }
        .match-banner { height: 180px; object-fit: cover; }
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


<div class="container my-5 pt-5">
<%
    try {
        con = DBConnection.getConnection();

        // ---------- GET STADIUM NAME ----------
        ps = con.prepareStatement("SELECT name FROM stadiums WHERE id=?");
        ps.setInt(1, stadiumId);
        rs = ps.executeQuery();
        if (rs.next()) {
            stadiumName = rs.getString("name");
        } else {
            response.sendRedirect("Grounds.jsp"); // Stadium not found
            return;
        }
        rs.close();
        ps.close();

        // ---------- GET MATCHES FOR THIS STADIUM ----------
        ps = con.prepareStatement(
            "SELECT id, team1, team2, match_date, match_time, price, banner " +
            "FROM matches WHERE stadium_id=? AND status='ACTIVE' ORDER BY match_date ASC"
        );
        ps.setInt(1, stadiumId);
        rs = ps.executeQuery();

%>
    <h3 class="fw-bold mb-4">🏏 Matches at <%= stadiumName %></h3>
    <div class="row g-4">
<%
        boolean hasMatches = false;
        while (rs.next()) {
            hasMatches = true;
            int matchId = rs.getInt("id");
            String team1 = rs.getString("team1");
            String team2 = rs.getString("team2");
            Date matchDate = rs.getDate("match_date");
            String matchTime = rs.getString("match_time");
            int price = rs.getInt("price");
            String banner = rs.getString("banner");
%>
        <div class="col-md-6 col-lg-4">
            <div class="card match-card">
                <img src="<%= banner %>" class="match-banner w-100" alt="<%= team1 + " vs " + team2 %>">
                <div class="card-body">
                    <h5 class="fw-bold"><%= team1 %> vs <%= team2 %></h5>
                    <p>🗓 <%= matchDate %> • <%= matchTime %></p>
                    <p>💰 Price: ₹<%= price %></p>
                    <a href="seats.jsp?matchId=<%= matchId %>&stadium=<%= java.net.URLEncoder.encode(stadiumName, "UTF-8") %>"
                       class="btn btn-success w-100">Select Seats</a>
                </div>
            </div>
        </div>
<%
        }

        if (!hasMatches) {
%>
        <div class="alert alert-warning w-100 text-center">
            No matches available at this stadium yet.
        </div>
<%
        }
    } catch (Exception e) {
%>
    <div class="alert alert-danger w-100 text-center">
        Error loading matches: <%= e.getMessage() %>
    </div>
<%
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception ignored) {}
        if (ps != null) try { ps.close(); } catch (Exception ignored) {}
        if (con != null) try { con.close(); } catch (Exception ignored) {}
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
