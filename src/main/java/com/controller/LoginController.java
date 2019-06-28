package com.controller;

import com.pojo.Login;
import com.pojo.Topic;
import com.service.LoginService;
import com.service.StudentChooseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping(value = "login")
public class LoginController {
    @Autowired
    private LoginService loginService;
    @Autowired
    private StudentChooseService studentChooseService;
    //跳转到登录的页面
    @RequestMapping(value = "gologin.action")
    public ModelAndView findLoginPage(){
        ModelAndView model=new ModelAndView();
        model.setViewName("login");
        return model;
    }
    //登录页面刷新
    @RequestMapping(value = "register.action",method = RequestMethod.GET)
    public String findUsers(HttpSession session, Model model, HttpServletRequest request){
       Login login=(Login)session.getAttribute("USER_SESSION");
        if (login!=null){
            System.out.println("getgetget");
            String msg=request.getParameter("msg");
            if(msg!=null){
                System.out.println(msg);
                model.addAttribute("msg",msg);
            }
            List<Topic> topicList=this.studentChooseService.findTopic("","","","");
            model.addAttribute("topicList",topicList);
            return "next";
        }
        return "login";
    }
    //login表单提交,通过
    @RequestMapping(value = "register.action",method = RequestMethod.POST)
    public String findUser(String userId, String password,String userState, HttpSession session, Model model){
        //不能同时间登录两个账号
        Login login1=(Login)session.getAttribute("USER_SESSION");
        if (login1!=null){
            model.addAttribute("msg","请先注销当前账号再重新登录");
            return "redirect:/login/register.action";
        }
        Login login=this.loginService.findLoginUser(userId,password,userState);
        if (login!=null){
            String remarks=login.getRemarks();
            System.out.println(remarks);
            if (remarks.equals("0")){
                this.loginService.updateRemarks("1",login.getUserId());
                session.setAttribute("USER_SESSION",login);
                //全部的课题列表
                List<Topic> topicList=this.studentChooseService.findTopic("","","","");
                model.addAttribute("topicList",topicList);
                return "redirect:/login/register.action";//避免在刷新以后表单再次提交
            }else{
                //已经登录
                model.addAttribute("msg","该账号已登录！");
                return "login";
            }
        }
        model.addAttribute("msg","账号或者密码或者身份不正确");
        //密码输错
        return "login";
    }
    //退出登录
    //在关闭浏览器以后似乎session不会再保存
    //js监听浏览器的关闭，如果关闭就走到这里来,例子：https://blog.csdn.net/qq285679784/article/details/72851670
    @RequestMapping(value = "quit.action")
    public String findQuit(HttpSession session){
        Login login=(Login)session.getAttribute("USER_SESSION");
        this.loginService.updateRemarks("0",login.getUserId());
        System.out.println("quit1111");
        session.removeAttribute("USER_SESSION");
        session.invalidate();
        return "login";
    }
}
