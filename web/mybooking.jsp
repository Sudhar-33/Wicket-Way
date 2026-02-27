<%-- 
    Document   : mybooking
    Created on : 25 Dec 2025, 11:15:25 pm
    Author     : ADMIN
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="db.DBConnection"%>
<%@ page session="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Bookings | WicketWay</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <!-- jsPDF -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>

    <style>
        body { background: #f4f6f9; font-family: 'Arial', sans-serif; }
        .booking-card {
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
            margin-bottom: 20px;
            position: relative;
            overflow: hidden;
            transition: transform 0.3s;
        }
        .booking-card:hover { transform: translateY(-5px); }
        .download-btn { position: absolute; top: 15px; right: 15px; }
        .no-booking { margin-top: 50px; }
    </style>
</head>
<body>

<%
    // ---------- AUTH CHECK ----------
    String username = (String) session.getAttribute("username");
    if(username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
%>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="fw-bold">🎟 My Bookings</h3>
        <a href="index.jsp" class="badge bg-success text-white px-3 py-2">Back To Home Page</a>
    </div>

<%
    try {
        con = DBConnection.getConnection();
        ps = con.prepareStatement(
            "SELECT * FROM bookings WHERE username=? ORDER BY booking_date DESC"
        );
        ps.setString(1, username);
        rs = ps.executeQuery();

        boolean hasBooking = false;
        while(rs.next()) {
            hasBooking = true;

            int bookingId = rs.getInt("booking_id");
            String matchName = rs.getString("match_name");
            String stadium = rs.getString("stadium");
            String stand = rs.getString("stand");
            int seats = rs.getInt("seats");
            int totalAmount = rs.getInt("total_amount");
            Timestamp bookingDate = rs.getTimestamp("booking_date");
%>

    <div class="card booking-card p-4" id="booking-<%= bookingId %>">
        <div class="row">
            <div class="col-md-8">
                <h5 class="fw-bold mb-3"><i class="bi bi-calendar-event"></i> Match Details</h5>
                <p><strong>🏏 Match:</strong> <%= matchName %></p>
                <p><strong>🏟 Stadium:</strong> <%= stadium %></p>
                <p><strong>📍 Stand:</strong> <%= stand %></p>
                <p><strong>💺 Seats:</strong> <%= seats %></p>
                <p><strong>🗓 Booking Date:</strong> <%= bookingDate %></p>
                <p><strong>💰 Total Paid:</strong> ₹<%= totalAmount %></p>
            </div>
            <div class="col-md-4 text-center border-start position-relative">
                <i class="bi bi-check-circle-fill text-success fs-1"></i>
                <h6 class="mt-2 fw-bold">Booking Confirmed</h6>
                <span class="badge bg-success mt-2">PAID</span>
                <button class="btn btn-primary download-btn mt-2" onclick="downloadPDF(<%= bookingId %>)">
                    <i class="bi bi-download"></i> Receipt
                </button>
            </div>
        </div>
    </div>

<%
        } // while

        if(!hasBooking) {
%>
    <div class="alert alert-warning text-center p-5 rounded no-booking">
        <i class="bi bi-ticket-perforated fs-1"></i>
        <h5 class="mt-3">No bookings found</h5>
        <p class="text-muted">Book a match and your ticket will appear here.</p>
        <a href="matches.jsp" class="btn btn-success mt-2">Book Match</a>
    </div>
<%
        }

    } catch(Exception e) {
        out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
    } finally {
        if(rs != null) try { rs.close(); } catch(Exception ignored) {}
        if(ps != null) try { ps.close(); } catch(Exception ignored) {}
        if(con != null) try { con.close(); } catch(Exception ignored) {}
    }
%>
</div>

<script>
function downloadPDF(id) {
    const { jsPDF } = window.jspdf;
    const doc = new jsPDF();

    const bookingCard = document.getElementById("booking-" + id);
    if (!bookingCard) return;

    const lines = bookingCard.innerText.split('\n');
    let y = 20;

    doc.setFontSize(16);
    doc.text("WicketWay Payment Receipt", 20, y);
    y += 10;
    doc.setFontSize(12);
    lines.forEach(line => {
        if(line.trim() !== "") {
            doc.text(line.trim(), 20, y);
            y += 8;
        }
    });

    doc.save("Booking_Receipt_" + id + ".pdf");
}
</script>

</body>
</html>




