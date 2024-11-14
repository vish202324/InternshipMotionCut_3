<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Expenses</title>
    <!-- Bootstrap CSS -->
  <%@include file="../components/all_css.jsp" %>
</head>
<body>
    <!-- Navbar -->
    <%@include file="../components/navbar.jsp" %>
    <div class="container mt-5">
    <!-- Display Messages -->
        <%
            String message = (String) session.getAttribute("message");
            String messageType = (String) session.getAttribute("messageType");
            if (message != null && messageType != null) {
        %>
            <div class="alert alert-<%= messageType %> alert-dismissible fade show" role="alert">
                <%= message %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <%
            session.removeAttribute("message");
            session.removeAttribute("messageType");
            }
        %>
        <h2 class="text-center mb-4">Your Expenses</h2>
        <div class="table-responsive">
            <table class="table table-bordered table-striped table-hover">
                <thead class="table-primary">
                    <tr>
                        <th>Title</th>
                        <th>Date</th>
                        <th>Category</th>
                        <th>Amount</th>
                        <th>Description</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Integer userId = (Integer) session.getAttribute("user_id");
                        if (userId != null) {
                            java.sql.Connection conn = null;
                            java.sql.PreparedStatement ps = null;
                            java.sql.ResultSet rs = null;

                            try {
                                conn = com.db.DatabaseConnection.getConnection();
                                String query = "SELECT id, title, date, category, amount, description FROM expenses WHERE user_id = ?";
                                ps = conn.prepareStatement(query);
                                ps.setInt(1, userId);
                                rs = ps.executeQuery();

                                while (rs.next()) {
                                    int expenseId = rs.getInt("id");
                    %>
                    <tr>
                        <td><%= rs.getString("title") %></td>
                        <td><%= rs.getDate("date") %></td>
                        <td><%= rs.getString("category") %></td>
                        <td><%= rs.getBigDecimal("amount") %></td>
                        <td><%= rs.getString("description") != null ? rs.getString("description") : "N/A" %></td>
                        <td>
                            <a href="editExpense.jsp?id=<%= expenseId %>" class="btn btn-warning btn-sm"><i class="fa-solid fa-pen-to-square"></i>&nbsp;Edit</a>
                            <a href="../DeleteExpenseServlet?id=<%= expenseId %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this expense?');"><i class="fa-solid fa-trash-can"></i>&nbsp;Delete</a>
                        </td>
                    </tr>
                    <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (rs != null) rs.close();
                                if (ps != null) ps.close();
                                if (conn != null) conn.close();
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>