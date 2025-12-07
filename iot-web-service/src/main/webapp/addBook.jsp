<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="beans.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书销售系统 - 添加图书</title>
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
            max-width: 800px;
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
            padding: 40px;
        }

        .form-container {
            max-width: 600px;
            margin: 0 auto;
            background: #f8f9fa;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        }

        .form-title {
            text-align: center;
            color: #2a5298;
            margin-bottom: 30px;
            font-size: 2rem;
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

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 1rem;
            font-family: inherit;
            transition: all 0.3s ease;
            box-sizing: border-box;
        }

        .form-control:focus {
            outline: none;
            border-color: #2a5298;
            box-shadow: 0 0 0 3px rgba(42, 82, 152, 0.1);
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 12px 25px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            text-decoration: none;
            font-size: 1rem;
            font-weight: 500;
            transition: all 0.3s ease;
            gap: 8px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #2a5298 0%, #1e3c72 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(42, 82, 152, 0.4);
        }

        .btn-block {
            display: block;
            width: 100%;
            text-align: center;
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

        .back-link {
            text-align: center;
            margin-top: 20px;
        }

        .back-link a {
            color: #495057;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .back-link a:hover {
            color: #2a5298;
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

            .content {
                padding: 20px;
            }

            .form-container {
                padding: 20px;
            }
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
            <h1><i class="fas fa-plus-circle"></i> 添加图书</h1>
            <p>为图书管理系统添加新的图书记录</p>
        </div>

        <div class="controls">
            <div class="nav-links">
                <a href="<%= request.getContextPath() %>/index.jsp">
                    <i class="fas fa-home"></i> 返回首页
                </a>
                <a href="<%= request.getContextPath() %>/servlet/bookList">
                    <i class="fas fa-book"></i> 图书列表
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

            <div class="form-container">
                <h2 class="form-title">图书信息</h2>

                <form action="<%= request.getContextPath() %>/servlet/addBook" method="post">
                    <div class="form-group">
                        <label for="name">图书名称 <i class="fas fa-book"></i></label>
                        <input type="text" id="name" name="name" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label for="price">价格 <i class="fas fa-yen-sign"></i></label>
                        <input type="number" id="price" name="price" class="form-control" step="0.01" min="0" required>
                    </div>

                    <div class="form-group">
                        <label for="author">作者 <i class="fas fa-user"></i></label>
                        <input type="text" id="author" name="author" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label for="stock">库存 <i class="fas fa-boxes"></i></label>
                        <input type="number" id="stock" name="stock" class="form-control" min="0" required>
                    </div>

                    <button type="submit" class="btn btn-primary btn-block">
                        <i class="fas fa-plus"></i> 添加图书
                    </button>
                </form>

                <div class="back-link">
                    <a href="<%= request.getContextPath() %>/servlet/bookList"><i class="fas fa-arrow-left"></i> 返回图书列表</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>