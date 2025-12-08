<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beans.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书销售系统 - 首页</title>
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
            text-align: center;
        }

        .header h1 {
            font-size: 2.8rem;
            margin-bottom: 15px;
            font-weight: 300;
        }

        .header p {
            opacity: 0.9;
            font-size: 1.2rem;
            margin-bottom: 20px;
        }

        .user-info {
            position: absolute;
            top: 20px;
            right: 30px;
            display: flex;
            gap: 10px;
            align-items: center;
            text-align: right;
            font-size: 1rem;
            color: white;
        }

        .user-info a {
            color: #fff;
            text-decoration: none;
            padding: 10px 18px;
            border-radius: 25px;
            background: rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 5px;
            backdrop-filter: blur(10px);
        }

        .user-info a:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .user-info a.login, .user-info a.register {
            background: linear-gradient(135deg, #2a5298 0%, #1e3c72 100%);
        }

        .user-info a.login:hover, .user-info a.register:hover {
            background: linear-gradient(135deg, #3a62a8 0%, #2e4c82 100%);
        }

        .user-info a.logout {
            background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
        }

        .user-info a.logout:hover {
            background: linear-gradient(135deg, #e85a4f 0%, #c74d40 100%);
        }

        .content {
            padding: 40px;
            text-align: center;
        }

        .welcome {
            font-size: 1.4rem;
            color: #495057;
            margin-bottom: 40px;
            line-height: 1.6;
        }

        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
            margin-bottom: 50px;
        }

        .feature-card {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: all 0.3s ease;
            border-top: 4px solid #2a5298;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 35px rgba(42, 82, 152, 0.2);
        }

        .feature-card i {
            font-size: 3rem;
            color: #2a5298;
            margin-bottom: 20px;
        }

        .feature-card h3 {
            color: #212529;
            margin-bottom: 15px;
            font-size: 1.4rem;
        }

        .feature-card p {
            color: #6c757d;
            font-size: 1rem;
            line-height: 1.6;
        }

        .menu {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin: 50px 0;
        }

        .menu-item {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            padding: 30px 20px;
            border-radius: 12px;
            text-decoration: none;
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
        }

        .menu-item i {
            font-size: 2.5rem;
            margin-bottom: 15px;
        }

        .menu-item h3 {
            font-size: 1.2rem;
            margin: 10px 0 5px 0;
        }

        .menu-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(42, 82, 152, 0.4);
        }

        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin: 40px 0;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            text-align: center;
            border-left: 4px solid #2a5298;
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

        .footer {
            text-align: center;
            padding: 30px;
            background: #f8f9fa;
            color: #6c757d;
            border-top: 1px solid #e9ecef;
            margin-top: 30px;
        }

        @media (max-width: 768px) {
            .header h1 {
                font-size: 2rem;
            }

            .welcome {
                font-size: 1.1rem;
            }

            .menu {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="user-info">
                <%
                User currentUser = (User) session.getAttribute("currentUser");
                if(currentUser != null) {
                %>
                    <span>欢迎, <%= currentUser.getUsername() %>!</span>
                    <a href="${pageContext.request.contextPath}/servlet/logout" class="logout">
                        <i class="fas fa-sign-out-alt"></i> 注销
                    </a>
                <%
                } else {
                %>
                    <a href="login.jsp" class="login">
                        <i class="fas fa-sign-in-alt"></i> 登录
                    </a>
                    <a href="register.jsp" class="register">
                        <i class="fas fa-user-plus"></i> 注册
                    </a>
                <%
                }
                %>
            </div>
            <h1><i class="fas fa-book"></i> 图书销售系统</h1>
            <p>一站式图书购买与管理平台</p>
        </div>

        <div class="content">
            <div class="features">
                <div class="feature-card">
                    <i class="fas fa-book-open"></i>
                    <h3>丰富图书资源</h3>
                    <p>海量优质图书，涵盖各类学科和技术领域，满足您的学习需求</p>
                </div>
                <div class="feature-card">
                    <i class="fas fa-shopping-cart"></i>
                    <h3>便捷购物体验</h3>
                    <p>轻松添加到购物车，一键下单，安全支付，快捷配送</p>
                </div>
                <div class="feature-card">
                    <i class="fas fa-tasks"></i>
                    <h3>智能管理功能</h3>
                    <p>完善的订单管理系统，实时跟踪订单状态，订单详情一目了然</p>
                </div>
            </div>


            <h2 style="margin: 40px 0; color: #212529;">快速导航</h2>

            <div class="menu">
                <a href="${pageContext.request.contextPath}/servlet/bookList" class="menu-item">
                    <i class="fas fa-book"></i>
                    <h3>图书管理</h3>
                    <p>浏览和管理图书</p>
                </a>
                <a href="${pageContext.request.contextPath}/servlet/userList" class="menu-item">
                    <i class="fas fa-users"></i>
                    <h3>用户管理</h3>
                    <p>管理用户信息</p>
                </a>
                <a href="${pageContext.request.contextPath}/servlet/cart" class="menu-item">
                    <i class="fas fa-shopping-cart"></i>
                    <h3>购物车</h3>
                    <p>查看购物车</p>
                </a>
                <a href="${pageContext.request.contextPath}/servlet/orderList" class="menu-item">
                    <i class="fas fa-list"></i>
                    <h3>订单管理</h3>
                    <p>查看和管理订单</p>
                </a>
            </div>
        </div>

    </div>
</body>
</html>