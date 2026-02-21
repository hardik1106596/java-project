package com.order.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBconnection {
    
    private static final String URL = "jdbc:mysql://localhost:3306/orderdb";
    private static final String USER = "root";
    private static final String PASSWORD = "1234"; // Change to YOUR MySQL password
    
    static {
        try {
            System.out.println("Loading MySQL Driver...");
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("✅ MySQL Driver Loaded Successfully!");
        } catch (ClassNotFoundException e) {
            System.out.println("❌ MySQL Driver NOT Found!");
            System.out.println("ERROR: " + e.getMessage());
            System.out.println("SOLUTION: Add mysql-connector-j-8.x.x.jar to Libraries!");
        }
    }
    
    public static Connection getConnect() {
        try {
            System.out.println("Trying to connect to: " + URL);
            Connection con = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✅ Database Connected Successfully!");
            return con;
        } catch (SQLException e) {
            System.out.println("❌ Database Connection Failed!");
            System.out.println("ERROR: " + e.getMessage());
            System.out.println("Check: 1) MySQL is running  2) Password is correct  3) Database exists");
            return null;
        }
    }
    
    public static void closeConnection(Connection con) {
        try {
            if (con != null && !con.isClosed()) {
                con.close();
                System.out.println("Database connection closed");
            }
        } catch (SQLException e) {
        }
    }
}