package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import model.PurchaseOrder;
import model.Supplier;
import model.InventoryItem;
import service.PurchaseService;
import service.SupplierService;
import service.InventoryService;

public class PurchaseServlet extends HttpServlet {

        private PurchaseService purchaseService = new PurchaseService();
        private SupplierService supplierService = new SupplierService();
        private InventoryService inventoryService = new InventoryService();

        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            HttpSession session = request.getSession(false);

            if (session == null || session.getAttribute("loggedUser") == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            String action = request.getParameter("action");

            if (action == null || action.equals("list")) {
                // Get all purchases and pass them to the view
                List<PurchaseOrder> purchases = purchaseService.getAllPurchases();
                // Get all suppliers for displaying supplier names
                List<Supplier> suppliers = supplierService.getAllSuppliers();
                // Get all inventory items for displaying item names
                List<InventoryItem> items = inventoryService.getAllItems();

                // Create maps for quick lookup of supplier and item names
                Map<String, String> supplierMap = new HashMap<>();
                Map<String, String> itemMap = new HashMap<>();

                for (Supplier supplier : suppliers) {
                    supplierMap.put(supplier.getSupplierId(), supplier.getName());
                }

                for (InventoryItem item : items) {
                    itemMap.put(item.getItemId(), item.getItemName());
                }

                request.setAttribute("purchases", purchases);
                request.setAttribute("supplierMap", supplierMap);
                request.setAttribute("itemMap", itemMap);
                request.getRequestDispatcher("/WEB-INF/views/purchase/viewPurchases.jsp").forward(request, response);
            } else if (action.equals("add")) {
                // Load suppliers for the dropdown
                List<Supplier> suppliers = supplierService.getAllSuppliers();
                // Load inventory items for the dropdown
                List<InventoryItem> items = inventoryService.getAllItems();
                request.setAttribute("suppliers", suppliers);
                request.setAttribute("items", items);
                // Show the add purchase form
                request.getRequestDispatcher("/WEB-INF/views/purchase/addPurchase.jsp").forward(request, response);
            } else if (action.equals("edit")) {
                // Get the purchase ID from the request
                String purchaseId = request.getParameter("id");
                if (purchaseId != null && !purchaseId.isEmpty()) {
                    // Get the purchase by ID
                    PurchaseOrder purchase = purchaseService.getPurchaseById(purchaseId);
                    if (purchase != null) {
                        // Load suppliers for the dropdown
                        List<Supplier> suppliers = supplierService.getAllSuppliers();
                        // Load inventory items for the dropdown
                        List<InventoryItem> items = inventoryService.getAllItems();

                        // Pass the purchase and other data to the edit form
                        request.setAttribute("purchase", purchase);
                        request.setAttribute("suppliers", suppliers);
                        request.setAttribute("items", items);

                        // Set default values for additional fields
                        request.setAttribute("totalAmount", "0.00");
                        request.setAttribute("paymentStatus", "pending");
                        request.setAttribute("notes", "");

                        request.getRequestDispatcher("/WEB-INF/views/purchase/editPurchase.jsp").forward(request, response);
                    } else {
                        // Purchase not found
                        request.getSession().setAttribute("errorMessage", "Purchase not found!");
                        response.sendRedirect(request.getContextPath() + "/purchases?action=list");
                    }
                } else {
                    response.sendRedirect(request.getContextPath() + "/purchases?action=list");
                }
            } else if (action.equals("delete")) {
                // Delete the purchase
                String purchaseId = request.getParameter("id");
                if (purchaseId != null && !purchaseId.isEmpty()) {
                    purchaseService.deletePurchase(purchaseId);
                    request.getSession().setAttribute("successMessage", "Purchase deleted successfully!");
                }
                response.sendRedirect(request.getContextPath() + "/purchases?action=list");
            }
        }

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            HttpSession session = request.getSession(false);

            if (session == null || session.getAttribute("loggedUser") == null) {
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }

            String action = request.getParameter("action");

            if (action != null && action.equals("add")) {
                // Get purchase details from the form
                String purchaseId = request.getParameter("purchaseId");
                String itemId = request.getParameter("itemId");
                String quantityStr = request.getParameter("quantity");
                String supplierId = request.getParameter("supplierId");
                String purchaseDate = request.getParameter("purchaseDate");
                String status = request.getParameter("status");

                // Create a new purchase order object
                int quantity = 1; // Default value
                try {
                    quantity = Integer.parseInt(quantityStr);
                } catch (NumberFormatException e) {
                    // If parsing fails, use default value
                    System.err.println("Error parsing quantity: " + quantityStr);
                }

                PurchaseOrder purchase = new PurchaseOrder(purchaseId, itemId, quantity, purchaseDate, supplierId);
                purchase.setStatus(status); // Set the status from the form

                // Add the purchase using the service
                purchaseService.addPurchase(purchase);

                // Set success message and redirect
                request.getSession().setAttribute("successMessage", "Purchase added successfully!");
                response.sendRedirect(request.getContextPath() + "/purchases?action=list");
            } else if (action != null && action.equals("update")) {
                // Get purchase details from the form
                String purchaseId = request.getParameter("purchaseId");
                String itemId = request.getParameter("itemId");
                String quantityStr = request.getParameter("quantity");
                String supplierId = request.getParameter("supplierId");
                String purchaseDate = request.getParameter("purchaseDate");
                String status = request.getParameter("status");

                // Create an updated purchase order object
                int quantity = 1; // Default value
                try {
                    quantity = Integer.parseInt(quantityStr);
                } catch (NumberFormatException e) {
                    // If parsing fails, use default value
                    System.err.println("Error parsing quantity: " + quantityStr);
                }

                PurchaseOrder purchase = new PurchaseOrder(purchaseId, itemId, quantity, purchaseDate, supplierId);
                purchase.setStatus(status); // Set the status from the form

                // Update the purchase using the service
                purchaseService.updatePurchase(purchase);

                // Set success message and redirect
                request.getSession().setAttribute("successMessage", "Purchase updated successfully!");
                response.sendRedirect(request.getContextPath() + "/purchases?action=list");
            } else {
                response.sendRedirect(request.getContextPath() + "/purchases?action=list");
            }
        }
    }

}
