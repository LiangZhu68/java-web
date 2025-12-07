#!/bin/bash

echo "开始删除无用文件..."

# 进入项目目录
cd /mnt/c/Users/liangzhu/Documents/GitHub/java-web/iot-web-service

# 删除备份文件
echo "删除备份文件..."
rm -f pom.xml.backup.*

# 删除日志文件
echo "删除日志文件..."
rm -f *.log
rm -f server_*.txt
rm -f server_*.log

# 删除测试脚本（如果不需要）
echo "删除测试脚本..."
rm -f test_server.sh

# 清理target目录（Maven构建目录）
echo "清理target目录..."
rm -rf target/

echo "无用文件清理完成！"

# 显示清理后的项目结构
echo ""
echo "清理后的项目结构："
ls -la