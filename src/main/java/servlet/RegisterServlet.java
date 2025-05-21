package servlet;

import model.User;
import service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class RegisterServlet extends HttpServlet {
    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String userId = request.getParameter("userId");

        if (userService.isUsernameExists(username)) {
            request.setAttribute("error", "Username already exists!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }


        List<User> users = userService.getAllUsers();
        if (users.stream().anyMatch(user -> user.getUserId().equals(userId))) {
            request.setAttribute("error", "User ID already exists!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }


        User newUser = new User(userId, username, password, "user");
        userService.addUser(newUser);

        request.setAttribute("success", "Registration successful! Please login.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}