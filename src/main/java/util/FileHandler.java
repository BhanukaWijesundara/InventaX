package util;

import model.*;

import java.io.*;
import java.util.*;

public class FileHandler {
    private static final String DATA_DIR = "C:\\Users\\ADMIN\\OneDrive\\Desktop\\Invapro\\test\\new\\InventaX\\data";
    private static final String ITEMS_FILE = DATA_DIR + "\\items.txt";

    static {
        File dataDir = new File(DATA_DIR);
        if (!dataDir.exists()) {
            dataDir.mkdirs();
        }

        File itemsFile = new File(ITEMS_FILE);
        if (!itemsFile.exists()) {
            try {
                itemsFile.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public static void writeUser(User user) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(DATA_DIR + "\\users.txt", true))) {
            writer.write(user.getUserId() + "," + user.getUsername() + "," + user.getPassword() + "," + user.getRole());
            writer.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static List<User> readUsers() {
        List<User> users = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(DATA_DIR + "\\users.txt"))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] d = line.split(",");
                users.add(new User(d[0], d[1], d[2], d[3]));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return users;
    }

    public static void rewriteUsers(List<User> users) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(DATA_DIR + "\\users.txt"))) {
            for (User user : users) {
                writer.write(user.getUserId() + "," + user.getUsername() + "," + user.getPassword() + "," + user.getRole());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //Purchase Orders
    public static void writePurchase(PurchaseOrder order) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter("C:\\Users\\ADMIN\\OneDrive\\Desktop\\Invapro\\test\\new\\InventaX\\data\\purchases.txt", true))) {
            writer.write(order.getPurchaseId() + "," + order.getItemId() + "," + order.getQuantity() + "," +
                    order.getDate() + "," + order.getSupplierId() + "," + order.getStatus());
            writer.newLine();
        } catch (IOException e) {
            System.err.println("Error writing purchase to file: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static List<PurchaseOrder> readPurchases() {
        List<PurchaseOrder> list = new ArrayList<>();
        File file = new File("C:\\Users\\ADMIN\\OneDrive\\Desktop\\Invapro\\test\\new\\InventaX\\data\\purchases.txt");
        if (!file.exists()) {
            try {
                file.createNewFile();
            } catch (IOException e) {
                System.err.println("Error creating purchases file: " + e.getMessage());
                e.printStackTrace();
            }
            return list;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] d = line.split(",");
                // Check if we have all required fields
                if (d.length >= 5) {
                    try {
                        PurchaseOrder order = new PurchaseOrder(d[0], d[1], Integer.parseInt(d[2]), d[3], d[4]);
                        // Set status if it exists in the file
                        if (d.length > 5) {
                            order.setStatus(d[5]);
                        }
                        list.add(order);
                    } catch (NumberFormatException e) {
                        System.err.println("Error parsing purchase data: " + line);
                        e.printStackTrace();
                    }
                } else {
                    System.err.println("Invalid purchase data format: " + line);
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading purchases file: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    //Report
    public static void writeReport(List<InventoryItem> sortedItems) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter("C:\\Users\\Shehan\\Documents\\Modules\\SE1020 -OOP\\Project\\final\\projectXX\\data\\report.txt"))) {
            for (InventoryItem item : sortedItems) {
                writer.write(item.getItemId() + "," + item.getItemName() + "," +
                        item.getQuantity() + "," + item.getExpiryDate() + "," + item.getCategory());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

    public static void rewritePurchases(List<PurchaseOrder> orders) {
        File file = new File("C:\\Users\\ADMIN\\OneDrive\\Desktop\\Invapro\\test\\new\\InventaX\\data\\purchases.txt");
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            for (PurchaseOrder o : orders) {
                writer.write(o.getPurchaseId() + "," + o.getItemId() + "," + o.getQuantity() + "," +
                        o.getDate() + "," + o.getSupplierId() + "," + o.getStatus());
                writer.newLine();
            }
        } catch (IOException e) {
            System.err.println("Error rewriting purchases file: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static void writeSupplier(Supplier s) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter("C:\\Users\\ADMIN\\OneDrive\\Desktop\\Invapro\\test\\new\\InventaX\\data\\suppliers.txt", true))) {
            writer.write(s.getSupplierId() + "," + s.getName() + "," + s.getContact() + "," + s.getEmail() + "," + s.getAddress());
            writer.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static List<Supplier> readSuppliers() {
        List<Supplier> list = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader("C:\\Users\\ADMIN\\OneDrive\\Desktop\\Invapro\\test\\new\\InventaX\\data\\suppliers.txt"))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] d = line.split(",");
                Supplier supplier = new Supplier(d[0], d[1], d[2], d[3]);
                if (d.length > 4) {
                    supplier.setAddress(d[4]);
                }
                list.add(supplier);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void rewriteSuppliers(List<Supplier> suppliers) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter("C:\\Users\\ADMIN\\OneDrive\\Desktop\\Invapro\\test\\new\\InventaX\\data\\suppliers.txt"))) {
            for (Supplier s : suppliers) {
                writer.write(s.getSupplierId() + "," + s.getName() + "," + s.getContact() + "," + s.getEmail() + "," + s.getAddress());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void writeSale(Sales sale) {
        try (BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream("C:\\Users\\ADMIN\\OneDrive\\Desktop\\Invapro\\test\\new\\InventaX\\data\\sales.txt", true), "UTF-8"))) {
            writer.write(sale.getSalesId() + "," + sale.getItemId() + "," + sale.getQuantity() + "," +
                    sale.getDate() + "," + sale.getTotalAmount() + "," + sale.getCustomerName() + "," +
                    sale.getPaymentStatus());
            writer.newLine();
        } catch (IOException e) {
            System.err.println("Error writing sale to file: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static List<Sales> readSales() {
        List<Sales> list = new ArrayList<>();
        File file = new File("C:\\Users\\ADMIN\\OneDrive\\Desktop\\Invapro\\test\\new\\InventaX\\data\\sales.txt");
        if (!file.exists()) {
            try {
                file.createNewFile();
            } catch (IOException e) {
                System.err.println("Error creating sales file: " + e.getMessage());
                e.printStackTrace();
            }
            return list;
        }

        try (BufferedReader reader = new BufferedReader(new InputStreamReader(
                new FileInputStream(file), "UTF-8"))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] d = line.split(",");
                // Check if we have all required fields
                if (d.length >= 7) {
                    try {
                        list.add(new Sales(d[0], d[1], Integer.parseInt(d[2]), d[3],
                                Double.parseDouble(d[4]), d[5], d[6]));
                    } catch (NumberFormatException e) {
                        System.err.println("Error parsing sales data: " + line);
                        e.printStackTrace();
                    }
                } else {
                    System.err.println("Invalid sales data format: " + line);
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading sales file: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public static void rewriteSales(List<Sales> sales) {
        File file = new File("C:\\Users\\ADMIN\\OneDrive\\Desktop\\Invapro\\test\\new\\InventaX\\data\\sales.txt");
        try (BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(
                new FileOutputStream(file), "UTF-8"))) {
            for (Sales s : sales) {
                writer.write(s.getSalesId() + "," + s.getItemId() + "," + s.getQuantity() + "," +
                        s.getDate() + "," + s.getTotalAmount() + "," + s.getCustomerName() + "," +
                        s.getPaymentStatus());
                writer.newLine();
            }
        } catch (IOException e) {
            System.err.println("Error rewriting sales file: " + e.getMessage());
            e.printStackTrace();
        }}// ======================= INVENTORY =======================

    public static void writeItem(InventoryItem item) {
        System.out.println("Writing item to file: " + ITEMS_FILE);
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(ITEMS_FILE, true))) {
            writer.write(item.getItemId() + "," + item.getItemName() + "," + item.getQuantity() + "," +
                    item.getExpiryDate() + "," + item.getCategory());
            writer.newLine();
            System.out.println("Item written successfully");
        } catch (IOException e) {
            System.err.println("Error writing item to file: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static List<InventoryItem> readItems() {
        List<InventoryItem> list = new ArrayList<>();
        System.out.println("Reading items from file: " + ITEMS_FILE);
        try (BufferedReader reader = new BufferedReader(new FileReader(ITEMS_FILE))) {
            String line;
            int lineNum = 0;
            while ((line = reader.readLine()) != null) {
                lineNum++;
                if (line.trim().isEmpty()) {
                    continue; // Skip empty lines
                }

                try {
                    String[] d = line.split(",");
                    if (d.length < 5) {
                        System.err.println("Warning: Line " + lineNum + " has insufficient data: " + line);
                        continue;
                    }

                    // Parse quantity with error handling and better whitespace handling
                    int quantity;
                    try {
                        // Clean up quantity by removing all whitespace
                        String cleanQuantity = d[2].replaceAll("\\s+", "").trim();
                        quantity = Integer.parseInt(cleanQuantity);
                    } catch (NumberFormatException e) {
                        System.err.println("Error parsing quantity at line " + lineNum + ": '" + d[2] + "'. Using default value 0.");
                        quantity = 0; // Use a default value
                    }

                    list.add(new InventoryItem(d[0], d[1], quantity, d[3], d[4]));
                } catch (Exception e) {
                    System.err.println("Error processing line " + lineNum + ": " + line);
                    e.printStackTrace();
                }
            }
            System.out.println("Read " + list.size() + " items from file");
        } catch (IOException e) {
            System.err.println("Error reading items from file: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    public static void rewriteItems(Stack<InventoryItem> items) {
        System.out.println("Rewriting items to file: " + ITEMS_FILE);
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(ITEMS_FILE))) {
            for (InventoryItem i : items) {
                writer.write(i.getItemId() + "," + i.getItemName() + "," + i.getQuantity() + "," +
                        i.getExpiryDate() + "," + i.getCategory());
                writer.newLine();
            }
            System.out.println("Items rewritten successfully");
        } catch (IOException e) {
            System.err.println("Error rewriting items to file: " + e.getMessage());
            e.printStackTrace();
        }
    }}

