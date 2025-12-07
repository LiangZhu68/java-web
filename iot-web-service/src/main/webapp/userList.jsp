<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="beans.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书销售系统 - 用户列表</title>
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
    </style>
</head>
<body>
    <div class="container">
        <div class="back-link">
            <a href="<%= request.getContextPath() %>/index.jsp">返回首页</a>
        </div>
        
        <h1>用户列表</h1>
        
        <table>
            <tr>
                <th>ID</th>
                <th>用户名</th>
                <th>邮箱</th>
                <th>操作</th>
            </tr>
            <%
                List<User> users = (List<User>) request.getAttribute("userList");
                if(users != null) {
                    for(User user : users) {
            %>
            <tr>
                <td><%= user.getId() %></td>
                <td><%= user.getUsername() %></td>
                <td><%= user.getEmail() %></td>
                <td>
                    <a href="<%= request.getContextPath() %>/servlet/userEdit?action=edit&id=<%= user.getId() %>" style="color: #4CAF50;">编辑</a> |
                    <a href="<%= request.getContextPath() %>/servlet/userEdit?action=delete&id=<%= user.getId() %>" style="color: #f44336;" onclick="return confirm('确定要删除吗？')">删除</a>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="4">暂无用户数据</td>
            </tr>
            <%
                }
            %>
        </table>

        <div style="margin-top: 20px;">
            <a href="<%= request.getContextPath() %>/servlet/register" style="display: inline-block; padding: 8px 16px; background-color: #4CAF50; color: white; text-decoration: none; border-radius: 4px;">添加用户</a>
        </div>
    </div>
</body>
</html>