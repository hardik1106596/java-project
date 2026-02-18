<%@ page import="java.util.*, com.order.bean.*, com.order.dao.*" %>
<%
    if (session.getAttribute("user") == null) { 
        response.sendRedirect("login.jsp"); 
        return; 
    }
    User user = (User) session.getAttribute("user");
    List<product> products = new ProductDAO().getAllProducts();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - Order Management System</title>
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
                            <i class="fas fa-user me-2"></i>Welcome, <%= user.getName() %>
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
            <h1><i class="fas fa-store me-3"></i>Our Products</h1>
            <p class="lead">Browse our amazing collection of products</p>
        </div>

        <% if (products.isEmpty()) { %>
            <div class="alert alert-info text-center">
                <i class="fas fa-info-circle me-2"></i>No products available at the moment.
            </div>
        <% } else { %>
            <div class="row g-4">
                <% for (product p : products) { %>
                    <div class="col-md-6 col-lg-4">
                        <div class="product-card">
                            <div class="product-image">
                                <i class="fas fa-box-open"></i>
                            </div>
                            <div class="product-body">
                                <h5 class="product-title"><%= p.getProductName() %></h5>
                                <p class="text-muted mb-2"><%= p.getDescription() %></p>
                                <div class="product-price">
                                    <i class="fas fa-rupee-sign me-1"></i><%= String.format("%.2f", p.getPrice()) %>
                                </div>
                                <div class="product-qty">
                                    <i class="fas fa-box me-2"></i>Available: <%= p.getQuantity() %> units
                                </div>
                                <span class="badge bg-primary mb-3"><%= p.getCategory() %></span>
                                
                                <% if (p.getQuantity() > 0) { %>
                                    <form action="order" method="post" class="mt-3">
                                        <input type="hidden" name="productId" value="<%= p.getProductId() %>">
                                        <input type="hidden" name="price" value="<%= p.getPrice() %>">
                                        <div class="input-group mb-3">
                                            <span class="input-group-text">Qty</span>
                                            <input type="number" class="form-control" name="quantity" 
                                                   value="1" min="1" max="<%= p.getQuantity() %>" required>
                                        </div>
                                        <button type="submit" class="btn btn-success w-100">
                                            <i class="fas fa-shopping-cart me-2"></i>Order Now
                                        </button>
                                    </form>
                                <% } else { %>
                                    <button class="btn btn-secondary w-100" disabled>
                                        <i class="fas fa-times-circle me-2"></i>Out of Stock
                                    </button>
                                <% } %>
                            </div>
                        </div>
                    </div>
                <% } %>
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