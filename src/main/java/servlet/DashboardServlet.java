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

public class DashboardServlet {

}
