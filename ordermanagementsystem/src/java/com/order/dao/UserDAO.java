package com.order.dao;

import com.order.bean.User;
import com.order.util.DBconnection;
import java.sql.*;
import java.util.*;

public class UserDAO {
    
    public User login(String email, String password) {
    System.out.println("[DAO] Trying to login: " + email);
    
    User user = null;
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    try {
        con = DBconnection.getConnect();
        System.out.println("[DAO] Connection: " + (con == null ? "NULL" : "OK"));

        if (con == null) {
            return null;
        }

        String query = "SELECT * FROM users WHERE email=? AND password=?";
        ps = con.prepareStatement(query);
        ps.setString(1, email);
        ps.setString(2, password);
        rs = ps.executeQuery();
        
        System.out.println("[DAO] Query executed");
        
        if (rs.next()) {
            System.out.println("[DAO] ✅ USER FOUND!");
            user = new User();
            user.setUserId(rs.getInt("user_id"));
            user.setName(rs.getString("name"));
            user.setEmail(rs.getString("email"));
            user.setPassword(rs.getString("password"));
            user.setPhone(rs.getString("phone"));
            user.setAddress(rs.getString("address"));
            user.setRole(rs.getString("role"));
            user.setCreatedAt(rs.getTimestamp("created_at"));
        } else {
            System.out.println("[DAO] ❌ USER NOT FOUND!");
        }
    } 
    catch (SQLException e) {
        System.out.println("[DAO] ERROR: " + e.getMessage());
        e.printStackTrace();
    } 
    finally {
        DBconnection.closeConnection(con);
    }
    return user;
}
    
    
    public boolean register(User user) {
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            con = DBconnection.getConnect();

            if (con == null) {
                System.out.println("[UserDAO] ERROR: Connection is NULL in register()");
                return false;
            }

            String query = "INSERT INTO users(name, email, password, phone, address, role) VALUES(?,?,?,?,?,?)";
            ps = con.prepareStatement(query);
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());
            ps.setString(6, "user");
            
            int result = ps.executeUpdate();
            System.out.println("[UserDAO] Register result: " + result + " row(s) inserted");
            return result > 0;
        } 
        catch (SQLException e) {
            System.out.println("[UserDAO] SQL ERROR in register(): " + e.getMessage());
            return false;
        } 
        finally {
            DBconnection.closeConnection(con);
        }
    }
    
    
    public User getUserById(int userId) {
        User user = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = DBconnection.getConnect();

            if (con == null) {
                System.out.println("[UserDAO] ERROR: Connection is NULL in getUserById()");
                return null;
            }

            String query = "SELECT * FROM users WHERE user_id=?";
            ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
            }
        }
        catch (SQLException e) {
            System.out.println("[UserDAO] SQL ERROR in getUserById(): " + e.getMessage());
        } 
        finally {
            DBconnection.closeConnection(con);
        }
        return user;
    }
    
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        
        try {
            con = DBconnection.getConnect();

            if (con == null) {
                System.out.println("[UserDAO] ERROR: Connection is NULL in getAllUsers()");
                return users;
            }

            st = con.createStatement();
            rs = st.executeQuery("SELECT * FROM users WHERE role='user'");
            
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                users.add(user);
            }
        } 
        catch (SQLException e) {
            System.out.println("[UserDAO] SQL ERROR in getAllUsers(): " + e.getMessage());
        } 
        finally {
            DBconnection.closeConnection(con);
        }
        return users;
    }
}