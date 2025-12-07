#!/bin/bash

echo "开始卸载和重装服务器..."

# 停止所有可能的Tomcat和Jetty进程
echo "停止Tomcat和Jetty进程..."
sudo pkill -f tomcat || true
sudo pkill -f jetty || true

# 卸载Tomcat
echo "卸载Tomcat..."
sudo apt remove --purge -y tomcat10* 2>/dev/null || {
    echo "尝试另一种方式卸载Tomcat..."
    sudo apt remove --purge -y tomcat* 2>/dev/null || true
}

# 清理依赖
echo "清理系统依赖..."
sudo apt autoremove -y
sudo apt autoclean

# 删除可能的配置文件
echo "删除Tomcat配置文件..."
sudo rm -rf /etc/tomcat* /var/lib/tomcat* /usr/share/tomcat* /usr/share/tomcat* /etc/default/tomcat*

# 重新安装Tomcat
echo "重新安装Tomcat10..."
sudo apt update
sudo apt install -y tomcat10

# 启动Tomcat服务
echo "启动Tomcat服务..."
sudo systemctl enable tomcat10
sudo systemctl start tomcat10

# 检查状态
echo "检查Tomcat服务状态..."
sudo systemctl status tomcat10 --no-pager -l

echo "服务器卸载和重装完成！"