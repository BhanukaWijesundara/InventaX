package model;

public class InventoryItem {
        private String itemId;
        private String itemName;
        private int quantity;
        private String expiryDate;
        private String category;

        // Constructor
        public InventoryItem(String itemId, String itemName, int quantity, String expiryDate, String category) {
            this.itemId = itemId;
            this.itemName = itemName;
            this.quantity = quantity;
            this.expiryDate = expiryDate;
            this.category = category;
        }

        // Getters
        public String getItemId() {
            return itemId;
        }

        public String getItemName() {
            return itemName;
        }

        public int getQuantity() {
            return quantity;
        }

        public String getExpiryDate() {
            return expiryDate;
        }

        public String getCategory() {
            return category;
        }

        // Setters
        public void setItemId(String itemId) {
            this.itemId = itemId;
        }

        public void setItemName(String itemName) {
            this.itemName = itemName;
        }

        public void setQuantity(int quantity) {
            this.quantity = quantity;
        }

        public void setExpiryDate(String expiryDate) {
            this.expiryDate = expiryDate;
        }

        public void setCategory(String category) {
            this.category = category;
        }
    }
}
