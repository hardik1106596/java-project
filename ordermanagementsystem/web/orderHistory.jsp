<%@ page import="java.util.*, java.sql.*, com.order.bean.*, com.order.dao.*, com.order.util.*" %>
<%
    if (session.getAttribute("user") == null) { 
        response.sendRedirect("login.jsp"); 
        return; 
    }
    User user = (User) session.getAttribute("user");
    List<Order> orders = new OrderDAO().getOrdersByUserId(user.getUserId());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order History - Order Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
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
                    <li class="nav-item">
                        <span class="nav-link">
                            <i class="fas fa-user me-2"></i><%= user.getName() %>
                        </span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="index.jsp">
                            <i class="fas fa-store me-2"></i>Shop
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

    <div class="main-container">
        <div class="page-header">
            <h1><i class="fas fa-history me-3"></i>My Order History</h1>
            <p class="lead">Track all your orders in one place</p>
        </div>

        <% if (orders.isEmpty()) { %>
            <div class="alert alert-info text-center">
                <i class="fas fa-info-circle me-2"></i>You haven't placed any orders yet. 
                <a href="index.jsp" class="alert-link">Start shopping now!</a>
            </div>
        <% } else { %>
            <div class="table-container">
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Order Date</th>
                                <th>Total Amount</th>
                                <th>Status</th>
                                <th>Shipping Address</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Order o : orders) { 
                                String statusClass = "";
                                String icon = "";
                                switch(o.getStatus().toLowerCase()) {
                                    case "placed": 
                                        statusClass = "status-placed"; 
                                        icon = "fa-clock";
                                        break;
                                    case "shipped": 
                                        statusClass = "status-shipped"; 
                                        icon = "fa-truck";
                                        break;
                                    case "delivered": 
                                        statusClass = "status-delivered"; 
                                        icon = "fa-check-circle";
                                        break;
                                    case "cancelled": 
                                        statusClass = "status-cancelled"; 
                                        icon = "fa-times-circle";
                                        break;
                                }
                            %>
                                <tr>
                                    <td><strong>#<%= o.getOrderId() %></strong></td>
                                    <td><i class="far fa-calendar-alt me-2"></i><%= o.getOrderDate() %></td>
                                    <td><strong>?<%= String.format("%.2f", o.getTotalAmount()) %></strong></td>
                                    <td>
                                        <span class="badge <%= statusClass %>">
                                            <i class="fas <%= icon %> me-1"></i><%= o.getStatus() %>
                                        </span>
                                    </td>
                                    <td><i class="fas fa-map-marker-alt me-2"></i><%= o.getShippingAddress() %></td>
                                    <td>
                                        <a href="orderItems.jsp?oid=<%= o.getOrderId() %>" 
                                           class="btn btn-primary btn-sm">
                                            <i class="fas fa-eye me-1"></i>View Items
                                        </a>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        <% } %>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p class="mb-0"><i class="fas fa-copyright me-2"></i>2024 Order Management System. All rights reserved.</p>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>