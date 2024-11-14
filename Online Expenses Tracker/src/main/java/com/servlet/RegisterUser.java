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

@WebServlet("/userRegister")
public class RegisterUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Check if the form was accessed directly or from the register page
		HttpSession session = request.getSession();
		Boolean formAccessed = (Boolean) session.getAttribute("formAccessed");

		if (formAccessed == null || !formAccessed) {
			// If not accessed from the register form, redirect to register page
			response.sendRedirect("register.jsp");
			return;
		}

		// Clear the session attribute to prevent repeated submissions
		session.removeAttribute("formAccessed");

		// Retrieve form data from the request
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String mobile = request.getParameter("mobile");

		try (Connection conn = DatabaseConnection.getConnection()) {

			// Check if email or mobile number already exists
			String checkSQL = "SELECT COUNT(*) FROM users WHERE email = ? OR mobile = ?";
			try (PreparedStatement checkStmt = conn.prepareStatement(checkSQL)) {
				checkStmt.setString(1, email);
				checkStmt.setString(2, mobile);
				try (ResultSet rs = checkStmt.executeQuery()) {
					if (rs.next() && rs.getInt(1) > 0) {
						session.setAttribute("message", "Error: Email or Mobile number already exists!");
						session.setAttribute("messageType", "danger"); // Bootstrap alert type
						response.sendRedirect("register.jsp");
						return;
					}
				}
			}

			// Insert new user into the database
			String insertSQL = "INSERT INTO users (name, email, password, mobile) VALUES (?, ?, ?, ?)";
			try (PreparedStatement ps = conn.prepareStatement(insertSQL)) {
				ps.setString(1, name);
				ps.setString(2, email);
				ps.setString(3, password);
				ps.setString(4, mobile);
				ps.executeUpdate();

				// Registration successful
				session.setAttribute("message", "Registration Successful! You can now log in.");
				session.setAttribute("messageType", "success");
				response.sendRedirect("register.jsp");

			}

		} catch (SQLException e) {
			e.printStackTrace();
			// In case of an error, show a failure message
			session.setAttribute("message", "Registration Failed due to a server error.");
			session.setAttribute("messageType", "danger");
			response.sendRedirect("register.jsp");
		}
	}

	// You can also handle GET method for redirecting to the registration page
	// directly if needed
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Ensure that the form is accessed through the correct flow
		HttpSession session = request.getSession();
		session.setAttribute("formAccessed", true);
		response.sendRedirect("register.jsp");
	}
}
