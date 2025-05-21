package service;

import model.InventoryItem;
import model.PurchaseOrder;
import model.ReportEntry;
import model.Sales;
import util.FileHandler;

import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
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

    reportContent.append("\nSUMMARY\n");
    reportContent.append("=======\n");
    reportContent.append(String.format("Total Items in Stock: %d\n", totalItems));
    reportContent.append(String.format("Number of Products: %d\n", totalProducts));

    int inStock = 0;
    int lowStock = 0;
    int outOfStock = 0;

    for (InventoryItem item : items) {
        if (item.getQuantity() <= 0) {
            outOfStock++;
        } else if (item.getQuantity() <= 5) {
            lowStock++;
        } else {
            inStock++;
        }
    }

    reportContent.append("\nSTOCK STATUS\n");
    reportContent.append("============\n");
    reportContent.append(String.format("Products In Stock (Good): %d\n", inStock));
    reportContent.append(String.format("Products Low Stock (<=5): %d\n", lowStock));
    reportContent.append(String.format("Products Out of Stock: %d\n", outOfStock));
}

private String truncateOrPad(String text, int maxLength) {
    if (text == null) {
        return String.format("%-" + maxLength + "s", "");
    }

    if (text.length() > maxLength) {
        return text.substring(0, maxLength - 3) + "...";
    }

    return String.format("%-" + maxLength + "s", text);
}

private void generateSalesReport(StringBuilder reportContent, String startDate, String endDate) throws IOException {
    List<Sales> sales = FileHandler.readSales();

    if (sales.isEmpty()) {
        reportContent.append("No sales data available.\n");
        return;
    }

    reportContent.append("SALES REPORT\n");
    reportContent.append("============\n\n");
    reportContent.append("Period: ").append(startDate).append(" to ").append(endDate).append("\n\n");


    reportContent.append(String.format("%-10s %-8s %-12s %-12s %-20s %-15s\n",
            "Sale ID", "Quantity", "Date", "Amount", "Customer", "Status"));
    reportContent.append(String.format("%-10s %-8s %-12s %-12s %-20s %-15s\n",
            "--------", "--------", "------------", "------------", "--------------------", "---------------"));

    double totalSales = 0;
    int totalItems = 0;
    int salesCount = 0;

    for (Sales sale : sales) {
        String saleDate = sale.getDate();

        if (isDateInRange(saleDate, startDate, endDate)) {
            reportContent.append(String.format("%-10s %-8d %-12s $%-11.2f %-20s %-15s\n",
                    sale.getSalesId(),
                    sale.getQuantity(),
                    saleDate,
                    sale.getTotalAmount(),
                    sale.getCustomerName(),
                    sale.getPaymentStatus()
            ));

            totalSales += sale.getTotalAmount();
            totalItems += sale.getQuantity();
            salesCount++;
        }
    }

    if (salesCount == 0) {
        reportContent.append("No sales recorded for the selected period.\n");
        return;
    }

    reportContent.append("\nSUMMARY\n");
    reportContent.append("=======\n");
    reportContent.append(String.format("Total Sales: $%.2f\n", totalSales));
    reportContent.append(String.format("Total Items Sold: %d\n", totalItems));
    reportContent.append(String.format("Number of Sales: %d\n", salesCount));
    reportContent.append(String.format("Average Sale Value: $%.2f\n", salesCount > 0 ? totalSales / salesCount : 0));
}

private void generatePurchasesReport(StringBuilder reportContent, String startDate, String endDate) throws IOException {
    List<PurchaseOrder> purchases = FileHandler.readPurchases();

    if (purchases.isEmpty()) {
        reportContent.append("No purchases data available.\n");
        return;
    }

    reportContent.append("PURCHASES REPORT\n");
    reportContent.append("================\n\n");
    reportContent.append("Period: ").append(startDate).append(" to ").append(endDate).append("\n\n");

    reportContent.append(String.format("%-15s %-10s %-12s %-15s %-15s\n",
            "Purchase ID", "Quantity", "Date", "Supplier ID", "Status"));
    reportContent.append(String.format("%-15s %-10s %-12s %-15s %-15s\n",
            "---------------", "----------", "------------", "---------------", "---------------"));

    int totalQuantity = 0;
    int purchaseCount = 0;

    for (PurchaseOrder purchase : purchases) {
        String purchaseDate = purchase.getDate();

        if (isDateInRange(purchaseDate, startDate, endDate)) {

            reportContent.append(String.format("%-15s %-10d %-12s %-15s %-15s\n",
                    purchase.getPurchaseId(),
                    purchase.getQuantity(),
                    purchaseDate,
                    purchase.getSupplierId(),
                    purchase.getStatus()
            ));

            totalQuantity += purchase.getQuantity();
            purchaseCount++;
        }
    }

    if (purchaseCount == 0) {
        reportContent.append("No purchases recorded for the selected period.\n");
        return;
    }

    reportContent.append("\nSUMMARY\n");
    reportContent.append("=======\n");
    reportContent.append(String.format("Total Items Purchased: %d\n", totalQuantity));
    reportContent.append(String.format("Number of Purchases: %d\n", purchaseCount));
}

