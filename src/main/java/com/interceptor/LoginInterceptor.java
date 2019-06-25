package com.interceptor;
import com.pojo.Login;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor implements HandlerInterceptor{
    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response, Object handler)
            throws Exception {
       System.out.println("preHanlew");
        //自己走到登录界面去
        String url = request.getRequestURI();
        HttpSession session = request.getSession();
        //session失效以后去quit的地址上
        String quitsignal=(String)session.getServletContext().getAttribute("QUIT");
        if(quitsignal!=null){
            System.out.println(quitsignal);
            Login login=new Login();
            login.setUserId(quitsignal);
            session.setAttribute("USER_SESSION",login);
            session.getServletContext().removeAttribute("QUIT");
            request.getRequestDispatcher("/login/quit.action").forward(request, response);
            System.out.println(request.getContextPath()+"/login/quit.action");
            return false;
        }

        //登录
        if (url.indexOf("/login/register.action") >= 0) {
            System.out.println("2222");
            return true;
        }
        Login user = (Login) session.getAttribute("USER_SESSION");
        //确认是否已经登录
        if (user != null) {
            return true;
        }

        //还未登录就跳转到登录的界面去输入信息
        request.setAttribute("msg", "您还没有登录，请先登录");
        request.getRequestDispatcher("/WEB-INF/jsp/login.jsp")
                .forward(request, response);
        return true;
    }
    @Override
    public void postHandle(HttpServletRequest request,
                           HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) throws Exception {
        System.out.println("postHand");
    }
    @Override
    public void afterCompletion(HttpServletRequest request,
                                HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
        System.out.println("afterCompletion");
    }
}
