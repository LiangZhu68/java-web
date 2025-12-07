<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beans.User" %>
<%@ page import="beans.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书销售系统 - 订单详情</title>
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
        .order-header {
            background-color: #f9f9f9;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-bottom: 20px;
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
        .items-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .items-table th, .items-table td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        .items-table th {
            background-color: #4CAF50;
            color: white;
        }
        .items-table tr:nth-child(even) {
            background-color: #f2f2f2;
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
        .order-summary {
            background-color: #f9f9f9;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-top: 20px;
            text-align: right;
        }
        .delete-btn {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
        }
        .delete-btn:hover {
            background-color: #d32f2f;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="back-link">
            <a href="<%= request.getContextPath() %>/servlet/orderList">返回订单列表</a>
        </div>

        <h1>订单详情</h1>

        <%
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        User currentUser = (User) session.getAttribute("currentUser");
        if(currentUser == null) {
        %>
            <p>请先<a href="login.jsp">登录</a>后再查看订单详情。</p>
        <%
        } else {
            String orderId = request.getParameter("orderId");
            if(orderId != null && !orderId.isEmpty()) {
                dao.OrderDao orderDao = new dao.OrderDao();
                Order order = orderDao.getOrderByOrderId(orderId);

                if(order != null && order.getUserId() == currentUser.getId()) {
        %>
                    <div class="order-header">
                        <h2>订单号: <%= order.getOrderId() %></h2>
                        <p><strong>创建时间:</strong> <%= order.getCreateTime() != null ? order.getCreateTime() : "" %></p>
                        <p><strong>更新时间:</strong> <%= order.getUpdateTime() != null ? order.getUpdateTime() : "" %></p>
                        <p><strong>订单状态:</strong>
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
                        </p>
                    </div>

                    <h3>订单商品列表</h3>
                    <table class="items-table">
                        <tr>
                            <th>图书名称</th>
                            <th>单价</th>
                            <th>数量</th>
                            <th>小计</th>
                        </tr>
                        <%
                        // 解析 JSON 格式的订单项，使用更简单直接的字符串处理方式
                        String orderItemsJson = order.getOrderItems();
                        if(orderItemsJson != null && !orderItemsJson.isEmpty()) {
                            try {
                                // 确保字符串以 [ 开头和 ] 结尾
                                String jsonStr = orderItemsJson.trim();
                                if(jsonStr.startsWith("[")) {
                                    jsonStr = jsonStr.substring(1);
                                }
                                if(jsonStr.endsWith("]")) {
                                    jsonStr = jsonStr.substring(0, jsonStr.length() - 1);
                                }

                                // 按 "},{" 分割各个订单项
                                String[] items = jsonStr.split("\\},\\s*\\{");

                                for(int i = 0; i < items.length; i++) {
                                    String itemStr = items[i].trim();

                                    // 清理首尾的 [ 和 ]
                                    if (i == 0 && itemStr.startsWith("[")) {
                                        itemStr = itemStr.substring(1);
                                    }
                                    if (i == items.length - 1 && itemStr.endsWith("]")) {
                                        itemStr = itemStr.substring(0, itemStr.length() - 1);
                                    }

                                    // 提取 bookName (格式: "bookName":"书名")
                                    String bookName = null;
                                    int bookNameStart = itemStr.indexOf("\"bookName\":\"");
                                    if(bookNameStart != -1) {
                                        bookNameStart += 12; // 跳过 "bookName":""
                                        int bookNameEnd = itemStr.indexOf("\"", bookNameStart);
                                        if(bookNameEnd != -1) {
                                            bookName = itemStr.substring(bookNameStart, bookNameEnd);
                                        }
                                    } else {
                                        // 尝试另一种格式，可能没有bookName字段，而是name
                                        bookNameStart = itemStr.indexOf("\"name\":\"");
                                        if(bookNameStart != -1) {
                                            bookNameStart += 8; // 跳过 "name":""
                                            int bookNameEnd = itemStr.indexOf("\"", bookNameStart);
                                            if(bookNameEnd != -1) {
                                                bookName = itemStr.substring(bookNameStart, bookNameEnd);
                                            }
                                        }
                                    }

                                    // 提取 price (格式: "price":数值)
                                    String priceStr = null;
                                    int priceStart = itemStr.indexOf("\"price\":");
                                    if(priceStart != -1) {
                                        priceStart += 8; // 跳过 "price":
                                        int priceEnd = itemStr.indexOf(',', priceStart);
                                        if(priceEnd == -1) { // 如果是最后一个字段，没有逗号
                                            // 查找下一个 "}" 或字符串结尾
                                            int braceEnd = itemStr.indexOf('}', priceStart);
                                            if(braceEnd != -1 && (priceEnd == -1 || braceEnd < priceEnd)) {
                                                priceEnd = braceEnd;
                                            } else {
                                                priceEnd = itemStr.length();
                                            }
                                        }
                                        priceStr = itemStr.substring(priceStart, priceEnd).trim();
                                        // 去除可能的非数字字符（保留数字、小数点和负号）
                                        priceStr = priceStr.replaceAll("[^0-9.\\-]", "");
                                    }

                                    // 提取 quantity (格式: "quantity":数值)
                                    String quantityStr = null;
                                    int quantityStart = itemStr.indexOf("\"quantity\":");
                                    if(quantityStart != -1) {
                                        quantityStart += 11; // 跳过 "quantity":
                                        int quantityEnd = itemStr.indexOf(',', quantityStart);
                                        if(quantityEnd == -1) { // 如果是最后一个字段，没有逗号
                                            // 查找下一个 "}" 或字符串结尾
                                            int braceEnd = itemStr.indexOf('}', quantityStart);
                                            if(braceEnd != -1 && (quantityEnd == -1 || braceEnd < quantityEnd)) {
                                                quantityEnd = braceEnd;
                                            } else {
                                                quantityEnd = itemStr.length();
                                            }
                                        }
                                        quantityStr = itemStr.substring(quantityStart, quantityEnd).trim();
                                        // 去除可能的非数字字符（只保留数字）
                                        quantityStr = quantityStr.replaceAll("[^0-9]", "");
                                    }

                                    // 如果所有字段都找到了，输出表格行
                                    if(bookName != null && priceStr != null && quantityStr != null) {
                                        double price = Double.parseDouble(priceStr);
                                        int quantity = Integer.parseInt(quantityStr);
                                        double subtotal = price * quantity;
                        %>
                        <tr>
                            <td><%= bookName %></td>
                            <td>¥<%= String.format("%.2f", price) %></td>
                            <td><%= quantity %></td>
                            <td>¥<%= String.format("%.2f", subtotal) %></td>
                        </tr>
                        <%
                                    } else if(bookName != null) { // 如果只有书名，也显示
                                        out.println("<tr><td colspan='4'>商品: " + bookName + " (解析其他信息失败)</td></tr>");
                                    } else {
                                        // 如果解析失败，输出错误信息
                                        out.println("<tr><td colspan='4'>解析订单项失败: bookName=" + bookName + ", priceStr=" + priceStr + ", quantityStr=" + quantityStr + "</td></tr>");
                                    }
                                }
                            } catch(Exception e) {
                                out.print("<tr><td colspan='4'>订单项数据解析失败: " + e.getMessage() + "</td></tr>");
                                e.printStackTrace(); // 打印错误堆栈到服务器日志
                            }
                        } else {
                        %>
                        <tr><td colspan='4'>订单项数据为空</td></tr>
                        <%
                        }
                        %>
                    </table>

                    <div class="order-summary">
                        <h3>订单总计: ¥<%= String.format("%.2f", order.getTotalPrice()) %></h3>
                    </div>
        <%
                } else {
        %>
                    <p>未找到订单或您没有权限查看此订单。</p>
        <%
                }
            } else {
        %>
                <p>缺少订单号参数。</p>
        <%
            }
        %>

        <div class="back-link">
            <a href="<%= request.getContextPath() %>/servlet/orderList">返回订单列表</a>
            <a href="<%= request.getContextPath() %>/servlet/bookList" style="margin-left: 10px;">继续购物</a>
        </div>
        <% } %>
    </div>
</body>
</html>