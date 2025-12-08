# IoT Web Service

这是一个基于Java的Web应用项目，提供图书销售和管理功能。

## 项目特性

- 图书管理：添加、编辑、删除、查看图书
- 用户管理：用户登录、注册、注销
- 购物车功能：添加商品到购物车
- 订单管理：处理用户订单
- 搜索和排序功能

## 系统要求

- Java 8 或更高版本
- MySQL 8.0 或 9.x
- Maven 3.6 或更高版本
- Apache Tomcat (内置)

## 安装步骤

1. **安装MySQL**
   - 下载并安装MySQL 8.0或9.x
   - 设置root用户的密码为 `040608`

2. **导入数据库**
   ```bash
   mysql -u root -p040608 --default-character-set=utf8mb4 < database.sql
   ```

3. **编译项目**
   ```bash
   mvn clean compile
   ```

## 运行项目

### 方法1: 使用Maven内置Tomcat
```bash
mvn tomcat7:run
```

### 方法2: 生成WAR包部署到外部Tomcat
```bash
mvn package
# 将生成的WAR文件部署到Tomcat webapps目录
```

访问 `http://localhost:8086` 开始使用系统

## 项目结构

- `src/main/java/` - Java源代码
- `src/main/resources/` - 配置文件
- `src/main/webapp/` - Web页面文件
- `src/main/webapp/WEB-INF/` - Web配置文件

## 数据库配置

数据库连接配置在 `src/main/resources/jdbc.properties`:
```
driverClassName=com.mysql.cj.jdbc.Driver
url=jdbc:mysql://localhost:3306/book?useSSL=false&serverTimezone=GMT%2B8&characterEncoding=utf8&allowPublicKeyRetrieval=true
username=root
password=040608
```

## 功能模块

1. **图书管理**
   - 添加/编辑/删除图书
   - 图书搜索和排序
   - 图书列表展示

2. **用户管理**
   - 用户登录/注册
   - 会话管理

3. **购物车系统**
   - 添加商品到购物车
   - 更新购物车数量
   - 结账功能

4. **订单管理**
   - 订单创建
   - 订单状态跟踪

## API接口

- `/servlet/bookList` - 图书列表页面
- `/servlet/userList` - 用户列表页面
- `/servlet/cart` - 购物车功能
- `/servlet/orderList` - 订单列表

## 技术栈

- Java Servlet/JSP
- MySQL数据库
- Maven构建工具
- Apache Tomcat服务器
- HTML/CSS/JavaScript
- JSTL标签库