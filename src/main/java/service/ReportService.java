package service;

import model.ReportEntry;
import model.InventoryItem;
import model.Sales;
import model.PurchaseOrder;
import util.FileHandler;

import java.io.*;
import java.nio.file.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class ReportService {
    private static final String BASE_DIR = System.getProperty("user.dir");
    private static final String DATA_DIR = BASE_DIR + File.separator + "data";

    public ReportService() {
        try {
            File dataDir = new File(DATA_DIR);
            if (!dataDir.exists()) {
                dataDir.mkdirs();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}

public String generateReport(String reportType, String startDate, String endDate) throws IOException {

    String reportId = UUID.randomUUID().toString();

    String reportFileName = reportType.toLowerCase() + "_report.txt";
    String reportFilePath = DATA_DIR + File.separator + reportFileName;

    StringBuilder reportContent = new StringBuilder();

    reportContent.append("=== ").append(reportType.toUpperCase()).append(" REPORT ===\n");
    reportContent.append("Report ID: ").append(reportId).append("\n");
    reportContent.append("Generated on: ").append(LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME)).append("\n");
    reportContent.append("Period: ").append(startDate).append(" to ").append(endDate).append("\n\n");

    switch (reportType.toLowerCase()) {
        case "inventory":
            generateInventoryReport(reportContent);
            break;
        case "sales":
            generateSalesReport(reportContent, startDate, endDate);
            break;
        case "purchases":
            generatePurchasesReport(reportContent, startDate, endDate);
            break;
        default:
            throw new IllegalArgumentException("Invalid report type: " + reportType);
    }

