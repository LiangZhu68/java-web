USE book;

-- 清空现有数据
DELETE FROM t_book;

-- 重新插入包含中文的测试图书数据
INSERT INTO t_book (name, price, author, stock, img_path) VALUES
('Java编程思想', 89.00, 'Bruce Eckel', 10, 'static/img/java.jpg'),
('设计模式', 65.00, 'Gang of Four', 15, 'static/img/design_pattern.jpg'),
('算法导论', 128.00, 'Thomas H.Cormen', 5, 'static/img/algorithms.jpg'),
('Java核心技术', 99.00, 'Cay S. Horstmann', 20, 'static/img/java_core.jpg'),
('Spring实战', 85.00, 'Craig Walls', 15, 'static/img/spring_in_action.jpg'),
('深入理解Java虚拟机', 128.00, '周志明', 10, 'static/img/jvm.jpg'),
('JavaScript高级程序设计', 149.00, 'Nicholas C. Zakas', 12, 'static/img/js_advanced.jpg'),
('Python编程：从入门到实践', 79.00, 'Eric Matthes', 30, 'static/img/python_practice.jpg'),
('Head First设计模式', 128.00, 'Eric Freeman', 18, 'static/img/head_first_dp.jpg'),
('数据结构与算法分析', 78.00, 'Mark Allen Weiss', 15, 'static/img/data_structure.jpg'),
('Effective Java', 89.00, 'Joshua Bloch', 20, 'static/img/effective_java.jpg'),
('计算机网络', 108.00, '谢希仁', 25, 'static/img/network.jpg'),
('操作系统概念', 139.00, 'Abraham Silberschatz', 12, 'static/img/os.jpg'),
('编译原理', 119.00, 'Alfred V. Aho', 8, 'static/img/compilation.jpg'),
('Redis设计与实现', 79.00, '黄健宏', 22, 'static/img/redis.jpg'),
('MySQL必知必会', 59.00, 'Ben Forta', 30, 'static/img/mysql.jpg'),
('Vue.js实战', 78.00, '梁灏', 18, 'static/img/vue.jpg'),
('React进阶之路', 89.00, '徐超', 15, 'static/img/react.jpg'),
('Node.js开发指南', 65.00, '郭家寶', 20, 'static/img/nodejs.jpg'),
('深入浅出Node.js', 95.00, '朴灵', 12, 'static/img/node_deep.jpg'),
('高性能MySQL', 128.00, 'Baron Schwartz', 10, 'static/img/high_performance_mysql.jpg');