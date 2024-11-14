package com.servlet;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/EditExpenseServlet")
public class EditExpenseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("user_id");

		if (userId == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		int expenseId = Integer.parseInt(request.getParameter("id"));
		String title = request.getParameter("title");
		String dateStr = request.getParameter("date");
		String category = request.getParameter("category");
		BigDecimal amount = new BigDecimal(request.getParameter("amount"));
		String description = request.getParameter("description");

		try (Connection conn = com.db.DatabaseConnection.getConnection()) {
			String sql = "UPDATE expenses SET title = ?, date = ?, category = ?, amount = ?, description = ? WHERE id = ? AND user_id = ?";
			try (PreparedStatement ps = conn.prepareStatement(sql)) {
				ps.setString(1, title);
				ps.setDate(2, Date.valueOf(dateStr));
				ps.setString(3, category);
				ps.setBigDecimal(4, amount);
				ps.setString(5, description);
				ps.setInt(6, expenseId);
				ps.setInt(7, userId);

				int rowsAffected = ps.executeUpdate();
				if (rowsAffected > 0) {
					session.setAttribute("message", "Expense updated successfully.");
					session.setAttribute("messageType", "success");
				} else {
					session.setAttribute("message", "Failed to update expense.");
					session.setAttribute("messageType", "danger");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			session.setAttribute("message", "An error occurred while updating the expense.");
			session.setAttribute("messageType", "danger");
		}

		response.sendRedirect("user/viewExpenses.jsp");
	}
}
