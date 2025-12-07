<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beans.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书销售系统 - 订单列表</title>
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
        }
        .status-pending {
            color: #ff9800;
            font-weight: bold;
        }
        .status-paid {
            color: #4CAF50;
            font-weight: bold;
        }
        .status-shipped {
            color: #2196F3;
            font-weight: bold;
        }
        .status-completed {
            color: #9C27B0;
            font-weight: bold;
        }
        .status-cancelled {
            color: #f44336;
            font-weight: bold;
        }
        .error {
            color: red;
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="back-link">
            <a href="<%= request.getContextPath() %>/index.jsp">返回首页</a>
        </div>

        <h1>订单列表</h1>

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
            <p>请先<a href="login.jsp">登录</a>后再查看订单。</p>
        <%
        } else {
        %>

        <table>
            <tr>
                <th>订单号</th>
                <th>创建时间</th>
                <th>更新时间</th>
                <th>总价</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
            <%
                java.util.List<beans.Order> orders = (java.util.List<beans.Order>) request.getAttribute("orders");
                if(orders != null && !orders.isEmpty()) {
                    for(beans.Order order : orders) {
            %>
            <tr>
                <td><%= order.getOrderId() %></td>
                <td><%= order.getCreateTime() != null ? order.getCreateTime() : "" %></td>
                <td><%= order.getUpdateTime() != null ? order.getUpdateTime() : "" %></td>
                <td>¥<%= String.format("%.2f", order.getTotalPrice()) %></td>
                <td>
                    <%
                        String statusClass = "";
                        String statusText = "未知状态";
                        switch(order.getStatus()) {
                            case 0: 
                                statusClass = "status-pending"; 
                                statusText = "待付款"; 
                                break;
                            case 1: 
                                statusClass = "status-paid"; 
                                statusText = "已付款"; 
                                break;
                            case 2: 
                                statusClass = "status-shipped"; 
                                statusText = "已发货"; 
                                break;
                            case 3: 
                                statusClass = "status-completed"; 
                                statusText = "已完成"; 
                                break;
                            case -1: 
                                statusClass = "status-cancelled"; 
                                statusText = "已取消"; 
                                break;
                        }
                        out.print("<span class=\"" + statusClass + "\">" + statusText + "</span>");
                    %>
                </td>
                <td>
                    <% if(order.getStatus() == 0) { %>
                        <a href="<%= request.getContextPath() %>/servlet/orderList?action=cancel&orderId=<%= order.getOrderId() %>" style="color: #f44336;" onclick="return confirm('确定要取消订单吗？')">取消订单</a>
                    <% } else if(order.getStatus() == 2) { %>
                        <a href="<%= request.getContextPath() %>/servlet/orderList?action=confirm&orderId=<%= order.getOrderId() %>" style="color: #4CAF50;" onclick="return confirm('确定已收到商品吗？')">确认收货</a>
                    <% } else if(order.getStatus() == 0 || order.getStatus() == 1) { %>
                        <a href="#" style="color: #9E9E9E;" disabled>待处理</a>
                    <% } else if(order.getStatus() == 3) { %>
                        <a href="#" style="color: #4CAF50;">交易完成</a>
                    <% } else if(order.getStatus() == -1) { %>
                        <a href="#" style="color: #f44336;">订单已取消</a>
                    <% } %>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="6">暂无订单数据</td>
            </tr>
            <%
                }
            %>
        </table>

        <div class="back-link">
            <a href="<%= request.getContextPath() %>/servlet/bookList">继续购物</a>
        </div>
        <% } %>
    </div>
</body>
</html>