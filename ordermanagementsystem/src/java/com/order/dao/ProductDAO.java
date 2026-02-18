/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.order.dao;

import com.order.bean.product;
import com.order.util.DBconnection;
import java.sql.*;
import java.util.*;

/**
 *
 * @author Admin
 */


public class ProductDAO {
    
    public List<product> getAllProducts() {
        List<product> products = new ArrayList<>();
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        
        try {
            con = DBconnection.getConnect();
            st = con.createStatement();
            rs = st.executeQuery("SELECT * FROM products");
            
            while (rs.next()) {
                product product = new product();
                product.setProductId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setQuantity(rs.getInt("quantity"));
                product.setCategory(rs.getString("category"));
                product.setImageUrl(rs.getString("image_url"));
                products.add(product);
            }
        } catch (SQLException e) {
        } finally {
            DBconnection.closeConnection(con);
        }
        return products;
    }
    
    public product getProductById(int productId) {
        product product = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = DBconnection.getConnect();
            String query = "SELECT * FROM products WHERE product_id=?";
            ps = con.prepareStatement(query);
            ps.setInt(1, productId);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                product = new product();
                product.setProductId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setQuantity(rs.getInt("quantity"));
                product.setCategory(rs.getString("category"));
            }
        } catch (SQLException e) {
        } finally {
            DBconnection.closeConnection(con);
        }
        return product;
    }
    
    public boolean addProduct(product product) {
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            con = DBconnection.getConnect();
            String query = "INSERT INTO products(product_name, description, price, quantity, category) VALUES(?,?,?,?,?)";
            ps = con.prepareStatement(query);
            ps.setString(1, product.getProductName());
            ps.setString(2, product.getDescription());
            ps.setDouble(3, product.getPrice());
            ps.setInt(4, product.getQuantity());
            ps.setString(5, product.getCategory());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            return false;
        } finally {
            DBconnection.closeConnection(con);
        }
    }
    
    public boolean updateProduct(product product) {
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            con = DBconnection.getConnect();
            String query = "UPDATE products SET product_name=?, description=?, price=?, quantity=?, category=? WHERE product_id=?";
            ps = con.prepareStatement(query);
            ps.setString(1, product.getProductName());
            ps.setString(2, product.getDescription());
            ps.setDouble(3, product.getPrice());
            ps.setInt(4, product.getQuantity());
            ps.setString(5, product.getCategory());
            ps.setInt(6, product.getProductId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            return false;
        } finally {
            DBconnection.closeConnection(con);
        }
    }
    
    public boolean deleteProduct(int productId) {
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            con = DBconnection.getConnect();
            String query = "DELETE FROM products WHERE product_id=?";
            ps = con.prepareStatement(query);
            ps.setInt(1, productId);
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            DBconnection.closeConnection(con);
        }
    }
    
    public boolean updateQuantity(int productId, int quantity) {
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            con = DBconnection.getConnect();
            String query = "UPDATE products SET quantity=? WHERE product_id=?";
            ps = con.prepareStatement(query);
            ps.setInt(1, quantity);
            ps.setInt(2, productId);
            
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            return false;
        } finally {
            DBconnection.closeConnection(con);
        }
    }
}

