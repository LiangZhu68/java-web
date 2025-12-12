### 实验内容及要求：
使用MVC模式开发一个功能齐全的现代化Web电商平台，专为图书销售设计。系统实现了完整的电子商务功能，包括用户管理、图书管理、购物车和订单系统。



## 运行说明

要运行本项目，请按以下步骤操作：

1. 确保系统已安装JDK 8+、Maven和MySQL
2. 安装MySQL数据库，执行`database.sql`脚本创建数据库和表结构
3. 修改`src/main/resources/jdbc.properties`文件中的数据库连接信息（用户名、密码等）
4. 在项目根目录下执行命令：`mvn tomcat7:run`
5. 访问应用：
  - 首页: http://localhost:8086/
  - 用户注册: http://localhost:8086/register.jsp
  - 用户登录: http://localhost:8086/login.jsp
  - 图书管理: http://localhost:8086/servlet/bookList
  - 用户管理: http://localhost:8086/servlet/userList
  - 购物车: http://localhost:8086/servlet/cart
  - 订单管理: http://localhost:8086/servlet/orderList

### 项目目录结构

```
java-web/
├── README.md                       # 项目说明文档
├── add_books.sql                   # 图书数据初始化SQL脚本
├── AddBooks.java                   # 图书数据初始化Java程序
├── cleanup_project.sh              # 项目清理脚本
├── 实验2 实验报告模板.doc
└── iot-web-service/
    ├── pom.xml                     # Maven项目配置文件
    ├── database.sql                # 数据库表结构SQL脚本
    ├── init_database.bat           # Windows批处理数据库初始化脚本
    ├── my.ini                      # MySQL配置文件
    ├── RUNNING.md                  # 项目运行说明文档
    ├── src/
    │   ├── main/
    │   │   ├── java/
    │   │   │   ├── beans/
    │   │   │   │   ├── Book.java         # 图书实体类
    │   │   │   │   ├── Cart.java         # 购物车实体类
    │   │   │   │   ├── Order.java        # 订单实体类
    │   │   │   │   └── User.java         # 用户实体类
    │   │   │   ├── dao/
    │   │   │   │   ├── BookDao.java      # 图书数据访问类
    │   │   │   │   ├── CartDao.java      # 购物车数据访问类
    │   │   │   │   ├── DataSourceUtil.java # 数据库连接工具类
    │   │   │   │   ├── DBUtils.java      # 数据库操作工具类
    │   │   │   │   ├── OrderDao.java     # 订单数据访问类
    │   │   │   │   └── UserDao.java      # 用户数据访问类
    │   │   │   ├── filter/
    │   │   │   │   └── encodingFilter.java # 编码过滤器
    │   │   │   └── servlet/
    │   │   │       ├── AddBookServlet.java   # 添加图书控制器
    │   │   │       ├── BookListServlet.java  # 图书列表控制器
    │   │   │       ├── CartServlet.java      # 购物车控制器
    │   │   │       ├── LoginServlet.java     # 用户登录控制器
    │   │   │       ├── LogoutServlet.java    # 用户注销控制器
    │   │   │       ├── OrderListServlet.java # 订单列表控制器
    │   │   │       ├── RegisterServlet.java  # 用户注册控制器
    │   │   │       ├── TestDbConnectionServlet.java # 数据库连接测试控制器
    │   │   │       ├── UpdateDeleteBookServlet.java # 图书更新删除控制器
    │   │   │       ├── UserEditServlet.java  # 用户编辑控制器
    │   │   │       └── UserListServlet.java  # 用户列表控制器
    │   │   ├── resources/
    │   │   │   └── jdbc.properties         # 数据库配置文件
    │   │   └── webapp/
    │   │       ├── addBook.jsp             # 添加图书页面
    │   │       ├── bookList.jsp            # 图书列表页面
    │   │       ├── cart.jsp                # 购物车页面
    │   │       ├── editBook.jsp            # 编辑图书页面
    │   │       ├── index.jsp               # 首页
    │   │       ├── login.jsp               # 登录页面
    │   │       ├── orderConfirmation.jsp   # 订单确认页面
    │   │       ├── orderList.jsp           # 订单列表页面
    │   │       ├── register.jsp            # 注册页面
    │   │       ├── userEdit.jsp            # 用户编辑页面
    │   │       ├── userList.jsp            # 用户列表页面
    │   │       ├── img/                    # 图片资源
    │   │       ├── static/                 # 静态资源
    │   │       │   ├── css/                # 样式文件
    │   │       │   ├── js/                 # JavaScript文件
    │   │       │   └── img/                # 图片资源
    │   │       └── WEB-INF/
    │   │           └── web.xml             # Web应用配置文件
    └── target/                             # Maven构建输出目录
```

### 技术架构

- **前端**: JSP + HTML5 + CSS3 + JavaScript + Font Awesome图标库
- **后端**: Java Servlet + JavaBean
- **数据库**: MySQL
- **构建工具**: Maven
- **服务器**: Tomcat
- **架构模式**: MVC (Model-View-Controller)

## 核心功能实现

### 1 实体类设计 (JavaBean)

