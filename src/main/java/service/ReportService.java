package service;

import model.InventoryItem;
import model.PurchaseOrder;
import util.FileHandler;

import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
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
    saveReport(reportId, reportType, startDate, endDate, reportFilePath);

    return content;
}

private void generateInventoryReport(StringBuilder reportContent) throws IOException {
    List<InventoryItem> items = FileHandler.readItems();

    if (items.isEmpty()) {
        reportContent.append("No inventory data available.\n");
        return;
    }

    reportContent.append("INVENTORY STATUS REPORT\n");
    reportContent.append("======================\n\n");

    reportContent.append(String.format("%-8s %-35s %12s %20s %15s\n",
            "Item No.", "Product Name", "Quantity", "Expiry Date", "Category"));
    reportContent.append(String.format("%-8s %-35s %12s %20s %15s\n",
            "--------", "-----------------------------------", "------------", "--------------------", "---------------"));

    int totalItems = 0;
    int totalProducts = items.size();
    int itemNumber = 1;

    for (InventoryItem item : items) {
        reportContent.append(String.format("%-8d %-35s %12d %20s %15s\n",
                itemNumber++,
                truncateOrPad(item.getItemName(), 35),
                item.getQuantity(),
                String.format("%20s", truncateOrPad(item.getExpiryDate(), 20)),
                String.format("%15s", truncateOrPad(item.getCategory(), 15))
        ));

        totalItems += item.getQuantity();
    }



