<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beans.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书销售系统</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
        .user-info {
            text-align: right;
            font-size: 14px;
        }
        .user-info a {
            color: #008CBA;
            text-decoration: none;
            margin-left: 10px;
        }
        .menu {
            text-align: center;
            margin: 20px 0;
        }
        .menu a {
            display: inline-block;
            margin: 10px;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
        .menu a:hover {
            background-color: #45a049;
        }
        .welcome {
            text-align: center;
            color: #555;
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>欢迎使用图书销售系统</h1>
            <div class="user-info">
                <%
                User currentUser = (User) session.getAttribute("currentUser");
                if(currentUser != null) {
                %>
                    欢迎, <%= currentUser.getUsername() %>!
                    <a href="servlet/logout">注销</a>
                <%
                } else {
                %>
                    <a href="login.jsp">登录</a> | <a href="register.jsp">注册</a>
                <%
                }
                %>
            </div>
        </div>

        <p class="welcome">这是一个基于MVC模式开发的Web应用，支持图书管理、用户管理和购物功能。</p>

        <div class="menu">
            <a href="servlet/bookList">图书管理</a>
            <a href="servlet/userList">用户管理</a>
            <a href="servlet/cart">购物车</a>
            <a href="servlet/orderList">订单管理</a>
        </div>

        <div style="text-align: center; margin-top: 50px; color: #666; font-size: 14px;">
            <p>欢迎使用我们的图书销售系统</p>
        </div>
    </div>
</body>
</html>