package listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import util.DataInitializer;

@WebListener
public class AppInitListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // 应用启动时初始化数据
        DataInitializer.initSampleData();
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // 应用关闭时的清理工作
    }
}