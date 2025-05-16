package model;

public class Sales {
    private String SalesId;
    private String itemId;
    private int quantity;
    private String date;
    private double totalAmount;
    private String customerName;
    private String paymentStatus;

    // Constructor
    public Sales(String SalesId, String itemId, int quantity, String date, double totalAmount, String customerName, String paymentStatus) {
        this.SalesId = SalesId;
        this.itemId = itemId;
        this.quantity = quantity;
        this.date = date;
        this.totalAmount = totalAmount;
        this.customerName = customerName;
        this.paymentStatus = paymentStatus;
    }

    // Getters and Setters
    public String getSalesId() {
        return SalesId; }

    public void setSalesId(String SalesId) {
        this.SalesId = SalesId; }

    public String getItemId() {
        return itemId; }

    public void setItemId(String itemId) {
        this.itemId = itemId; }

    public int getQuantity() {
        return quantity; }

    public void setQuantity(int quantity) {
        this.quantity = quantity; }

    public String getDate() {
        return date; }

    public void setDate(String date) {
        this.date = date; }

    public double getTotalAmount() {
        return totalAmount; }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount; }

    public String getCustomerName() {
        return customerName; }

    public void setCustomerName(String customerName) {
        this.customerName = customerName; }

    public String getPaymentStatus() {
        return paymentStatus; }
    
    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus; }
}
