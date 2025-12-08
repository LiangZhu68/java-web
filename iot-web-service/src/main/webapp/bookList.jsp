<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="beans.User" %>
<%@ page import="java.util.List" %>
<%@ page import="beans.Book" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书销售系统 - 图书列表</title>
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
            flex: 1;
            max-width: 400px;
        }

        .search-box input {
            padding: 12px 20px 12px 45px;
            border: 2px solid #e9ecef;
            border-radius: 25px;
            font-size: 14px;
            transition: all 0.3s ease;
            width: 100%;
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
            cursor: pointer;
            user-select: none;
            position: relative;
        }

        th:hover {
            background: linear-gradient(135deg, #3a62a8 0%, #2e4c82 100%);
        }

        th i.sort-icon {
            margin-left: 5px;
            font-size: 0.8em;
            opacity: 0.7;
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

        .price {
            font-weight: bold;
            color: #e74c3c;
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

            .search-box {
                max-width: 100%;
                margin-bottom: 10px;
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

            .table-container {
                font-size: 0.9rem;
            }

            th, td {
                padding: 10px 8px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-book"></i> 图书管理中心</h1>
            <p>管理图书信息，维护库存和价格</p>
        </div>

        <div class="controls">
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="搜索图书名称、作者...">
            </div>
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/index.jsp">
                    <i class="fas fa-home"></i> 首页
                </a>
                <a href="${pageContext.request.contextPath}/servlet/addBook" class="primary">
                    <i class="fas fa-plus"></i> 添加图书
                </a>
            </div>
        </div>

        <div class="content">
            <h2 class="section-title">图书列表</h2>

            <%
            List<Book> books = (List<Book>) request.getAttribute("bookList");
            if(books != null && !books.isEmpty()) {
            %>

            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th onclick="sortTable('id')">
                                ID
                                <i class="sort-icon fas fa-sort"></i>
                            </th>
                            <th onclick="sortTable('name')">
                                书名
                                <i class="sort-icon fas fa-sort"></i>
                            </th>
                            <th onclick="sortTable('author')">
                                作者
                                <i class="sort-icon fas fa-sort"></i>
                            </th>
                            <th onclick="sortTable('price')">
                                价格
                                <i class="sort-icon fas fa-sort"></i>
                            </th>
                            <th onclick="sortTable('stock')">
                                库存
                                <i class="sort-icon fas fa-sort"></i>
                            </th>
                            <th onclick="sortTable('sales')">
                                销量
                                <i class="sort-icon fas fa-sort"></i>
                            </th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        for(Book book : books) {
                    %>
                    <tr>
                        <td><strong>#<%= book.getId() %></strong></td>
                        <td><%= book.getName() %></td>
                        <td><%= book.getAuthor() %></td>
                        <td class="price">¥<%= book.getPrice() %></td>
                        <td><%= book.getBookCount() %></td>
                        <td><%= book.getSales() %></td>
                        <td>
                            <div class="action-buttons">
                                <a href="${pageContext.request.contextPath}/servlet/cart?action=addToCart&id=<%= book.getId() %>" class="btn btn-success">
                                    <i class="fas fa-cart-plus"></i> 添加购物车
                                </a>
                                <a href="${pageContext.request.contextPath}/servlet/updateBook?id=<%= book.getId() %>" class="btn btn-primary">
                                    <i class="fas fa-edit"></i> 编辑
                                </a>
                                <a href="${pageContext.request.contextPath}/servlet/deleteBook?id=<%= book.getId() %>" class="btn btn-danger" onclick="return confirm('确定要删除这本书吗？')">
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
                <i class="fas fa-book-open"></i>
                <h3>暂无图书数据</h3>
                <p>系统中还没有任何图书记录，点击上方"添加图书"按钮开始添加图书</p>
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
                    const bookCells = row.textContent.toLowerCase();
                    if(bookCells.includes(searchTerm)) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            });
        });
        
        // 排序功能
        function sortTable(sortBy) {
            const currentSortBy = '<%= request.getAttribute("sortBy") %>';
            const currentOrder = '<%= request.getAttribute("order") %>';
            
            let newOrder = 'ASC';
            if (currentSortBy === sortBy && currentOrder === 'ASC') {
                newOrder = 'DESC';
            }
            
            window.location.href = '?sortBy=' + sortBy + '&order=' + newOrder;
        }
        
        // 更新排序图标
        document.addEventListener('DOMContentLoaded', function() {
            const sortBy = '<%= request.getAttribute("sortBy") %>';
            const order = '<%= request.getAttribute("order") %>';
            
            if (sortBy) {
                const header = document.querySelector(`th[onclick*="sortTable('${sortBy}')"]`);
                if (header) {
                    const sortIcon = header.querySelector('.sort-icon');
                    if (sortIcon) {
                        sortIcon.className = 'sort-icon fas ' + (order === 'DESC' ? 'fa-sort-down' : 'fa-sort-up');
                    }
                }
            }
        });
    </script>
</body>
</html>