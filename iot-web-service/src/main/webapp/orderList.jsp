<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beans.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书销售系统 - 订单管理</title>
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
            padding: 40px 30px;
            position: relative;
        }

        .user-info {
            position: absolute;
            top: 20px;
            right: 30px;
            text-align: right;
            font-size: 1rem;
            color: white;
        }

        .user-info a {
            color: #fff;
            text-decoration: none;
            margin-left: 15px;
            padding: 8px 15px;
            border-radius: 20px;
            background: rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;
        }

        .user-info a:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
        }

        .header h1 {
            font-size: 2.8rem;
            margin-bottom: 10px;
            font-weight: 300;
            text-align: center;
        }

        .header p {
            opacity: 0.9;
            font-size: 1.2rem;
            text-align: center;
            margin-bottom: 0;
        }

        .controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 30px;
            background: #f8f9fa;
            border-bottom: 1px solid #e9ecef;
        }

        .search-box {
            position: relative;
        }

        .search-box input {
            padding: 12px 20px 12px 45px;
            border: 2px solid #e9ecef;
            border-radius: 25px;
            font-size: 14px;
            transition: all 0.3s ease;
            width: 300px;
        }

        .search-box i {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }

        .search-box input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
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

        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            text-align: center;
            border-left: 4px solid #2a5298;
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
        }

        .stat-card i {
            font-size: 2.5rem;
            color: #2a5298;
            margin-bottom: 15px;
        }

        .stat-card .number {
            font-size: 2rem;
            font-weight: bold;
            color: #212529;
        }

        .stat-card .label {
            color: #6c757d;
            font-size: 0.9rem;
        }

        .table-container {
            overflow-x: auto;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
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

        .status-tag {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
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

        .action-buttons {
            display: flex;
            gap: 8px;
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

        .btn-disabled {
            background: #6c757d;
            color: white;
            cursor: not-allowed;
            opacity: 0.6;
        }

        .btn-form {
            background: none;
            border: none;
            padding: 0;
            margin: 0;
        }

        .price {
            font-weight: bold;
            color: #2c3e50;
            font-size: 1.1rem;
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

        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 30px;
            gap: 10px;
        }

        .pagination a {
            padding: 10px 15px;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            text-decoration: none;
            color: #495057;
            transition: all 0.3s ease;
        }

        .pagination a:hover,
        .pagination a.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-color: transparent;
        }

        @media (max-width: 768px) {
            .controls {
                flex-direction: column;
                gap: 15px;
                align-items: stretch;
            }

            .search-box input {
                width: 100%;
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

        .error {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%);
            color: white;
            padding: 15px;
            border-radius: 8px;
            margin: 15px 0;
            text-align: center;
            font-weight: 500;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="user-info">
                <%
                User headerUser = (User) session.getAttribute("currentUser");
                if(headerUser != null) {
                %>
                    <span>欢迎, <%= headerUser.getUsername() %>!</span>
                    <a href="<%= request.getContextPath() %>/servlet/logout"><i class="fas fa-sign-out-alt"></i> 注销</a>
                <%
                } else {
                %>
                    <a href="<%= request.getContextPath() %>/login.jsp"><i class="fas fa-sign-in-alt"></i> 登录</a>
                    <a href="<%= request.getContextPath() %>/register.jsp"><i class="fas fa-user-plus"></i> 注册</a>
                <%
                }
                %>
            </div>
            <h1><i class="fas fa-shopping-cart"></i> 订单管理中心</h1>
            <p>管理您的订单，查看配送状态，享受便捷购物体验</p>
        </div>

        <div class="controls">
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="搜索订单号、日期...">
            </div>
            <div class="nav-links">
                <a href="<%= request.getContextPath() %>/index.jsp" class="primary">
                    <i class="fas fa-home"></i> 返回首页
                </a>
                <a href="<%= request.getContextPath() %>/servlet/bookList">
                    <i class="fas fa-book"></i> 继续购物
                </a>
            </div>
        </div>

        <div class="content">
            <%
            String errorMsg = (String) request.getAttribute("errorMsg");
            if(errorMsg != null) {
            %>
                <div class="error"><%= errorMsg %></div>
            <%
            }
            %>

            <!-- 从servlet获取的订单数据，无需再次检查用户登录状态（servlet已完成检查） -->
            <%
            java.util.List<beans.Order> orders = (java.util.List<beans.Order>) request.getAttribute("orders");
            %>


            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>订单号</th>
                            <th>创建时间</th>
                            <th>更新时间</th>
                            <th>订单金额</th>
                            <th>订单状态</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        if(orders != null && !orders.isEmpty()) {
                            for(beans.Order order : orders) {
                    %>
                    <tr>
                        <td><strong>#<%= order.getOrderId() %></strong></td>
                        <td><%= order.getCreateTime() != null ? order.getCreateTime() : "" %></td>
                        <td><%= order.getUpdateTime() != null ? order.getUpdateTime() : "" %></td>
                        <td class="price">¥<%= String.format("%.2f", order.getTotalPrice()) %></td>
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
                                out.print("<span class=\"status-tag " + statusClass + "\">" + statusText + "</span>");
                            %>
                        </td>
                        <td>
                            <div class="action-buttons">
                                <a href="<%= request.getContextPath() %>/orderDetail.jsp?orderId=<%= order.getOrderId() %>" class="btn btn-primary">
                                    <i class="fas fa-eye"></i> 详情
                                </a>

                                <% if(order.getStatus() == 0) { %>
                                    <form method="post" action="<%= request.getContextPath() %>/servlet/orderList" style="display: inline;" onsubmit="return confirm('确定要取消订单吗？')">
                                        <input type="hidden" name="action" value="cancel">
                                        <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                                        <button type="submit" class="btn btn-danger btn-form" style="background: linear-gradient(135deg, #f44336 0%, #d32f2f 100%); color: white; font-weight: bold; padding: 10px 15px; border-radius: 20px; border: none; cursor: pointer;">
                                            <i class="fas fa-times"></i> 取消
                                        </button>
                                    </form>
                                <% } else if(order.getStatus() == 2) { %>
                                    <form method="post" action="<%= request.getContextPath() %>/servlet/orderList" style="display: inline;" onsubmit="return confirm('确定已收到商品吗？')">
                                        <input type="hidden" name="action" value="confirm">
                                        <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                                        <button type="submit" class="btn btn-success btn-form">
                                            <i class="fas fa-check"></i> 确认
                                        </button>
                                    </form>
                                <% } else if(order.getStatus() == 1) { %>
                                    <span class="btn btn-disabled">
                                        <i class="fas fa-clock"></i> 待处理
                                    </span>
                                <% } else if(order.getStatus() == 3) { %>
                                    <span class="btn btn-success">
                                        <i class="fas fa-check-circle"></i> 已完成
                                    </span>
                                <% } else if(order.getStatus() == -1) { %>
                                    <form method="post" action="<%= request.getContextPath() %>/servlet/orderList" style="display: inline;" onsubmit="return confirm('确定要删除此订单吗？')">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                                        <button type="submit" class="btn btn-danger btn-form" style="background: linear-gradient(135deg, #f44336 0%, #d32f2f 100%); color: white; font-weight: bold; padding: 10px 15px; border-radius: 20px; border: none; cursor: pointer;">
                                            <i class="fas fa-trash"></i> 删除
                                        </button>
                                    </form>
                                <% } %>
                            </div>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="6">
                            <div class="empty-state">
                                <i class="fas fa-inbox"></i>
                                <h3>暂无订单</h3>
                                <p>您还没有任何订单记录，开始购物吧！</p>
                            </div>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
        // 搜索功能
        document.addEventListener('DOMContentLoaded', function() {
            const searchBox = document.querySelector('.search-box input');
            const rows = document.querySelectorAll('tbody tr');

            searchBox.addEventListener('keyup', function() {
                const searchTerm = this.value.toLowerCase();

                rows.forEach(row => {
                    const orderCells = row.textContent.toLowerCase();
                    if(orderCells.includes(searchTerm)) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            });
        });

        // 美化表单提交按钮的提示效果
        const forms = document.querySelectorAll('form');
        forms.forEach(form => {
            form.addEventListener('submit', function(e) {
                const submitBtn = this.querySelector('button[type="submit"]');
                const originalText = submitBtn.innerHTML;
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> 处理中...';

                setTimeout(() => {
                    submitBtn.innerHTML = originalText;
                }, 2000);
            });
        });
    </script>
</body>
</html>