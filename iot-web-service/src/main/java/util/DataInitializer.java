package util;

import dao.BookDao;
import dao.UserDao;
import beans.Book;
import beans.User;

public class DataInitializer {

    public static void initSampleData() {
        BookDao bookDao = new BookDao();
        UserDao userDao = new UserDao();


        // 检查数据库中是否已有数据，如果有则不重复添加
        if(bookDao.getAllBooks().isEmpty()) {
            // 添加20本示例图书
            String[] bookNames = {
                "Java编程思想", "Python核心编程", "数据结构与算法", "设计模式", "操作系统概念",
                "计算机网络", "数据库系统概念", "算法导论", "深入理解计算机系统", "现代操作系统",
                "计算机组成与设计", "编译原理", "软件工程", "人工智能", "机器学习实战",
                "深度学习", "Web开发实战", "物联网技术", "网络安全基础", "云计算技术"
            };

            String[] authors = {
                "张三", "李四", "王五", "赵六", "钱七", "孙八", "周九", "吴十",
                "蒋老师", "沈老师", "杨老师", "朱老师", "秦老师", "尤老师", "许老师",
                "何老师", "吕老师", "施老师", "张老师", "孔老师"
            };

            for(int i = 0; i < 20; i++) {
                Book book = new Book();
                book.setName(bookNames[i % bookNames.length] + " - 第" + (i/10 + 1) + "版");
                book.setAuthor(authors[i % authors.length]);
                book.setPrice(20.0 + (i * 2.5));
                book.setBookCount(50 - (i % 50));

                bookDao.addBook(book);
            }
        }

        // 添加一些示例用户
        if(userDao.getAllUsers().isEmpty()) {
            User adminUser = new User();
            adminUser.setUsername("admin");
            adminUser.setPassword("040608");
            adminUser.setEmail("admin@example.com");
            userDao.addUser(adminUser);

            User testUser = new User();
            testUser.setUsername("test");
            testUser.setPassword("test123");
            testUser.setEmail("test@example.com");
            userDao.addUser(testUser);
        }
    }
}