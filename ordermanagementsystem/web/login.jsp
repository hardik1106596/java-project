<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Order Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <!-- Preconnect for faster font loading -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<!-- Meta for better mobile experience -->
<meta name="theme-color" content="#667eea">
<meta name="apple-mobile-web-app-capable" content="yes">
    <style>
        .login-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .login-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.3);
            padding: 40px;
            max-width: 900px;
            width: 100%;
        }
        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .login-header h2 {
            color: #667eea;
            font-weight: 700;
            margin-bottom: 10px;
        }
        .role-tabs {
            display: flex;
            margin-bottom: 30px;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .role-tab {
            flex: 1;
            padding: 15px;
            text-align: center;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
            border: none;
            background: #f8f9fa;
        }
        .role-tab.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .role-tab:hover {
            background: #e9ecef;
        }
        .role-tab.active:hover {
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
        }
        .login-form {
            display: none;
        }
        .login-form.active {
            display: block;
        }
        .admin-section {
            border-left: 4px solid #667eea;
            padding-left: 20px;
        }
        .customer-section {
            border-left: 4px solid #28a745;
            padding-left: 20px;
        }
        .btn-admin {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            font-weight: 600;
            padding: 10px 30px;
            border-radius: 25px;
            transition: all 0.3s;
        }
        .btn-admin:hover {
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        .btn-customer {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            border: none;
            font-weight: 600;
            padding: 10px 30px;
            border-radius: 25px;
            transition: all 0.3s;
        }
        .btn-customer:hover {
            background: linear-gradient(135deg, #38ef7d 0%, #11998e 100%);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(17, 153, 142, 0.4);
        }
        .info-box {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 15px;
            margin-top: 20px;
        }
        .info-box i {
            color: #667eea;
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-card">
            <div class="login-header">
                <i class="fas fa-shopping-cart fa-3x text-primary mb-3"></i>
                <h2>Welcome to Order Management System</h2>
                <p class="text-muted">Please select your role and login</p>
            </div>
            
            <!-- Role Selection Tabs -->
            <div class="role-tabs">
                <button class="role-tab active" onclick="showRole('admin')">
                    <i class="fas fa-user-shield me-2"></i>Admin
                </button>
                <button class="role-tab" onclick="showRole('customer')">
                    <i class="fas fa-user me-2"></i>Customer
                </button>
            </div>
            
            <% String msg = (String) request.getAttribute("msg");
               if (msg != null) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i><%= msg %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>
            
            <!-- Admin Login Form -->
            <div id="admin-form" class="login-form active admin-section">
                <h4 class="mb-3"><i class="fas fa-user-shield text-primary me-2"></i>Admin Login</h4>
                <form action="login" method="post">
                    <input type="hidden" name="role" value="admin">
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-envelope me-2"></i>Email Address</label>
                        <input type="email" class="form-control" name="email" placeholder="admin@order.com" required>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-lock me-2"></i>Password</label>
                        <input type="password" class="form-control" name="password" placeholder="Enter your password" required>
                    </div>
                    
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="adminRemember">
                        <label class="form-check-label" for="adminRemember">Remember me</label>
                    </div>
                    
                    <div class="d-grid">
                        <button type="submit" class="btn btn-admin btn-lg">
                            <i class="fas fa-sign-in-alt me-2"></i>Login as Admin
                        </button>
                    </div>
                </form>
                
                <div class="info-box">
                    <i class="fas fa-info-circle"></i>
                    <strong>Admin Credentials:</strong><br>
                    Email: admin@order.com<br>
                    Password: admin123
                </div>
            </div>
            
            <!-- Customer Login Form -->
            <div id="customer-form" class="login-form customer-section">
                <h4 class="mb-3"><i class="fas fa-user text-success me-2"></i>Customer Login</h4>
                <form action="login" method="post">
                    <input type="hidden" name="role" value="customer">
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-envelope me-2"></i>Email Address</label>
                        <input type="email" class="form-control" name="email" placeholder="your@email.com" required>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label"><i class="fas fa-lock me-2"></i>Password</label>
                        <input type="password" class="form-control" name="password" placeholder="Enter your password" required>
                    </div>
                    
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="customerRemember">
                        <label class="form-check-label" for="customerRemember">Remember me</label>
                    </div>
                    
                    <div class="d-grid">
                        <button type="submit" class="btn btn-customer btn-lg">
                            <i class="fas fa-sign-in-alt me-2"></i>Login as Customer
                        </button>
                    </div>
                </form>
                
                <div class="info-box">
                    <i class="fas fa-info-circle"></i>
                    <strong>New Customer?</strong><br>
                    <a href="register.jsp" class="text-success text-decoration-none">
                        <i class="fas fa-user-plus me-1"></i>Register here to create an account
                    </a>
                </div>
            </div>
            
            <div class="text-center mt-4">
                <p class="text-muted">
                    <i class="fas fa-question-circle me-1"></i>
                    Need help? Contact support
                </p>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function showRole(role) {
            // Hide all forms
            document.querySelectorAll('.login-form').forEach(form => {
                form.classList.remove('active');
            });
            document.querySelectorAll('.role-tab').forEach(tab => {
                tab.classList.remove('active');
            });
            
            // Show selected form
            if (role === 'admin') {
                document.getElementById('admin-form').classList.add('active');
                document.querySelectorAll('.role-tab')[0].classList.add('active');
            } else {
                document.getElementById('customer-form').classList.add('active');
                document.querySelectorAll('.role-tab')[1].classList.add('active');
            }
        }
    </script>
</body>
</html>