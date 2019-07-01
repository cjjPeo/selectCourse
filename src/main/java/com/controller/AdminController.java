package com.controller;

import com.pojo.Topic;
import com.pojo.User;
import com.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping(value = "admin")
public class AdminController {
    @Autowired
    private AdminService adminService;
    @RequestMapping(value = "admin-teacher-info.action")
    public  String admin5(Model model){
        List<User> teacherList=this.adminService.findTeacherList();
        model.addAttribute("teacherList",teacherList);
        return  "admin-teacher-info1";
    }
    @RequestMapping(value = "findTeacherList.action")
    @ResponseBody
   /* public JSONArray findTeacherList(Model model){
        List<User> teacherList=this.adminService.findTeacherList();
        model.addAttribute("teacherList",teacherList);
        System.out.println("adminFind");
        JSONArray jb = JSONArray.fromObject( teacherList );
        return jb;
    }*/
    public String findTeacherList(Model model){
        List<User> teacherList=this.adminService.findTeacherList();
        model.addAttribute("teacherList",teacherList);
        System.out.println("adminFind");
       // JSONArray jb = JSONArray.fromObject( teacherList );
        return "";
    }
    @RequestMapping(value = "ToInsert.action")
    public String ToInsert(){
        return "insertTeacher";
    }
    @RequestMapping(value = "insertTeacher.action")
    public String insertTeacher(String userId,String userName,String gender,Model model){
        Integer i=this.adminService.findTeacherExist(userId);
        System.out.println("insertTeacher");
        if(i>0){
            model.addAttribute("msg","该账号已经存在");
        }else {
            this.adminService.insertTeacher(userId,userName,gender);

        }
        return "redirect:/admin/findTeacherList.action";
    }
    @RequestMapping(value = "deleteTeacher.action")
    @ResponseBody
    public String deleteTeacher(String userId,Model model){
       Integer i= this.adminService.deleteTeacher(userId);
       if (i>0){
           return "OK";
       }else return "FAIL";
        //return "redirect:/admin/findTeacherList.action";
    }
    //重置密码
    @RequestMapping(value = "updateTeacherPassword.action")
    @ResponseBody
    public String updateTeacherPassword(String userId){
        Integer u=this.adminService.updateTeacherPassword(userId);
        if (u>0){
            return "ok";
        }
        return "fail";
    }
    @RequestMapping(value = "ToUpdateInsertTeacher,action")
    public String toUpdateInsertTeacher(String userId,String userName,String gender,Model model){
        model.addAttribute("userId",userId);
        model.addAttribute("userName",userName);
        model.addAttribute("gender",gender);
        return "updateTeacher";
    }
    @RequestMapping(value = "updateTeacher.action")
    @ResponseBody
    public String updateTeacher(String userName,String gender,String userId){
        Integer i=this.adminService.updateTeacherUsers(gender,userName,userId);
        if (i>0) {
            return "OK";
        }
        return "FAIL";
    }
    @RequestMapping(value = "admin-course.action")
    public  String admin2( Model model){
        List<Topic> topicList=this.adminService.findCourses("");
        model.addAttribute("topicList",topicList);
        return  "admin-course1";
    }
    @RequestMapping(value = "findCourses.action")
    @ResponseBody
   /* public JSONArray findCourses(String topicId){
       List<Topic> topicList=this.adminService.findCourses(topicId);
        JSONArray jb = JSONArray.fromObject( topicList );
        return jb;
    }*/
    public String findCourses(String topicId){
        List<Topic> topicList=this.adminService.findCourses(topicId);
       // JSONArray jb = JSONArray.fromObject( topicList );
        return "";
    }
    @RequestMapping("ManaAddTopic")
    @ResponseBody
    public String ManaaddTop(Topic topic) {
        int rows=adminService.ManaAddTopic(topic);
        if(rows>0) {
            System.out.println("添加课程成功！");
            return "OK";
        }else {
            System.out.println("添加课程失败！");
            return "FALL";
        }
    }
    @RequestMapping(value = "updateCourses.action")
    @ResponseBody
    public String updateTopic(String topicId,String topicName,String topicYear,String demand,Integer numberLimit,String majorLimit,String deadline,Character releaseSingal){
        Topic topic =new Topic();
        topic.setTopicId(topicId);
        topic.setTopicName(topicName);
        topic.setTopicYear(topicYear);
        topic.setDemand(demand);
        topic.setNumberLimit(numberLimit);
        topic.setMajorLimit(majorLimit);
        topic.setDemand(deadline);
        topic.setReleaseSingal(releaseSingal);
        Integer integer=   this.adminService.updateCourses(topic);
        if (integer>0){
            return "OK";
        }
        return "FAIL";
    }

    @RequestMapping(value = "deleteCourses.action")
    @ResponseBody
    public String deleteTopic(String topicId){
     Integer integer=   this.adminService.deleteCourseAt(topicId);
        if (integer>0){
            return "OK";
        }
        return "FAIL";
    }
    @RequestMapping(value = "startAllCourse.action")
    @ResponseBody
    public String startAllCourse(){
        Integer integer=this.adminService.startAllCourse();
        if (integer>0){
            return "ok";
        }
        return "fail";
    }
    @RequestMapping(value = "stopAllCourse.action")
    @ResponseBody
    public String stopAllCourse(){
        Integer integer=this.adminService.stopAllCourse();
        if (integer>0){
            return "ok";
        }
        return "fail";
    }
    @RequestMapping(value = "admin-student-info.action")
    public  String admin4(Model model){
        List<User> students=adminService.findStudentList("", "", null, "", "", "", null);
        model.addAttribute("students",students);
        return  "admin-student-info1";
    }
    @RequestMapping("StudentList.action")
    @ResponseBody
    public String list(String userId,String userName,Character gender,String enterYear,String className,String majorIn,Character selectedSignal,Model model) {
        List<User> students=adminService.findStudentList(userId, userName, gender, enterYear, className, majorIn, selectedSignal);
        model.addAttribute("students", students);
        return "topic3";
    }
    //删除学生
    @RequestMapping("eleteStu.action")
    @ResponseBody
    public String delStu(String userId) {
        int rows=adminService.deleteStu(userId);
        if(rows>0) {
            System.out.println("删除学生成功！");
            return "OK";
        }else {
            System.out.println("删除学生失败！");
            return "FALL";
        }
    }

    //增加学生
    @RequestMapping("addStu")
    @ResponseBody
    public String addStu(User user) {
        int rows=adminService.addStu(user);
        if(rows>0) {
            System.out.println("添加学生成功！");
            return "OK";
        }else {
            System.out.println("添加学生失败！");
            return "FALL";
        }
    }
    //获取需要修改学生的额具体的信息
    @RequestMapping(value = "toEdit.action")
    @ResponseBody
    public User toEdit(String userId,Model model){
        User u =this.adminService.toeditStu(userId);
        model.addAttribute("user",u);
        return u;
    }
    @RequestMapping("editStu.action")
    @ResponseBody
    public String editStumsg(User user) {
        //user.setUserId("");
        int rows=adminService.editStu(user);
        System.out.println(user);
        if(rows>0) {
            System.out.println("修改学生成功！");
            return "OK";
        }else {
            System.out.println("修改学生失败！");
            return "FALL";
        }
    }


}
