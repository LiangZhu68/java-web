package beans;

import java.io.Serializable;

public class Order implements Cloneable, Serializable {
    private int id;
    private String orderId;
    private int userId;
    private double totalPrice;
    private int status; // 0-待付款, 1-已付款, 2-已发货, 3-已完成, -1-已取消
    private String createTime;
    private String updateTime;
    private String orderItems; // 保存订单项的JSON字符串或其他格式

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(String updateTime) {
        this.updateTime = updateTime;
    }

    public String getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(String orderItems) {
        this.orderItems = orderItems;
    }

    @Override
    public Object clone() {
        Order newOrder = null;
        try {
            newOrder = (Order) super.clone();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return newOrder;
    }
}