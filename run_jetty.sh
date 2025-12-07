#!/bin/bash

# 确保在项目目录中
cd /mnt/c/Users/liangzhu/Documents/GitHub/java-web/iot-web-service

echo "使用Jetty运行项目..."

# 使用随机端口运行Jetty（pom.xml中已经配置了端口为0）
mvn jetty:run -Djetty.http.port=0