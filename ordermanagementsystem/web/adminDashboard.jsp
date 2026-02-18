<%@ page import="java.util.*, com.order.bean.*, com.order.dao.*" %>
<%
    if (session.getAttribute("user") == null) { 
        response.sendRedirect("login.jsp"); 
        return; 
    }
    User user = (User) session.getAttribute("user");
    if (!"admin".equals(user.getRole())) { 
        response.sendRedirect("index.jsp"); 
        return; 
    }
    
    // Handle Add Product
    String action = request.getParameter("action");
    if ("add".equals(action)) {
        product p = new product();
        p.setProductName(request.getParameter("pname"));
        p.setDescription(request.getParameter("pdesc"));
        p.setPrice(Double.parseDouble(request.getParameter("pprice")));
        p.setQuantity(Integer.parseInt(request.getParameter("pqty")));
        p.setCategory(request.getParameter("pcat"));
        new ProductDAO().addProduct(p);
    }
    
    // Handle Delete Product
    if ("delete".equals(action)) {
        int pid = Integer.parseInt(request.getParameter("pid"));
        new ProductDAO().deleteProduct(pid);
        response.sendRedirect("adminDashboard.jsp");
    }
    
    List<product> products = new ProductDAO().getAllProducts();
    List<User> users = new UserDAO().getAllUsers();
    List<Order> orders = new OrderDAO().getAllOrders();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Order Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="adminDashboard.jsp">
                <i class="fas fa-user-shield me-2"></i>Admin Panel
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
                            <i class="fas fa-store me-2"></i>View Site
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
            <h1><i class="fas fa-tachometer-alt me-3"></i>Admin Dashboard</h1>
            <p class="lead">Manage products, orders, and users</p>
        </div>

        <!-- Statistics -->
        <div class="row g-4 mb-5">
            <div class="col-md-4">
                <div class="stats-card">
                    <div class="stats-icon text-primary">
                        <i class="fas fa-box"></i>
                    </div>
                    <div class="stats-number"><%= products.size() %></div>
                    <div class="stats-label">Total Products</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stats-card">
                    <div class="stats-icon text-success">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    <div class="stats-number"><%= orders.size() %></div>
                    <div class="stats-label">Total Orders</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stats-card">
                    <div class="stats-icon text-info">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="stats-number"><%= users.size() %></div>
                    <div class="stats-label">Total Users</div>
                </div>
            </div>
        </div>

        <!-- Add Product Section -->
        <div class="card mb-5">
            <div class="card-header">
                <i class="fas fa-plus-circle me-2"></i>Add New Product
            </div>
            <div class="card-body">
                <form method="post" class="row g-3">
                    <input type="hidden" name="action" value="add">
                    <div class="col-md-6">
                        <label class="form-label">Product Name</label>
                        <input type="text" class="form-control" name="pname" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Category</label>
                        <input type="text" class="form-control" name="pcat" required>
                    </div>
                    <div class="col-md-12">
                        <label class="form-label">Description</label>
                        <textarea class="form-control" name="pdesc" rows="2" required></textarea>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Price (?)</label>
                        <input type="number" class="form-control" name="pprice" step="0.01" required>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Quantity</label>
                        <input type="number" class="form-control" name="pqty" required>
                    </div>
                    <div class="col-md-4 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary w-100">
                            <i class="fas fa-plus me-2"></i>Add Product
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Products Table -->
        <div class="table-container mb-5">
            <h4 class="mb-4"><i class="fas fa-boxes me-2"></i>Product Management</h4>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Product Name</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (product p : products) { %>
                            <tr>
                                <td><%= p.getProductId() %></td>
                                <td><strong><%= p.getProductName() %></strong></td>
                                <td><%= p.getCategory() %></td>
                                <td>?<%= String.format("%.2f", p.getPrice()) %></td>
                                <td>
                                    <% if (p.getQuantity() > 10) { %>
                                        <span class="badge bg-success"><%= p.getQuantity() %></span>
                                    <% } else if (p.getQuantity() > 0) { %>
                                        <span class="badge bg-warning"><%= p.getQuantity() %></span>
                                    <% } else { %>
                                        <span class="badge bg-danger">Out of Stock</span>
                                    <% } %>
                                </td>
                                <td>
                                    <a href="adminDashboard.jsp?action=delete&pid=<%= p.getProductId() %>" 
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirm('Are you sure you want to delete this product?')">
                                        <i class="fas fa-trash me-1"></i>Delete
                                    </a>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Users Table -->
        <div class="table-container mb-5">
            <h4 class="mb-4"><i class="fas fa-users me-2"></i>Registered Users</h4>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Address</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (User u : users) { %>
                            <tr>
                                <td><%= u.getUserId() %></td>
                                <td><strong><%= u.getName() %></strong></td>
                                <td><%= u.getEmail() %></td>
                                <td><%= u.getPhone() %></td>
                                <td><%= u.getAddress() %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Orders Table -->
        <div class="table-container">
            <h4 class="mb-4"><i class="fas fa-shopping-bag me-2"></i>All Orders</h4>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>User ID</th>
                            <th>Date</th>
                            <th>Amount</th>
                            <th>Status</th>
                            <th>Address</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Order o : orders) { %>
                            <tr>
                                <td><strong>#<%= o.getOrderId() %></strong></td>
                                <td><%= o.getUserId() %></td>
                                <td><%= o.getOrderDate() %></td>
                                <td>?<%= String.format("%.2f", o.getTotalAmount()) %></td>
                                <td>
                                    <span class="badge status-<%= o.getStatus().toLowerCase() %>">
                                        <%= o.getStatus() %>
                                    </span>
                                </td>
                                <td><%= o.getShippingAddress() %></td>
                            </tr>
                        <% } %>
                    </tbody>
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