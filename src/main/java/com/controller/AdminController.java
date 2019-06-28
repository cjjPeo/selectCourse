package com.controller;

import com.pojo.User;
import com.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping(value = "admin")
public class AdminController {
    @Autowired
    private AdminService adminService;
    @RequestMapping(value = "findTeacherList.action")
    public String findTeacherList(Model model){
        List<User> teacherList=this.adminService.findTeacherList();
        model.addAttribute("teacherList",teacherList);
        return "doToTeacher";
    }
    @RequestMapping(value = "ToInsert.action")
    public String ToInsert(){
        return "insertTeacher";
    }
    @RequestMapping(value = "insertTeacher.action")
    public String insertTeacher(String userId,String userName,String gender,Model model){
        Integer i=this.adminService.findTeacherExist(userId);
        if(i>0){
            model.addAttribute("msg","该账号已经存在");
        }else {
            this.adminService.insertTeacher(userId,userName,gender);

        }
        return "redirect:admin/findTeacherList.action";
    }
    @RequestMapping(value = "deleteTeacher.action")
    public String deleteTeacher(String userId,Model model){
        this.adminService.deleteTeacher(userId);
        return "redirect:admin/findTeacherList.action";
    }
    //重置密码
    @RequestMapping(value = "updateTeacherPassword.action")
    public String updateTeacherPassword(String userId){
        this.adminService.updateTeacherPassword(userId);
        return "redirect:admin/findTeacherList.action";
    }
    @RequestMapping(value = "ToUpdateInsertTeacher,action")
    public String toUpdateInsertTeacher(String userId,String userName,String gender,Model model){
        model.addAttribute("userId",userId);
        model.addAttribute("userName",userName);
        model.addAttribute("gender",gender);
        return "updateTeacher";
    }
    @RequestMapping(value = "updateTeacher.action")
    public String updateTeacher(String userName,String gender,String userId){
        this.adminService.updateTeacherUsers(gender,userName,userId);
        return "redirect:admin/findTeacherList.action";
    }
}
