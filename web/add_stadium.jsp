<%-- 
    Document   : add_stadium
    Created on : 26 Dec 2025, 5:18:05 pm
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
if(session.getAttribute("admin") == null) {
    response.sendRedirect("adminlogin.jsp");
    return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Add Stadium | WicketWay</title>
    <meta charset="UTF-8">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f5f6fa;
        }

        h3 {
            font-weight: 600;
        }

        table {
            background: #ffffff;
        }

        th {
            width: 30%;
            background-color: #f1f1f1;
            vertical-align: middle;
        }

        td {
            vertical-align: middle;
        }
    </style>
</head>

<body>

<div class="container my-5">

    <h3 class="mb-4">Add New Stadium</h3>

    <!-- LOGIC UNCHANGED -->
    <form action="add_stadium_process.jsp" method="post">

        <table class="table table-bordered">
            <tr>
                <th>Stadium Name</th>
                <td>
                    <input type="text" name="name" class="form-control" required>
                </td>
            </tr>

            <tr>
                <th>City</th>
                <td>
                    <input type="text" name="city" class="form-control" required>
                </td>
            </tr>

            <tr>
                <th>Capacity</th>
                <td>
                    <input type="number" name="capacity" class="form-control" required>
                </td>
            </tr>

            <tr>
                <th>Image URL</th>
                <td>
                    <input type="text" name="image" class="form-control">
                </td>
            </tr>

            <tr>
                <td colspan="2" class="text-center">
                    <button type="submit" class="btn btn-success me-2">
                        Save
                    </button>
                    <a href="admin_dashboard.jsp" class="btn btn-secondary">
                        Back
                    </a>
                </td>
            </tr>
        </table>

    </form>

</div>

</body>
</html>



