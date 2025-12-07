# Tomcat部署指南

## 部署步骤

1. **安装Tomcat**（如果尚未安装）：
   ```bash
   sudo apt update
   sudo apt install tomcat9 tomcat9-admin
   ```

2. **构建WAR包**：
   ```bash
   cd /mnt/c/Users/liangzhu/Desktop/实验二/iot-web-service/
   mvn clean package
   ```

3. **部署WAR包到Tomcat**：
   ```bash
   # 方法1：复制WAR文件到webapps目录
   sudo cp /mnt/c/Users/liangzhu/Desktop/实验二/iot-web-service/target/iot-web-service.war /var/lib/tomcat9/webapps/
   
   # 方法2：使用Tomcat Manager（需要先配置管理员用户）
   sudo systemctl start tomcat9
   ```

4. **配置Tomcat管理员用户**（可选，用于Manager页面）：
   ```bash
   sudo nano /etc/tomcat9/tomcat-users.xml
   ```
   在 `<tomcat-users>` 标签内添加：
   ```xml
   <role rolename="manager-gui"/>
   <role rolename="admin-gui"/>
   <user username="admin" password="040608" roles="manager-gui,admin-gui"/>
   ```

5. **启动Tomcat服务**：
   ```bash
   sudo systemctl enable tomcat9
   sudo systemctl start tomcat9
   ```

## 数据库配置

确保系统中安装并运行了MariaDB/MySQL：

```bash
# 安装MariaDB（如果尚未安装）
sudo apt update
sudo apt install mariadb-server

# 启动MariaDB服务
sudo systemctl start mariadb
sudo systemctl enable mariadb

# 安全配置
sudo mysql_secure_installation
```

然后使用以下命令设置数据库：
```bash
# 设置root密码为040608
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '040608'; FLUSH PRIVILEGES;"

# 创建book数据库和表
mysql -u root -p040608 -e "CREATE DATABASE IF NOT EXISTS book CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

# 导入表结构
mysql -u root -p040608 book < /mnt/c/Users/liangzhu/Desktop/实验二/iot-web-service/database.sql
```

## 访问应用程序

部署完成后，可以通过以下URL访问：
- http://localhost:8080/iot-web-service/
- 或 http://localhost:8080/iot-web-service-1.0-SNAPSHOT/ （如果上下文名称不同）

## 取消订单功能

取消订单功能的代码实现已经完整：
- 前端：orderList.jsp 中的取消订单链接
- 后端：OrderListServlet.java 中的 cancelOrder() 方法
- 数据库：OrderDao.java 中的 updateOrderStatus() 方法

## 故障排除

如果遇到数据库连接问题：
1. 检查MariaDB服务是否运行：`sudo systemctl status mariadb`
2. 确认数据库密码配置：检查 jdbc.properties 文件
3. 检查数据库表是否已创建：`mysql -u root -p040608 -e "USE book; SHOW TABLES;"`

## 停止服务

需要停止服务时：
```bash
sudo systemctl stop tomcat9
sudo systemctl stop mariadb  # 如果需要
```