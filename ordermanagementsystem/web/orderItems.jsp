<meta charset="UTF-8">


<%@ page import="java.sql.*, com.order.util.*, com.order.bean.*" %>
<%
    // Check if user is logged in
    if (session.getAttribute("user") == null) { 
        response.sendRedirect("login.jsp"); 
        return; 
    }
    
    // Get order ID safely
    String oidParam = request.getParameter("oid");
    if (oidParam == null || oidParam.isEmpty()) {
        response.sendRedirect("orderHistory.jsp");
        return;
    }
    
    int orderId = 0;
    try {
        orderId = Integer.parseInt(oidParam);
    } catch (NumberFormatException e) {
        response.sendRedirect("orderHistory.jsp");
        return;
    }
    
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details - Order Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <!-- Preconnect for faster font loading -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<!-- Meta for better mobile experience -->
<meta name="theme-color" content="#667eea">
<meta name="apple-mobile-web-app-capable" content="yes">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">
                <i class="fas fa-shopping-cart me-2"></i>OrderMS
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <% if ("admin".equals(user.getRole())) { %>
                        <li class="nav-item">
                            <a class="nav-link" href="adminDashboard.jsp">
                                <i class="fas fa-user-shield me-2"></i>Admin Dashboard
                            </a>
                        </li>
                    <% } %>
                    <li class="nav-item">
                        <span class="nav-link">
                            <i class="fas fa-user me-2"></i><%= user.getName() %>
                        </span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="orderHistory.jsp">
                            <i class="fas fa-history me-2"></i>My Orders
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="logout">
                            <i class="fas fa-sign-out-alt me-2"></i>Logout
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="main-container">
        <div class="page-header">
            <h1><i class="fas fa-receipt me-3"></i>Order Details</h1>
            <p class="lead">Order #<%= orderId %></p>
        </div>

        <div class="table-container">
            <a href="orderHistory.jsp" class="btn btn-secondary mb-4">
                <i class="fas fa-arrow-left me-2"></i>Back to Orders
            </a>
            
            <h4 class="mb-4">Order Items</h4>
            
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>Product Name</th>
                            <th>Quantity</th>
                            <th>Price (?)</th>
                            <th>Subtotal (?)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            double total = 0;
                            try (Connection con = DBconnection.getConnect();
                                 PreparedStatement ps = con.prepareStatement(
                                     "SELECT oi.*, p.product_name FROM order_items oi " +
                                     "JOIN products p ON oi.product_id = p.product_id " +
                                     "WHERE oi.order_id = ?")) {
                                ps.setInt(1, orderId);
                                ResultSet rs = ps.executeQuery();
                                
                                boolean hasItems = false;
                                while(rs.next()) {
                                    hasItems = true;
                                    double subtotal = rs.getDouble("price") * rs.getInt("quantity");
                                    total += subtotal;
                        %>
                            <tr>
                                <td><strong><%= rs.getString("product_name") %></strong></td>
                                <td><%= rs.getInt("quantity") %></td>
                                <td>?<%= String.format("%.2f", rs.getDouble("price")) %></td>
                                <td><strong>?<%= String.format("%.2f", subtotal) %></strong></td>
                            </tr>
                        <% 
                                }
                                
                                if (!hasItems) {
                        %>
                            <tr>
                                <td colspan="4" class="text-center text-muted">No items found in this order</td>
                            </tr>
                        <% 
                                }
                            } catch(Exception e) { 
                                e.printStackTrace();
                        %>
                            <tr>
                                <td colspan="4" class="text-center text-danger">
                                    <i class="fas fa-exclamation-triangle me-2"></i>Error loading order items
                                </td>
                            </tr>
                        <%
                            }
                        %>
                    </tbody>
                    <tfoot class="table-light">
                        <tr>
                            <th colspan="3" class="text-end">Total Amount:</th>
                            <th><strong>?<%= String.format("%.2f", total) %></strong></th>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p class="mb-0"><i class="fas fa-copyright me-2"></i>2024 Order Management System. All rights reserved.</p>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>