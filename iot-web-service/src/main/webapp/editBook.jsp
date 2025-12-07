<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beans.Book" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书销售系统 - 编辑图书</title>
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
        .btn-delete {
            background-color: #f44336;
        }
        .btn-delete:hover {
            background-color: #da190b;
        }
        .error {
            color: red;
            margin-bottom: 10px;
        }
        .back-link {
            margin-top: 20px;
        }
        .back-link a {
            color: #008CBA;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>编辑图书</h2>
        
        <%
        String errorMsg = (String) request.getAttribute("errorMsg");
        Book book = (Book) request.getAttribute("book");
        if(errorMsg != null) {
        %>
            <div class="error"><%= errorMsg %></div>
        <%
        }
        if(book != null) {
        %>
        <form action="<%= request.getContextPath() %>/servlet/updateBook" method="post">
            <input type="hidden" name="id" value="<%= book.getId() %>">
            <div class="form-group">
                <label for="name">图书名称:</label>
                <input type="text" id="name" name="name" value="<%= book.getName() %>" required>
            </div>
            <div class="form-group">
                <label for="price">价格:</label>
                <input type="number" id="price" name="price" step="0.01" min="0" value="<%= book.getPrice() %>" required>
            </div>
            <div class="form-group">
                <label for="author">作者:</label>
                <input type="text" id="author" name="author" value="<%= book.getAuthor() %>" required>
            </div>
            <div class="form-group">
                <label for="stock">库存:</label>
                <input type="number" id="stock" name="stock" min="0" value="<%= book.getBookCount() %>" required>
            </div>
            <button type="submit" class="btn">更新图书</button>
            <a href="<%= request.getContextPath() %>/servlet/bookList" class="btn" style="background-color: #008CBA;">取消</a>
            <a href="<%= request.getContextPath() %>/servlet/deleteBook?id=<%= book.getId() %>" class="btn btn-delete" onclick="return confirm('确定要删除这本书吗？')">删除图书</a>
        </form>
        <%
        } else {
        %>
            <div class="error">找不到图书信息！</div>
            <a href="<%= request.getContextPath() %>/servlet/bookList" class="back-link">返回图书列表</a>
        <%
        }
        %>
    </div>
</body>
</html>