<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beans.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书销售系统 - 编辑用户</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 500px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #555;
        }
        .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-right: 10px;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .btn-back {
            background-color: #008CBA;
        }
        .btn-back:hover {
            background-color: #007B9A;
        }
        .error {
            color: red;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>编辑用户</h2>
        
        <% 
        String errorMsg = (String) request.getAttribute("errorMsg");
        User user = (User) request.getAttribute("user");
        if(errorMsg != null) {
        %>
            <div class="error"><%= errorMsg %></div>
        <%
        }
        if(user != null) {
        %>
        <form action="<%= request.getContextPath() %>/servlet/userEdit" method="post">
            <input type="hidden" name="id" value="<%= user.getId() %>">
            <div class="form-group">
                <label for="username">用户名:</label>
                <input type="text" id="username" name="username" value="<%= user.getUsername() %>" required>
            </div>
            <div class="form-group">
                <label for="password">密码:</label>
                <input type="password" id="password" name="password" value="<%= user.getPassword() %>" required>
            </div>
            <div class="form-group">
                <label for="email">邮箱:</label>
                <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required>
            </div>
            <button type="submit" class="btn">更新用户</button>
            <a href="<%= request.getContextPath() %>/servlet/userList" class="btn btn-back">返回用户列表</a>
        </form>
        <%
        } else {
        %>
            <div class="error">找不到用户信息！</div>
            <a href="<%= request.getContextPath() %>/servlet/userList" class="btn btn-back">返回用户列表</a>
        <%
        }
        %>
    </div>
</body>
</html>