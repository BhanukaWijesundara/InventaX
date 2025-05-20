package servlet;

import model.InventoryItem;
import service.InventoryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

public class InventoryServlet extends HttpServlet {
    private InventoryService service = new InventoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            // Show the add item form
            request.getRequestDispatcher("/WEB-INF/views/inventory/addItem.jsp").forward(request, response);
        } else if ("list".equals(action)) {
            // Show the list of items
            List<InventoryItem> items = service.getSortedInventory();
            request.setAttribute("inventoryItems", items);
            request.getRequestDispatcher("/WEB-INF/views/inventory/viewInventory.jsp").forward(request, response);
        } else if ("edit".equals(action)) {
            // Get the item ID from the request
            String itemId = request.getParameter("id");
            if (itemId != null && !itemId.isEmpty()) {
                InventoryItem item = service.getItemById(itemId);
                if (item != null) {
                    request.setAttribute("item", item);
                    request.getRequestDispatcher("/WEB-INF/views/inventory/editItem.jsp").forward(request, response);
                } else {
                    request.getSession().setAttribute("errorMessage", "Item not found!");
                    response.sendRedirect("inventory?action=list");
                }
            } else {
                response.sendRedirect("inventory?action=list");
            }
        } else {
            List<InventoryItem> items = service.getSortedInventory();
            request.setAttribute("inventoryItems", items);
            request.getRequestDispatcher("/WEB-INF/views/inventory/viewInventory.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String itemId = UUID.randomUUID().toString();
            String name = request.getParameter("itemName");
            int qty = Integer.parseInt(request.getParameter("quantity"));
            String expiry = request.getParameter("expiryDate");
            String category = request.getParameter("category");

            InventoryItem item = new InventoryItem(itemId, name, qty, expiry, category);
            service.addItem(item);

            request.setAttribute("successMessage", "Item added successfully!");
            response.sendRedirect("inventory?action=list");
        } else if ("delete".equals(action)) {
            String itemId = request.getParameter("itemId");
            service.deleteItem(itemId);

            request.setAttribute("successMessage", "Item deleted successfully!");
            response.sendRedirect("inventory?action=list");
        } else if ("update".equals(action)) {
            String itemId = request.getParameter("itemId");
            String name = request.getParameter("itemName");
            int qty = Integer.parseInt(request.getParameter("quantity"));
            String expiry = request.getParameter("expiryDate");
            String category = request.getParameter("category");

            InventoryItem item = new InventoryItem(itemId, name, qty, expiry, category);
            service.updateItem(item);

            request.setAttribute("successMessage", "Item updated successfully!");
            response.sendRedirect("inventory?action=list");

        }
    }
}