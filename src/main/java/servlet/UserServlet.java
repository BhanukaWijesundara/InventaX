package servlet;

import model.User;
import service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class UserServlet extends HttpServlet {
    UserService service = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        User loggedUser = (User) session.getAttribute("loggedUser");
        if (!"admin".equals(loggedUser.getRole())) {
            response.sendRedirect("dashboard.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            request.getRequestDispatcher("/WEB-INF/views/user/addUser.jsp").forward(request, response);
        } else if ("edit".equals(action)) {
            String userId = request.getParameter("id");
            if (userId != null && !userId.isEmpty()) {
                List<User> users = service.getAllUsers();
                User userToEdit = users.stream()
                        .filter(user -> user.getUserId().equals(userId))
                        .findFirst()
                        .orElse(null);

                if (userToEdit != null) {
                    request.setAttribute("user", userToEdit);
                    request.getRequestDispatcher("/WEB-INF/views/user/editUser.jsp").forward(request, response);
                } else {
                    request.getSession().setAttribute("errorMessage", "User not found!");
                    response.sendRedirect("user");
                }
            } else {
                response.sendRedirect("user");
            }
        } else {
            List<User> users = service.getAllUsers();
            request.setAttribute("users", users);

            request.getRequestDispatcher("/WEB-INF/views/user/viewUsers.jsp").forward(request, response);
        }
    }
    }

