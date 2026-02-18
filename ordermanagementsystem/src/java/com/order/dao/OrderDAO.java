/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.order.dao;


import com.order.bean.Order;
import com.order.util.DBconnection;
import java.sql.*;
import java.util.*;

/**
 *
 * @author Admin
 */



public class OrderDAO {
    
    public boolean placeOrder(Order order, int productId, int quantity, double price) {
        Connection con = null;
        PreparedStatement ps1 = null, ps2 = null, ps3 = null;
        ResultSet rs = null;
        
        try {
            con = DBconnection.getConnect();
            con.setAutoCommit(false);
            
            // Insert order
            String query1 = "INSERT INTO orders(user_id, total_amount, shipping_address) VALUES(?,?,?)";
            ps1 = con.prepareStatement(query1, Statement.RETURN_GENERATED_KEYS);
            ps1.setInt(1, order.getUserId());
            ps1.setDouble(2, order.getTotalAmount());
            ps1.setString(3, order.getShippingAddress());
            ps1.executeUpdate();
            
            // Get generated order_id
            rs = ps1.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) {
                orderId = rs.getInt(1);
            }
            
            // Insert order item
            String query2 = "INSERT INTO order_items(order_id, product_id, quantity, price) VALUES(?,?,?,?)";
            ps2 = con.prepareStatement(query2);
            ps2.setInt(1, orderId);
            ps2.setInt(2, productId);
            ps2.setInt(3, quantity);
            ps2.setDouble(4, price);
            ps2.executeUpdate();
            
            // Update product quantity
            String query3 = "UPDATE products SET quantity = quantity - ? WHERE product_id=?";
            ps3 = con.prepareStatement(query3);
            ps3.setInt(1, quantity);
            ps3.setInt(2, productId);
            ps3.executeUpdate();
            
            con.commit();
            return true;
        } catch (Exception e) {
            try {
                if (con != null) con.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            DBconnection.closeConnection(con);
        }
    }
    
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = DBconnection.getConnect();
            String query = "SELECT * FROM orders WHERE user_id=? ORDER BY order_date DESC";
            ps = con.prepareStatement(query);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setStatus(rs.getString("status"));
                order.setShippingAddress(rs.getString("shipping_address"));
                orders.add(order);
            }
        } catch (SQLException e) {
        } finally {
            DBconnection.closeConnection(con);
        }
        return orders;
    }
    
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        
        try {
            con = DBconnection.getConnect();
            st = con.createStatement();
            rs = st.executeQuery("SELECT * FROM orders ORDER BY order_date DESC");
            
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setStatus(rs.getString("status"));
                order.setShippingAddress(rs.getString("shipping_address"));
                orders.add(order);
            }
        } catch (SQLException e) {
        } finally {
            DBconnection.closeConnection(con);
        }
        return orders;
    }
    
    public boolean updateOrderStatus(int orderId, String status) {
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            con = DBconnection.getConnect();
            String query = "UPDATE orders SET status=? WHERE order_id=?";
            ps = con.prepareStatement(query);
            ps.setString(1, status);
            ps.setInt(2, orderId);
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            DBconnection.closeConnection(con);
        }
    }
    
    public Order getOrderById(int orderId) {
        Order order = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = DBconnection.getConnect();
            String query = "SELECT * FROM orders WHERE order_id=?";
            ps = con.prepareStatement(query);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setStatus(rs.getString("status"));
                order.setShippingAddress(rs.getString("shipping_address"));
            }
        } catch (SQLException e) {
        } finally {
            DBconnection.closeConnection(con);
        }
        return order;
    }
}

