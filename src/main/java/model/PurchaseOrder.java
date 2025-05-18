package model;

public class PurchaseOrder {
    private String purchaseId;
    private String ItemId;
    private int quantity;
    private String date;
    private String supplierId;
    private String status;

    //Constructor
    public PurchaseOrder(String purchaseId, String ItemId, int quantity, String date, String supplierId, String status) {
        this.purchaseId = purchaseId;
        this.ItemId = ItemId;
        this.quantity = quantity;
        this.date = date;
        this.supplierId = supplierId;
        this.status = "Pending"; // Default Status

    }
    //Getters and Setters
    public String getPurchaseId() {
        return purchaseId;
    }

    public void setPurchaseId(String purchaseId) {
        this.purchaseId = purchaseId;
    }

    public String getItemId() {
        return ItemId;
    }

    public void setItemId(String itemId) {
        ItemId = itemId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(String supplierId) {
        this.supplierId = supplierId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }



}
