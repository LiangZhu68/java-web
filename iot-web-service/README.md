# IoT Web Service

这是一个基于Java的物联网Web服务项目。

## Windows环境配置说明

### MySQL数据库配置

由于Linux和Windows系统在MySQL配置上的差异，Windows用户需要特别注意以下步骤：

#### 1. MySQL卸载（如果已安装旧版本）
运行项目目录下的 `uninstall_mysql.bat` 脚本进行清理，或手动：
- 通过控制面板卸载所有MySQL相关程序
- 删除MySQL服务：`sc delete mysql`
- 删除MySQL安装目录
- 重启计算机

#### 2. MySQL重新安装
- 从 https://dev.mysql.com/downloads/mysql/ 下载MySQL Community Server
- 安装时设置root密码为：`040608`
- 将MySQL配置为Windows服务并设为自动启动

#### 3. 数据库初始化
安装完成后，运行项目目录下的 `init_database.bat` 脚本，或手动执行：
```
mysql -u root -p040608 < "database.sql"
```

#### 4. 数据库连接配置
项目已配置为使用适合Windows环境的连接参数：
- URL: `jdbc:mysql://localhost:3306/book?useSSL=false&serverTimezone=GMT%2B8&characterEncoding=utf8&allowPublicKeyRetrieval=true`
- 用户名: `root`
- 密码: `040608`

#### 5. 连接测试
可以运行 `test_connection.bat` 脚本来验证数据库连接。

### 项目构建和运行
```
mvn clean compile
mvn tomcat7:run
```

项目将在 http://localhost:8086 上运行。