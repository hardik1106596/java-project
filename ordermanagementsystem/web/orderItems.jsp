<%@ page import="java.sql.*, com.order.util.*, com.order.bean.*" %>
<%
    if (session.getAttribute("user") == null) { 
        response.sendRedirect("login.jsp"); 
        return; 
    }
    
    int orderId = Integer.parseInt(request.getParameter("oid"));
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
</head>
<body>
    <div class="main-container">
        <div class="page-header">
            <h1><i class="fas fa-receipt me-3"></i>Order Details</h1>
            <p class="lead">Order #<%= orderId %></p>
        </div>

        <div class="table-container">
            <a href="orderHistory.jsp" class="btn btn-secondary mb-4">
                <i class="fas fa-arrow-left me-2"></i>Back to Orders
            </a>
            
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Product ID</th>
                            <th>Quantity</th>
                            <th>Price</th>
                            <th>Subtotal</th>
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
                                
                                while(rs.next()) {
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
                            } catch(Exception e) { 
                                e.printStackTrace();
                            }
                        %>
                    </tbody>
                    <tfoot>
                        <tr>
                            <th colspan="3" class="text-end">Total Amount:</th>
                            <th><strong>?<%= String.format("%.2f", total) %></strong></th>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>