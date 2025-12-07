<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beans.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书销售系统 - 购物车</title>
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
            margin-bottom: 20px;
        }
        .back-link a {
            display: inline-block;
            padding: 8px 16px;
            background-color: #008CBA;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
        .checkout-btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #f44336;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin-top: 20px;
        }
        .error {
            color: red;
            margin: 10px 0;
        }
        .quantity-input {
            width: 60px;
            padding: 5px;
        }
        .update-btn {
            padding: 5px 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-left: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="back-link">
            <a href="<%= request.getContextPath() %>/index.jsp">返回首页</a>
        </div>

        <h1>购物车</h1>

        <%
        String errorMsg = (String) request.getAttribute("errorMsg");
        if(errorMsg != null) {
        %>
            <div class="error"><%= errorMsg %></div>
        <%
        }
        %>

        <% 
        User currentUser = (User) session.getAttribute("currentUser");
        if(currentUser == null) {
        %>
            <p>请先<a href="login.jsp">登录</a>后再查看购物车。</p>
        <%
        } else {
        %>
        <table>
            <tr>
                <th>ID</th>
                <th>图书名称</th>
                <th>单价</th>
                <th>数量</th>
                <th>小计</th>
                <th>操作</th>
            </tr>
            <%
                java.util.List<beans.Cart> cartList = (java.util.List<beans.Cart>) request.getAttribute("cartList");
                Double totalPrice = (Double) request.getAttribute("totalPrice");

                if(cartList != null && !cartList.isEmpty()) {
                    for(beans.Cart cartItem : cartList) {
                        double itemTotal = cartItem.getPrice() * cartItem.getQuantity();
            %>
            <tr>
                <td><%= cartItem.getId() %></td>
                <td><%= cartItem.getBookName() %></td>
                <td>¥<%= cartItem.getPrice() %></td>
                <td>
                    <form action="<%= request.getContextPath() %>/servlet/cart" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="updateQuantity">
                        <input type="hidden" name="cartId" value="<%= cartItem.getId() %>">
                        <input type="number" name="quantity" class="quantity-input" value="<%= cartItem.getQuantity() %>" min="1">
                        <button type="submit" class="update-btn">更新</button>
                    </form>
                </td>
                <td>¥<%= itemTotal %></td>
                <td>
                    <a href="<%= request.getContextPath() %>/servlet/cart?action=removeFromCart&id=<%= cartItem.getId() %>" style="color: #f44336;" onclick="return confirm('确定要从购物车中删除吗？')">删除</a>
                </td>
            </tr>
            <%
                    }
            %>
            <tr>
                <td colspan="4" style="text-align: right; font-weight: bold;">总计：</td>
                <td colspan="2" style="font-weight: bold;">¥<%= String.format("%.2f", totalPrice) %></td>
            </tr>
            <%
                } else {
            %>
            <tr>
                <td colspan="6" style="text-align: center;">购物车为空</td>
            </tr>
            <%
                }
            %>
        </table>

        <% if(cartList != null && !cartList.isEmpty()) { %>
        <div style="text-align: right; margin-top: 20px;">
            <form action="<%= request.getContextPath() %>/servlet/cart" method="post" style="display: inline;">
                <input type="hidden" name="action" value="checkout">
                <button type="submit" class="checkout-btn">生成订单</button>
            </form>
        </div>
        <% } 
        } %>
    </div>
</body>
</html>