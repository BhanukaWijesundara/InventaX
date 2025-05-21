package servlet;

import model.User;
import service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class AdminServlet extends HttpServlet {
    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Optional: Check if user is admin
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("loggedUser");

        if (user != null && "admin".equalsIgnoreCase(user.getRole())) {
            // Admin verified
            request.setAttribute("users", userService.getAllUsers());
            RequestDispatcher dispatcher = request.getRequestDispatcher("dashboard.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("login.jsp?error=unauthorized");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Example: delete user from dashboard
        String action = request.getParameter("action");

        if ("deleteUser".equals(action)) {
            String userId = request.getParameter("userId");
            userService.deleteUser(userId);
            response.sendRedirect("admin");
        } else {
            doGet(request, response);
        }
    }
}