#!/bin/bash
# Tomcat部署脚本

echo "构建项目WAR包..."
cd /mnt/c/Users/liangzhu/Desktop/实验二/iot-web-service/
mvn clean package

if [ $? -eq 0 ]; then
    echo "构建成功！WAR包位于："
    ls -l target/iot-web-service.war
    
    echo ""
    echo "要部署到Tomcat，请执行以下命令："
    echo "1. sudo cp target/iot-web-service.war /var/lib/tomcat9/webapps/"
    echo "2. sudo systemctl start tomcat9"
    echo "3. 访问 http://localhost:8080/iot-web-service/"
else
    echo "构建失败，请检查项目配置。"
fi