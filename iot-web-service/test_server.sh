# 检查服务器是否运行
sleep 5  # 等待服务器启动

# 尝试访问服务器
curl -s -o /dev/null -w "%{http_code}" http://localhost:9090/iot-web-service/