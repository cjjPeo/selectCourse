package com.sessionlistener;

import com.dao.LoginDao;
import com.pojo.Login;
import com.service.LoginService;
import com.service.impl.LoginServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.*;

public class SessionListner  implements HttpSessionListener{
    @Override
    public void sessionCreated(HttpSessionEvent se) {
        System.out.println("sessionCreated");
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se){
        HttpSession session=se.getSession();
        Login user_session =(Login) session.getAttribute("USER_SESSION");
        if (user_session!=null){
            String id=user_session.getUserId();
            System.out.println("id:"+id);
            session.getServletContext().setAttribute("QUIT",id);
        }

    }
}
