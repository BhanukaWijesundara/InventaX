package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Sales;
import model.InventoryItem;
import service.SalesService;
import service.InventoryService;

public class SalesServlet extends HttpServlet {
    private SalesService salesService = new SalesService();
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

            List<Sales> sales = salesService.getAllSales();

            List<InventoryItem> items = inventoryService.getAllItems();
            request.setAttribute("sales", sales);
            request.setAttribute("items", items);
            request.getRequestDispatcher("/WEB-INF/views/sales/viewSales.jsp").forward(request, response);
        } else if (action.equals("add")) {

            List<InventoryItem> items = inventoryService.getAllItems();
            request.setAttribute("items", items);

            request.getRequestDispatcher("/WEB-INF/views/sales/addSale.jsp").forward(request, response);
        } else if (action.equals("edit")) {

            String salesId = request.getParameter("id");
            if (salesId != null && !salesId.isEmpty()) {

                Sales sale = salesService.getSaleById(salesId);
                if (sale != null) {

                    List<InventoryItem> items = inventoryService.getAllItems();


                    request.setAttribute("sale", sale);
                    request.setAttribute("items", items);

                    request.getRequestDispatcher("/WEB-INF/views/sales/editSale.jsp").forward(request, response);
                } else {

                    request.getSession().setAttribute("errorMessage", "Sale not found!");
                    response.sendRedirect("sales?action=list");
                }
            } else {
                response.sendRedirect("sales?action=list");
            }
        } else if (action.equals("delete")) {

            String salesId = request.getParameter("id");
            if (salesId != null && !salesId.isEmpty()) {
                salesService.deleteSale(salesId);
                request.getSession().setAttribute("successMessage", "Sale deleted successfully!");
            }
            response.sendRedirect("sales?action=list");
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

        if (action != null && action.equals("add")) {

            String salesId = request.getParameter("salesId");
            String itemId = request.getParameter("itemId");
            String quantityStr = request.getParameter("quantity");
            String date = request.getParameter("date");
            String totalAmountStr = request.getParameter("totalAmount");
            String customerName = request.getParameter("customerName");
            String paymentStatus = request.getParameter("paymentStatus");


            int quantity = 1; // Default value
            double totalAmount = 0.0; // Default value
            try {
                quantity = Integer.parseInt(quantityStr);
                totalAmount = Double.parseDouble(totalAmountStr);
            } catch (NumberFormatException e) {

                System.err.println("Error parsing numeric values: " + e.getMessage());
            }

            Sales sale = new Sales(salesId, itemId, quantity, date, totalAmount, customerName, paymentStatus);


            salesService.addSale(sale);


            request.getSession().setAttribute("successMessage", "Sale added successfully!");
            response.sendRedirect("sales?action=list");
        } else if (action != null && action.equals("update")) {

            String salesId = request.getParameter("salesId");
            String itemId = request.getParameter("itemId");
            String quantityStr = request.getParameter("quantity");
            String date = request.getParameter("date");
            String totalAmountStr = request.getParameter("totalAmount");
            String customerName = request.getParameter("customerName");
            String paymentStatus = request.getParameter("paymentStatus");


            int quantity = 1; // Default value
            double totalAmount = 0.0; // Default value
            try {
                quantity = Integer.parseInt(quantityStr);
                totalAmount = Double.parseDouble(totalAmountStr);
            } catch (NumberFormatException e) {

                System.err.println("Error parsing numeric values: " + e.getMessage());
            }

            Sales sale = new Sales(salesId, itemId, quantity, date, totalAmount, customerName, paymentStatus);


            salesService.updateSale(sale);


            request.getSession().setAttribute("successMessage", "Sale updated successfully!");
            response.sendRedirect("sales?action=list");
        } else {
            response.sendRedirect("sales?action=list");
        }
    }
}


