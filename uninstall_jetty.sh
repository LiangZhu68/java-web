#!/bin/bash

echo "开始卸载Jetty..."

# 停止任何正在运行的Jetty进程
echo "停止正在运行的Jetty进程..."
pkill -f jetty 2>/dev/null || true

# 如果Jetty是通过包管理器安装的（如存在的话）
# 在Ubuntu/Debian系统上卸载Jetty
echo "卸载Jetty包（如果已安装）..."
sudo apt remove --purge -y jetty9 jetty* 2>/dev/null || echo "Jetty包未通过包管理器安装或已卸载"

# 清理可能的Jetty相关文件和目录
echo "清理Jetty相关文件..."
rm -rf ~/.m2/repository/org/eclipse/jetty/ 2>/dev/null || true
sudo rm -rf /etc/jetty* /var/lib/jetty* /usr/share/jetty* /usr/share/jetty*/ 2>/dev/null || true

# 清理Maven的Jetty依赖缓存
echo "清理Maven中的Jetty依赖..."
rm -rf ~/.m2/repository/org/eclipse/jetty/ 2>/dev/null || true

# 检查本地项目中的Jetty配置并移除
cd /mnt/c/Users/liangzhu/Documents/GitHub/java-web/iot-web-service

# 备份当前pom.xml
cp pom.xml pom.xml.pre-jetty-removal.backup

# 从pom.xml中移除Jetty插件配置
# 这里我们创建一个不包含Jetty插件的pom.xml版本
cat > pom.xml << 'EOF'
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.zwu.iot</groupId>
  <artifactId>iot-web-service</artifactId>
  <packaging>war</packaging>
  <version>1.0-SNAPSHOT</version>
  <name>iot-web-service Maven Webapp</name>
  <url>http://maven.apache.org</url>

  <properties>
    <maven.compiler.source>8</maven.compiler.source>
    <maven.compiler.target>8</maven.compiler.target>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  </properties>

  <dependencies>
    <!-- JUnit 依赖 -->
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.13.2</version>
      <scope>test</scope>
    </dependency>

    <!-- Servlet API 依赖 -->
    <dependency>
      <groupId>javax.servlet</groupId>
      <artifactId>javax.servlet-api</artifactId>
      <version>4.0.1</version>
      <scope>provided</scope>
    </dependency>

    <!-- JSP API 依赖 -->
    <dependency>
      <groupId>javax.servlet.jsp</groupId>
      <artifactId>jsp-api</artifactId>
      <version>2.2</version>
      <scope>provided</scope>
    </dependency>

    <!-- JSTL 依赖 -->
    <dependency>
      <groupId>javax.servlet</groupId>
      <artifactId>jstl</artifactId>
      <version>1.2</version>
    </dependency>

    <!-- MySQL 连接器依赖 -->
    <dependency>
      <groupId>mysql</groupId>
      <artifactId>mysql-connector-java</artifactId>
      <version>8.0.33</version>
    </dependency>
  </dependencies>

  <build>
    <finalName>iot-web-service</finalName>
    <plugins>
      <!-- 编译插件 -->
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-compiler-plugin</artifactId>
        <version>3.8.1</version>
        <configuration>
          <source>8</source>
          <target>8</target>
        </configuration>
      </plugin>

      <!-- WAR打包插件 -->
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-war-plugin</artifactId>
        <version>3.2.3</version>
        <configuration>
          <failOnMissingWebXml>false</failOnMissingWebXml>
        </configuration>
      </plugin>
    </plugins>
  </build>
</project>
EOF

echo "Jetty已完全卸载！"
echo ""
echo "pom.xml文件已更新，移除了Jetty插件配置。"
echo ""
echo "项目现在只包含编译和WAR打包插件。"
echo "如果需要部署，可以使用其他应用服务器（如Tomcat）。"