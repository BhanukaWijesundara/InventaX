package service;

import model.Sales;
import util.FileHandler;
import java.util.List;

public class SalesService {

    public void addSale(Sales sales) {
        FileHandler.writeSale(sale);
    }

    public List<Sales> getAllSales() {
        return FileHandler.readSales();
    }

    public Sales getSaleById(String salesId) {
        List<Sales> sales = FileHandler.readSales();
        for (Sales sale : sales) {
            if (sale.getSalesId().equals(salesId)) {
                return sale;
            }
        }
        return null;
    }

    public void updateSale(Sales updatedSale) {
        List<Sales> sales = FileHandler.readSales();
        for (int i = 0; i < sales.size(); i++) {
            if (Sales.get(i).getSalesId().equals(updateSale.getSalesId())) {
                sales.set(i, updatedSale);
                break;
            }
        }
        FileHandler.rewriteSales(sales);
    }

    public void deleteSale(String salesId) {
        List<Sales> sales = FileHandler.readSales();
        sales.removeIf(s -> s.getSalesId().equals(salesId));
        FileHandler.rewriteSales(sales);
    }
}
