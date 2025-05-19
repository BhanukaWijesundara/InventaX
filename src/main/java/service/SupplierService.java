//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

package service;

import java.util.List;
import model.Supplier;
import util.FileHandler;

public class SupplierService {
    public SupplierService() {
    }

    public void addSupplier(Supplier supplier) {
        FileHandler.writeSupplier(supplier);
    }

    public List<Supplier> getAllSuppliers() {
        return FileHandler.readSuppliers();
    }

    public Supplier getSupplierById(String supplierId) {
        for(Supplier supplier : FileHandler.readSuppliers()) {
            if (supplier.getSupplierId().equals(supplierId)) {
                return supplier;
            }
        }

        return null;
    }

    public void updateSupplier(Supplier updatedSupplier) {
        List<Supplier> suppliers = FileHandler.readSuppliers();

        for(int i = 0; i < suppliers.size(); ++i) {
            if (((Supplier)suppliers.get(i)).getSupplierId().equals(updatedSupplier.getSupplierId())) {
                suppliers.set(i, updatedSupplier);
                break;
            }
        }

        FileHandler.rewriteSuppliers(suppliers);
    }

    public void deleteSupplier(String supplierId) {
        List<Supplier> suppliers = FileHandler.readSuppliers();
        suppliers.removeIf((s) -> s.getSupplierId().equals(supplierId));
        FileHandler.rewriteSuppliers(suppliers);
    }
}
