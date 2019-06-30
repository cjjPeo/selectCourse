package com.controller;

import com.pojo.Excel;
import com.pojo.Login;
import com.pojo.Topic;
import com.pojo.User;
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
    @RequestMapping(value = "student-course-list.action")
    public  String student1(Model model){
        List<Topic> topicList=this.studentChooseService.findTopic("","","","");
        model.addAttribute("topicList",topicList);
        return  "student-course-list";
    }
    @RequestMapping(value = "student-my-class.action")
    public  String student2(HttpSession session,Model model){
        Login login=(Login)session.getAttribute("USER_SESSION");
        Topic mytopicmsg=studentChooseService.findMyTopic(login.getUserId());
        model.addAttribute("mytopicmsg", mytopicmsg);
        return  "student-my-class";
    }
    @RequestMapping(value = "student-my-group.action")
    public  String student3(){
        return  "student-my-group";
    }
    @RequestMapping(value = "userinfo.action")
    public  String info1(HttpSession session,Model model){
        Login login=(Login)session.getAttribute("USER_SESSION");
        User userMy=this.studentChooseService.findMyInfo(login.getUserId());
        model.addAttribute("userMy",userMy);
        return  "userinfo";
    }
    @RequestMapping(value = "notice.action")
    public  String info2(){
        return  "notice";
    }
    @RequestMapping(value = "change-password.action")
    public  String info3(){
        return  "change-password";
    }

    @RequestMapping(value = "teacher.action")
    public  String teacher1(){
        return  "teacher";
    }
    @RequestMapping(value = "teacher-add-course.action")
    public  String teacher2(){
        return  "teacher-add-course";
    }
    /*@RequestMapping(value = "teacher-change-course.action")
    public  String teacher3(){
        return  "teacher-change-course";
    }*/
    @RequestMapping(value = "teacher-my-course1.action")
    public  String teacher4(HttpSession session,Model model){
        return  "teacher-my-course";
    }


    @RequestMapping(value = "admin.action")
    public  String admin1(){
        return  "admin";
    }
    @RequestMapping(value = "admin-course.action")
    public  String admin2(){
        return  "admin-course";
    }
    @RequestMapping(value = "admin-password-init.action")
    public  String admin3(){
        return  "admin-password-init";
    }
    @RequestMapping(value = "admin-student-info.action")
    public  String admin4(){
        return  "admin-student-info";
    }
    @RequestMapping(value = "admin-teacher-info.action")
    public  String admin5(){
        return  "admin-teacher-info";
    }

    //登录页面刷新
    @RequestMapping(value = "register.action",method = RequestMethod.GET)
    public String findUsers(HttpSession session, Model model, HttpServletRequest request){
       Login login=(Login) session.getAttribute("USER_SESSION");
        if (login!=null){
            System.out.println("getgetget");
            String msg=request.getParameter("msg");
            if(msg!=null){
                System.out.println(msg);
                model.addAttribute("msg",msg);
            }
           // List<Topic> topicList=this.studentChooseService.findTopic("","","","");
           // model.addAttribute("topicList",topicList);
            if(login.getUserState().equals("user")){
                return "student";
            }else if (login.getUserState().equals("teacher")){
                return "teacher";
            }else if (login.getUserState().equals("admin")){
                return "admin";
            }
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
          // return "student";
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
               /* List<Topic> topicList=this.studentChooseService.findTopic("","","","");
                model.addAttribute("topicList",topicList);*/
                if(userState.equals("user")){
                    return "student";
                }else if (userState.equals("teacher")){
                    return "teacher";
                }else if (userState.equals("admin")){
                    return "admin";
                }
                    // return "redirect:/login/register.action";//避免在刷新以后表单再次提交
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
