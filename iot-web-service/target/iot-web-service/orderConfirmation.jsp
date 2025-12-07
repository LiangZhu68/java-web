<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书销售系统 - 订单确认</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .back-link {
            margin-top: 20px;
        }
        .back-link a {
            display: inline-block;
            padding: 8px 16px;
            background-color: #008CBA;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin-right: 10px;
        }
        .success-message {
            background-color: #dff0d8;
            color: #3c763d;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="success-message">
            <h2>订单生成成功！</h2>
            <p><strong>订单号：</strong><%= request.getAttribute("orderId") %></p>
            <p><strong>订单总价：</strong>¥<%= String.format("%.2f", (Double) request.getAttribute("totalPrice")) %></p>
        </div>

        <h1>订单详情</h1>

        <table>
            <tr>
                <th>图书名称</th>
                <th>单价</th>
                <th>数量</th>
                <th>小计</th>
            </tr>
            <%
                java.util.List<beans.Cart> cartList = (java.util.List<beans.Cart>) request.getAttribute("cartList");
                if(cartList != null) {
                    for(beans.Cart cartItem : cartList) {
                        double itemTotal = cartItem.getPrice() * cartItem.getQuantity();
            %>
            <tr>
                <td><%= cartItem.getBookName() %></td>
                <td>¥<%= cartItem.getPrice() %></td>
                <td><%= cartItem.getQuantity() %></td>
                <td>¥<%= itemTotal %></td>
            </tr>
            <%
                    }
                }
            %>
        </table>

        <div class="back-link">
            <a href="<%= request.getContextPath() %>/servlet/bookList">继续购物</a>
            <a href="<%= request.getContextPath() %>/servlet/orderList">查看订单</a>
        </div>
    </div>
</body>
</html>