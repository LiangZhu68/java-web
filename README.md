### 实验内容及要求：
使用MVC模式开发一个功能齐全的现代化Web电商平台，专为图书销售设计。系统实现了完整的电子商务功能，包括用户管理、图书管理、购物车和订单系统。

### 主要仪器名称及型号：
- PC
- IDEA

---

## 1. 实验目的和意义

本次实验的目的是让学生巩固如下知识与技能：
1. 掌握使用MVC（JSP+JavaBean+Servlet）模式开发一个WEB应用
2. 掌握在web应用中连接、访问MySql数据库（或SQL Server数据库）的方法
3. 理解和实践完整的电商系统功能架构
4. 掌握现代化Web界面设计与用户体验优化

## 2. 技术要求

要求学生掌握JSP连接、访问MySql数据库（或SQL Server数据库）的方法；熟练使用JDBC API连接、访问数据库的常用接口与DriverManager类；实现完整的CRUD操作；掌握会话管理和安全认证机制。

## 3. 项目结构

### 3.1 项目目录结构

```
java-web/
├── README.md                       # 项目说明文档
├── add_books.sql                   # 图书数据初始化SQL脚本
├── AddBooks.java                   # 图书数据初始化Java程序
├── cleanup_project.sh              # 项目清理脚本
├── 《物联网信息服务》任务书-实验2-WEB信息服务综合应用.docx
├── 《物联网信息服务》指导书-实验2-WEB信息服务综合应用.doc
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

### 3.2 技术架构

- **前端**: JSP + HTML5 + CSS3 + JavaScript + Font Awesome图标库
- **后端**: Java Servlet + JavaBean
- **数据库**: MySQL
- **构建工具**: Maven
- **服务器**: Tomcat
- **架构模式**: MVC (Model-View-Controller)

### 3.3 特色功能

#### 现代化界面设计
- 响应式设计，支持移动端访问
- 渐变色彩和阴影效果
- 图标丰富的用户界面
- 交互动画和悬停效果

#### 统计功能
- 实时数据统计
- 动态图表显示
- 数据可视化

#### 搜索功能
- 全局搜索功能
- 实时搜索过滤

## 4. 核心功能实现

### 4.1 实体类设计 (JavaBean)

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

### 4.2 数据访问层 (DAO)

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

### 4.3 控制层 (Servlet)

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

### 4.4 视图层 (JSP)

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

### 4.5 过滤器

**encodingFilter.java** - 字符编码过滤器
- 解决中文乱码问题
- 统一设置请求和响应的字符编码

## 5. 数据库设计

根据实验要求，创建了以下数据表：

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

## 6. 配置文件

**pom.xml** - Maven项目配置文件
- 配置了Servlet API, JSP API, JSTL, MySQL连接器等依赖
- 配置了Tomcat插件用于运行Web应用
- 设置了编译版本和打包插件

**jdbc.properties** - 数据库连接配置文件
- 配置数据库驱动、URL、用户名和密码

**web.xml** - Web应用部署描述符
- 配置了字符编码过滤器
- 配置了欢迎页面

## 7. 实验过程

### 7.1 项目搭建
1. 使用Maven创建Web项目骨架
2. 配置pom.xml添加所需依赖
3. 创建包结构（beans, dao, filter, servlet）
4. 配置Tomcat插件以支持mvn tomcat7:run命令

### 7.2 实体类实现
按照JavaBean规范创建了User、Book、Cart和Order实体类，实现了Serializable接口和克隆方法。

### 7.3 数据访问层实现
- 创建DataSourceUtil类管理数据库连接
- 实现UserDao、BookDao、CartDao、OrderDao类封装CRUD操作
- 使用配置文件管理数据库连接参数

### 7.4 控制层实现
- 创建各个功能模块对应的Servlet
- 实现请求处理和页面转发逻辑
- 使用注解配置URL映射

### 7.5 视图层实现
- 创建JSP页面实现用户界面
- 使用JSTL和EL表达式显示数据
- 实现页面间的导航功能

## 8. 实验数据记录或图片

- **项目成功编译**: 执行`mvn clean compile`成功，无编译错误
- **服务器成功启动**: 执行`mvn tomcat7:run`成功启动Tomcat服务器
- **页面访问测试**: curl测试显示服务器正常响应HTTP 200状态码
- **功能模块**:
  - 首页: http://localhost:8086/
  - 用户注册: http://localhost:8086/register.jsp
  - 用户登录: http://localhost:8086/login.jsp
  - 图书管理: http://localhost:8086/servlet/bookList
  - 用户管理: http://localhost:8086/servlet/userList
  - 购物车: http://localhost:8086/servlet/cart
  - 订单管理: http://localhost:8086/servlet/orderList

## 9. 实验结论

通过本次实验，我成功实现了以下目标：

1. **MVC架构实现**：采用JSP+JavaBean+Servlet模式构建Web应用，实现了模型、视图和控制器的分离，使代码结构清晰，职责分明。

2. **数据库连接**：通过JDBC API成功连接MySQL数据库，实现了数据的持久化存储和访问。使用配置文件管理数据库连接参数，提高了程序的可配置性。

3. **功能模块**：
   - 用户注册功能：用户可以输入注册信息，提交后存储在数据库中
   - 用户登录功能：用户使用注册的账号进行登录，系统判断输入的用户是否在数据库中存在
   - 用户管理功能：显示用户列表，并实现对用户信息的增删改查操作
   - 图书管理功能：显示图书列表，并实现图书的增删改查操作
   - 购物管理功能：对图书进行添加购物车，对购物车中的数据生成订单，实现订单的增删改查

4. **技术掌握**：
   - 熟练使用Maven进行项目构建和依赖管理
   - 掌握了Servlet开发技术
   - 理解了JSP页面开发和数据绑定
   - 学会了使用过滤器处理全局问题（如字符编码）
   - 掌握了数据库设计和操作

5. **开发流程**：通过本次实验，熟悉了完整Web应用的开发流程，从前端页面到后端逻辑，从数据库设计到部署运行。

## 10. 运行说明

要运行本项目，请按以下步骤操作：

1. 确保系统已安装JDK 8+、Maven和MySQL
2. 安装MySQL数据库，执行`database.sql`脚本创建数据库和表结构
3. 修改`src/main/resources/jdbc.properties`文件中的数据库连接信息（用户名、密码等）
4. 在项目根目录下执行命令：`mvn tomcat7:run`
5. 访问应用：`http://localhost:8086/`

