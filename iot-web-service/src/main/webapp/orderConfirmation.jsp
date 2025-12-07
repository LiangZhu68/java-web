<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书销售系统 - 订单确认</title>
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
            padding: 40px;
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

        .success-card {
            background: linear-gradient(135deg, #e8f5e9 0%, #c8e6c9 100%);
            padding: 40px;
            border-radius: 16px;
            text-align: center;
            margin-bottom: 40px;
            border-left: 4px solid #4CAF50;
            box-shadow: 0 4px 15px rgba(76, 175, 80, 0.2);
        }

        .success-card i {
            font-size: 5rem;
            color: #4CAF50;
            margin-bottom: 20px;
        }

        .success-card h2 {
            font-size: 2.5rem;
            color: #212529;
            margin-bottom: 15px;
        }

        .order-details {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            margin-bottom: 30px;
        }

        .order-summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .summary-card {
            background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
            padding: 20px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        }

        .summary-card i {
            font-size: 2rem;
            color: #2a5298;
            margin-bottom: 10px;
        }

        .summary-card .value {
            font-size: 1.8rem;
            font-weight: bold;
            color: #2a5298;
        }

        .summary-card .label {
            color: #6c757d;
            margin-top: 5px;
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

        .btn {
            padding: 10px 20px;
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
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(42, 82, 152, 0.4);
        }

        .btn-success {
            background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
            color: white;
        }

        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(76, 175, 80, 0.4);
        }

        .btn-warning {
            background: linear-gradient(135deg, #ff9800 0%, #f57c00 100%);
            color: white;
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

        .actions {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
            margin-top: 30px;
        }

        .price {
            font-weight: bold;
            color: #2a5298;
            font-size: 1.1rem;
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

            .order-summary {
                grid-template-columns: 1fr;
            }

            .actions {
                flex-direction: column;
                align-items: center;
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
            <h1><i class="fas fa-check-circle"></i> 订单确认</h1>
            <p>感谢您的购买，订单已成功生成</p>
        </div>

        <div class="controls">
            <div class="nav-links">
                <a href="<%= request.getContextPath() %>/index.jsp">
                    <i class="fas fa-home"></i> 首页
                </a>
                <a href="<%= request.getContextPath() %>/servlet/bookList">
                    <i class="fas fa-book"></i> 继续购物
                </a>
                <a href="<%= request.getContextPath() %>/servlet/orderList" class="primary">
                    <i class="fas fa-list"></i> 我的订单
                </a>
            </div>
        </div>

        <div class="content">
            <div class="success-card">
                <i class="fas fa-check-circle"></i>
                <h2>订单生成成功！</h2>
                <p style="font-size: 1.2rem; color: #495057; margin: 15px 0;">感谢您的信任与支持，我们已收到您的订单</p>

                <div class="order-summary">
                    <div class="summary-card">
                        <i class="fas fa-barcode"></i>
                        <div class="value"><%= request.getAttribute("orderId") %></div>
                        <div class="label">订单号</div>
                    </div>
                    <div class="summary-card">
                        <i class="fas fa-dollar-sign"></i>
                        <div class="value">¥<%= String.format("%.2f", (Double) request.getAttribute("totalPrice")) %></div>
                        <div class="label">订单总价</div>
                    </div>
                    <div class="summary-card">
                        <i class="fas fa-shopping-cart"></i>
                        <div class="value">
                        <%
                            java.util.List<beans.Cart> cartList = (java.util.List<beans.Cart>) request.getAttribute("cartList");
                            int totalItems = 0;
                            if(cartList != null) {
                                for(beans.Cart cartItem : cartList) {
                                    totalItems += cartItem.getQuantity();
                                }
                            }
                            out.print(totalItems);
                        %>
                        </div>
                        <div class="label">商品总数</div>
                    </div>
                    <div class="summary-card">
                        <i class="fas fa-truck"></i>
                        <div class="value">待配送</div>
                        <div class="label">配送状态</div>
                    </div>
                </div>
            </div>

            <div class="order-details">
                <h2 style="color: #212529; margin-bottom: 20px; text-align: center;">订单商品列表</h2>

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
                            if(cartList != null) {
                                for(beans.Cart cartItem : cartList) {
                                    double itemTotal = cartItem.getPrice() * cartItem.getQuantity();
                        %>
                        <tr>
                            <td><%= cartItem.getBookName() %></td>
                            <td class="price">¥<%= String.format("%.2f", cartItem.getPrice()) %></td>
                            <td><%= cartItem.getQuantity() %> 本</td>
                            <td class="price">¥<%= String.format("%.2f", itemTotal) %></td>
                        </tr>
                        <%
                                }
                            }
                        %>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="actions">
                <a href="<%= request.getContextPath() %>/servlet/bookList" class="btn btn-primary">
                    <i class="fas fa-book"></i> 继续购物
                </a>
                <a href="<%= request.getContextPath() %>/servlet/orderList" class="btn btn-success">
                    <i class="fas fa-list"></i> 查看订单
                </a>
                <a href="<%= request.getContextPath() %>/index.jsp" class="btn btn-warning">
                    <i class="fas fa-home"></i> 返回首页
                </a>
            </div>
        </div>
    </div>
</body>
</html>