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

@WebServlet("/AddExpenseServlet")
public class AddExpenseServlet extends HttpServlet {
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

		// Retrieve form data
		String title = request.getParameter("title");
		String dateStr = request.getParameter("date");
		String category = request.getParameter("category");
		BigDecimal amount = new BigDecimal(request.getParameter("amount"));
		String description = request.getParameter("description");

		try (Connection conn = com.db.DatabaseConnection.getConnection()) {
			String sql = "INSERT INTO expenses (user_id, title, date, category, amount, description) VALUES (?, ?, ?, ?, ?, ?)";
			try (PreparedStatement ps = conn.prepareStatement(sql)) {
				ps.setInt(1, userId);
				ps.setString(2, title);
				ps.setDate(3, Date.valueOf(dateStr));
				ps.setString(4, category);
				ps.setBigDecimal(5, amount);
				ps.setString(6, description);

				ps.executeUpdate();
				// Set success message
				session.setAttribute("message", "Expense added successfully!");
				session.setAttribute("messageType", "success");
			}
		} catch (SQLException e) {
			e.printStackTrace();

			// Set failure message
			session.setAttribute("message", "Failed to add expense. Please try again.");
			session.setAttribute("messageType", "danger");
		}

		// Redirect back to addExpense.jsp
		response.sendRedirect("user/addExpenses.jsp");
	}
}
