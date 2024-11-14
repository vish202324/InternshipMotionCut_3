package com.servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutUser extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Get the current session
		HttpSession session = request.getSession(false); // false means do not create if not exists

		session.removeAttribute("user");
		session.setAttribute("message", "You are Successfully Logged out !");
		session.setAttribute("messageType", "success");
		response.sendRedirect("login.jsp");

//		// If a session exists, invalidate it
//		if (session != null) {
//			session.invalidate(); // This will remove all session attributes
//		}
//
//		// Prevent caching of the page to ensure the user cannot go back to the previous
//		// page
//		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
//		response.setHeader("Pragma", "no-cache"); // HTTP 1.0
//		response.setHeader("Expires", "0"); // Proxies
//
//		// Redirect to the index.jsp page after logging out
//		response.sendRedirect("logout.jsp"); // Redirect to the homepage or login page
	}
}
