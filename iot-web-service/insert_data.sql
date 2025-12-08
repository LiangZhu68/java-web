USE book;

-- 创建初始管理员用户
INSERT INTO t_user (username, password, email) VALUES ('admin', '040608', 'admin@example.com') ON DUPLICATE KEY UPDATE username=username;

-- 插入测试图书数据（使用ASCII字符以避免编码问题）
INSERT INTO t_book (name, price, author, stock, img_path) VALUES
('Java Programming Thoughts', 89.00, 'Bruce Eckel', 10, 'static/img/java.jpg'),
('Design Patterns', 65.00, 'Gang of Four', 15, 'static/img/design_pattern.jpg'),
('Introduction to Algorithms', 128.00, 'Thomas H.Cormen', 5, 'static/img/algorithms.jpg'),
('Java Core Technology', 99.00, 'Cay S. Horstmann', 20, 'static/img/java_core.jpg'),
('Spring in Action', 85.00, 'Craig Walls', 15, 'static/img/spring_in_action.jpg'),
('Understanding the JVM', 128.00, 'Zhou Zhiming', 10, 'static/img/jvm.jpg'),
('Advanced JavaScript Programming', 149.00, 'Nicholas C. Zakas', 12, 'static/img/js_advanced.jpg'),
('Python Programming from入门to Practice', 79.00, 'Eric Matthes', 30, 'static/img/python_practice.jpg'),
('Head First Design Patterns', 128.00, 'Eric Freeman', 18, 'static/img/head_first_dp.jpg'),
('Data Structures and Algorithm Analysis', 78.00, 'Mark Allen Weiss', 15, 'static/img/data_structure.jpg'),
('Effective Java', 89.00, 'Joshua Bloch', 20, 'static/img/effective_java.jpg'),
('Computer Networks', 108.00, 'Xie Xiren', 25, 'static/img/network.jpg'),
('Operating System Concepts', 139.00, 'Abraham Silberschatz', 12, 'static/img/os.jpg'),
('Principles of Compiler Design', 119.00, 'Alfred V. Aho', 8, 'static/img/compilation.jpg'),
('Redis Design and Implementation', 79.00, 'Huang Jianhong', 22, 'static/img/redis.jpg'),
('MySQL Must-Know', 59.00, 'Ben Forta', 30, 'static/img/mysql.jpg'),
('Vue.js Practice', 78.00, 'Liang Hao', 18, 'static/img/vue.jpg'),
('React Advanced Road', 89.00, 'Xu Chao', 15, 'static/img/react.jpg'),
('Node.js Development Guide', 65.00, 'Guo Jiabao', 20, 'static/img/nodejs.jpg'),
('Deep Understanding Node.js', 95.00, 'Pu Ling', 12, 'static/img/node_deep.jpg'),
('High Performance MySQL', 128.00, 'Baron Schwartz', 10, 'static/img/high_performance_mysql.jpg');