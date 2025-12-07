<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="beans.Book" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书销售系统 - 图书列表</title>
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
        .action-links a {
            margin-right: 10px;
            text-decoration: none;
        }
        .edit-link { color: #4CAF50; }
        .delete-link { color: #f44336; }
        .add-to-cart-link { color: #2196F3; }
        .add-book-link {
            display: inline-block;
            padding: 8px 16px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="back-link">
            <a href="<%= request.getContextPath() %>/index.jsp">返回首页</a>
        </div>

        <h1>图书列表</h1>

        <a href="<%= request.getContextPath() %>/servlet/addBook" class="add-book-link">添加图书</a>
        
        <table>
            <tr>
                <th>ID</th>
                <th>书名</th>
                <th>作者</th>
                <th>价格</th>
                <th>库存</th>
                <th>操作</th>
            </tr>
            <%
                List<Book> books = (List<Book>) request.getAttribute("bookList");
                if(books != null) {
                    for(Book book : books) {
            %>
            <tr>
                <td><%= book.getId() %></td>
                <td><%= book.getName() %></td>
                <td><%= book.getAuthor() %></td>
                <td><%= book.getPrice() %></td>
                <td><%= book.getBookCount() %></td>
                <td class="action-links">
                    <a href="<%= request.getContextPath() %>/servlet/updateBook?id=<%= book.getId() %>" class="edit-link">编辑</a> |
                    <a href="<%= request.getContextPath() %>/servlet/deleteBook?id=<%= book.getId() %>" class="delete-link" onclick="return confirm('确定要删除吗？')">删除</a> |
                    <a href="<%= request.getContextPath() %>/servlet/cart?action=addToCart&id=<%= book.getId() %>&name=<%= java.net.URLEncoder.encode(book.getName(), "UTF-8") %>&price=<%= book.getPrice() %>&author=<%= java.net.URLEncoder.encode(book.getAuthor(), "UTF-8") %>&stock=<%= book.getBookCount() %>" class="add-to-cart-link">加入购物车</a>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="6">暂无图书数据</td>
            </tr>
            <%
                }
            %>
        </table>
    </div>
</body>
</html>