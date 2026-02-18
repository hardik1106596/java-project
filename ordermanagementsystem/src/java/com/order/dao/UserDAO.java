/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */


package com.order.dao;


import com.order.bean.User;
import com.order.util.DBconnection;
import java.sql.*;
import java.util.*;

/**
 *
 * @author Admin
 */
public class UserDAO 
{
    public User login(String email, String password) 
    {
        User user = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try 
        {
            con = DBconnection.getConnect();
            String query = "SELECT * FROM users WHERE email=? AND password=?";
            ps = con.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            rs = ps.executeQuery();
            
            
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
            }
        } catch (SQLException e) {
        } finally {
            DBconnection.closeConnection(con);
        }
        return user;
    }
    
    
    public boolean register(User user) {
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            con = DBconnection.getConnect();
            String query = "INSERT INTO users(name, email, password, phone, address, role) VALUES(?,?,?,?,?,?)";
            ps = con.prepareStatement(query);
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());
            ps.setString(6, "user");
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            return false;
        } finally {
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
        catch (SQLException e) 
        {
        } finally {
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
        } catch (SQLException e) {
        } finally {
            DBconnection.closeConnection(con);
        }
        return users;
    }
        
    
}
