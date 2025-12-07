<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="beans.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书销售系统 - 用户列表</title>
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
            padding: 30px;
            text-align: center;
        }

        .header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            font-weight: 300;
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
            border-color: #2a5298;
            box-shadow: 0 0 0 3px rgba(42, 82, 152, 0.1);
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

        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            text-align: center;
            border-left: 4px solid #2a5298;
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
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

        .action-buttons {
            display: flex;
            gap: 10px;
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

        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #e9ecef;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #6c757d;
            font-weight: bold;
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
            background: linear-gradient(135deg, #2a5298 0%, #1e3c72 100%);
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
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-users"></i> 用户管理中心</h1>
            <p>管理用户信息，维护账户安全</p>
        </div>

        <div class="controls">
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="搜索用户名、邮箱...">
            </div>
            <div class="nav-links">
                <a href="<%= request.getContextPath() %>/index.jsp">
                    <i class="fas fa-home"></i> 首页
                </a>
                <a href="<%= request.getContextPath() %>/servlet/register" class="primary">
                    <i class="fas fa-plus"></i> 添加用户
                </a>
            </div>
        </div>

        <div class="content">
            <h2 class="section-title">用户列表</h2>

            <%
            List<User> users = (List<User>) request.getAttribute("userList");
            if(users != null) {
            %>


            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>头像</th>
                            <th>ID</th>
                            <th>用户名</th>
                            <th>邮箱</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        for(User user : users) {
                    %>
                    <tr>
                        <td>
                            <div class="avatar">
                                <%= user.getUsername().substring(0, 1).toUpperCase() %>
                            </div>
                        </td>
                        <td><strong>#<%= user.getId() %></strong></td>
                        <td><%= user.getUsername() %></td>
                        <td><%= user.getEmail() %></td>
                        <td>
                            <div class="action-buttons">
                                <a href="<%= request.getContextPath() %>/servlet/userEdit?action=edit&id=<%= user.getId() %>" class="btn btn-primary">
                                    <i class="fas fa-edit"></i> 编辑
                                </a>
                                <a href="<%= request.getContextPath() %>/servlet/userEdit?action=delete&id=<%= user.getId() %>" class="btn btn-danger" onclick="return confirm('确定要删除这个用户吗？')">
                                    <i class="fas fa-trash"></i> 删除
                                </a>
                            </div>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>

            <% } else { %>

            <div class="empty-state">
                <i class="fas fa-user-friends"></i>
                <h3>暂无用户数据</h3>
                <p>系统中还没有任何用户记录，点击上方"添加用户"按钮开始添加用户</p>
            </div>

            <% } %>
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
                    const userCells = row.textContent.toLowerCase();
                    if(userCells.includes(searchTerm)) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            });
        });
    </script>
</body>
</html>