<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<%
    int expenseId = Integer.parseInt(request.getParameter("id"));
    Integer userId = (Integer) session.getAttribute("user_id");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    try {
        conn = com.db.DatabaseConnection.getConnection();
        String query = "SELECT * FROM expenses WHERE id = ? AND user_id = ?";
        ps = conn.prepareStatement(query);
        ps.setInt(1, expenseId);
        ps.setInt(2, userId);
        rs = ps.executeQuery();
        if (!rs.next()) {
            response.sendRedirect("user/viewExpenses.jsp");
            return;
        }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Expense</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<!-- Navbar -->
	<%@include file="../components/navbar.jsp"%>
    <div class="container mt-5">
        <h2 class="text-center mb-4">Edit Expense</h2>
        <div class="col-md-6 offset-md-3">
            <form action="../EditExpenseServlet" method="post">
                <input type="hidden" name="id" value="<%= expenseId %>">
                <div class="mb-3">
                    <label for="title" class="form-label">Title</label>
                    <input type="text" class="form-control" id="title" name="title" value="<%= rs.getString("title") %>" required>
                </div>
                <div class="mb-3">
                    <label for="date" class="form-label">Date</label>
                    <input type="date" class="form-control" id="date" name="date" value="<%= rs.getDate("date") %>" required>
                </div>
                <div class="mb-3">
                    <label for="category" class="form-label">Category</label>
                    <input type="text" class="form-control" id="category" name="category" value="<%= rs.getString("category") %>" required>
                </div>
                <div class="mb-3">
                    <label for="amount" class="form-label">Amount</label>
                    <input type="number" class="form-control" id="amount" name="amount" value="<%= rs.getBigDecimal("amount") %>" required>
                </div>
                <div class="mb-3">
                    <label for="description" class="form-label">Description</label>
                    <textarea class="form-control" id="description" name="description"><%= rs.getString("description") %></textarea>
                               </div>
                <div class="mb-3 text-center">
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                    <a href="viewExpenses.jsp" class="btn btn-secondary ml-2">Cancel</a>
                </div>
            </form>
        </div>
    </div>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("");
    } finally {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
               