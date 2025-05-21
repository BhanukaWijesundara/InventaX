package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Map;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import model.PurchaseOrder;
import model.InventoryItem;
import model.Supplier;
import model.Sales;
import service.PurchaseService;
import service.InventoryService;
import service.SupplierService;
import service.SalesService;
import util.FileHandler;

public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Initialize services
        PurchaseService purchaseService = new PurchaseService();
        InventoryService inventoryService = new InventoryService();
        SupplierService supplierService = new SupplierService();
        SalesService salesService = new SalesService();

        // Get all data
        List<InventoryItem> allItems = inventoryService.getAllItems();
        List<PurchaseOrder> allPurchases = purchaseService.getAllPurchases();
        List<Supplier> allSuppliers = supplierService.getAllSuppliers();
        List<Sales> allSales = salesService.getAllSales();

        // Create supplier map for quick lookup
        Map<String, String> supplierMap = new HashMap<>();
        for (Supplier supplier : allSuppliers) {
            supplierMap.put(supplier.getSupplierId(), supplier.getName());
        }

        // Get today's date
        LocalDate today = LocalDate.now();

        // Get date 7 days ago
        LocalDate sevenDaysAgo = today.minusDays(7);

        // Get date 7 days from now
        LocalDate sevenDaysFromNow = today.plusDays(7);

        // Process recent purchases
        List<PurchaseData> recentPurchases = new ArrayList<>();
        for (PurchaseOrder purchase : allPurchases) {
            try {
                LocalDate purchaseDate = LocalDate.parse(purchase.getDate());
                if (!purchaseDate.isBefore(sevenDaysAgo) && !purchaseDate.isAfter(today)) {
                    String supplierName = supplierMap.getOrDefault(purchase.getSupplierId(), "Unknown Supplier");
                    recentPurchases.add(new PurchaseData(
                            purchase.getPurchaseId(),
                            supplierName,
                            purchase.getDate(),
                            purchase.getQuantity(),
                            "Completed",
                            "success"
                    ));
                }
            } catch (Exception e) {
                // Skip invalid dates
                System.err.println("Skipping purchase due to invalid date: " + purchase.getPurchaseId() + ", Date: " + purchase.getDate());
                e.printStackTrace();
            }
        }

        // Process expiring items
        List<ExpiringItem> expiringItemsList = new ArrayList<>();
        for (InventoryItem item : allItems) {
            try {
                LocalDate expiryDate = LocalDate.parse(item.getExpiryDate());
                if (!expiryDate.isBefore(today) && !expiryDate.isAfter(sevenDaysFromNow)) {
                    int daysUntilExpiry = (int) ChronoUnit.DAYS.between(today, expiryDate);
                    expiringItemsList.add(new ExpiringItem(
                            item.getItemId(),
                            item.getItemName(),
                            item.getCategory(),
                            item.getQuantity(),
                            item.getExpiryDate(),
                            daysUntilExpiry
                    ));
                }
            } catch (Exception e) {
                // Skip invalid dates
                System.err.println("Skipping item due to invalid expiry date: " + item.getItemId() + ", Date: " + item.getExpiryDate());
                e.printStackTrace();
            }
        }

        // Process low stock items
        List<InventoryItem> lowStockItemsList = new ArrayList<>();
        for (InventoryItem item : allItems) {
            if (item.getQuantity() <= 5) {
                lowStockItemsList.add(item);
            }
        }

        // Set all attributes
        request.setAttribute("totalItems", allItems.size());
        request.setAttribute("lowStockItems", lowStockItemsList.size());
        request.setAttribute("expiringItems", expiringItemsList.size());
        request.setAttribute("totalSuppliers", supplierMap.size());
        request.setAttribute("totalPurchases", allPurchases.size());
        request.setAttribute("totalSales", allSales.size());
        request.setAttribute("recentPurchases", recentPurchases);
        request.setAttribute("expiringItemsList", expiringItemsList);
        request.setAttribute("lowStockItemsList", lowStockItemsList);

        // Forward to dashboard.jsp
        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }

    // Helper classes for data
    public static class PurchaseData {
        private String id;
        private String supplierName;
        private String date;
        private int quantity;
        private String status;
        private String statusColor;

        public PurchaseData(String id, String supplierName, String date, int quantity, String status, String statusColor) {
            this.id = id;
            this.supplierName = supplierName;
            this.date = date;
            this.quantity = quantity;
            this.status = status;
            this.statusColor = statusColor;
        }

        public String getId() { return id; }
        public String getSupplierName() { return supplierName; }
        public String getDate() { return date; }
        public int getQuantity() { return quantity; }
        public String getStatus() { return status; }
        public String getStatusColor() { return statusColor; }
    }

    public static class ExpiringItem {
        private String id;
        private String name;
        private String category;
        private int quantity;
        private String expiryDate;
        private int daysUntilExpiry;

        public ExpiringItem(String id, String name, String category, int quantity, String expiryDate, int daysUntilExpiry) {
            this.id = id;
            this.name = name;
            this.category = category;
            this.quantity = quantity;
            this.expiryDate = expiryDate;
            this.daysUntilExpiry = daysUntilExpiry;
        }
        
        public String getId() { return id; }
        public String getName() { return name; }
        public String getCategory() { return category; }
        public int getQuantity() { return quantity; }
        public String getExpiryDate() { return expiryDate; }
        public int getDaysUntilExpiry() { return daysUntilExpiry; }
    }
}
