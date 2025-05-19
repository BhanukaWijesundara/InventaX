package service;

import model.PurchaseOrder;
import util.FileHandler;

import java.util.List;

public class InventoryService {

    public void addPurchase(PurchaseOrder order) {
        FileHandler.writePurchase(order);
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

    public void updatePurchase(PurchaseOrder updatedPurchase) {
        List<PurchaseOrder> purchases = FileHandler.readPurchases();
        for (int i = 0; i < purchases.size(); i++) {
            if (purchases.get(i).getPurchaseId().equals(updatedPurchase.getPurchaseId())) {
                purchases.set(i, updatedPurchase);
                break;
            }
        }
        FileHandler.rewritePurchases(purchases);
    }

    public void deletePurchase(String purchaseId) {
        List<PurchaseOrder> orders = FileHandler.readPurchases();
        orders.removeIf(p -> p.getPurchaseId().equals(purchaseId));
        FileHandler.rewritePurchases(orders);
    }
}

