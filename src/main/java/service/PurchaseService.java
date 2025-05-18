package service;

import model.PurchaseOrder;
import util.FileHandler;
import java.util.List;

public class PurchaseService {

    public void addPurchase(PurchaseOrder Order) {
        FileHandler.writePurchase(Order);

    }

    public List<PurchaseOrder> getAllPurchases() {
        return FileHandler.readPurchases();
    }

    public PurchaseOrder getPurchaseById(String purchaseId) {
        List<PurchaseOrder> purchases = FileHandler.readPurchases();
        for (PurchaseOrder purchase : purchases) {
            if (purchase.getPurchaseId().equals(purchaseId)) {
                return purchase;
            }
        }
        return null;
    }



}
