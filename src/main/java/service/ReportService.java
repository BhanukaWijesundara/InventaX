package service;

import model.InventoryItem;
import model.PurchaseOrder;

import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

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

    String content = reportContent.toString();
    
    try {
        System.out.println("Saving " + reportType + " report content to: " + reportFilePath);
        File reportFile = new File(reportFilePath);
        if (!reportFile.exists()) {
            reportFile.createNewFile();
            System.out.println("Created " + reportFileName + " file");
        }
        try (FileWriter writer = new FileWriter(reportFile)) {
            writer.write(content);
            writer.flush();
            System.out.println("Successfully wrote " + reportType + " report content");
        }
    } catch (IOException e) {
        System.err.println("Error writing to " + reportType + " report file: " + e.getMessage());
        e.printStackTrace();
        throw e;
    }



