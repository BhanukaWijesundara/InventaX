package util;

import model.PurchaseOrder;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

public class FileHandler {
    public static void writePurchase(PurchaseOrder order){
        try(BufferedWriter writer = new BufferedWriter(new FileWriter("C:\\Users\\Hasanthi\\Documents\\GitHub\\InventaX\\data\\purchases.txt",true))){
            writer.write(order.getPurchaseId() + "," + order.getItemId() + "," + order.getQuantity() + "," +
                    order.getDate() + "," + order.getSupplierId() + "," + order.getStatus());
            writer.newLine();
        }
        catch (IOException e) {
            System.err.println("Error writing purchase to file: " + e.getMessage());
            e.printStackTrace();
        }
    }
}