private boolean isDateInRange(String date, String startDate, String endDate) {
    if (date == null || startDate == null || endDate == null) {
        return true;
    }
    return date.compareTo(startDate) >= 0 && date.compareTo(endDate) <= 0;
}

private void saveReport(String reportId, String reportType, String startDate, String endDate, String reportFilePath) throws IOException {
    String reportEntry = String.format("%s,%s,%s,%s,%s,%s\n",
            reportId, reportType, startDate, endDate,
            LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME),
            reportFilePath);

    String reportsFilePath = DATA_DIR + File.separator + "reports.txt";
    System.out.println("Saving report metadata to: " + reportsFilePath);

    File reportsFile = new File(reportsFilePath);
    if (!reportsFile.exists()) {
        reportsFile.createNewFile();
        System.out.println("Created reports.txt file");
    }

    try (FileWriter writer = new FileWriter(reportsFile, true)) {
        writer.write(reportEntry);
        writer.flush();
        System.out.println("Successfully wrote report metadata: " + reportEntry);
    } catch (IOException e) {
        System.err.println("Error writing to reports file: " + e.getMessage());
        e.printStackTrace();
        throw e;
    }

    try (FileWriter reportWriter = new FileWriter(reportFilePath, true)) {
        reportWriter.write("\n\nReport ID: " + reportId + "\n");
        reportWriter.flush();
    } catch (IOException e) {
        System.err.println("Error appending report ID to report file: " + e.getMessage());
    }
}

public List<ReportEntry> getAllReports() throws IOException {
    List<ReportEntry> reports = new ArrayList<>();
    File reportsFile = new File(DATA_DIR, "reports.txt");

    if (!reportsFile.exists()) {
        return reports;
    }
    try (BufferedReader reader = new BufferedReader(new FileReader(reportsFile))) {
        String line;
        while ((line = reader.readLine()) != null) {
            String[] parts = line.split(",");
            if (parts.length >= 5) {
                ReportEntry report = new ReportEntry();
                report.setReportId(parts[0]);
                report.setReportType(parts[1]);
                try {
                    report.setStartDate(java.sql.Date.valueOf(parts[2]));
                    report.setEndDate(java.sql.Date.valueOf(parts[3]));
                    report.setGeneratedDate(java.sql.Date.valueOf(parts[4].split("T")[0]));

                    if (parts.length >= 6) {
                        report.setFilePath(parts[5]);
                    }
                } catch (IllegalArgumentException e) {
                    System.err.println("Error parsing date in report entry: " + line);
                    continue;
                }
                reports.add(report);
            }
        }
    } catch (IOException e) {
        System.err.println("Error reading reports file: " + e.getMessage());
        e.printStackTrace();
        throw e;
    }

    return reports;
}

public void deleteReport(String reportId) throws IOException {
    List<ReportEntry> reports = new ArrayList<>();
    File reportsFile = new File(DATA_DIR, "reports.txt");
    String reportFilePath = null;

    if (reportsFile.exists()) {
        List<String> lines = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(reportsFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length > 0) {
                    if (parts[0].equals(reportId)) {
                        if (parts.length >= 6) {
                            reportFilePath = parts[5];
                        } else if (parts.length >= 2) {
                            reportFilePath = DATA_DIR + File.separator + parts[1].toLowerCase() + "_report.txt";
                        }
                    } else {
                        lines.add(line);
                    }
                }
            }
        }


    }
}