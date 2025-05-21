package util;

import model.InventoryItem;

import java.util.*;

public class SortUtil {

    public static List<InventoryItem> mergeSortByExpiry(List<InventoryItem> list) {
        if (list.size() <= 1) return list;

        int mid = list.size() / 2;
        List<InventoryItem> left = mergeSortByExpiry(list.subList(0, mid));
        List<InventoryItem> right = mergeSortByExpiry(list.subList(mid, list.size()));

        return merge(left, right);
    }

    private static List<InventoryItem> merge(List<InventoryItem> left, List<InventoryItem> right) {
        List<InventoryItem> merged = new ArrayList<>();
        int i = 0, j = 0;
        while (i < left.size() && j < right.size()) {
            if (left.get(i).getExpiryDate().compareTo(right.get(j).getExpiryDate()) <= 0) {
                merged.add(left.get(i++));
            } else {
                merged.add(right.get(j++));
            }
        }
        merged.addAll(left.subList(i, left.size()));
        merged.addAll(right.subList(j, right.size()));
        return merged;
    }
}
