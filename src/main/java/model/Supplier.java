package model;

public class Supplier {
    private String supplierId;
    private String name;
    private String contact;
    private String email;
    private String address;


    public Supplier(String supplierId, String name, String contact, String email) {
        this.supplierId = supplierId;
        this.name = name;
        this.contact = contact;
        this.email = email;
        this.address = ""; 
    }


    public String getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(String supplierId) {
        this.supplierId = supplierId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}

