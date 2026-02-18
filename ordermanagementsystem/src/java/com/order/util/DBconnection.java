package com.order.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBconnection {
    
    // ⚙️ CONFIGURATION - CHANGE THESE IF NEEDED
    private static final String URL = "jdbc:mysql://localhost:3306/orderdb";
    private static final String USER = "root";
    private static final String PASSWORD = "1234"; // ⚠️ CHANGE THIS to your MySQL password
    
    // Load MySQL Driver
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("✅ MySQL Driver Loaded Successfully");
        } catch (ClassNotFoundException e) {
            System.out.println("❌ MySQL Driver Not Found! Add MySQL Connector JAR to Libraries.");
        }
    }
    
    // Method to get Connection
    public static Connection getConnect() {
        try {
            Connection con = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✅ Database Connected: " + URL);
            return con;
        } catch (SQLException e) {
            System.out.println("❌ Database Connection Failed!");
            System.out.println("Error: " + e.getMessage());
            return null;
        }
    }
    
    // Method to close Connection
    public static void closeConnection(Connection con) {
        try {
            if (con != null && !con.isClosed()) {
                con.close();
                System.out.println("🔒 Database Connection Closed");
            }
        } catch (SQLException e) {
        }
    }
}