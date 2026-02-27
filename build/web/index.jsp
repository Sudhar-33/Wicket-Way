<%-- 
    Document   : index
    Created on : 25 Dec 2025, 12:02:09 am
    Author     : ADMIN
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, db.DBConnection" %>
<%
    String username = (String) session.getAttribute("username");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>WicketWay | Cricket Stadium Ticket Booking</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/Home.css?v=11">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!--CSS Link-->
    
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
                <button class="btn btn-success btn-sm" type="submit">
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

<!-- HERO SECTION -->
<header class="hero">
    <div class="overlay">
        <div class="container text-center text-white">
            <h1 class="display-5 fw-bold">Book Cricket Stadium Tickets Easily</h1>
            <p class="lead">Live Matches • IPL • International • Domestic</p>

            <% if (username == null) { %>
                <a href="<%= request.getContextPath() %>/login.jsp" class="btn btn-warning btn-lg mt-3">🔐 Login to Book Ticket</a>
            <% } else { %>
                <a href="<%= request.getContextPath() %>/matchespage.jsp" class="btn btn-success btn-lg mt-3">🎟 Book Ticket</a>
            <% } %>
        </div>
    </div>
</header>

<!-- KEY FEATURES -->
<section class="container my-5">
    <h2 class="text-center fw-bold mb-4">✨ Why Choose WicketWay?</h2>
    <div class="row text-center g-4">
        <div class="col-md-3"><div class="p-4 shadow rounded bg-light h-100"><h1>🎟</h1><h5 class="fw-bold">Instant Booking</h5><p class="text-muted">Book tickets in seconds with live seat availability.</p></div></div>
        <div class="col-md-3"><div class="p-4 shadow rounded bg-light h-100"><h1>🏟</h1><h5 class="fw-bold">Top Stadiums</h5><p class="text-muted">All major Indian & international cricket stadiums.</p></div></div>
        <div class="col-md-3"><div class="p-4 shadow rounded bg-light h-100"><h1>💳</h1><h5 class="fw-bold">Secure Payments</h5><p class="text-muted">UPI, Cards & NetBanking with 100% security.</p></div></div>
        <div class="col-md-3"><div class="p-4 shadow rounded bg-light h-100"><h1>📱</h1><h5 class="fw-bold">Mobile Friendly</h5><p class="text-muted">Book anytime, anywhere from any device.</p></div></div>
    </div>
</section>

<!-- HOW IT WORKS -->
<section class="bg-light py-5">
    <div class="container">
        <h2 class="text-center fw-bold mb-4">⚡ How Booking Works</h2>
        <div class="row text-center g-4">
            <div class="col-md-3"><h1>🔍</h1><h5>Select Match</h5><p class="text-muted">Choose your favorite match & stadium.</p></div>
            <div class="col-md-3"><h1>🪑</h1><h5>Select Seats</h5><p class="text-muted">Pick stands and number of seats.</p></div>
            <div class="col-md-3"><h1>💳</h1><h5>Make Payment</h5><p class="text-muted">Fast & secure online payment.</p></div>
            <div class="col-md-3"><h1>🎉</h1><h5>Enjoy Match</h5><p class="text-muted">Get e-ticket & enjoy live cricket.</p></div>
        </div>
    </div>
</section>

<!-- LIVE HIGHLIGHTS -->
<section class="container my-5 text-center">
    <h2 class="fw-bold mb-4">🔥 Live Cricket Highlights</h2>
    <div class="row g-4">
        <div class="col-md-4"><div class="card shadow"><div class="card-body"><h3 class="fw-bold text-success" id="matchesCount">0</h3><p class="text-muted">Upcoming Matches</p></div></div></div>
        <div class="col-md-4"><div class="card shadow"><div class="card-body"><h3 class="fw-bold text-primary" id="stadiumCount">0</h3><p class="text-muted">Stadiums Covered</p></div></div></div>
        <div class="col-md-4"><div class="card shadow"><div class="card-body"><h3 class="fw-bold text-danger" id="bookingCount">0+</h3><p class="text-muted">Tickets Booked</p></div></div></div>
    </div>
</section>

<!-- UPCOMING MATCHES -->
<section id="grounds" class="container my-5">
    <h2 class="text-center fw-bold mb-4">🏆 Upcoming Matches – T20 World Cup</h2>
    <div class="row g-4">

        <!-- Example match, dynamic data should come from DB in future -->
        <div class="col-md-4 stadium-item">
            <div class="card stadium-card">
                <img src="https://assets-in.bmscdn.com/nmcms/events/banner/desktop/media-desktop-india-vs-pakistan-icc-men-s-t20-wc-2026-0-2025-12-11-t-13-57-9.jpg" class="card-img-top" alt="India vs Pakistan">
                <div class="card-body">
                    <h5 class="card-title">India vs Pakistan</h5>
                    <p class="card-text">Colombo • 15 Feb 2026</p>
                    <a href="<%= (username == null) ? request.getContextPath() + "/login.jsp" : request.getContextPath() + "/matchespage.jsp" %>" class="btn btn-success w-100">
                        <%= (username == null) ? "Login to Book" : "Book Ticket" %>
                    </a>
                </div>
            </div>
        </div>
                    
        
        <!-- Example match, dynamic data should come from DB in future -->
        <div class="col-md-4 stadium-item">
            <div class="card stadium-card">
                <img src="https://assets-in.bmscdn.com/nmcms/events/banner/desktop/media-desktop-india-vs-netherlands-icc-men-s-t20-wc-2026-0-2025-12-5-t-10-9-5.jpg" class="card-img-top" alt="India vs Pakistan">
                <div class="card-body">
                    <h5 class="card-title">India vs Netherlands</h5>
                    <p class="card-text">Ahmedabad • 18 Feb 2026</p>
                    <a href="<%= (username == null) ? request.getContextPath() + "/login.jsp" : request.getContextPath() + "/matchespage.jsp" %>" class="btn btn-success w-100">
                        <%= (username == null) ? "Login to Book" : "Book Ticket" %>
                    </a>
                </div>
            </div>
        </div>
                    
                    
                    
        <!-- Example match, dynamic data should come from DB in future -->
        <div class="col-md-4 stadium-item">
            <div class="card stadium-card">
                <img src="https://assets-in.bmscdn.com/nmcms/events/banner/desktop/media-desktop-india-vs-namibia-icc-men-s-t20-wc-2026-0-2025-12-5-t-13-5-20.jpg" class="card-img-top" alt="India vs Pakistan">
                <div class="card-body">
                    <h5 class="card-title">India vs Namibia</h5>
                    <p class="card-text">New Delhi • 12 Feb 2026</p>
                    <a href="<%= (username == null) ? request.getContextPath() + "/login.jsp" : request.getContextPath() + "/matchespage.jsp" %>" class="btn btn-success w-100">
                        <%= (username == null) ? "Login to Book" : "Book Ticket" %>
                    </a>
                </div>
            </div>
        </div>

    </div>
</section>

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




    

</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() %>/Home.js"></script>
</body>
</html>




