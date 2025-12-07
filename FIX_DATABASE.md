# 数据库连接问题解决方案

## 问题描述
当前应用程序无法连接到MariaDB数据库，导致无法添加图书、注册用户等功能无法使用，尽管服务器本身可以启动。

错误信息：
```
Access denied for user 'root'@'localhost' (using password: YES)
```

## 解决方案

### 方案一：重置MariaDB root密码（推荐）

1. **使用sudo权限执行安全安装脚本**：
```bash
sudo mysql_secure_installation
```
按提示设置root密码为 `040608`

2. **如果上述方法不行，手动重置密码**：
```bash
# 停止MariaDB服务
sudo systemctl stop mariadb

# 以跳过权限验证的方式启动
sudo mysqld_safe --skip-grant-tables --skip-networking &

# 连接到数据库
mysql -u root

# 在MySQL命令行中执行
USE mysql;
UPDATE user SET authentication_string=PASSWORD('040608') WHERE User='root' AND Host='localhost';
FLUSH PRIVILEGES;

# 退出MySQL
EXIT;

# 停止安全模式的MariaDB进程并重启服务
sudo pkill mysqld
sudo systemctl start mariadb
```

### 方案二：检查数据库是否存在

如果密码正确但仍连接失败，请手动创建数据库：

```bash
# 使用正确的密码登录
mysql -u root -p040608

# 在MySQL命令行中执行
CREATE DATABASE IF NOT EXISTS book CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE book;

# 创建必要的表（使用项目中的database.sql中的CREATE TABLE语句）
```

### 方案三：验证数据库连接

测试数据库连接是否正常：

```bash
mysql -u root -p040608 -e "SHOW DATABASES;"
```

## 项目状态

**取消订单功能已经完整实现**，代码位于：
- 前端：`orderList.jsp` 中的取消订单链接
- 后端：`OrderListServlet.java` 中的 `cancelOrder()` 方法
- 数据库：`OrderDao.java` 中的 `updateOrderStatus()` 方法

一旦数据库连接问题解决，取消订单功能将可以正常使用。

## 验证步骤

1. 按上述方案解决数据库连接问题
2. 重启应用程序：`cd /mnt/c/Users/liangzhu/Desktop/实验二/iot-web-service/ && mvn jetty:run`
3. 访问 http://localhost:9090/iot-web-service/
4. 注册新用户或登录
5. 添加图书到购物车并创建订单
6. 在订单列表页面尝试取消一个"待付款"状态的订单