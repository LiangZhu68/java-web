# MariaDB修复解决方案

由于系统权限限制，需要您提供sudo密码以修复MariaDB连接问题。

## 方法1：重置MariaDB root密码（推荐）

打开终端并执行以下命令：

```bash
# 1. 使用sudo权限停止MariaDB服务
sudo systemctl stop mariadb

# 2. 以跳过权限验证模式启动MariaDB
sudo mysqld_safe --skip-grant-tables --skip-networking &

# 3. 等待启动完成
sleep 5

# 4. 连接到MariaDB并重置root密码
sudo mysql -u root mysql << EOF
UPDATE user SET authentication_string=PASSWORD('040608') WHERE User='root' AND Host='localhost';
FLUSH PRIVILEGES;
EXIT;
EOF

# 5. 停止安全模式并重启服务
sudo pkill mysqld
sudo systemctl start mariadb

# 6. 验证新密码
mysql -u root -p040608 -e "SHOW DATABASES;"
```

## 方法2：创建专用数据库用户（如果您不希望修改root密码）

```bash
# 1. 启动MariaDB（如果已停止）
sudo systemctl start mariadb

# 2. 以root身份连接并创建新用户
sudo mysql -u root << EOF
CREATE USER 'iot_user'@'localhost' IDENTIFIED BY '040608';
GRANT ALL PRIVILEGES ON *.* TO 'iot_user'@'localhost';
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS book CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
EXIT;
EOF
```

然后修改 /mnt/c/Users/liangzhu/Desktop/实验二/iot-web-service/src/main/resources/jdbc.properties 文件：

```
driverClassName=com.mysql.cj.jdbc.Driver
url=jdbc:mysql://localhost:3306/book?useSSL=false&serverTimezone=UTC&characterEncoding=utf8
username=iot_user
password=040608
```

## 应用已完成的更改

取消订单功能的代码已完整实现，同时以下配置已更新：
- DataInitializer.java: 管理员密码已更新为'040608'
- database.sql: 管理员密码已更新为'040608'
- jdbc.properties: 密码已设置为'040608'

## 启动应用程序

数据库修复后，运行：
```bash
cd /mnt/c/Users/liangzhu/Desktop/实验二/iot-web-service/
mvn clean compile
mvn jetty:run
```

## 测试功能

- 访问：http://localhost:9090/iot-web-service/
- 登录：用户名 'admin'，密码 '040608'
- 测试取消订单功能

注意：取消订单功能的代码实现已经完整，修复数据库连接后即可正常使用。