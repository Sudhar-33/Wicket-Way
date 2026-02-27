<%-- 
    Document   : seats
    Created on : 25 Dec 2025, 11:14:37 pm
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, db.DBConnection" %>
<%@page session="true"%>

<%
    // -------- AUTH CHECK --------
    String username = (String) session.getAttribute("username");
    if(username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // -------- GET MATCH ID --------
    String matchIdStr = request.getParameter("matchId");
    if(matchIdStr == null || matchIdStr.isEmpty()) {
        response.sendRedirect("matchespage.jsp");
        return;
    }

    int matchId = Integer.parseInt(matchIdStr);

    // -------- FETCH MATCH INFO --------
    String matchName = "";
    String matchDate = "";
    String matchTime = "";
    String stadium    = "";

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        con = DBConnection.getConnection();
        ps = con.prepareStatement(
            "SELECT m.team1, m.team2, m.match_date, m.match_time, s.name AS stadium " +
            "FROM matches m JOIN stadiums s ON m.stadium_id = s.id WHERE m.id=?"
        );
        ps.setInt(1, matchId);
        rs = ps.executeQuery();

        if(rs.next()) {
            matchName = rs.getString("team1") + " vs " + rs.getString("team2");
            matchDate = rs.getString("match_date");
            matchTime = rs.getString("match_time");
            stadium   = rs.getString("stadium");
        } else {
            response.sendRedirect("matchespage.jsp");
            return;
        }
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
        return;
    } finally {
        if(rs != null) try { rs.close(); } catch(Exception ignored){}
        if(ps != null) try { ps.close(); } catch(Exception ignored){}
        if(con != null) try { con.close(); } catch(Exception ignored){}
    }

    // -------- HANDLE FORM SUBMIT --------
    if("POST".equalsIgnoreCase(request.getMethod())) {
        String stand = request.getParameter("stand");
        int seats = Integer.parseInt(request.getParameter("seats"));

        int price = 0;
        if("GENERAL".equalsIgnoreCase(stand)) price = 500;
        else if("PREMIUM".equalsIgnoreCase(stand)) price = 1500;
        else if("VIP".equalsIgnoreCase(stand)) price = 3000;

        session.setAttribute("matchId", matchId);
        session.setAttribute("matchName", matchName);
        session.setAttribute("stadium", stadium);
        session.setAttribute("stand", stand);
        session.setAttribute("seats", seats);
        session.setAttribute("price", price);

        response.sendRedirect("payment.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Select Seats | WicketWay</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(to right, #4facfe, #00f2fe); min-height:100vh; display:flex; justify-content:center; align-items:center; }
        .seat-container { background:#fff; padding:30px; border-radius:15px; width:100%; max-width:500px; box-shadow:0 8px 20px rgba(0,0,0,.3);}
        .btn-custom { background: linear-gradient(to right, #34e89e, #0f3443); color:white; font-weight:bold; }
    </style>
</head>
<body>

<div class="seat-container">
    <h3 class="text-center mb-4">🎟 Select Your Seats</h3>

    <p><b>Match:</b> <%= matchName %></p>
    <p><b>Stadium:</b> <%= stadium %></p>
    <p><b>Date:</b> <%= matchDate %> | <b>Time:</b> <%= matchTime %></p>

    <form method="post">
        <label class="fw-bold">Select Stand</label>
        <select name="stand" class="form-select mb-3" required>
            <option value="GENERAL">General - ₹500</option>
            <option value="PREMIUM">Premium - ₹1500</option>
            <option value="VIP">VIP - ₹3000</option>
        </select>

        <label class="fw-bold">Number of Seats</label>
        <input type="number" name="seats" class="form-control mb-3" min="1" max="6" required>

        <button type="submit" class="btn btn-custom w-100">Proceed to Payment</button>
    </form>
</div>

</body>
</html>






