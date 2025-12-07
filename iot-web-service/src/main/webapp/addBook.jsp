<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书销售系统 - 添加图书</title>
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
        }
        .btn:hover {
            background-color: #45a049;
        }
        .error {
            color: red;
            margin-bottom: 10px;
        }
        .back-link {
            margin-top: 15px;
        }
        .back-link a {
            color: #008CBA;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>添加图书</h2>
        
        <% 
        String errorMsg = (String) request.getAttribute("errorMsg");
        if(errorMsg != null) {
        %>
            <div class="error"><%= errorMsg %></div>
        <%
        }
        %>
        
        <form action="<%= request.getContextPath() %>/servlet/addBook" method="post">
            <div class="form-group">
                <label for="name">图书名称:</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="price">价格:</label>
                <input type="number" id="price" name="price" step="0.01" min="0" required>
            </div>
            <div class="form-group">
                <label for="author">作者:</label>
                <input type="text" id="author" name="author" required>
            </div>
            <div class="form-group">
                <label for="stock">库存:</label>
                <input type="number" id="stock" name="stock" min="0" required>
            </div>
            <button type="submit" class="btn">添加图书</button>
        </form>
        
        <div class="back-link">
            <a href="../servlet/bookList">← 返回图书列表</a>
        </div>
    </div>
</body>
</html>