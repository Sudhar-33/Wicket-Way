<%-- 
    Document   : payment
    Created on : 25 Dec 2025, 11:14:51 pm
    Author     : ADMIN
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="db.DBConnection" %>
<%@ page session="true" %>

<%
    // ---------- AUTH CHECK ----------
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // ---------- READ SESSION DATA ----------
    String matchName = (String) session.getAttribute("matchName");
    String stadium   = (String) session.getAttribute("stadium");
    String stand     = (String) session.getAttribute("stand");
    Integer seats    = (Integer) session.getAttribute("seats");
    Integer price    = (Integer) session.getAttribute("price");

    if (matchName == null || stadium == null || stand == null || seats == null || price == null) {
        response.sendRedirect("seats.jsp");
        return;
    }

    int totalAmount = price * seats;

    // ---------- HANDLE PAYMENT SUBMISSION ----------
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            Connection con = null;
            PreparedStatement ps = null;
            try {
                con = DBConnection.getConnection();

                // Insert booking into database
                ps = con.prepareStatement(
                    "INSERT INTO bookings (username, match_name, stadium, stand, seats, total_amount, booking_date) " +
                    "VALUES (?, ?, ?, ?, ?, ?, NOW())"
                );
                ps.setString(1, username);
                ps.setString(2, matchName);
                ps.setString(3, stadium);
                ps.setString(4, stand);
                ps.setInt(5, seats);
                ps.setInt(6, totalAmount);

                ps.executeUpdate();

                // Clear session data after booking
                session.removeAttribute("matchId");
                session.removeAttribute("matchName");
                session.removeAttribute("stadium");
                session.removeAttribute("stand");
                session.removeAttribute("seats");
                session.removeAttribute("price");

            } finally {
                if(ps != null) try { ps.close(); } catch(Exception ignored) {}
                if(con != null) try { con.close(); } catch(Exception ignored) {}
            }

            // Redirect to my bookings
            response.sendRedirect("mybooking.jsp");
            return;

        } catch(Exception e) {
            out.println("<div class='alert alert-danger text-center mt-3'>DB Error: " + e.getMessage() + "</div>");
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payment | WicketWay</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(to right,#00c6ff,#0072ff);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .payment-card {
            background: #fff;
            padding: 30px;
            border-radius: 15px;
            width: 100%;
            max-width: 500px;
            box-shadow: 0 10px 25px rgba(0,0,0,.3);
        }
        .btn-confirm {
            width: 100%;
            background: linear-gradient(to right, #34e89e, #0f3443);
            color: white;
            font-weight: bold;
        }
        label { font-weight: bold; }
    </style>
</head>
<body>

<div class="payment-card">
    <h3 class="text-center mb-4">💳 Payment Confirmation</h3>

    <ul class="list-group mb-3">
        <li class="list-group-item"><b>Match:</b> <%= matchName %></li>
        <li class="list-group-item"><b>Stadium:</b> <%= stadium %></li>
        <li class="list-group-item"><b>Stand:</b> <%= stand %></li>
        <li class="list-group-item"><b>Seats:</b> <%= seats %></li>
        <li class="list-group-item"><b>Total Amount:</b> ₹<%= totalAmount %></li>
    </ul>

    <form method="post">
        <label>Select Payment Method</label><br>
        <div class="form-check">
            <input class="form-check-input" type="radio" name="payment" id="credit" value="Credit Card" required>
            <label class="form-check-label" for="credit">Credit Card</label>
        </div>
        <div class="form-check">
            <input class="form-check-input" type="radio" name="payment" id="debit" value="Debit Card">
            <label class="form-check-label" for="debit">Debit Card</label>
        </div>
        <div class="form-check">
            <input class="form-check-input" type="radio" name="payment" id="upi" value="UPI">
            <label class="form-check-label" for="upi">UPI</label>
        </div>
        <div class="form-check">
            <input class="form-check-input" type="radio" name="payment" id="wallet" value="Wallet">
            <label class="form-check-label" for="wallet">Wallet</label>
        </div>

        <button type="submit" class="btn btn-confirm mt-3">Confirm & Pay</button>
    </form>
</div>

</body>
</html>





