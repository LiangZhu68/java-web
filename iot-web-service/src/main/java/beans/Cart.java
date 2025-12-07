package beans;

import java.io.Serializable;

public class Cart implements Cloneable, Serializable {
    private int id;
    private int userId;
    private int bookId;
    private int quantity;
    private String bookName;
    private double price;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Override
    public Object clone() {
        Cart newCart = null;
        try {
            newCart = (Cart) super.clone();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return newCart;
    }
}