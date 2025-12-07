<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beans.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书销售系统 - 购物车</title>
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

        .header p {
            opacity: 0.9;
            font-size: 1.1rem;
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
            padding: 30px;
        }

        .section-title {
            font-size: 1.8rem;
            color: #212529;
            margin-bottom: 30px;
            text-align: center;
        }

        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            text-align: center;
            border-left: 4px solid #2a5298;
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-card i {
            font-size: 2.5rem;
            color: #2a5298;
            margin-bottom: 15px;
        }

        .stat-card .number {
            font-size: 2rem;
            font-weight: bold;
            color: #343a40;
        }

        .stat-card .label {
            color: #6c757d;
            font-size: 0.9rem;
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

        .action-buttons {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .btn i {
            font-size: 0.9rem;
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

        .quantity-control {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .quantity-input {
            width: 60px;
            padding: 8px;
            border: 1px solid #ced4da;
            border-radius: 8px;
            text-align: center;
            font-size: 0.9rem;
        }

        .update-btn {
            padding: 8px 12px;
            background: #2a5298;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 0.8rem;
        }

        .total-section {
            background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
            padding: 25px;
            border-radius: 12px;
            text-align: right;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        }

        .total-amount {
            font-size: 2rem;
            font-weight: bold;
            color: #2a5298;
        }

        .checkout-btn {
            padding: 15px 30px;
            background: linear-gradient(135deg, #f44336 0%, #d32f2f 100%);
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: bold;
            font-size: 1.1rem;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .checkout-btn:hover {
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

        .error {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%);
            color: white;
            padding: 15px;
            border-radius: 8px;
            margin: 15px 0;
            text-align: center;
            font-weight: 500;
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

            .stats {
                grid-template-columns: 1fr;
            }

            .table-container {
                font-size: 0.9rem;
            }

            th, td {
                padding: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-shopping-cart"></i> 购物车管理中心</h1>
            <p>管理购物车中的商品，完成订单结算</p>
        </div>

        <div class="controls">
            <div class="nav-links">
                <a href="<%= request.getContextPath() %>/index.jsp">
                    <i class="fas fa-home"></i> 首页
                </a>
                <a href="<%= request.getContextPath() %>/servlet/bookList">
                    <i class="fas fa-book"></i> 继续购物
                </a>
                <a href="<%= request.getContextPath() %>/servlet/orderList">
                    <i class="fas fa-list"></i> 我的订单
                </a>
            </div>
        </div>

        <div class="content">
            <h2 class="section-title">购物车</h2>

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
                <div class="empty-state">
                    <i class="fas fa-user-lock"></i>
                    <h3>需要登录</h3>
                    <p>请先<a href="login.jsp" style="color: #2a5298; text-decoration: none;">登录</a>后再查看购物车。</p>
                </div>
            <%
            } else {
                java.util.List<beans.Cart> cartList = (java.util.List<beans.Cart>) request.getAttribute("cartList");
                Double totalPrice = (Double) request.getAttribute("totalPrice");
            %>

            <%
            if(cartList != null && !cartList.isEmpty()) {
            %>

            <div class="stats">
                <div class="stat-card">
                    <i class="fas fa-shopping-cart"></i>
                    <div class="number"><%= cartList.size() %></div>
                    <div class="label">商品数量</div>
                </div>
                <div class="stat-card">
                    <i class="fas fa-cubes"></i>
                    <div class="number">
                    <%
                        int totalItems = 0;
                        for(beans.Cart cartItem : cartList) {
                            totalItems += cartItem.getQuantity();
                        }
                        out.print(totalItems);
                    %>
                    </div>
                    <div class="label">商品总数</div>
                </div>
                <div class="stat-card">
                    <i class="fas fa-dollar-sign"></i>
                    <div class="number"><%= String.format("%.2f", totalPrice) %></div>
                    <div class="label">总金额</div>
                </div>
                <div class="stat-card">
                    <i class="fas fa-percent"></i>
                    <div class="number">免税</div>
                    <div class="label">税费</div>
                </div>
            </div>

            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>序号</th>
                            <th>图书名称</th>
                            <th>单价</th>
                            <th>数量</th>
                            <th>小计</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        for(beans.Cart cartItem : cartList) {
                            double itemTotal = cartItem.getPrice() * cartItem.getQuantity();
                    %>
                    <tr>
                        <td><strong>#<%= cartItem.getId() %></strong></td>
                        <td><%= cartItem.getBookName() %></td>
                        <td class="price">¥<%= String.format("%.2f", cartItem.getPrice()) %></td>
                        <td>
                            <form action="<%= request.getContextPath() %>/servlet/cart" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="updateQuantity">
                                <input type="hidden" name="cartId" value="<%= cartItem.getId() %>">
                                <div class="quantity-control">
                                    <input type="number" name="quantity" class="quantity-input" value="<%= cartItem.getQuantity() %>" min="1" max="99">
                                    <button type="submit" class="update-btn">
                                        <i class="fas fa-sync-alt"></i>
                                    </button>
                                </div>
                            </form>
                        </td>
                        <td class="price">¥<%= String.format("%.2f", itemTotal) %></td>
                        <td>
                            <div class="action-buttons">
                                <a href="<%= request.getContextPath() %>/servlet/cart?action=removeFromCart&id=<%= cartItem.getId() %>" class="btn btn-danger" onclick="return confirm('确定要从购物车中删除吗？')">
                                    <i class="fas fa-trash"></i> 删除
                                </a>
                            </div>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>

            <div class="total-section">
                <h3>订单总计</h3>
                <div class="total-amount">¥<%= String.format("%.2f", totalPrice) %></div>
                <p style="color: #6c757d; margin-top: 10px;">含 <%= cartList.size() %> 件商品，共 <%= totalItems %> 本图书</p>
            </div>

            <div style="text-align: right;">
                <form action="<%= request.getContextPath() %>/servlet/cart" method="post" style="display: inline;">
                    <input type="hidden" name="action" value="checkout">
                    <button type="submit" class="checkout-btn">
                        <i class="fas fa-check-circle"></i> 生成订单
                    </button>
                </form>
            </div>

            <% } else { %>

            <div class="empty-state">
                <i class="fas fa-shopping-cart"></i>
                <h3>购物车为空</h3>
                <p>您的购物车中没有任何商品，开始购物吧！</p>
                <a href="<%= request.getContextPath() %>/servlet/bookList" class="btn btn-primary" style="margin-top: 20px; display: inline-block;">
                    <i class="fas fa-book"></i> 浏览图书
                </a>
            </div>

            <% } %>
            <% } %>
        </div>
    </div>
</body>
</html>