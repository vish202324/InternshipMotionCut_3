package com.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DatabaseConnection {

	private static final String URL = "jdbc:mysql://localhost:3306/"; // Notice we're pointing to the server, not a
																		// specific db
	private static final String USER = "root"; // Your MySQL username
	private static final String PASSWORD = "VIvek9045@#"; // Your MySQL password
	private static final String DATABASE_NAME = "expenses_db"; // The database you want to check

	public static Connection getConnection() throws SQLException {
		Connection conn = null;
		try {
			// Load the MySQL JDBC driver
			Class.forName("com.mysql.cj.jdbc.Driver");

			// Step 1: Connect to MySQL server (not directly to the database)
			conn = DriverManager.getConnection(URL, USER, PASSWORD);

			// Step 2: Check if the database exists
			if (!doesDatabaseExist(conn, DATABASE_NAME)) {
				throw new SQLException("Database " + DATABASE_NAME + " does not exist.");
			}

			// Step 3: If the database exists, connect to it
			conn = DriverManager.getConnection(URL + DATABASE_NAME, USER, PASSWORD);

		} catch (ClassNotFoundException e) {
			System.err.println("MySQL JDBC Driver not found. Please include the JDBC library.");
			throw new SQLException("JDBC Driver not found.", e);
		} catch (SQLException e) {
			// If database is not found or there's any connection error
			System.err.println(
					"Error: Unable to connect to the database. Please check if the database exists or if the connection settings are correct.");
			throw new SQLException("Database connection error.", e);
		}

		return conn;
	}

	// Method to check if a database exists
	private static boolean doesDatabaseExist(Connection conn, String dbName) throws SQLException {
		boolean exists = false;
		String sql = "SHOW DATABASES LIKE ?";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, dbName);
			try (ResultSet rs = ps.executeQuery()) {
				exists = rs.next(); // If the result set contains a row, the database exists
			}
		}
		return exists;
	}
}
