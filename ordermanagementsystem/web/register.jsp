<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Order Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
    <div class="auth-container">
        <div class="auth-card">
            <div class="auth-header">
                <i class="fas fa-user-plus fa-3x text-primary mb-3"></i>
                <h2>Create Account</h2>
                <p class="text-muted">Join our order management system</p>
            </div>
            
            <% String success = (String) request.getAttribute("success");
               if ("true".equals(success)) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>Registration successful! Please login.
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>
            
            <form action="register" method="post">
                <div class="mb-3">
                    <label class="form-label"><i class="fas fa-user me-2"></i>Full Name</label>
                    <input type="text" class="form-control" name="name" placeholder="Enter your full name" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label"><i class="fas fa-envelope me-2"></i>Email Address</label>
                    <input type="email" class="form-control" name="email" placeholder="Enter your email" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label"><i class="fas fa-phone me-2"></i>Phone Number</label>
                    <input type="tel" class="form-control" name="phone" placeholder="Enter your phone number" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label"><i class="fas fa-map-marker-alt me-2"></i>Address</label>
                    <textarea class="form-control" name="address" rows="3" placeholder="Enter your address" required></textarea>
                </div>
                
                <div class="mb-3">
                    <label class="form-label"><i class="fas fa-lock me-2"></i>Password</label>
                    <input type="password" class="form-control" name="password" placeholder="Create a password" required>
                </div>
                
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary btn-lg">
                        <i class="fas fa-user-plus me-2"></i>Register
                    </button>
                </div>
            </form>
            
            <div class="text-center mt-4">
                <p class="text-muted">Already have an account? <a href="login.jsp" class="text-primary text-decoration-none">Login here</a></p>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>