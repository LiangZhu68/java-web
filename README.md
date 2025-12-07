# 图书销售系统

这是一个基于MVC模式开发的Web应用，支持图书管理、用户管理和购物功能。

## 项目结构

- beans/ - JavaBean实体类
- dao/ - 数据访问层
- filter/ - 过滤器
- servlet/ - Servlet控制器
- webapp/ - 视图层（JSP页面）

## 功能模块

1. 用户注册/登录
2. 图书管理（增删改查）
3. 用户管理（增删改查）
4. 购物车功能
5. 订单管理（增删改查）

## 运行说明

1. 确保已安装JDK 8+ 和 Maven
2. 安装MySQL数据库，创建名为`book`的数据库，并执行SQL脚本创建表
3. 修改`src/main/resources/jdbc.properties`中的数据库连接信息
4. 在项目根目录执行：`mvn jetty:run`
5. 访问应用：`http://localhost:9090/iot-web-service/`

## 使用说明

### 公共功能（无需登录）：
- 查看图书列表：`/servlet/bookList`
- 查看用户列表：`/servlet/userList`

### 需要登录的功能：
- 购物车管理：`/servlet/cart`
- 订单管理：`/servlet/orderList`
- 添加图书到购物车

### 管理功能（可访问，但请注意安全）：
- 添加图书：`/servlet/addBook`
- 编辑/删除图书：通过图书列表页面操作
- 管理用户：`/servlet/userList`，可以编辑或删除用户

**注意**：为使数据库功能正常工作，需要：
- 在本地启动MySQL服务器
- 创建所需的数据库和表
- 确保数据库配置信息正确

## 技术栈

- Java Servlet
- JSP
- MySQL
- Maven
- Jetty

## 数据库表结构

- t_user: 用户信息表
- t_book: 图书信息表
- t_cart: 购物车表
- t_orders: 订单信息表