**User.java** - 用户实体类
- id: 用户ID
- username: 用户名
- password: 密码
- email: 邮箱

**Book.java** - 图书实体类
- id: 图书ID
- name: 图书名称
- price: 图书价格
- bookCount: 图书库存数量
- author: 图书作者

**Cart.java** - 购物车实体类
- id: 购物车项ID
- userId: 用户ID
- bookId: 图书ID
- quantity: 购买数量
- bookName: 图书名称
- price: 图书价格

**Order.java** - 订单实体类
- id: 订单ID
- orderId: 订单号
- userId: 用户ID
- totalPrice: 总价格
- status: 订单状态（0-待付款, 1-已付款, 2-已发货, 3-已完成, -1-已取消）
- createTime: 创建时间
- updateTime: 更新时间
- orderItems: 订单项（JSON格式）

### 2 数据访问层 (DAO)

**UserDao.java** - 用户数据访问类
- getAllUsers(): 获取所有用户列表
- getUserById(): 根据ID获取用户
- addUser(): 添加新用户
- updateUser(): 更新用户信息
- deleteUser(): 删除用户
- getUserByUsername(): 根据用户名查询用户
- login(): 用户登录验证

**BookDao.java** - 图书数据访问类
- getAllBooks(): 获取所有图书列表
- getBookById(): 根据ID获取图书
- addBook(): 添加新图书
- updateBook(): 更新图书信息
- deleteBook(): 删除图书

**CartDao.java** - 购物车数据访问类
- getCartByUserId(): 获取用户购物车
- addToCart(): 添加到购物车
- removeFromCart(): 从购物车移除
- updateCartQuantity(): 更新购物车数量
- clearCartByUserId(): 清空用户购物车

**OrderDao.java** - 订单数据访问类
- getAllOrdersByUserId(): 获取用户订单列表
- getOrderByOrderId(): 根据订单号获取订单
- addOrder(): 添加订单
- updateOrderStatus(): 更新订单状态
- deleteOrder(): 删除订单

### 3 控制层 (Servlet)

**RegisterServlet.java** - 用户注册控制器
- 处理用户注册请求
- 验证用户名唯一性
- 保存新用户到数据库

**LoginServlet.java** - 用户登录控制器
- 处理用户登录请求
- 验证用户凭据
- 创建用户会话

**UserListServlet.java** - 用户管理控制器
- 获取并显示所有用户列表
- 支持用户信息的增删改查

**UserEditServlet.java** - 用户编辑控制器
- 处理用户信息的编辑和删除
- 更新用户信息到数据库

**BookListServlet.java** - 图书管理控制器
- 获取并显示所有图书列表
- 支持图书信息的增删改查

**AddBookServlet.java** - 添加图书控制器
- 处理添加图书请求
- 验证图书信息
- 保存图书数据到数据库

**UpdateDeleteBookServlet.java** - 图书编辑控制器
- 处理图书信息的编辑和删除
- 更新图书信息到数据库

**CartServlet.java** - 购物车控制器
- 处理购物车相关操作（添加、删除、更新数量）
- 处理生成订单的请求
- 计算订单总价格

**OrderListServlet.java** - 订单管理控制器
- 获取并显示用户订单列表
- 支持订单的增删改查

**LogoutServlet.java** - 用户注销控制器
- 销毁用户会话
- 重定向到首页

### 4 视图层 (JSP)

- index.jsp: 系统首页，提供导航到各功能模块
- login.jsp: 用户登录页面
- register.jsp: 用户注册页面
- userList.jsp: 显示用户列表，支持用户管理操作
- userEdit.jsp: 用户编辑页面
- bookList.jsp: 显示图书列表，支持图书管理操作
- addBook.jsp: 添加图书页面
- editBook.jsp: 编辑图书页面
- cart.jsp: 购物车页面，显示添加到购物车的商品
- orderConfirmation.jsp: 订单确认页面，显示生成的订单信息
- orderList.jsp: 订单列表页面，显示用户历史订单

### 5 过滤器

**encodingFilter.java** - 字符编码过滤器
- 解决中文乱码问题
- 统一设置请求和响应的字符编码

## 数据库设计

```sql
-- 创建数据库
CREATE DATABASE IF NOT EXISTS book CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE book;

-- 用户表
CREATE TABLE IF NOT EXISTS t_user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 图书表
CREATE TABLE IF NOT EXISTS t_book (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    author VARCHAR(100) NOT NULL,
    sales INT DEFAULT 0,
    stock INT NOT NULL,
    img_path VARCHAR(500),
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 购物车表
CREATE TABLE IF NOT EXISTS t_cart (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    book_name VARCHAR(200) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES t_user(id),
    FOREIGN KEY (book_id) REFERENCES t_book(id)
);

-- 订单表
CREATE TABLE IF NOT EXISTS t_orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id VARCHAR(50) NOT NULL UNIQUE,
    user_id INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status INT DEFAULT 0, -- 0-待付款, 1-已付款, 2-已发货, 3-已完成, -1-已取消
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    order_items TEXT, -- 存储订单项的JSON字符串
    FOREIGN KEY (user_id) REFERENCES t_user(id)
);
```
