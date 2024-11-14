package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/DeleteExpenseServlet")
public class DeleteExpenseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("user_id");

		if (userId == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		int expenseId = Integer.parseInt(request.getParameter("id"));

		try (Connection conn = com.db.DatabaseConnection.getConnection()) {
			String sql = "DELETE FROM expenses WHERE id = ? AND user_id = ?";
			try (PreparedStatement ps = conn.prepareStatement(sql)) {
				ps.setInt(1, expenseId);
				ps.setInt(2, userId);

				int rowsAffected = ps.executeUpdate();
				if (rowsAffected > 0) {
					session.setAttribute("message", "Expense deleted successfully.");
					session.setAttribute("messageType", "success");
				} else {
					session.setAttribute("message", "Failed to delete expense.");
					session.setAttribute("messageType", "warning");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			session.setAttribute("message", "An error occurred while deleting the expense.");
			session.setAttribute("messageType", "danger");
		}

		response.sendRedirect("user/viewExpenses.jsp");
	}
}
