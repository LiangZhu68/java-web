<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beans.Book" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书销售系统 - 编辑图书</title>
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
            max-width: 600px;
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

        .form-container {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #495057;
            font-weight: 500;
            font-size: 1.1rem;
        }

        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
            box-sizing: border-box;
        }

        .form-group input:focus {
            outline: none;
            border-color: #2a5298;
            box-shadow: 0 0 0 3px rgba(42, 82, 152, 0.1);
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 30px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 12px 24px;
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

        .btn-secondary {
            background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
            color: white;
        }

        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(108, 117, 125, 0.4);
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

        .form-title {
            text-align: center;
            margin-bottom: 25px;
            color: #212529;
            font-size: 1.5rem;
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

            .action-buttons {
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
            <h1><i class="fas fa-book"></i> 图书管理中心</h1>
            <p>编辑图书信息，更新库存和价格</p>
        </div>

        <div class="controls">
            <div class="nav-links">
                <a href="<%= request.getContextPath() %>/index.jsp">
                    <i class="fas fa-home"></i> 首页
                </a>
                <a href="<%= request.getContextPath() %>/servlet/bookList" class="primary">
                    <i class="fas fa-th-list"></i> 图书列表
                </a>
            </div>
        </div>

        <div class="content">
            <h2 class="section-title">编辑图书</h2>

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

            <div class="form-container">
                <h3 class="form-title">图书信息</h3>
                <form action="<%= request.getContextPath() %>/servlet/updateBook" method="post">
                    <input type="hidden" name="id" value="<%= book.getId() %>">
                    <div class="form-group">
                        <label for="name"><i class="fas fa-book"></i> 图书名称:</label>
                        <input type="text" id="name" name="name" value="<%= book.getName() %>" required>
                    </div>
                    <div class="form-group">
                        <label for="price"><i class="fas fa-tag"></i> 价格:</label>
                        <input type="number" id="price" name="price" step="0.01" min="0" value="<%= book.getPrice() %>" required>
                    </div>
                    <div class="form-group">
                        <label for="author"><i class="fas fa-user"></i> 作者:</label>
                        <input type="text" id="author" name="author" value="<%= book.getAuthor() %>" required>
                    </div>
                    <div class="form-group">
                        <label for="stock"><i class="fas fa-boxes"></i> 库存:</label>
                        <input type="number" id="stock" name="stock" min="0" value="<%= book.getBookCount() %>" required>
                    </div>
                    <div class="action-buttons">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> 更新图书
                        </button>
                        <a href="<%= request.getContextPath() %>/servlet/bookList" class="btn btn-secondary">
                            <i class="fas fa-times"></i> 取消
                        </a>
                        <a href="<%= request.getContextPath() %>/servlet/deleteBook?id=<%= book.getId() %>" class="btn btn-danger" onclick="return confirm('确定要删除这本书吗？')">
                            <i class="fas fa-trash"></i> 删除图书
                        </a>
                    </div>
                </form>
            </div>

            <%
            } else {
            %>

            <div class="empty-state">
                <i class="fas fa-exclamation-triangle"></i>
                <h3>找不到图书信息</h3>
                <p>系统中未找到指定的图书，无法进行编辑操作</p>
                <a href="<%= request.getContextPath() %>/servlet/bookList" class="btn btn-primary" style="margin-top: 20px; display: inline-block;">
                    <i class="fas fa-arrow-left"></i> 返回图书列表
                </a>
            </div>

            <%
            }
            %>
        </div>
    </div>
</body>
</html>