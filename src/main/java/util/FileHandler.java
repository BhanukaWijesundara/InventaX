package util;

import model.*;

import java.io.*;
import java.util.*;

public class FileHandler {
    private static final String DATA_DIR = "C:\\Users\\ADMIN\\OneDrive\\Desktop\\Invapro\\InventaX\\data";
    private static final String ITEMS_FILE = DATA_DIR + "\\items.txt";

    static {
        // Create data directory if it doesn't exist
        File dataDir = new File(DATA_DIR);
        if (!dataDir.exists()) {
            dataDir.mkdirs();
        }

        // Create items file if it doesn't exist
        File itemsFile = new File(ITEMS_FILE);
        if (!itemsFile.exists()) {
            try {
                itemsFile.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    //User part file handling(bhanuka)
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
}