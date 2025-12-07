#!/bin/bash

# MariaDB配置修复脚本
# 请使用以下命令运行此脚本：
# sudo -s
# chmod +x /mnt/c/Users/liangzhu/Desktop/实验二/mariadb_setup.sh
# ./mnt/c/Users/liangzhu/Desktop/实验二/mariadb_setup.sh

echo "MariaDB配置修复脚本"
echo "=================="

# 检查MariaDB是否已安装
if ! command -v mysql &> /dev/null
then
    echo "错误: 未找到MariaDB/MySQL。请先安装MariaDB。"
    exit 1
fi

echo "MariaDB已安装，继续配置..."

# 尝试使用安全模式重置密码
echo "停止MariaDB服务..."
systemctl stop mariadb

echo "以安全模式启动MariaDB（跳过权限验证）..."
mysqld_safe --skip-grant-tables --skip-networking &

# 等待一段时间让MariaDB启动
sleep 5

echo "重置root密码为040608..."
mysql -u root mysql << EOF
UPDATE user SET authentication_string=PASSWORD('040608') WHERE User='root' AND Host='localhost';
FLUSH PRIVILEGES;
EXIT;
EOF

echo "密码重置完成。"

# 重启MariaDB服务
echo "停止安全模式..."
pkill mysqld

echo "启动MariaDB服务..."
systemctl start mariadb

echo "验证密码是否生效..."
mysql -u root -p040608 -e "SHOW DATABASES;"

if [ $? -eq 0 ]; then
    echo "成功！MariaDB root密码已设置为040608。"
    
    # 创建book数据库（如果不存在）
    echo "创建book数据库..."
    mysql -u root -p040608 -e "CREATE DATABASE IF NOT EXISTS book CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    
    # 导入数据库结构
    echo "导入数据库结构..."
    mysql -u root -p040608 book < /mnt/c/Users/liangzhu/Desktop/实验二/iot-web-service/database.sql
    
    echo "数据库配置完成！"
    echo "现在您可以启动应用程序："
    echo "cd /mnt/c/Users/liangzhu/Desktop/实验二/iot-web-service/"
    echo "mvn jetty:run"
else
    echo "错误：密码验证失败。"
fi