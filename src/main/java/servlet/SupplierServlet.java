//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.Supplier;
import service.SupplierService;

public class SupplierServlet extends HttpServlet {
    private SupplierService supplierService = new SupplierService();

    public SupplierServlet() {
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("loggedUser") != null) {
            String action = request.getParameter("action");
            if (action != null && !action.equals("list")) {
                if (action.equals("add")) {
                    request.getRequestDispatcher("/WEB-INF/views/supplier/addSupplier.jsp").forward(request, response);
                } else if (action.equals("edit")) {
                    String supplierId = request.getParameter("id");
                    if (supplierId != null && !supplierId.isEmpty()) {
                        Supplier supplier = this.supplierService.getSupplierById(supplierId);
                        if (supplier != null) {
                            request.setAttribute("supplier", supplier);
                            request.getRequestDispatcher("/WEB-INF/views/supplier/editSupplier.jsp").forward(request, response);
                        } else {
                            request.getSession().setAttribute("errorMessage", "Supplier not found!");
                            response.sendRedirect("suppliers?action=list");
                        }
                    } else {
                        response.sendRedirect("suppliers?action=list");
                    }
                }
            } else {
                List<Supplier> suppliers = this.supplierService.getAllSuppliers();
                request.setAttribute("suppliers", suppliers);
                request.getRequestDispatcher("/WEB-INF/views/supplier/viewSuppliers.jsp").forward(request, response);
            }

        } else {
            response.sendRedirect("login.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("loggedUser") != null) {
            String action = request.getParameter("action");
            if (action != null && action.equals("add")) {
                String supplierId = request.getParameter("supplierId");
                String name = request.getParameter("name");
                String contact = request.getParameter("contact");
                String email = request.getParameter("email");
                String address = request.getParameter("address");
                Supplier supplier = new Supplier(supplierId, name, contact, email);
                supplier.setAddress(address);
                this.supplierService.addSupplier(supplier);
                request.getSession().setAttribute("successMessage", "Supplier added successfully!");
                response.sendRedirect("suppliers?action=list");
            } else if (action != null && action.equals("update")) {
                String supplierId = request.getParameter("supplierId");
                String name = request.getParameter("name");
                String contact = request.getParameter("contact");
                String email = request.getParameter("email");
                String address = request.getParameter("address");
                Supplier supplier = new Supplier(supplierId, name, contact, email);
                supplier.setAddress(address);
                this.supplierService.updateSupplier(supplier);
                request.getSession().setAttribute("successMessage", "Supplier updated successfully!");
                response.sendRedirect("suppliers?action=list");
            } else if (action != null && action.equals("delete")) {
                String supplierId = request.getParameter("supplierId");
                if (supplierId != null && !supplierId.isEmpty()) {
                    this.supplierService.deleteSupplier(supplierId);
                    request.getSession().setAttribute("successMessage", "Supplier deleted successfully!");
                }

                response.sendRedirect("suppliers?action=list");
            } else {
                response.sendRedirect("suppliers?action=list");
            }

        } else {
            response.sendRedirect("login.jsp");
        }
    }
}
