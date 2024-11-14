package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.db.DatabaseConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/userLogin")
public class LoginUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Retrieve login credentials from form
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		HttpSession session = request.getSession();

		// If the user is already logged in, redirect to home page
		if (session.getAttribute("user") != null) {
			response.sendRedirect("user/home.jsp");
			return;
		}

		try (Connection conn = DatabaseConnection.getConnection()) {
			// Check if the email and password match in the database
			String loginSQL = "SELECT id, name FROM users WHERE email = ? AND password = ?";
			try (PreparedStatement ps = conn.prepareStatement(loginSQL)) {
				ps.setString(1, email);
				ps.setString(2, password);

				try (ResultSet rs = ps.executeQuery()) {
					if (rs.next()) {
						// If login is successful, store user information in session
						int userId = rs.getInt("id"); // Get the user ID from result set
						String userName = rs.getString("name");

						session.setAttribute("user", userName); // Store user's name
						session.setAttribute("user_id", userId); // Store user's ID
						session.setAttribute("userEmail", email);

						response.sendRedirect("user/home.jsp"); // Redirect to home page
					} else {
						// If login fails, show error message
						session.setAttribute("message", "Invalid email or password!");
						session.setAttribute("messageType", "danger");
						response.sendRedirect("login.jsp"); // Redirect to login page
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			session.setAttribute("message", "Login Failed due to a server error.");
			session.setAttribute("messageType", "danger");
			response.sendRedirect("login.jsp"); // Redirect to login page
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// If the user is already logged in, redirect to home page
		HttpSession session = request.getSession();
		if (session.getAttribute("user") != null) {
			response.sendRedirect("index.jsp");
		} else {
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}
}
