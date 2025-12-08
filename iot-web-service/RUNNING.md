# IoT Web Service Running Instructions

## Quick Start

### 1. Environment Requirements
- Ensure MySQL service is running (username: root, password: 040608)
- Ensure Java 8+ is installed and configured in PATH
- Ensure Maven is installed and configured in PATH

### 2. Database Initialization
If the database is not initialized, run:
```
init_database.bat
```

### 3. Start Service
Double click to run:
```
start_server.bat
```

### 4. Access Application
Open browser and visit:
```
http://localhost:8086
```

## Server Management

### Starting Server
- Double click `start_server.bat` - Standard start, shows server console, automatically opens browser
- Double click `start_server_background.bat` - Background start, doesn't block current window, automatically opens browser
- Or run `mvn tomcat7:run` directly

### Stopping Server
- Press Ctrl+C in server console, or run `stop_server.bat`
- stop_server.bat stops Java processes running in current project directory

## Important Files

- `database.sql` - Database structure and initial data
- `my.ini` - MySQL configuration file
- `pom.xml` - Maven project configuration
- `start_server.bat` - Start server script
- `start_server_background.bat` - Start server in background script
- `stop_server.bat` - Stop server script
- `init_database.bat` - Initialize database script
- `src/` - Project source code
  - `src/main/java` - Java source code
  - `src/main/webapp` - Web page files
  - `src/main/resources` - Configuration files

## Common Issues

### 1. Port is occupied
If port 8086 is occupied, modify the port configuration in pom.xml.

### 2. Database connection failed
Check the database connection configuration in jdbc.properties file.

### 3. Cannot start
Ensure MySQL service is running and the database name is `book`.