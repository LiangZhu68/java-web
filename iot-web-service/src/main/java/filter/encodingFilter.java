package filter;

import java.io.IOException;
import javax.servlet.DispatcherType;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.http.HttpServletResponse;

/**
 * 该过滤器的功能是解决中文乱码问题
 * 所有的请求先经过过滤器，在过滤器中设置
 * request.setCharacterEncoding("utf-8");
 * 这样不要再每个servlet中添加上面一句话
 */
@WebFilter(value = "/*",
dispatcherTypes = {DispatcherType.FORWARD,DispatcherType.REQUEST},
initParams = {@WebInitParam(name = "encoding",value = "utf-8")})
public class encodingFilter implements Filter {
    private String encoding;

    public encodingFilter() {
        // TODO Auto-generated constructor stub
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
FilterChain chain)
throws IOException, ServletException {

        //HttpServletResponse response2 = (HttpServletResponse)response;
        //response2.setContentType("text/html;charset="+this.encoding);
        request.setCharacterEncoding(this.encoding);
        response.setCharacterEncoding(this.encoding);
        chain.doFilter(request, response);

    }

    @Override
    public void destroy() {
    }

    @Override
    public void init(FilterConfig fConfig) throws ServletException{
        this.encoding = fConfig.getInitParameter("encoding");
    }

}