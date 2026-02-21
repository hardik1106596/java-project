package com.order.controller;

import com.order.bean.User;
import com.order.dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("========== LOGIN STARTED ==========");
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        System.out.println("Email: " + email);
        System.out.println("Password: " + password);
        
        User user = new UserDAO().login(email, password);
        
        System.out.println("User from DB: " + user);
        
        if (user != null) {
            System.out.println("Login SUCCESS - Role: " + user.getRole());
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            if ("admin".equals(user.getRole())) {
                response.sendRedirect("adminDashboard.jsp");
            } else {
                response.sendRedirect("index.jsp");
            }
        } else {
            System.out.println("Login FAILED - User is NULL");
            request.setAttribute("msg", "Invalid Email or Password!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}