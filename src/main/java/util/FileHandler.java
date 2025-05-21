package util;

import model.*;

import java.io.*;
import java.util.*;

public class FileHandler {
    private static final String DATA_DIR = "C:\\Users\\ADMIN\\OneDrive\\Desktop\\Invapro\\InventaX\\data";
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
        try (BufferedWriter writer = new BufferedWriter(new FileWriter("C:\\Users\\Hasanthi\\Documents\\GitHub\\InventaX\\data\\purchases.txt", true))) {
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
        File file = new File("C:\\Users\\Hasanthi\\Documents\\GitHub\\InventaX\\data\\purchases.txt");
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

