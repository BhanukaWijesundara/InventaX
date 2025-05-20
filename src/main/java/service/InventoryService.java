package service;

import model.InventoryItem;
import util.FileHandler;
import util.SortUtil;

import java.util.List;
import java.util.Stack;
import java.util.stream.Collectors;

public class InventoryService {
    private Stack<InventoryItem> inventory = new Stack<>();

    public void addItem(InventoryItem item) {
        System.out.println("Adding item: " + item.getItemName());
        inventory.push(item);
        FileHandler.writeItem(item);
        System.out.println("Item added successfully");
    }

    public InventoryItem removeItem() {
        InventoryItem removed = inventory.pop();
        FileHandler.rewriteItems(inventory);
        return removed;
    }

    public List<InventoryItem> getSortedInventory() {
        List<InventoryItem> items = SortUtil.mergeSortByExpiry(FileHandler.readItems());
        System.out.println("Getting sorted inventory. Total items: " + items.size());
        return items;
    }

    public List<InventoryItem> getAllItems() {
        List<InventoryItem> items = FileHandler.readItems();
        System.out.println("Getting all items. Total items: " + items.size());
        items.forEach(item -> System.out.println("Item: " + item.getItemName() + ", ID: " + item.getItemId()));
        return items;
    }

    public void deleteItem(String itemId) {
        List<InventoryItem> items = FileHandler.readItems();
        System.out.println("Before deletion. Total items: " + items.size());
        List<InventoryItem> updatedItems = items.stream()
                .filter(item -> !item.getItemId().equals(itemId))
                .collect(Collectors.toList());
        System.out.println("After deletion. Total items: " + updatedItems.size());

        // Convert List to Stack
        Stack<InventoryItem> updatedStack = new Stack<>();
        updatedStack.addAll(updatedItems);
        FileHandler.rewriteItems(updatedStack);
    }

    public InventoryItem getItemById(String itemId) {
        List<InventoryItem> items = FileHandler.readItems();
        return items.stream()
                .filter(item -> item.getItemId().equals(itemId))
                .findFirst()
                .orElse(null);
    }

    public void updateItem(InventoryItem updatedItem) {
        List<InventoryItem> items = FileHandler.readItems();
        List<InventoryItem> updatedItems = items.stream()
                .map(item -> item.getItemId().equals(updatedItem.getItemId()) ? updatedItem : item)
                .collect(Collectors.toList());

        // Convert List to Stack
        Stack<InventoryItem> updatedStack = new Stack<>();
        updatedStack.addAll(updatedItems);
        FileHandler.rewriteItems(updatedStack);
    }
}
