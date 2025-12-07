<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beans.User,beans.Order" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书销售系统 - 订单详情</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }

        .header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            font-weight: 300;
        }

        .controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 30px;
            background: #f8f9fa;
            border-bottom: 1px solid #e9ecef;
        }

        .nav-links {
            display: flex;
            gap: 10px;
        }

        .nav-links a {
            display: inline-block;
            padding: 10px 20px;
            text-decoration: none;
            color: #495057;
            border-radius: 25px;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .nav-links a:hover {
            background: #e9ecef;
            color: #2a5298;
        }

        .nav-links a.primary {
            background: linear-gradient(135deg, #2a5298 0%, #1e3c72 100%);
            color: white;
        }

        .nav-links a.primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(42, 82, 152, 0.4);
        }

        .content {
            padding: 40px;
        }

        .order-card {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            margin-bottom: 30px;
        }

        .order-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .info-item {
            background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
            padding: 15px;
            border-radius: 8px;
            text-align: center;
        }

        .info-item i {
            font-size: 2rem;
            color: #2a5298;
            margin-bottom: 10px;
        }

        .info-item .label {
            font-size: 0.9rem;
            color: #6c757d;
        }

        .info-item .value {
            font-size: 1.2rem;
            font-weight: bold;
            color: #2a5298;
        }

        .status-badge {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 500;
            font-size: 0.9rem;
        }

        .status-pending {
            background-color: rgba(255, 152, 0, 0.1);
            color: #ff9800;
            border: 1px solid rgba(255, 152, 0, 0.3);
        }

        .status-paid {
            background-color: rgba(76, 175, 80, 0.1);
            color: #4CAF50;
            border: 1px solid rgba(76, 175, 80, 0.3);
        }

        .status-shipped {
            background-color: rgba(33, 150, 243, 0.1);
            color: #2196F3;
            border: 1px solid rgba(33, 150, 243, 0.3);
        }

        .status-completed {
            background-color: rgba(156, 39, 176, 0.1);
            color: #9C27B0;
            border: 1px solid rgba(156, 39, 176, 0.3);
        }

        .status-cancelled {
            background-color: rgba(244, 67, 54, 0.1);
            color: #f44336;
            border: 1px solid rgba(244, 67, 54, 0.3);
        }

        .table-container {
            overflow-x: auto;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }

        th {
            background: linear-gradient(135deg, #2a5298 0%, #1e3c72 100%);
            color: white;
            padding: 15px 20px;
            text-align: left;
            font-weight: 500;
        }

        td {
            padding: 15px 20px;
            border-bottom: 1px solid #e9ecef;
        }

        tr:nth-child(even) {
            background-color: #f8f9fa;
        }

        tr:hover {
            background-color: #f1f3f5;
        }

        .summary {
            background: linear-gradient(135deg, #e8f5e9 0%, #c8e6c9 100%);
            padding: 25px;
            border-radius: 12px;
            text-align: right;
            border-left: 4px solid #4CAF50;
        }

        .summary h3 {
            font-size: 1.5rem;
            color: #2a5298;
            margin-bottom: 10px;
        }

        .summary .total-price {
            font-size: 2.5rem;
            font-weight: bold;
            color: #2a5298;
        }

        .actions {
            text-align: center;
            margin-top: 30px;
        }

        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            text-decoration: none;
            font-size: 1rem;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn i {
            font-size: 1rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, #2a5298 0%, #1e3c72 100%);
            color: white;
            margin-right: 10px;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(42, 82, 152, 0.4);
        }

        .btn-success {
            background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
            color: white;
            margin-right: 10px;
        }

        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(76, 175, 80, 0.4);
        }

        .btn-warning {
            background: linear-gradient(135deg, #ff9800 0%, #f57c00 100%);
            color: white;
            margin-right: 10px;
        }

        .btn-warning:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 152, 0, 0.4);
        }

        .btn-danger {
            background: linear-gradient(135deg, #f44336 0%, #d32f2f 100%);
            color: white;
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(244, 67, 54, 0.4);
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #6c757d;
        }

        .empty-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            opacity: 0.3;
        }

        .empty-state h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: #495057;
        }

        .price {
            font-weight: bold;
            color: #2a5298;
            font-size: 1.1rem;
        }

        .quantity {
            background: #e3f2fd;
            padding: 4px 10px;
            border-radius: 20px;
            color: #1976d2;
        }

        @media (max-width: 768px) {
            .controls {
                flex-direction: column;
                gap: 15px;
                align-items: stretch;
            }

            .nav-links {
                display: flex;
                justify-content: center;
                flex-wrap: wrap;
                gap: 10px;
            }

            .nav-links a {
                margin: 0 5px;
                padding: 8px 16px;
            }

            .order-info {
                grid-template-columns: 1fr;
            }

            .table-container {
                font-size: 0.9rem;
            }

            th, td {
                padding: 10px;
            }

            .actions {
                display: flex;
                flex-direction: column;
                gap: 10px;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-receipt"></i> 订单详情</h1>
            <p>查看订单信息，跟踪配送状态</p>
        </div>

        <div class="controls">
            <div class="nav-links">
                <a href="<%= request.getContextPath() %>/index.jsp">
                    <i class="fas fa-home"></i> 首页
                </a>
                <a href="<%= request.getContextPath() %>/servlet/orderList" class="primary">
                    <i class="fas fa-list"></i> 订单列表
                </a>
                <a href="<%= request.getContextPath() %>/servlet/bookList">
                    <i class="fas fa-book"></i> 继续购物
                </a>
            </div>
        </div>

        <div class="content">
            <%
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
            response.setContentType("text/html; charset=UTF-8");

            User currentUser = (User) session.getAttribute("currentUser");
            if(currentUser == null) {
            %>
                <div class="empty-state">
                    <i class="fas fa-user-lock"></i>
                    <h3>需要登录</h3>
                    <p>请先<a href="login.jsp" style="color: #2a5298; text-decoration: none;">登录</a>后再查看订单详情。</p>
                </div>
            <%
            } else {
                String orderId = request.getParameter("orderId");
                if(orderId != null && !orderId.isEmpty()) {
                    dao.OrderDao orderDao = new dao.OrderDao();
                    Order order = orderDao.getOrderByOrderId(orderId);

                    if(order != null && order.getUserId() == currentUser.getId()) {
            %>
                        <div class="order-card">
                            <div class="order-info">
                                <div class="info-item">
                                    <i class="fas fa-barcode"></i>
                                    <div class="label">订单号</div>
                                    <div class="value">#<%= order.getOrderId() %></div>
                                </div>
                                <div class="info-item">
                                    <i class="fas fa-calendar"></i>
                                    <div class="label">创建时间</div>
                                    <div class="value"><%= order.getCreateTime() != null ? order.getCreateTime() : "" %></div>
                                </div>
                                <div class="info-item">
                                    <i class="fas fa-sync-alt"></i>
                                    <div class="label">更新时间</div>
                                    <div class="value"><%= order.getUpdateTime() != null ? order.getUpdateTime() : "" %></div>
                                </div>
                                <div class="info-item">
                                    <i class="fas fa-dollar-sign"></i>
                                    <div class="label">订单金额</div>
                                    <div class="value">¥<%= String.format("%.2f", order.getTotalPrice()) %></div>
                                </div>
                            </div>

                            <div style="text-align: center; margin: 20px 0;">
                                <span class="status-badge status-<%= order.getStatus() == 0 ? "pending" :
                                    order.getStatus() == 1 ? "paid" :
                                    order.getStatus() == 2 ? "shipped" :
                                    order.getStatus() == 3 ? "completed" : "cancelled" %>">
                                    <%
                                        String statusText = "未知状态";
                                        switch(order.getStatus()) {
                                            case 0:
                                                statusText = "待付款";
                                                break;
                                            case 1:
                                                statusText = "已付款";
                                                break;
                                            case 2:
                                                statusText = "已发货";
                                                break;
                                            case 3:
                                                statusText = "已完成";
                                                break;
                                            case -1:
                                                statusText = "已取消";
                                                break;
                                        }
                                        out.print(statusText);
                                    %>
                                </span>
                            </div>
                        </div>

                        <h2 style="color: #212529; margin-bottom: 20px; text-align: center;">订单商品清单</h2>

                        <div class="table-container">
                            <table>
                                <thead>
                                    <tr>
                                        <th>图书名称</th>
                                        <th>单价</th>
                                        <th>数量</th>
                                        <th>小计</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%
                                // 解析订单项JSON字符串
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

                                            // 提取 bookName (格式: "bookName":"书名" 或 "name":"书名")
                                            String bookName = null;
                                            int bookNameStart = itemStr.indexOf("\"bookName\":\"");
                                            if(bookNameStart != -1) {
                                                bookNameStart += 12; // 跳过 "bookName":""
                                                int bookNameEnd = itemStr.indexOf("\"", bookNameStart);
                                                if(bookNameEnd != -1) {
                                                    bookName = itemStr.substring(bookNameStart, bookNameEnd);
                                                }
                                            } else {
                                                // 尝试另一种格式
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
                                    <td class="price">¥<%= String.format("%.2f", price) %></td>
                                    <td><span class="quantity"><%= quantity %> 本</span></td>
                                    <td class="price">¥<%= String.format("%.2f", subtotal) %></td>
                                </tr>
                                <%
                                            } else if(bookName != null) { // 如果只有书名，也显示
                                                out.println("<tr><td colspan='4'>商品: " + bookName + " (解析其他信息失败)</td></tr>");
                                            } else {
                                                // 如果解析失败，输出错误信息
                                                out.println("<tr><td colspan='4'>解析订单项失败</td></tr>");
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
                                </tbody>
                            </table>
                        </div>

                        <div class="summary">
                            <h3>订单总计</h3>
                            <div class="total-price">¥<%= String.format("%.2f", order.getTotalPrice()) %></div>
                        </div>

                        <div class="actions">
                            <a href="<%= request.getContextPath() %>/servlet/orderList" class="btn btn-primary">
                                <i class="fas fa-arrow-left"></i> 返回订单列表
                            </a>
                            <a href="<%= request.getContextPath() %>/servlet/bookList" class="btn btn-success">
                                <i class="fas fa-shopping-cart"></i> 继续购物
                            </a>
                            <a href="<%= request.getContextPath() %>/index.jsp" class="btn btn-warning">
                                <i class="fas fa-home"></i> 返回首页
                            </a>
                        </div>
            <%
                    } else {
            %>
                        <div class="empty-state">
                            <i class="fas fa-exclamation-triangle"></i>
                            <h3>订单不存在</h3>
                            <p>未找到订单或您没有权限查看此订单。</p>
                        </div>
            <%
                    }
                } else {
            %>
                    <div class="empty-state">
                        <i class="fas fa-question-circle"></i>
                        <h3>缺少订单号</h3>
                        <p>缺少订单号参数，无法查看订单详情。</p>
                    </div>
            <%
                }
            }
            %>
        </div>
    </div>
</body>
</html>