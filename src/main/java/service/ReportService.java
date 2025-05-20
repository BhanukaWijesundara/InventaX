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