### 10.1 数据初始化

项目提供了多种数据初始化方式：

**方式一：使用SQL脚本**
- 执行根目录下的`add_books.sql`脚本，该脚本将清空图书表并插入21本示例图书数据
- 示例图书包括：Java编程思想、设计模式、算法导论等技术类书籍

**方式二：使用Java程序**
- 运行根目录下的`AddBooks.java`程序，该程序将通过数据库连接直接插入20本示例图书数据
- 程序使用`DataSourceUtil`工具类管理数据库连接

### 10.2 项目维护

- 项目包含`cleanup_project.sh`脚本用于清理无用文件和构建目录
- 该脚本会自动删除日志文件、备份文件和target目录（Maven构建目录）
- 可通过执行`./cleanup_project.sh`来清理项目

### 10.3 依赖文档

项目还包含以下文档：
- 《物联网信息服务》任务书-实验2-WEB信息服务综合应用.docx
- 《物联网信息服务》指导书-实验2-WEB信息服务综合应用.doc
- 实验2 实验报告模板.doc

## 11. 系统优势

1. **架构清晰**: 采用标准MVC架构，代码结构清晰分离
2. **功能完整**: 包含电商系统的核心功能
3. **界面美观**: 现代化的UI设计，用户体验良好
4. **响应迅速**: 轻量级架构，加载速度快
5. **易于扩展**: 模块化设计，便于功能扩展
6. **安全可靠**: 实现了用户认证和会话管理机制
7. **数据完整**: 完善的数据库设计，保证数据一致性

## 12. 修复说明

**修复的主要问题：**
1. 修复了Tomcat插件配置，确保服务器能够正常启动
2. 修复了数据库连接管理，优化了连接的开启和关闭
3. 修复了字符编码问题，确保中文正常显示
4. 修复了会话管理机制，确保用户登录状态正确维持
5. 修复了购物车和订单生成功能，确保数据正确流转

**新增的改进：**
1. 采用更完善的数据模型设计（用户、图书、购物车、订单实体）
2. 实现了完整的CRUD操作（创建、读取、更新、删除）
3. 优化了用户界面，提供更好的用户体验
4. 增强了错误处理机制，提高系统稳定性
5. 改进了数据库连接池管理，提高性能
6. 提供了多种数据初始化方式（SQL脚本和Java程序）
7. 增加了项目维护脚本，便于项目清理和维护
8. 补充了详细的项目文档和说明

## 13. 项目成就

此项目成功实现了预期的所有功能，包括用户注册登录、图书管理、购物车功能和订单系统，并且具有现代化的用户界面和良好的用户体验。系统代码结构清晰，遵循良好的编程实践，是一个成功的Web应用开发实例。项目还提供了多种数据初始化方式和项目维护工具，使得系统更易于部署和维护。

## 14. 总结与反思

本次实验让我深入理解了MVC设计模式在Web开发中的应用，掌握了使用Java技术栈开发Web应用的基本方法。项目成功运行，达到了实验要求的目标。在开发过程中也遇到了一些挑战，如数据库连接配置、表结构设计、端口冲突等，通过查阅资料和调试逐步解决，提升了问题解决能力。

项目完整实现了以下功能：
- 用户注册/登录/注销功能
- 用户管理（增删改查）
- 图书管理（增删改查）
- 购物车功能
- 订单管理（增删改查）
- 数据库连接与操作

项目完全采用MVC架构，代码结构清晰，模块划分合理，达到了实验要求的各项指标。整个系统功能完整，运行稳定，用户界面友好，是MVC模式开发Web应用的优秀实践案例。
